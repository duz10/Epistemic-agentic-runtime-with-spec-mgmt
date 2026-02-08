# Checkpoint 005: Telemetry Plugin Built & Validated

**Date**: 2025-01-11
**Token**: WT-TELEM-001
**Stage**: Implementation Complete
**State Version**: 9

---

## Summary

Built and validated the ELCS telemetry plugin for code-puppy. The plugin captures observational telemetry via infrastructure callbacks without requiring agent compliance.

---

## What Was Built

**Location:** `~/.code_puppy/plugins/elcs_telemetry/`

| File | Purpose |
|------|---------||
| `__init__.py` | Package init |
| `register_callbacks.py` | Callback registrations and event handlers |
| `telemetry_writer.py` | JSONL file writer with project detection |
| `README.md` | Documentation |

---

## Events Captured

| Event | Callback | Data |
|-------|----------|------|
| `session_start` | `agent_run_start` | agent, model, session_id |
| `session_end` | `agent_run_end` | success, thinking_length, response_length, confusion_signals |
| `tool_call` | `stream_event` | tool, args, duration_ms |
| `file_operation` | `edit_file`, `delete_file` | operation, file_path, success |
| `shell_command` | `run_shell_command` | command, cwd, timeout |
| `agent_delegation` | `invoke_agent` | from_session, to_agent, prompt_preview |
| `error` | `agent_exception` | error_type, error_message |

---

## Key Technical Discoveries

### 1. User Plugins Work with uvx
Plugins at `~/.code_puppy/plugins/` are loaded regardless of how code-puppy is launched. No need for local clone or `--with` flags.

### 2. stream_event for Tool Calls
The `pre_tool_call`/`post_tool_call` callbacks exist but aren't wired to built-in tools yet. Used `stream_event` with `ToolCallPart` detection as workaround.

### 3. Pydantic Payloads
The `edit_file` callback receives Pydantic models (ContentPayload, ReplacementsPayload), not dicts. Required attribute access instead of `.get()`.

### 4. Confusion Detection Works
Pattern matching on response text successfully detects uncertainty signals like "I'm not sure", "could you clarify", etc.

---

## Hypothesis Validation

**H8: Infrastructure-based telemetry is sufficient** → ✅ VALIDATED

The plugin captures all key events without any agent compliance required. Agents don't need to log anything — the infrastructure observes their behavior.

---

## What Telemetry Is For

Telemetry is the **microscope**, not the **map**:
- ELCS state/artifacts = The authoritative record of WHAT happened
- Telemetry = Debugging tool for HOW it happened (when you need to dig in)

---

## Files Changed

| File | Action |
|------|--------|
| `~/.code_puppy/plugins/elcs_telemetry/*` | Created (4 files) |
| `epistemic/state.json` | Updated (v8 → v9) |
| `epistemic/hypotheses.md` | Updated (H8 validated) |
| `epistemic/evidence.md` | Added E17 |
| `epistemic/tokens/closed/WT-TELEM-001.json` | Closed |

---

*Checkpoint by planning-agent-11242f + code-puppy collaboration*
