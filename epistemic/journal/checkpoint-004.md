# Checkpoint 004: Telemetry Architecture & Test Project Planning

**Date**: 2025-01-11
**Stage**: Planning
**State Version**: 7

---

## Summary

Planned telemetry infrastructure for ELCS framework validation. Key decisions:
1. Infrastructure-based telemetry via code-puppy callback hooks (not agent compliance)
2. User plugin at `~/.code_puppy/plugins/elcs_telemetry/`
3. Complex test project with organic, 70-80% defined prompt

---

## Lens Evaluation Conducted

Applied 7 lenses to telemetry design (all 3 tiers vs lean approach):

| Lens | Verdict | Key Finding |
|------|---------|-------------|
| Philosophy | 🟡 Caution | We're designing before knowing what questions we'll ask |
| Data Science | 🟡 Selective | Tier 1 + confusion signals answers our test questions |
| Safety/Risk | 🟢 OK | Add redaction rules for Tier 3 |
| Topology | 🟢 OK | Tiers are additive and independent |
| Math | 🟢 OK | Consistent with ELCS principles |
| Systems | 🟢 OK | Buildable via user plugin |
| Product/UX | 🟡 Selective | Start with Tier 1, cherry-pick from others |

**Recommendation**: Tier 1+ (core events + selective Tier 2/3)

---

## Key Insights

### Artifact-Based Telemetry is Redundant
User correctly identified that watching ELCS file changes just duplicates what's already in artifacts. The artifacts ARE the record. Useful telemetry captures:
- Tool calls (which, when, how long)
- Session timing
- Errors/failures
- Confusion signals
- Token usage

### Code-Puppy Has the Hooks We Need
Discovered existing callback infrastructure in code-puppy:
- `pre_tool_call` / `post_tool_call` — Tool usage
- `agent_run_start` / `agent_run_end` — Session lifecycle
- `edit_file` / `delete_file` — File modifications
- `stream_event` — Real-time streaming

### User Plugin Model Works
Code-puppy loads plugins from `~/.code_puppy/plugins/` automatically. No need to manage local dev version — works with `uvx code-puppy`.

### Universal Telemetry Not Feasible
Claude Code CLI, Cursor, and Windsurf lack hook infrastructure. For these platforms, ELCS artifacts serve as the record. Telemetry is Code-puppy only (for now).

---

## Decisions Made

1. **Telemetry approach**: Infrastructure hooks, not agent compliance
2. **Platform scope**: Code-puppy only (via user plugin)
3. **Event coverage**: Tier 1 + delegation + confusion signals
4. **Test project**: Complex organic prompt (70-80% defined)
5. **GitHub issues created**: 8 issues for all open gaps

---

## New Hypotheses

- **H8**: Infrastructure-based telemetry is sufficient (testing)
- **H9**: Complex organic prompts stress-test agent behavior (proposed)

---

## Next Steps

1. [ ] Design telemetry event schema
2. [ ] Create `~/.code_puppy/plugins/elcs_telemetry/` plugin
3. [ ] Design complex test prompt (domain TBD)
4. [ ] Run test with telemetry enabled
5. [ ] Analyze results, validate H6, H8, H9

---

## Open Questions

- What domain should the test project use? (Personal finance tracker? Recipe planner? Dev tool?)
- Should we run the test single-agent first, then multi-agent?

---

*Checkpoint by planning-agent-11242f*
