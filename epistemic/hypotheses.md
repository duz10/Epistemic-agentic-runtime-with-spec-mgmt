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

## 🟡 Untested Hypotheses

### H6: Distance Vectors Enable Self-Selection (Stage D)
- **Claim**: Distance vectors enable agent self-selection without central dispatcher
- **Confidence**: 0.50
- **Falsification**: If agents cannot meaningfully compute/use distance vectors, or coordination degrades without dispatcher
- **Status**: 🟡 Untested
- **Test Plan**: Implement distance vector computation, test agent self-selection

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
| H6 | Distance vector self-selection | D | 🟡 Untested | 0.50 |

---

*Last updated: 2025-01-10 after H5 coalition contract validation*
