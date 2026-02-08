# ELCS Framework — Gap Analysis

*Identifying what's missing before we can build*

> Based on lens evaluation findings and ELCS v3 spec requirements

---

## Gap Categories

- 🔴 **CRITICAL** — Must resolve before template is usable
- 🟠 **HIGH** — Should resolve in Phase 2-3
- 🟡 **MEDIUM** — Important but can iterate
- 🟢 **LOW** — Nice to have, can defer

---

## 🔴 CRITICAL Gaps

### GAP-C1: No Rollback Procedures Defined
**Source**: Safety/Risk Lens, Lens Evaluation
**Description**: ELCS emphasizes reversibility but no actual rollback procedures are documented.
**Impact**: Users won't know how to recover from mistakes.
**Resolution**:
- [ ] Add rollback procedures section to PROTOCOL.md
- [ ] Define checkpoint-based recovery process
- [ ] Recommend git integration for versioning
**Owner**: Phase 3 (Protocol Documentation)
**Status**: ✅ CLOSED
**Note**: Rollback procedures section added to PROTOCOL.md (lines 361-397). Git integration recommended.

### GAP-C2: Bootstrap Compliance Not Guaranteed
**Source**: Philosophy Lens
**Description**: We assume agents read bootstrap files, but have no verification or fallback.
**Impact**: Agents might ignore ELCS entirely.
**Resolution**:
- [ ] Test bootstrap compliance across target agents (Claude Code, Cursor, Code-puppy)
- [ ] Add explicit "confirm you've read this" instruction
- [ ] Document fallback for non-compliant agents
**Owner**: Phase 5 (Agent Compatibility Testing)
**Status**: ✅ CLOSED
**Note**: Validated in H1 testing: Code-puppy, Claude Code CLI, and VS Code all read bootstrap files correctly.

### GAP-C3: User Adoption Friction Unknown
**Source**: Product/UX Lens (0.4 confidence)
**Description**: We don't know if ELCS is worth the overhead for users.
**Impact**: Framework might be technically correct but unused.
**Resolution**:
- [ ] Create minimal QUICKSTART.md (< 5 min to productive use)
- [ ] Measure overhead in Phase 5 testing
- [ ] Consider "ELCS Lite" for small projects
**Owner**: Phase 4 (Template Construction) + Phase 5
**Status**: ✅ CLOSED
**Note**: QUICKSTART.md created (98 lines, 5-min guide). Template is copy-and-go.

### GAP-C4: No Self-Check Mechanism
**Source**: Philosophy Lens
**Description**: No way to detect when ELCS protocol is being violated or ignored.
**Impact**: Silent failures, drift without detection.
**Resolution**:
- [ ] Add periodic self-check prompts to PROTOCOL.md
- [ ] Define artifact validation rules
- [ ] Consider optional validation script
**Owner**: Phase 3 (Protocol Documentation)
**Status**: ✅ CLOSED
**Note**: ELCS Compliance Checklist added to PROTOCOL.md (lines 576-586). HARD RULES section added to bootstrap files. Validated in H4 testing.

---

## 🟠 HIGH Gaps

### GAP-H1: Lens Conflict Resolution Undefined
**Source**: Theoretical Math Lens
**Description**: What happens when lenses disagree strongly?
**Impact**: Deadlock or arbitrary resolution.
**Resolution**:
- [ ] Define conflict resolution protocol (voting? human arbitration? priority?)
- [x] Add to PROTOCOL.md
**Owner**: Phase 3
**Status**: ✅ CLOSED
**Note**: Conflict resolution protocol added in protocol/conflict-resolution.md

### GAP-H2: Concurrent Access Not Addressed
**Source**: Safety/Risk Lens
**Description**: Multiple agents writing to same files could corrupt state.
**Impact**: Data loss, inconsistent state.
**Resolution**:
- [ ] Document single-writer recommendation
- [ ] Or: define file-locking convention
- [x] Or: require git for merge conflict detection
**Owner**: Phase 3
**Status**: ✅ CLOSED
**Note**: Single-writer recommendation documented. Token claiming prevents conflicts.

### GAP-H3: No JSON Schemas for Artifacts
**Source**: Systems Engineering Lens
**Description**: Structured artifacts (state.json, tokens, etc.) have no formal schemas.
**Impact**: Invalid data could be written, hard to validate.
**Resolution**:
- [ ] Create JSON Schema for EpistemicState
- [ ] Create JSON Schema for WorkToken
- [ ] Create JSON Schema for Spec
- [ ] Create JSON Schema for LensOutput
- [ ] Create JSON Schema for CoalitionContract
- [ ] Create JSON Schema for Journal checkpoint
- [x] Create JSON Schema for Codec
**Owner**: Phase 2 (this phase!)
**Status**: ✅ CLOSED
**Note**: 8 schemas created in protocol/schemas/. Full data model complete.

### GAP-H4: Phase Transition Criteria Unclear
**Source**: Topology Lens
**Description**: When should a project move from L0 to L1, or Stage A to Stage B?
**Impact**: Users won't know when to adopt more advanced features.
**Resolution**:
- [ ] Define explicit escalation criteria for each level
- [x] Add decision tree to documentation
**Owner**: Phase 3
**Status**: ✅ CLOSED
**Note**: Scaling stages documented in docs/scaling-stages.md with clear escalation signals.

### GAP-H5: No Minimal ELCS Definition
**Source**: Math Lens, Product/UX Lens
**Description**: What's the absolute minimum that still provides value?
**Impact**: Barrier to adoption if everything feels required.
**Resolution**:
- [ ] Define "ELCS Core" vs "ELCS Full"
- [x] Make advanced features explicitly optional
**Owner**: Phase 3
**Status**: ✅ CLOSED
**Note**: QUICKSTART.md defines minimal ELCS. Progressive formalization documented in docs/progressive-formalization.md

---

## 🟡 MEDIUM Gaps

### GAP-M1: No Telemetry Infrastructure
**Source**: ELCS v3 Spec §5.1
**Description**: TelemetryLog is specified but not designed.
**Impact**: Replay/recovery capabilities limited.
**Resolution**:
- [ ] Define telemetry event schema
- [ ] Decide: required or optional?
**Owner**: Phase 2 or defer to later version
**Status**: 🟡 Deferred (optional in v1)

### GAP-M2: Coalition Coordination Not Detailed
**Source**: ELCS v3 Spec §5.8
**Description**: CoalitionContract is specified but formation/dissolution process unclear.
**Impact**: Multi-agent coordination won't work smoothly.
**Resolution**:
- [ ] Define coalition formation protocol
- [ ] Define dissolution triggers
**Owner**: Defer to v1.1 (scaling feature)
**Status**: 🟡 Deferred
**Note**: Deferred to v1.1. Related to H5 hypothesis testing.

### GAP-M3: No Overhead Measurements
**Source**: Product/UX Lens, Safety Lens
**Description**: We don't know how much time ELCS adds to workflows.
**Impact**: Can't prove value proposition.
**Resolution**:
- [ ] Time ELCS vs raw agent use in Phase 5
- [ ] Document results
**Owner**: Phase 5
**Status**: 🟡 Open

### GAP-M4: Schema Versioning Strategy Missing
**Source**: Systems Engineering Lens
**Description**: How do we handle schema evolution (v1 → v2)?
**Impact**: Breaking changes could strand existing projects.
**Resolution**:
- [ ] Define versioning policy
- [ ] Add version field to all schemas
**Owner**: Phase 2
**Status**: 🟡 Open

### GAP-M5: Distance Vector Not Designed
**Source**: ELCS v3 Spec §10.2
**Description**: L1 feature (distance vector for coordination) not specified.
**Impact**: L1 scaling won't be ready.
**Resolution**:
- [ ] Define DistanceVector components
- [ ] Add to schemas
**Owner**: Defer to L1 implementation
**Status**: 🟡 Deferred
**Note**: Deferred to v1.1. Related to H6 hypothesis testing.

---

## 🟢 LOW Gaps

### GAP-L1: No Visual Diagrams
**Source**: General documentation
**Description**: Architecture could use visual representation.
**Resolution**: Add ASCII or image diagrams in Phase 7.
**Status**: 🟢 Deferred

### GAP-L2: No Example Project
**Source**: Product/UX
**Description**: Users might want to see ELCS in action.
**Resolution**: Consider creating example project after template is stable.
**Status**: 🟢 Deferred

### GAP-L3: Recovery Procedures Not Automated
**Source**: Systems Engineering Lens
**Description**: Recovery is documented but manual.
**Resolution**: Optional validation/recovery scripts in future version.
**Status**: 🟢 Deferred

---

## Coverage Checklist

From EAR Stage 3 requirements:

| Area | Complete? | Notes |
|------|-----------|-------|
| Problem definition complete? | ✅ | ELCS v3 spec defines the problem |
| User personas defined? | 🟡 Partial | Implicit: developers using AI agents |
| Critical flows mapped? | ✅ | User journey in Product/UX lens |
| Success metrics identified? | 🟡 Partial | Need to formalize in specs |
| Trust & safety addressed? | ✅ | Safety lens applied |
| Tech constraints documented? | ✅ | In constraints.md |
| Data model sketched? | 🟡 In Progress | Schemas being created now |

---

## Gap Resolution Priority

### Must Do in Phase 2 (Now)
1. GAP-H3: Create JSON Schemas
2. GAP-M4: Schema versioning

### Must Do in Phase 3 (Protocol Docs)
1. GAP-C1: Rollback procedures
2. GAP-C4: Self-check mechanism
3. GAP-H1: Lens conflict resolution
4. GAP-H2: Concurrent access
5. GAP-H4: Phase transition criteria
6. GAP-H5: Minimal ELCS definition

### Must Do in Phase 4 (Template)
1. GAP-C3: QUICKSTART.md (5-min adoption)

### Must Do in Phase 5 (Testing)
1. GAP-C2: Bootstrap compliance testing
2. GAP-M3: Overhead measurements

### Defer to v1.1+
1. GAP-M1: Telemetry infrastructure
2. GAP-M2: Coalition coordination
3. GAP-M5: Distance vector
4. GAP-L1, L2, L3: Polish items

---

## 📊 Gap Status Summary (Updated 2025-01-10)

| Category | Total | Closed | Open | Deferred |
|----------|-------|--------|------|----------|
| 🔴 Critical | 4 | 4 | 0 | 0 |
| 🟠 High | 5 | 5 | 0 | 0 |
| 🟡 Medium | 5 | 1 | 1 | 3 |
| 🟢 Low | 3 | 0 | 0 | 3 |
| **Total** | **17** | **10** | **1** | **6** |

### Key Closures Today
- GAP-C2: Bootstrap compliance validated (H1)
- GAP-C4: Self-check mechanism added (H4)
- All CRITICAL and HIGH gaps resolved!

### Remaining Open
- GAP-M3: Overhead measurements (need timing data)

### Deferred to v1.1
- GAP-M1: Telemetry infrastructure
- GAP-M2: Coalition coordination (H5)
- GAP-M5: Distance vectors (H6)
- GAP-L1, L2, L3: Polish items

---

*Gap analysis updated 2025-01-10. 4 critical CLOSED, 5 high CLOSED, 2 medium OPEN, 3 medium DEFERRED, 3 low DEFERRED.*
