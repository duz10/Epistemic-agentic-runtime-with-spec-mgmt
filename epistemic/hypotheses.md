# ELCS Project Hypotheses

*Falsifiable claims we're testing through this project*

---

## ✅ Validated Hypotheses

### H2: Pure File-Based Protocol Is Sufficient
- **Claim**: ELCS protocol can be followed by agents without custom tooling
- **Confidence**: 0.95 (was 0.80)
- **Falsification**: If agents require custom tools/APIs to follow ELCS
- **Status**: ✅ VALIDATED (2025-01-10)
- **Evidence**: E4 — Agent followed ELCS protocol (tokens, claims, checkpoints) using only file-based artifacts

### H3: WorkToken Coordination Enables Emergence
- **Claim**: WorkToken-based coordination will enable emergent multi-agent collaboration
- **Confidence**: 0.85 (was 0.60)
- **Falsification**: If token claiming leads to deadlocks or no coordination improvement
- **Status**: ✅ VALIDATED (2025-01-10)
- **Evidence**: E5 — Bernard delegated WT-008 to python-programmer sub-agent while implementing 3 other tokens in parallel. No conflicts, proper attribution.

### H7: Natural Rigor Scaling
- **Claim**: Agents naturally scale rigor to risk without explicit instruction
- **Confidence**: 0.80
- **Falsification**: If agents apply same ceremony to trivial and complex tasks
- **Status**: ✅ VALIDATED (2025-01-10)
- **Evidence**: E6 — Agent created single token for simple work, but 4 parallel tokens + sub-agent delegation for complex work. Scaled without instruction.

### H1: Multi-Entry Bootstrap Works Cross-Platform
- **Claim**: Multi-entry bootstrap (CLAUDE.md + .cursorrules + .windsurfrules) will work across 3+ agent environments
- **Confidence**: 0.90 (was 0.70)
- **Falsification**: If any major agent environment ignores all bootstrap files
- **Status**: ✅ VALIDATED (2025-01-10)
- **Evidence**: E7 — Same ELCS project successfully read by Code-puppy (AGENTS.md), Claude Code CLI (CLAUDE.md), and VS Code Claude chat mode (CLAUDE.md). All three understood project state and context.

### H4: Validator/Compliance Enforcement Works (Stage B)
- **Claim**: Protocol rules can enforce quality gates and compliance when made prominent
- **Confidence**: 0.85 (was 0.65)
- **Falsification**: If agents ignore prominent rules or compliance fails despite visibility
- **Status**: ✅ VALIDATED (2025-01-10)
- **Evidence**: E8 — After adding HARD RULES section to CLAUDE.md/AGENTS.md with visual checklist, agent followed full token lifecycle: created token BEFORE work, ran pre-edit checklist, ran compliance checklist, wrote checkpoint. First fully compliant token (WT-012).
- **Key Insight**: Rules buried in 800-line PROTOCOL.md get skipped. Rules prominently displayed in bootstrap files get followed.

### H5: Coalition Contracts Enable Multi-Agent Coordination (Stage C)
- **Claim**: Coalition contracts enable tighter agent coupling without conflict
- **Confidence**: 0.90 (was 0.55)
- **Falsification**: If coalitions produce more conflicts than solo agents, or exit conditions fail to trigger
- **Status**: ✅ VALIDATED (2025-01-10)
- **Evidence**: E9 — Coalition CC-001-web-calculator successfully coordinated 6 agents (planning-agent, python-programmer, code-puppy, qa-kitten + 2 validators) across 4 tokens with 6 explicit handoffs. Validators had blocking power (both approved). Scope boundaries respected. Coalition dissolved cleanly when all exit conditions met.
- **Key Deliverables**: Flask backend, HTML/JS frontend, 41 unit tests, 14 E2E tests — all coordinated without conflicts.

---

## 🟡 Partially Tested Hypotheses

### H6: Distance Vectors Enable Self-Selection (Stage D)
- **Claim**: Distance vectors enable agent self-selection without central dispatcher
- **Confidence**: 0.90 (was 0.60)
- **Falsification**: If agents cannot meaningfully compute/use distance vectors, or coordination degrades without dispatcher
- **Status**: ✅ VALIDATED (2025-02-09)
- **Evidence**: E10, E11, E12, E19 (GroceryBrain showed natural agent delegation patterns)

#### Validation Results (GroceryBrain Test Case)
| Observation | Evidence |
|-------------|----------|
| Agents picked appropriate work | planning-agent planned, code-puppy coded |
| Delegation happened naturally | `invoke_agent` used for implementation tasks |
| No role confusion | Clear separation of concerns |

#### Previous Testing (2025-01-10)
1. **Infrastructure Built**: Distance vector schema created, self-selection protocol added to PROTOCOL.md, "Protocol First" HARD RULE added to all bootstrap files.

2. **Test Scenario**: Calculator project with 3 issues (security vulnerability, failing test, missing docs). Asked agent to "figure out what matters most and handle it."

3. **Result**: Agent successfully self-selected and prioritized (security → test → docs) using **intuition**, not formal distance vectors.

4. **Key Finding**: When priorities are obvious (CRITICAL vs MEDIUM), agents use common sense effectively. Distance vectors provide structure when needed but don't create overhead when priorities are clear.

#### Infrastructure Ready
- ✅ `protocol/schemas/distance-vector.schema.json`
- ✅ Self-selection protocol in `template/elcs/PROTOCOL.md`
- ✅ "Protocol First" rule in all bootstrap files
- ✅ GroceryBrain validates multi-agent coordination works

---

### H8: Infrastructure-Based Telemetry Is Sufficient
- **Claim**: Infrastructure-based telemetry (via code-puppy callback hooks) provides sufficient observability for framework validation without requiring agent compliance
- **Confidence**: 0.90 (was 0.75)
- **Falsification**: If the callback hooks fail to capture meaningful events, or if we need agent-initiated logging to understand behavior
- **Status**: ✅ VALIDATED (2025-01-11)
- **Evidence**: E13, E14, E17

#### Validation Results
Built and tested `~/.code_puppy/plugins/elcs_telemetry/` plugin. Successfully captures:
- Session start/end with agent, model, session_id
- Tool calls with args, duration_ms, session_id
- File operations (edit, create, delete) with file_path
- Shell commands with command, cwd, timeout
- Agent delegation via invoke_agent
- Confusion signals (uncertainty, clarification_needed, etc.)
- Thinking/response length metrics

#### Design Decisions
1. **Observational, not participatory**: Telemetry captures events via infrastructure hooks, not by asking agents to log
2. **Code-puppy only (for now)**: Other platforms (Claude Code CLI, Cursor, Windsurf) lack hook infrastructure
3. **Tier 1+ approach**: Core events (tool calls, session lifecycle) plus selective Tier 2/3 (delegation, confusion signals)
4. **User plugin model**: Telemetry plugin lives at `~/.code_puppy/plugins/elcs_telemetry/`

#### Key Insight (from lens evaluation)
Artifact-based telemetry is redundant — ELCS artifacts ARE the record. Useful telemetry captures what ISN'T in artifacts: tool calls, timing, errors, agent confusion.

#### Technical Discoveries During Implementation
1. **stream_event for tool calls**: `pre_tool_call`/`post_tool_call` exist but aren't wired to built-in tools. Used `stream_event` with `ToolCallPart` detection.
2. **Pydantic payloads**: `edit_file` callback receives Pydantic models, not dicts. Required attribute access.
3. **Confusion detection works**: Pattern matching on response text successfully detects uncertainty signals.

---

### H9: Complex Organic Prompts Stress-Test Agent Behavior
- **Claim**: Complex, organic test prompts (70-80% defined with mixed requirements/questions/gaps) effectively stress-test agent parsing, prioritization, and ELCS compliance
- **Confidence**: 0.90 (was 0.70)
- **Falsification**: If agents handle complex prompts identically to simple ones, or if complexity doesn't reveal new behaviors
- **Status**: ✅ VALIDATED (2025-02-09)
- **Evidence**: E19 (GroceryBrain was 70% defined, handled gracefully)

#### Validation Results (GroceryBrain Test Case)
| Observation | Evidence |
|-------------|----------|
| Multi-domain prompt handled | Discord + OCR + DB + parsing + learning |
| 70% defined scope worked | Open questions resolved during build |
| Ambiguity handled gracefully | Lens evaluation surfaced unknowns |
| Real bugs found and fixed | CLAHE, store detection, FTS5 issues |

#### Test Prompt Characteristics (Validated)
- 70-80% defined (clear enough to start, fuzzy enough to require decisions) ✅
- Mixed content: hard requirements, soft preferences, open questions, known gaps, rough phases ✅
- Realistic scope (not trivial, not massive) ✅
- Triggered: parsing, prioritization, token creation, clarifying questions, delegation ✅

---

## Hypothesis Testing Summary

| ID | Claim | Stage | Status | Confidence |
|----|-------|-------|--------|------------|
| H2 | Pure file-based protocol | A | ✅ Validated | 0.95 |
| H3 | WorkToken coordination | A-B | ✅ Validated | 0.85 |
| H7 | Natural rigor scaling | A | ✅ Validated | 0.80 |
| H1 | Multi-entry bootstrap | A | ✅ Validated | 0.90 |
| H4 | Validator/compliance enforcement | B | ✅ Validated | 0.85 |
| H5 | Coalition contracts | C | ✅ Validated | 0.90 |
| H6 | Distance vector self-selection | D | 🟡 Partial | 0.60 |
| H8 | Infrastructure-based telemetry sufficient | - | ✅ Validated | 0.90 |
| H9 | Complex organic prompts stress-test behavior | - | 📋 Proposed | 0.70 |

---

*Last updated: 2025-02-09 after GroceryBrain validation (H6, H8, H9 validated)*
