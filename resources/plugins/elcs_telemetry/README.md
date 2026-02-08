# ELCS Telemetry Plugin

A Code-Puppy plugin that captures observational telemetry for ELCS framework validation and debugging.

## Quick Start

### Option 1: Symlink (Recommended for Development)

**Windows (PowerShell as Admin):**
```powershell
New-Item -ItemType SymbolicLink -Path "$HOME\.code_puppy\plugins\elcs_telemetry" -Target "<path-to-elcs-repo>\resources\plugins\elcs_telemetry"
```

**Linux/Mac:**
```bash
ln -s /path/to/elcs-repo/resources/plugins/elcs_telemetry ~/.code_puppy/plugins/elcs_telemetry
```

### Option 2: Copy

Copy the entire `elcs_telemetry` folder to `~/.code_puppy/plugins/`:

```
~/.code_puppy/plugins/
└── elcs_telemetry/
    ├── __init__.py
    ├── register_callbacks.py
    ├── telemetry_writer.py
    └── README.md
```

## Verify Installation

Run `uvx code-puppy` and the plugin will be automatically loaded. If there are no errors at startup, it's working!

## What It Captures

| Event | Data Captured |
|-------|---------------|
| `session_start` | agent, model, session_id |
| `session_end` | success, thinking_length, response_length, confusion_signals |
| `tool_call` | tool name, args, duration_ms |
| `file_operation` | operation type, file_path, success |
| `shell_command` | command (redacted if sensitive), cwd, timeout |
| `agent_delegation` | from_session, to_agent, prompt_preview |
| `error` | error_type, error_message |

## Output Location

Telemetry is written to:
```
<your-project>/elcs/telemetry/events-YYYY-MM-DD.jsonl
```

The plugin automatically detects ELCS projects by looking for an `elcs/` directory.

## Security

- Sensitive fields (password, secret, token, key, etc.) are automatically redacted
- Long strings (>200 chars) are truncated
- Shell commands containing sensitive patterns are fully redacted

## Confusion Detection

The plugin detects uncertainty signals in agent responses:
- `uncertainty` - "I'm not sure", "I'm unsure"
- `clarification_needed` - "Could you clarify", "What do you mean"
- `self_correction` - "Actually,", "Wait,", "Let me reconsider"
- And more...

## Known Limitations

- **Token usage**: Actual API token counts not available (code-puppy doesn't pass this data). Use `thinking_length + response_length` as an estimate (~4 chars ≈ 1 token).
- **Tool results**: Success/failure of individual tool calls not captured (would require `post_tool_call` callback to be wired up in code-puppy).
