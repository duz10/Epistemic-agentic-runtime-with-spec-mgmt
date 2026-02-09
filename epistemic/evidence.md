# ELCS Project Evidence

*Observations and data supporting our beliefs*

## Evidence Log

### E1: Bootstrap File Behavior
- **Type**: Observation
- **Summary**: Code-puppy and Claude Code both read claude.md/CLAUDE.md files at session start
- **Source**: Direct observation during this project
- **Date**: 2026-02-07
- **Supports**: A1

### E2: EAR Template Persistence
- **Type**: Observation
- **Summary**: EAR template (epistemic-agentic-runtime-main) successfully persists state across sessions via files
- **Source**: Current project usage
- **Date**: 2026-02-07
- **Supports**: A2

### E3: EAR Pipeline Success
- **Type**: Observation
- **Summary**: EAR 12-stage pipeline has guided this project from idea through scaffolding successfully
- **Source**: Current session
- **Date**: 2026-02-07
- **Supports**: A5

## E13: Code-Puppy Callback Infrastructure
- **Type**: Observation
- **Date**: 2025-01-11
- **Summary**: Code-puppy has callback hooks (pre_tool_call, post_tool_call, agent_run_start/end, edit_file, stream_event) that fire automatically without agent compliance
- **Source**: Code inspection of code_puppy/callbacks.py
- **Supports**: H8, A8

## E14: User Plugin Loading
- **Type**: Observation
- **Date**: 2025-01-11
- **Summary**: Code-puppy loads user plugins from ~/.code_puppy/plugins/ directory, enabling custom telemetry plugins to work with uvx code-puppy
- **Source**: Code inspection of code_puppy/plugins/__init__.py
- **Supports**: H8, A8

## E15: Artifact Telemetry Redundancy
- **Type**: Analysis
- **Date**: 2025-01-11
- **Summary**: Artifact-based telemetry (watching ELCS file changes) is redundant - the artifacts themselves ARE the record. Useful telemetry must capture what ISN'T in artifacts: tool calls, timing, errors, confusion signals
- **Source**: Lens evaluation and discussion with user
- **Supports**: H8 design decisions

## E16: Plugin Loading Confirmed for uvx
- **Type**: Verification
- **Date**: 2025-01-11
- **Summary**: Confirmed that `plugins.load_plugin_callbacks()` runs at module import time in `cli_runner.py` (line 52). This means `~/.code_puppy/plugins/` is scanned regardless of how code-puppy is launched (uvx or local). User plugins WILL work with `uvx code-puppy`.
- **Source**: Code inspection of cli_runner.py
- **Supports**: A8, H8
- **Key Distinction Documented**: 
  - Python AGENTS scan internal dir (`code_puppy/agents/`) — uvx --with won't work
  - Python PLUGINS scan user dir (`~/.code_puppy/plugins/`) — works with uvx!

## E17: Telemetry Plugin Validation
- **Type**: Validation
- **Date**: 2025-01-11
- **Summary**: Built and tested elcs_telemetry plugin at `~/.code_puppy/plugins/elcs_telemetry/`. Successfully captures via infrastructure hooks:
  - Session start/end with agent, model, session_id
  - Tool calls with args, duration_ms, session_id
  - File operations (edit, create, delete) with file_path
  - Shell commands with command, cwd, timeout
  - Agent delegation via invoke_agent
  - Confusion signals (uncertainty, clarification_needed, etc.)
  - Thinking/response length metrics
- **Source**: Live testing with uvx code-puppy
- **Supports**: H8 (infrastructure telemetry is sufficient)
- **Key Finding**: Works with `uvx code-puppy` via user plugins directory - no local clone needed

## E18: Token Usage Gap Identified
- **Type**: Gap / Future Enhancement
- **Date**: 2025-01-11
- **Summary**: Actual API token usage is not available in the `agent_run_end` callback. Code-puppy currently passes only the model name in metadata, not pydantic-ai's `result.usage()` data.
- **Source**: Code inspection of base_agent.py line 1980
- **Future Paths**:
  1. **Estimated tokens (easy)**: Calculate from thinking_length + response_length using ~4 chars = 1 token heuristic
  2. **Actual tokens (PR required)**: Submit PR to code-puppy to pass `result.usage()` in the metadata dict
- **Impact**: Low - estimated tokens sufficient for most post-work analysis

---

## E19: GroceryBrain Validation Complete
- **Type**: Validation
- **Date**: 2025-02-09
- **Summary**: GroceryBrain test case validates core ELCS hypotheses (H6, H8, H9)
- **Source**: Full development session (~8 hours)
- **Metrics**:
  - 9 tokens completed
  - 160 tests passing
  - 11+ checkpoints
  - 4 bugs found and fixed via real-world testing
- **Conclusion**: ELCS enables complex multi-domain AI-assisted development

---

## Evidence Gaps

- No direct testing of Cursor or Windsurf bootstrap behavior yet
- ~~No evidence on multi-agent coordination effectiveness yet~~ → Validated via GroceryBrain (E19)
