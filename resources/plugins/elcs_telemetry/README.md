# ELCS Telemetry Plugin

A Code-Puppy plugin that captures observational telemetry for ELCS framework validation and debugging.

## Installation

### Which Option Should I Choose?

| Situation | Recommendation |
|-----------|----------------|
| ELCS repo is in a normal folder | **Symlink** — updates auto-propagate |
| ELCS repo is in OneDrive/Dropbox | **Copy** — avoids potential sync issues |
| You want the latest plugin changes automatically | **Symlink** |
| You want a stable, isolated copy | **Copy** |

> **Note:** The `~/.code_puppy/plugins/` directory is in your user profile (e.g., `C:\Users\you\.code_puppy\`), which is typically NOT in cloud sync. The installation method only matters if your ELCS repo source is in a synced folder.

### Option 1: Symlink (Recommended for Non-Cloud Folders)

Creates a link so plugin updates in the ELCS repo automatically apply.

**Windows (PowerShell as Admin):**
```powershell
New-Item -ItemType SymbolicLink -Path "$HOME\.code_puppy\plugins\elcs_telemetry" -Target "C:\path\to\elcs-framework\resources\plugins\elcs_telemetry"
```

**Linux/Mac:**
```bash
ln -s /path/to/elcs-framework/resources/plugins/elcs_telemetry ~/.code_puppy/plugins/elcs_telemetry
```

### Option 2: Copy (Recommended for OneDrive/Dropbox)

Copies files directly — no dependency on the source location.

**Windows:**
```powershell
Copy-Item -Recurse "C:\path\to\elcs-framework\resources\plugins\elcs_telemetry" "$HOME\.code_puppy\plugins\elcs_telemetry"
```

**Linux/Mac:**
```bash
cp -r /path/to/elcs-framework/resources/plugins/elcs_telemetry ~/.code_puppy/plugins/
```

> **OneDrive Users:** If you run `$env:UV_LINK_MODE = "copy"; uvx code-puppy` because your project is in OneDrive, using the **Copy** option for the plugin ensures everything stays outside of cloud sync.

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
