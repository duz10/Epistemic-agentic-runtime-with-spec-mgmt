# ELCS Telemetry

Observational telemetry for debugging and post-work analysis.

## Philosophy

> Telemetry is the **microscope**, not the **map**.

- **ELCS state/artifacts** = The authoritative record of WHAT happened
- **Telemetry** = Debugging tool for HOW it happened (when you need to dig in)

Telemetry is valuable when the user or agent NEEDS to dig into the details. For most workflows, ELCS state management is sufficient.

## Setup

See [resources/plugins/elcs_telemetry/README.md](../resources/plugins/elcs_telemetry/README.md) for installation instructions.

## When to Use Telemetry

✅ **Good use cases:**
- Debugging why a session was slow
- Understanding agent confusion/uncertainty
- Analyzing delegation patterns
- Post-mortem on failed workflows

❌ **Overkill:**
- Tracking every session (ELCS state already does this)
- Storing full responses (that's what artifacts are for)
- Real-time monitoring (telemetry is for analysis)

## Reading Telemetry

Telemetry is stored as JSONL (one JSON object per line):

```bash
# View today's telemetry
cat elcs/telemetry/events-$(date +%Y-%m-%d).jsonl

# Pretty print
cat elcs/telemetry/events-*.jsonl | jq .

# Filter by event type
cat elcs/telemetry/events-*.jsonl | jq 'select(.event == "tool_call")'

# Find slow tool calls (>1 second)
cat elcs/telemetry/events-*.jsonl | jq 'select(.event == "tool_call" and .duration_ms > 1000)'

# Find confused sessions
cat elcs/telemetry/events-*.jsonl | jq 'select(.confusion_signals != null)'
```

## Event Reference

| Event | Fields |
|-------|--------|
| `session_start` | ts, agent, model, session_id |
| `session_end` | ts, agent, model, session_id, success, error, thinking_length, response_length, confusion_signals |
| `tool_call` | ts, tool, args, duration_ms, session_id |
| `file_operation` | ts, operation, file_path, success, session_id |
| `shell_command` | ts, command, cwd, timeout, session_id |
| `agent_delegation` | ts, from_session, to_agent, to_session, prompt_preview |
| `error` | ts, error_type, error_message, session_id |

## Hypothesis Validation

This telemetry system validated **H8: Infrastructure-based telemetry is sufficient**.

Key finding: Callback hooks in code-puppy provide full observability without requiring agents to explicitly log anything. The infrastructure observes agent behavior passively.
