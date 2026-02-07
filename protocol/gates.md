# ELCS Goal Gates Protocol

*Goals are earned, not assumed. Every goal must pass 6 gates.*

---

## The Core Principle

> In ELCS, objectives are **outputs** of the epistemic process, not inputs.
> A goal becomes actionable only after demonstrating it's worth pursuing.

This prevents:
- Premature commitment to poorly-defined goals
- Wasted effort on unvalidated directions
- "Infinite sensemaking" without action
- Unbounded scope creep

---

## The 6 Gates

Every candidate goal must pass ALL gates before it can drive work.

### Gate 1: Observables 🔭
**Question**: Does this goal have measurable outcomes?

| Pass Criteria | Fail Criteria |
|--------------|---------------|
| Success criteria are defined | Vague or subjective outcomes |
| Metrics can be computed | "We'll know it when we see it" |
| Observable changes specified | Only internal state changes |

**Example**:
- ✅ "Users can complete onboarding in < 5 minutes"
- ❌ "Make the product feel better"

---

### Gate 2: Testability 🧪
**Question**: Does it have clear success/failure criteria?

| Pass Criteria | Fail Criteria |
|--------------|---------------|
| Binary or threshold-based criteria | Ambiguous evaluation |
| Test method defined | No way to verify |
| Edge cases considered | Only happy path defined |

**Example**:
- ✅ "API returns 200 for valid requests, 400 for malformed"
- ❌ "The API works well"

---

### Gate 3: Reversibility ↩️
**Question**: Is there a rollback plan if it fails?

| Pass Criteria | Fail Criteria |
|--------------|---------------|
| Rollback procedure documented | "We'll figure it out" |
| Blast radius bounded | Unknown downstream effects |
| Recovery time estimated | No recovery path |

**Reversibility Categories**:
- **Trivial**: Undo in seconds (e.g., revert commit)
- **Easy**: Undo in minutes (e.g., restore from backup)
- **Hard**: Undo in hours/days (e.g., database migration rollback)
- **Irreversible**: Cannot undo (e.g., email sent, data deleted)

**For irreversible actions**: Require additional human approval gate.

---

### Gate 4: Confidence Threshold 📊
**Question**: Is confidence above minimum threshold?

| Level | Threshold | Use Case |
|-------|-----------|----------|
| Exploration | ≥ 0.3 | Early ideas, hypotheses |
| Development | ≥ 0.6 | Active implementation |
| Commitment | ≥ 0.8 | Production deployment |

**Confidence Sources**:
- Evidence supporting the goal
- Prior success with similar goals
- Lens agreement (see Gate 5)
- Expert judgment

**If confidence too low**: 
- Create WorkTokens to gather evidence
- Return to goal candidate later

---

### Gate 5: Lens Agreement 🔍
**Question**: Do 3+ lenses approve this goal?

Each lens votes: **Approve**, **Conditional Approve**, **Reject**, or **Abstain**

| Voting Result | Outcome |
|---------------|----------|
| ≥3 Approve (no Critical rejections) | ✅ Pass |
| ≥3 Approve (with conditions) | ✅ Pass with conditions |
| <3 Approve or any Critical rejection | ❌ Fail |
| Majority Abstain | ⚠️ Re-evaluate (more lenses needed) |

**Lens Voting Weights** (optional, for complex decisions):
- Safety/Risk lens rejection = veto power
- Other lenses = equal weight

**If disagreement**:
- Document dissenting views
- Create WorkTokens for resolution
- Or escalate to human decision

---

### Gate 6: Evidence Grounding 📚
**Question**: Is this goal based on actual evidence?

| Pass Criteria | Fail Criteria |
|--------------|---------------|
| Links to supporting evidence | Pure speculation |
| Evidence is recent and relevant | Outdated or tangential data |
| Provenance is traceable | "Trust me" |

**Evidence Requirements by Goal Type**:
- **Technical goals**: Test results, benchmarks, prior implementation data
- **Product goals**: User feedback, analytics, market research
- **Process goals**: Historical metrics, team feedback

---

## Gate Evaluation Process

### Step 1: Candidate Goal Formation
```json
{
  "goal_id": "G1",
  "statement": "Implement user authentication with OAuth2",
  "proposed_by": "planning_phase",
  "created_at": "2025-01-20T10:00:00Z"
}
```

### Step 2: Gate Evaluation
```json
{
  "goal_id": "G1",
  "gates": {
    "observables": {
      "passed": true,
      "criteria": ["User can log in via Google", "Session persists for 24h"],
      "evidence": ["E12"]
    },
    "testability": {
      "passed": true,
      "test_plan": "Integration tests for login flow",
      "evidence": ["E13"]
    },
    "reversibility": {
      "passed": true,
      "category": "easy",
      "rollback_plan": "Revert to email/password auth",
      "evidence": []
    },
    "confidence": {
      "passed": true,
      "score": 0.75,
      "threshold": 0.6,
      "evidence": ["E14", "E15"]
    },
    "lens_agreement": {
      "passed": true,
      "votes": {
        "systems_engineering": "approve",
        "safety_risk": "conditional_approve",
        "product_ux": "approve",
        "topology": "abstain"
      },
      "conditions": ["Implement rate limiting before launch"]
    },
    "evidence_grounding": {
      "passed": true,
      "supporting_evidence": ["E12", "E14", "E16"],
      "evidence_quality": "strong"
    }
  },
  "overall": "PASSED",
  "conditions": ["Implement rate limiting before launch"],
  "evaluated_at": "2025-01-20T10:30:00Z"
}
```

### Step 3: Outcome Handling

**If PASSED**:
- Goal becomes actionable
- Create WorkTokens for implementation
- Add to active spec

**If PASSED WITH CONDITIONS**:
- Goal is actionable but conditions must be tracked
- Conditions become constraints or linked WorkTokens

**If FAILED**:
- Document which gate(s) failed and why
- Create WorkTokens to address gaps
- Return to candidate pool for re-evaluation

---

## Quick Reference Card

```
┌─────────────────────────────────────────────────────────────────┐
│                    ELCS 6-GATE CHECKLIST                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  □ Gate 1: OBSERVABLES                                         │
│    Can we measure success?                                      │
│                                                                 │
│  □ Gate 2: TESTABILITY                                         │
│    Can we verify pass/fail?                                     │
│                                                                 │
│  □ Gate 3: REVERSIBILITY                                       │
│    Can we undo if wrong?                                        │
│                                                                 │
│  □ Gate 4: CONFIDENCE ≥ 0.6                                    │
│    Are we confident enough?                                     │
│                                                                 │
│  □ Gate 5: LENS AGREEMENT (3+ approve)                         │
│    Do perspectives align?                                       │
│                                                                 │
│  □ Gate 6: EVIDENCE GROUNDING                                  │
│    Is this based on data?                                       │
│                                                                 │
├─────────────────────────────────────────────────────────────────┤
│  ALL GATES PASSED? → Goal is actionable                        │
│  ANY GATE FAILED?  → Create WorkTokens, re-evaluate later      │
└─────────────────────────────────────────────────────────────────┘
```

---

## Configurable Thresholds

Projects can adjust thresholds based on context:

| Parameter | Default | Range | Notes |
|-----------|---------|-------|-------|
| `confidence_threshold` | 0.6 | 0.3-0.9 | Lower for exploration, higher for production |
| `min_lens_approval` | 3 | 2-7 | Fewer for simple projects, more for critical |
| `safety_lens_veto` | true | boolean | Can Safety lens block alone? |
| `require_human_for_irreversible` | true | boolean | Human gate for irreversible actions |

Store in project configuration:
```json
{
  "gate_config": {
    "confidence_threshold": 0.6,
    "min_lens_approval": 3,
    "safety_lens_veto": true,
    "require_human_for_irreversible": true
  }
}
```

---

*Goals are earned through evidence, tested through lenses, and only then do they guide action.*
