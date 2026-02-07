# ELCS Framework — Lens Evaluation

*Applying the 7 core lenses to evaluate the ELCS framework design itself*

> This is a meta-evaluation: we're using ELCS lenses to evaluate ELCS.
> Any issues found here become WorkTokens for resolution.

---

## 1. Philosophy Lens

**Focus**: Epistemic honesty, hidden assumptions, category errors

### Evaluation

#### Hidden Assumptions Inventory
| Assumption | Risk Level | Notes |
|------------|------------|-------|
| Agents will follow instructions in bootstrap files | 🟡 Medium | May not hold for all agents or user overrides |
| File-based coordination is sufficient for complex work | 🟡 Medium | Latency between file writes/reads could cause issues |
| Users will maintain ELCS artifacts correctly | 🟠 High | No enforcement mechanism; relies on agent discipline |
| Natural language instructions are unambiguous enough | 🟡 Medium | Edge cases will exist |

#### Category Errors
- **Risk**: Conflating "protocol" with "tool" — ELCS is a methodology, not software
- **Mitigation**: Documentation must be clear that ELCS is agent-agnostic

#### Epistemic Humility Check
- ✅ We acknowledge ELCS is untested at scale
- ✅ We have explicit falsification criteria for hypotheses
- ⚠️ We should add more "unknown unknowns" acknowledgment

### Lens Output
```json
{
  "risk_flags": [
    {"severity": "medium", "text": "Bootstrap compliance is assumed, not guaranteed"},
    {"severity": "high", "text": "No enforcement mechanism for artifact maintenance"}
  ],
  "questions": [
    "How do we detect when agents ignore ELCS protocol?",
    "What's the recovery path when artifacts become inconsistent?"
  ],
  "tests_requested": [
    {"id": "T1", "text": "Test bootstrap compliance across 3+ agent environments"}
  ],
  "evidence_gaps": [
    "No data on real-world ELCS adoption patterns"
  ],
  "constraints_delta": [
    {"op": "add", "constraint": {"severity": "soft", "text": "Include self-check prompts in PROTOCOL.md"}}
  ]
}
```

---

## 2. Data Science Lens

**Focus**: Measurability, testability, confounding risks

### Evaluation

#### Identifiability Analysis
| Metric | Measurable? | How? |
|--------|-------------|------|
| Protocol compliance | 🟡 Partial | Check for expected artifact structure |
| Token throughput | ✅ Yes | Count tokens created/closed over time |
| Evidence quality | 🟡 Partial | Subjective; could use proxy metrics |
| Goal achievement | ✅ Yes | Success criteria in spec |
| Drift detection | 🟡 Partial | Compare preference/constraint diffs |

#### Confounding Warnings
- Agent capability vs ELCS effectiveness (hard to separate)
- User discipline vs methodology value
- Project complexity vs coordination overhead

#### Experiment Design
To validate ELCS, we need:
1. **Control**: Same project without ELCS (just raw agent use)
2. **Treatment**: Project with full ELCS protocol
3. **Metrics**: Time to completion, error rate, context recovery success

### Lens Output
```json
{
  "risk_flags": [
    {"severity": "medium", "text": "Attribution of outcomes to ELCS vs agent quality is difficult"}
  ],
  "questions": [
    "How do we measure 'epistemic quality' of a project?",
    "What's the minimal instrumentation needed for telemetry?"
  ],
  "tests_requested": [
    {"id": "T2", "text": "Define 5 measurable success metrics for ELCS adoption"},
    {"id": "T3", "text": "Run controlled comparison: ELCS vs non-ELCS project"}
  ],
  "evidence_gaps": [
    "No baseline data for comparison",
    "No defined threshold for 'protocol compliance'"
  ],
  "constraints_delta": []
}
```

---

## 3. Safety/Risk Lens

**Focus**: Failure modes, reversibility, runaway prevention

### Evaluation

#### Failure Mode Analysis
| Failure Mode | Likelihood | Impact | Mitigation |
|--------------|------------|--------|------------|
| Agent ignores protocol entirely | Medium | High | Multi-entry bootstrap; clear directives |
| Token deadlock (all claimed, none resolved) | Low | High | Timeout/escalation mechanism |
| Artifact corruption/inconsistency | Medium | High | Validation scripts; checksums |
| Infinite loop (circular token creation) | Low | Medium | Depth limits; budget caps |
| State file conflicts (concurrent writes) | Medium | Medium | File locking or single-agent enforcement |
| User bypasses ELCS for speed | High | Medium | Make ELCS lightweight enough to use |

#### Reversibility Assessment
- ✅ All ELCS artifacts are files — can be version-controlled
- ✅ Journal checkpoints enable state recovery
- ⚠️ No automatic rollback mechanism defined
- ⚠️ Concurrent coalition work could create merge conflicts

#### Circuit Breakers Needed
1. Token budget exhaustion → escalate to human
2. Loop detection → force pause
3. Constraint violation → block commit

### Lens Output
```json
{
  "risk_flags": [
    {"severity": "high", "text": "No automatic rollback mechanism defined"},
    {"severity": "medium", "text": "Concurrent writes could corrupt state"},
    {"severity": "high", "text": "User bypass risk is high if ELCS feels heavy"}
  ],
  "questions": [
    "Should ELCS mandate git for artifact versioning?",
    "How do we handle multi-agent concurrent file access?"
  ],
  "tests_requested": [
    {"id": "T4", "text": "Simulate concurrent agent writes to same artifact"},
    {"id": "T5", "text": "Time ELCS overhead vs direct agent use"}
  ],
  "evidence_gaps": [
    "No data on ELCS performance overhead",
    "No real-world failure recovery testing"
  ],
  "constraints_delta": [
    {"op": "add", "constraint": {"severity": "soft", "text": "Recommend git for all ELCS projects"}},
    {"op": "add", "constraint": {"severity": "hard", "text": "Must include rollback procedures in PROTOCOL.md"}}
  ]
}
```

---

## 4. Topology Lens

**Focus**: Structure stability, phase transitions, path dependence

### Evaluation

#### Equivalence Classes
- **Bootstrap files**: CLAUDE.md ≈ .cursorrules ≈ .windsurfrules (functionally equivalent)
- **Token types**: question ≈ evidence_gap (often convertible)
- **Scaling levels**: Not equivalent — L0 ⊂ L1 ⊂ L2 ⊂ L3 ⊂ L4

#### Obstruction Detection
| Obstruction | Description | Resolution Path |
|-------------|-------------|------------------|
| Agent incapability | Some agents can't write files | Require file-writing capability as prerequisite |
| No shared state | Agents can't see each other's work | ELCS artifacts ARE the shared state |
| Circular dependencies | Token A needs B, B needs A | Dependency ordering in token schema |

#### Phase Transitions (Critical Thresholds)
1. **Single agent → Multi-agent**: When WorkTokens require multiple cones
2. **Manual → Emergent**: When token claiming becomes self-organizing
3. **L0 → L1+**: When distance vectors are needed for coordination

#### Path Dependence Risks
- Order of lens application could affect results
- Early constraint choices limit later flexibility
- **Mitigation**: Document all constraints with rationale for potential revision

### Lens Output
```json
{
  "risk_flags": [
    {"severity": "low", "text": "Lens application order not specified"},
    {"severity": "medium", "text": "Phase transition criteria not well-defined"}
  ],
  "questions": [
    "Is there a canonical lens application order?",
    "What triggers the transition from L0 to L1?"
  ],
  "tests_requested": [
    {"id": "T6", "text": "Define explicit escalation criteria for each level transition"}
  ],
  "evidence_gaps": [
    "No data on natural phase transitions in real projects"
  ],
  "constraints_delta": []
}
```

---

## 5. Theoretical Math Lens

**Focus**: Logical consistency, minimal axioms, counterexamples

### Evaluation

#### Consistency Check
| Claim | Consistent? | Notes |
|-------|-------------|-------|
| Goals are earned, not assumed | ✅ Yes | Coherent with gate system |
| Agents are objective-optional | ✅ Yes | Preferences + constraints sufficient |
| Everything is a Ralph Loop | 🟡 Mostly | Meta-processes (human review) might not fit cleanly |
| File-based coordination is sufficient | ⚠️ Unproven | May break down at scale |

#### Minimal Axiom Set
The irreducible core of ELCS:
1. **Ralph Loop is universal** (all cognition follows O→O→D→A→O)
2. **State lives in files** (artifacts are truth, memory is ephemeral)
3. **Goals must pass gates** (earned, not assumed)
4. **Lenses provide perspectives** (no single authority)
5. **Tokens coordinate work** (stigmergic, not hierarchical)

#### Counterexample Search
- **Challenge**: "What if an agent can't read files?" → ELCS requires file-capable agents (documented constraint)
- **Challenge**: "What if gates are too strict and nothing passes?" → Gate thresholds should be configurable
- **Challenge**: "What if all lenses disagree?" → Need conflict resolution protocol

### Lens Output
```json
{
  "risk_flags": [
    {"severity": "medium", "text": "Conflict resolution when lenses disagree is underspecified"}
  ],
  "questions": [
    "What's the minimal ELCS that still provides value?",
    "Can gate thresholds be project-specific?"
  ],
  "tests_requested": [
    {"id": "T7", "text": "Identify the absolute minimal ELCS implementation (Level 0-)"}
  ],
  "evidence_gaps": [
    "No formal proof that 5 axioms are sufficient"
  ],
  "constraints_delta": [
    {"op": "add", "constraint": {"severity": "soft", "text": "Gate thresholds should be configurable per-project"}}
  ]
}
```

---

## 6. Systems Engineering Lens

**Focus**: Buildability, interfaces, failure recovery

### Evaluation

#### Service Boundaries
| Component | Boundary | Interface |
|-----------|----------|----------|
| Bootstrap files | Entry point | Natural language directives |
| EpistemicState | Core state | JSON file read/write |
| Lenses | Evaluation modules | Structured output (LensOutput) |
| Tokens | Coordination layer | JSON files in tokens/ subdirs |
| Journal | Memory layer | Markdown checkpoints |

#### Interface Contracts
All interfaces are file-based:
- **Input**: Read file from expected path
- **Output**: Write file to expected path
- **Schema**: JSON Schema for structured files (to be defined)

#### Failure Recovery
| Failure | Recovery |
|---------|----------|
| Missing artifact | Create from template |
| Malformed JSON | Validation error → fix or restore from git |
| Stale state | Force re-read from files |
| Lost session | Journal + archives enable resume |

#### Observability
- All state changes are file changes → git log is telemetry
- Explicit stage gates → progress is visible in .stages/
- WorkTokens → work backlog is visible

### Lens Output
```json
{
  "risk_flags": [
    {"severity": "medium", "text": "No JSON Schema validation defined yet"},
    {"severity": "low", "text": "Recovery procedures are documented but not automated"}
  ],
  "questions": [
    "Should we provide validation scripts for artifact integrity?",
    "How do we handle schema evolution (v1 → v2)?"
  ],
  "tests_requested": [
    {"id": "T8", "text": "Create JSON Schemas for all structured artifacts"},
    {"id": "T9", "text": "Build optional validation script for artifact integrity"}
  ],
  "evidence_gaps": [
    "No schema versioning strategy defined"
  ],
  "constraints_delta": [
    {"op": "add", "constraint": {"severity": "soft", "text": "All JSON files should have corresponding schemas"}}
  ]
}
```

---

## 7. Product/UX Lens

**Focus**: User value, adoption, MVP definition

### Evaluation

#### Value Hypotheses
| Hypothesis | Confidence | Evidence |
|------------|------------|----------|
| ELCS reduces context loss between sessions | 0.8 | EAR template already demonstrates this |
| ELCS improves project transparency | 0.7 | Artifacts are inspectable by design |
| ELCS is worth the overhead | 0.5 | Unproven; overhead not measured |
| Users will adopt ELCS voluntarily | 0.4 | Requires friction to be very low |

#### User Workflow Analysis
```
User Journey:
1. User has an idea → wants to start a project
2. Runs CLI generator → gets ELCS scaffold
3. Opens folder in preferred agent/IDE
4. Agent reads bootstrap → understands ELCS
5. User says "let's build X" → agent follows ELCS stages
6. Progress persists across sessions via artifacts
7. User can resume anytime with full context
```

**Pain Points to Address**:
- Bootstrap step must be invisible (agent handles it)
- Overhead must be minimal for small projects
- "Happy path" should be obvious

#### MVP Definition
**Minimum Viable ELCS (for user adoption)**:
1. Multi-entry bootstrap files (CLAUDE.md, .cursorrules)
2. PROTOCOL.md with clear instructions
3. Basic state/ and journal/ structure
4. Simple token system (open → done, no complex lifecycle)

**NOT in MVP**:
- Coalitions
- Formal problem spaces
- Telemetry infrastructure
- Distance vectors

#### Adoption Risks
| Risk | Mitigation |
|------|------------|
| Too complex for casual use | Offer "ELCS Lite" option |
| Competes with agent's built-in features | Clear messaging: ELCS is protocol, not tool |
| Learning curve too steep | Excellent QUICKSTART.md + tutorial |

### Lens Output
```json
{
  "risk_flags": [
    {"severity": "high", "text": "User adoption confidence is only 0.4"},
    {"severity": "medium", "text": "Overhead vs value not yet proven"}
  ],
  "questions": [
    "What's the absolute minimal ELCS that still provides value?",
    "Should we have an 'ELCS Lite' mode for small projects?"
  ],
  "tests_requested": [
    {"id": "T10", "text": "Measure time overhead of ELCS vs raw agent use"},
    {"id": "T11", "text": "User test: can someone unfamiliar follow ELCS?"}
  ],
  "evidence_gaps": [
    "No user testing data",
    "No overhead measurements"
  ],
  "constraints_delta": [
    {"op": "add", "constraint": {"severity": "hard", "text": "QUICKSTART.md must enable productive use within 5 minutes"}}
  ]
}
```

---

## Summary: Aggregated Lens Output

### Risk Flags (by severity)

#### 🔴 High Severity
1. No automatic rollback mechanism defined (Safety)
2. User bypass risk is high if ELCS feels heavy (Safety)
3. No enforcement mechanism for artifact maintenance (Philosophy)
4. User adoption confidence is only 0.4 (Product/UX)

#### 🟠 Medium Severity
1. Bootstrap compliance is assumed, not guaranteed (Philosophy)
2. Attribution of outcomes to ELCS vs agent quality is difficult (Data Science)
3. Concurrent writes could corrupt state (Safety)
4. Conflict resolution when lenses disagree is underspecified (Math)
5. No JSON Schema validation defined yet (Systems)
6. Phase transition criteria not well-defined (Topology)
7. Overhead vs value not yet proven (Product/UX)

#### 🟢 Low Severity
1. Lens application order not specified (Topology)
2. Recovery procedures are documented but not automated (Systems)

### Tests Requested
| ID | Test | Requesting Lens |
|----|------|------------------|
| T1 | Test bootstrap compliance across 3+ agent environments | Philosophy |
| T2 | Define 5 measurable success metrics for ELCS adoption | Data Science |
| T3 | Run controlled comparison: ELCS vs non-ELCS project | Data Science |
| T4 | Simulate concurrent agent writes to same artifact | Safety |
| T5 | Time ELCS overhead vs direct agent use | Safety |
| T6 | Define explicit escalation criteria for each level transition | Topology |
| T7 | Identify the absolute minimal ELCS implementation | Math |
| T8 | Create JSON Schemas for all structured artifacts | Systems |
| T9 | Build optional validation script for artifact integrity | Systems |
| T10 | Measure time overhead of ELCS vs raw agent use | Product/UX |
| T11 | User test: can someone unfamiliar follow ELCS? | Product/UX |

### New Constraints Proposed
| Source | Severity | Constraint |
|--------|----------|------------|
| Philosophy | Soft | Include self-check prompts in PROTOCOL.md |
| Safety | Soft | Recommend git for all ELCS projects |
| Safety | Hard | Must include rollback procedures in PROTOCOL.md |
| Math | Soft | Gate thresholds should be configurable per-project |
| Systems | Soft | All JSON files should have corresponding schemas |
| Product/UX | Hard | QUICKSTART.md must enable productive use within 5 minutes |

### Evidence Gaps (Priority Order)
1. No user testing data
2. No overhead measurements
3. No baseline data for comparison
4. No data on real-world ELCS adoption patterns
5. No data on natural phase transitions in real projects

---

## Next Steps

Based on this lens evaluation:

1. **Immediate**: Address high-severity risks in Phase 2 design
2. **Phase 3**: Ensure PROTOCOL.md includes rollback procedures and self-checks
3. **Phase 5**: Run tests T1, T5, T10, T11 during agent compatibility testing
4. **Future**: Gather evidence to close gaps

*Lens evaluation complete. Ready for gap analysis.*
