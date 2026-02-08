"""ELCS Telemetry Plugin - Comprehensive event capture for ELCS framework validation.

Captures:
- Session lifecycle (start, end)
- Tool calls (with args, duration)
- File modifications (edit_file)
- Shell commands (run_shell_command)
- Agent delegation (invoke_agent)
- Agent reasoning (thinking parts)
- Agent responses (text parts)
- Errors (agent_exception)

OBSERVATIONAL ONLY - does not modify agent behavior.
"""

import json
import logging
import time
from typing import Any

from code_puppy.callbacks import register_callback

from .telemetry_writer import TelemetryWriter

logger = logging.getLogger(__name__)

# Global writer instance (initialized lazily per-project)
_writer: TelemetryWriter | None = None

# Current session ID (set at session_start, used by all events)
_current_session_id: str | None = None

# Track tool calls in progress: index -> {tool, start_time, args_json}
_active_tool_calls: dict[int, dict] = {}

# Track text/thinking accumulation per session
_accumulated_thinking: list[str] = []
_accumulated_response: list[str] = []


def _get_writer() -> TelemetryWriter | None:
    """Get or create the telemetry writer for the current project."""
    global _writer
    if _writer is None:
        _writer = TelemetryWriter()
    return _writer if _writer.is_active() else None


def _reset_state() -> None:
    """Reset all state at session end."""
    global _writer, _current_session_id, _active_tool_calls
    global _accumulated_thinking, _accumulated_response
    _writer = None
    _current_session_id = None
    _active_tool_calls = {}
    _accumulated_thinking = []
    _accumulated_response = []


# ============================================
# SESSION LIFECYCLE
# ============================================

async def _on_session_start(agent_name: str, model_name: str, session_id: str | None = None):
    """Capture session start event."""
    global _current_session_id
    _current_session_id = session_id
    
    writer = _get_writer()
    if writer:
        writer.emit({
            "event": "session_start",
            "agent": agent_name,
            "model": model_name,
            "session_id": session_id,
        })


async def _on_session_end(
    agent_name: str,
    model_name: str,
    session_id: str | None = None,
    success: bool = True,
    error: Exception | None = None,
    response_text: str | None = None,
    metadata: dict | None = None,
):
    """Capture session end event with confusion detection."""
    writer = _get_writer()
    if writer:
        # Combine accumulated response for confusion detection
        full_response = response_text or " ".join(_accumulated_response)
        
        event_data = {
            "event": "session_end",
            "agent": agent_name,
            "model": model_name,
            "session_id": session_id or _current_session_id,
            "success": success,
            "error": str(error) if error else None,
            "tokens_used": metadata.get("tokens_used") if metadata else None,
            "thinking_length": sum(len(t) for t in _accumulated_thinking),
            "response_length": sum(len(r) for r in _accumulated_response),
        }
        
        # Detect confusion signals
        if full_response:
            confusion_signals = _detect_confusion(full_response)
            if confusion_signals:
                event_data["confusion_signals"] = confusion_signals
        
        writer.emit(event_data)
    
    _reset_state()


# ============================================
# STREAM EVENTS (Tool Calls, Thinking, Response)
# ============================================

async def _on_stream_event(event_type: str, event_data: Any, session_id: str | None = None):
    """Capture stream events: tool calls, thinking, responses."""
    writer = _get_writer()
    if not writer:
        return
    
    effective_session_id = session_id or _current_session_id
    
    # ===== PART START =====
    if event_type == "part_start":
        part_type = event_data.get("part_type", "")
        part = event_data.get("part")
        index = event_data.get("index")
        
        # Tool call start
        if part_type == "ToolCallPart" and part is not None:
            tool_name = getattr(part, "tool_name", None) or ""
            _active_tool_calls[index] = {
                "tool": tool_name,
                "start_time": time.perf_counter(),
                "args_json": "",
            }
        
        # Thinking part start (capture initial content if any)
        elif part_type == "ThinkingPart" and part is not None:
            content = getattr(part, "content", "") or ""
            if content:
                _accumulated_thinking.append(content)
        
        # Text part start (capture initial content if any)  
        elif part_type == "TextPart" and part is not None:
            content = getattr(part, "content", "") or ""
            if content:
                _accumulated_response.append(content)
    
    # ===== PART DELTA =====
    elif event_type == "part_delta":
        index = event_data.get("index")
        delta = event_data.get("delta")
        delta_type = event_data.get("delta_type", "")
        
        if delta is None:
            return
            
        # Tool call args streaming
        if index in _active_tool_calls and delta_type == "ToolCallPartDelta":
            args_delta = getattr(delta, "args_delta", "") or ""
            if args_delta:
                _active_tool_calls[index]["args_json"] += args_delta
            tool_name_delta = getattr(delta, "tool_name_delta", "") or ""
            if tool_name_delta:
                _active_tool_calls[index]["tool"] += tool_name_delta
        
        # Thinking content streaming
        elif delta_type == "ThinkingPartDelta":
            content = getattr(delta, "content_delta", "") or ""
            if content:
                _accumulated_thinking.append(content)
        
        # Response content streaming
        elif delta_type == "TextPartDelta":
            content = getattr(delta, "content_delta", "") or ""
            if content:
                _accumulated_response.append(content)
    
    # ===== PART END =====
    elif event_type == "part_end":
        index = event_data.get("index")
        
        # Emit completed tool call
        if index in _active_tool_calls:
            tool_data = _active_tool_calls.pop(index)
            duration_ms = (time.perf_counter() - tool_data["start_time"]) * 1000
            
            # Parse accumulated args
            args = {}
            args_json = tool_data.get("args_json", "")
            if args_json:
                try:
                    args = json.loads(args_json)
                except json.JSONDecodeError:
                    args = {"_raw": args_json[:200] + "..." if len(args_json) > 200 else args_json}
            
            writer.emit({
                "event": "tool_call",
                "tool": tool_data["tool"],
                "args": _summarize_args(args),
                "duration_ms": round(duration_ms, 2),
                "session_id": effective_session_id,
            })


# ============================================
# FILE OPERATIONS
# ============================================

def _on_edit_file(context: Any, result: dict, payload: Any) -> None:
    """Capture file edit events.
    
    Note: payload can be a Pydantic model (ContentPayload, ReplacementsPayload)
    or a dict, so we need to handle both cases.
    """
    writer = _get_writer()
    if not writer:
        return None
    
    # Extract file path - handle both Pydantic models and dicts
    file_path = "unknown"
    try:
        if hasattr(payload, "file_path"):
            # Pydantic model with file_path attribute
            file_path = payload.file_path
        elif hasattr(payload, "path"):
            # Pydantic model with path attribute
            file_path = payload.path
        elif isinstance(payload, dict):
            # Dict-style access
            file_path = payload.get("file_path") or payload.get("path") or "unknown"
    except Exception as e:
        logger.debug(f"Could not extract file_path from payload: {e}")
    
    # Determine operation type
    operation = "edit"
    try:
        # Check if it's a create operation
        if hasattr(payload, "overwrite"):
            # ContentPayload - check if file was created
            if isinstance(result, dict) and result.get("created"):
                operation = "create"
        elif isinstance(result, dict):
            if result.get("created"):
                operation = "create"
    except Exception:
        pass
    
    # Extract result info
    success = True
    lines_changed = None
    if isinstance(result, dict):
        success = result.get("success", True)
        lines_changed = result.get("lines_changed")
    
    writer.emit({
        "event": "file_operation",
        "operation": operation,
        "file_path": str(file_path),
        "success": success,
        "lines_changed": lines_changed,
        "session_id": _current_session_id,
    })
    
    return None  # Don't modify the result


def _on_delete_file(context: Any, *args, **kwargs) -> None:
    """Capture file delete events.
    
    The delete_file callback receives varying arguments, so we handle them flexibly.
    """
    writer = _get_writer()
    if not writer:
        return None
    
    # Try to extract file path from args or kwargs
    file_path = "unknown"
    try:
        if args:
            # First positional arg might be file_path or a result dict
            first_arg = args[0]
            if isinstance(first_arg, str):
                file_path = first_arg
            elif isinstance(first_arg, dict):
                file_path = first_arg.get("path") or first_arg.get("file_path") or str(first_arg)
            elif hasattr(first_arg, "path"):
                file_path = first_arg.path
            elif hasattr(first_arg, "file_path"):
                file_path = first_arg.file_path
        if file_path == "unknown" and "file_path" in kwargs:
            file_path = kwargs["file_path"]
        if file_path == "unknown" and "path" in kwargs:
            file_path = kwargs["path"]
    except Exception as e:
        logger.debug(f"Could not extract file_path from delete args: {e}")
    
    writer.emit({
        "event": "file_operation",
        "operation": "delete",
        "file_path": str(file_path),
        "session_id": _current_session_id,
    })
    
    return None


# ============================================
# SHELL COMMANDS
# ============================================

async def _on_shell_command(context: Any, command: str, cwd: str, timeout: int) -> None:
    """Capture shell command execution."""
    writer = _get_writer()
    if not writer:
        return None
    
    # Redact potentially sensitive commands
    safe_command = _redact_command(command)
    
    writer.emit({
        "event": "shell_command",
        "command": safe_command,
        "cwd": str(cwd),
        "timeout": timeout,
        "session_id": _current_session_id,
    })
    
    return None  # Don't block the command


# ============================================
# AGENT DELEGATION
# ============================================

async def _on_invoke_agent(*args, **kwargs) -> None:
    """Capture agent delegation events."""
    writer = _get_writer()
    if not writer:
        return None
    
    agent_name = kwargs.get("agent_name") or (args[0] if args else "unknown")
    delegated_session_id = kwargs.get("session_id")
    prompt = kwargs.get("prompt") or (args[1] if len(args) > 1 else "")
    
    # Truncate prompt for telemetry
    prompt_preview = prompt[:200] + "..." if len(prompt) > 200 else prompt
    
    writer.emit({
        "event": "agent_delegation",
        "from_session": _current_session_id,
        "to_agent": agent_name,
        "to_session": delegated_session_id,
        "prompt_preview": prompt_preview,
    })
    
    return None


# ============================================
# ERRORS
# ============================================

async def _on_agent_exception(exception: Exception, *args, **kwargs) -> None:
    """Capture agent exceptions."""
    writer = _get_writer()
    if not writer:
        return None
    
    writer.emit({
        "event": "error",
        "error_type": type(exception).__name__,
        "error_message": str(exception)[:500],
        "session_id": _current_session_id,
    })
    
    return None


# ============================================
# HELPER FUNCTIONS
# ============================================

def _summarize_args(args: dict) -> dict:
    """Summarize tool arguments, redacting sensitive data."""
    if not args:
        return {}
    
    summary = {}
    sensitive_keys = ['password', 'secret', 'token', 'key', 'credential', 'auth', 'api_key']
    
    for key, value in args.items():
        if any(s in key.lower() for s in sensitive_keys):
            summary[key] = "[REDACTED]"
        elif isinstance(value, str) and len(value) > 200:
            summary[key] = f"{value[:100]}... [{len(value)} chars]"
        else:
            summary[key] = value
    
    return summary


def _redact_command(command: str) -> str:
    """Redact potentially sensitive parts of shell commands."""
    # List of patterns that might contain secrets
    sensitive_patterns = ['password', 'token', 'secret', 'api_key', 'apikey', 'auth']
    
    cmd_lower = command.lower()
    for pattern in sensitive_patterns:
        if pattern in cmd_lower:
            return f"[REDACTED - contains {pattern}]"
    
    # Truncate very long commands
    if len(command) > 500:
        return command[:500] + "... [truncated]"
    
    return command


def _detect_confusion(text: str) -> list[str] | None:
    """Detect confusion signals in response text."""
    if not text:
        return None
    
    signals = []
    text_lower = text.lower()
    
    confusion_markers = [
        ("i'm not sure", "uncertainty"),
        ("i'm unsure", "uncertainty"),
        ("i don't understand", "comprehension"),
        ("could you clarify", "clarification_needed"),
        ("what do you mean", "clarification_needed"),
        ("i'm confused", "confusion"),
        ("this is unclear", "ambiguity"),
        ("i need more information", "information_gap"),
        ("i'm not certain", "uncertainty"),
        ("it's ambiguous", "ambiguity"),
        ("i apologize", "recovery"),
        ("let me reconsider", "self_correction"),
        ("actually,", "self_correction"),
        ("wait,", "self_correction"),
    ]
    
    for marker, signal_type in confusion_markers:
        if marker in text_lower and signal_type not in signals:
            signals.append(signal_type)
    
    return signals if signals else None


# ============================================
# REGISTER ALL CALLBACKS
# ============================================

# Session lifecycle
register_callback("agent_run_start", _on_session_start)
register_callback("agent_run_end", _on_session_end)

# Stream events (tool calls, thinking, response)
register_callback("stream_event", _on_stream_event)

# File operations
register_callback("edit_file", _on_edit_file)
register_callback("delete_file", _on_delete_file)

# Shell commands
register_callback("run_shell_command", _on_shell_command)

# Agent delegation
register_callback("invoke_agent", _on_invoke_agent)

# Errors
register_callback("agent_exception", _on_agent_exception)

logger.info("ELCS Telemetry plugin loaded - capturing ALL events")
