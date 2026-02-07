# ELCS Conflict Resolution Protocol

*What happens when lenses disagree or agents conflict*

---

## Types of Conflicts

### 1. Lens Disagreement
Two or more lenses reach different conclusions about the same proposal.

**Example**: 
- Product/UX lens approves (users want this feature)
- Safety lens rejects (introduces security risk)

### 2. Agent Conflict
Multiple agents claim the same WorkToken or produce incompatible outputs.

### 3. Constraint Contradiction
Two constraints cannot both be satisfied.

**Example**:
- C1: "Must complete by Friday"
- C2: "Must have 100% test coverage"
- Reality: Not enough time for both

### 4. Evidence Conflict
Two pieces of evidence point to opposite conclusions.

---

## Resolution Hierarchy

When conflict occurs, resolve in this order:

```
┌─────────────────────────────────────────────────────────┐
│              CONFLICT RESOLUTION HIERARCHY              │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Level 1: SAFETY VETO                                  │
│  └─ Safety/Risk lens can block any proposal            │
│     with "critical" risk flag                          │
│                                                         │
│  Level 2: HARD CONSTRAINT CHECK                        │
│  └─ Any violation of hard constraint = rejection       │
│                                                         │
│  Level 3: EVIDENCE WEIGHT                              │
│  └─ Position with stronger evidence wins               │
│     (quality × recency × relevance)                    │
│                                                         │
│  Level 4: LENS VOTING                                  │
│  └─ Majority of lenses (≥3 of 7) decides              │
│                                                         │
│  Level 5: PREFERENCE WEIGHT                            │
│  └─ Apply soft constraint preferences                  │
│                                                         │
│  Level 6: HUMAN ARBITRATION                            │
│  └─ Escalate to user for decision                      │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## Lens Disagreement Protocol

### Step 1: Document the Disagreement
```json
{
  "conflict_id": "uuid",
  "type": "lens_disagreement",
  "subject": "proposal X",
  "positions": {
    "product_ux": {
      "verdict": "approve",
      "rationale": "Users need this feature",
      "evidence": ["E12", "E15"]
    },
    "safety_risk": {
      "verdict": "reject",
      "rationale": "Introduces auth bypass risk",
      "evidence": ["E18"],
      "severity": "high"
    }
  }
}
```

### Step 2: Check Safety Veto
If Safety lens has severity="critical", **it wins**. Document and move on.

### Step 3: Seek Synthesis
Can both lenses be satisfied?
- "Add this feature WITH additional security controls"
- Create conditions that address both concerns

### Step 4: Evidence Comparison
Which position has stronger evidence?
- More evidence items?
- More recent evidence?
- More direct relevance?

### Step 5: Lens Vote
If still unresolved, count approvals:
- ≥4 approve → proceed with conditions from dissenters
- 3-4 mixed → human decision required
- ≤2 approve → reject

### Step 6: Document Resolution
```json
{
  "conflict_id": "uuid",
  "resolution": "proceed_with_conditions",
  "conditions": ["Implement rate limiting", "Add auth audit logging"],
  "rationale": "Product value outweighs risk when mitigations applied",
  "decided_by": "lens_vote",
  "vote_count": {"approve": 5, "conditional": 1, "reject": 1}
}
```

---

## Agent Conflict Protocol

### Concurrent Claim
Two agents try to claim the same WorkToken.

**Resolution**:
1. First claim timestamp wins
2. If simultaneous, prefer agent with better capability match
3. If still tied, create sub-tokens and divide work

### Incompatible Outputs
Two agents produce conflicting results for related work.

**Resolution**:
1. Create a "conflict" type WorkToken
2. Document both outputs
3. Apply lens evaluation to each
4. Select winner based on evidence/quality
5. Archive rejected output (might be useful later)

### File Conflict
Two agents try to write the same file.

**Resolution**:
1. **Prevent**: Only one agent writes to a file at a time
2. **Detect**: If conflict occurs, treat as merge conflict
3. **Resolve**: Create conflict token, human arbitration

---

## Constraint Contradiction Protocol

### Step 1: Identify the Contradiction
```
C1: "Must complete by Friday" (hard)
C2: "Must have 100% test coverage" (soft)
C3: "Available time is 20 hours"
MATH: Task requires 40 hours for both → impossible
```

### Step 2: Check Hard vs Soft
- Hard constraint wins over soft constraint
- If both hard → escalate to human

### Step 3: Seek Alternatives
- Can we reduce scope?
- Can we extend timeline?
- Can we get more resources?
- Can we change the constraint?

### Step 4: Document Trade-off Decision
```json
{
  "conflict_type": "constraint_contradiction",
  "constraints": ["C1", "C2"],
  "resolution": "relax C2",
  "new_constraint": {
    "id": "C2-revised",
    "severity": "soft",
    "text": "Must have 80% test coverage on critical paths"
  },
  "rationale": "Timeline is immovable; coverage can be improved post-launch",
  "decided_by": "human"
}
```

---

## Evidence Conflict Protocol

### Step 1: Document Both
```json
{
  "conflict_type": "evidence_conflict",
  "evidence_a": {
    "id": "E5",
    "claim": "Users prefer dark mode",
    "source": "Survey N=50"
  },
  "evidence_b": {
    "id": "E12",
    "claim": "Users prefer light mode",
    "source": "A/B test N=1000"
  }
}
```

### Step 2: Evaluate Evidence Quality

| Factor | E5 Score | E12 Score |
|--------|----------|----------|
| Sample size | Low | High |
| Recency | Medium | High |
| Methodology | Survey (stated preference) | A/B test (revealed preference) |
| Relevance | Medium | High |

**Winner**: E12 (revealed preference > stated preference, larger N)

### Step 3: Don't Discard Loser
The losing evidence might indicate:
- A segment that prefers differently
- Changing preferences over time
- Context-dependent preferences

Document for future reference.

---

## Escalation to Human

When to escalate:
- Safety lens critical rejection
- Hard constraint conflict
- Evidence is inconclusive
- High-stakes irreversible decision
- Deadlock after trying all resolution levels

### Escalation Format
```markdown
## 🚨 Human Decision Required

**Conflict**: [Brief description]

**Options**:
1. [Option A] - Supported by: [lenses/evidence]
2. [Option B] - Supported by: [lenses/evidence]
3. [Option C] - Compromise position

**Recommendation**: [Your suggestion with rationale]

**Impact of Delay**: [What happens if we don't decide now]

Please respond with your choice or additional questions.
```

---

## Conflict Prevention

### Best Practices
1. **Early lens application** — Catch conflicts before they're expensive
2. **Clear constraint hierarchy** — Know which constraints are hard vs soft
3. **Evidence gathering** — More evidence = easier resolution
4. **Single-writer files** — Prevent agent file conflicts
5. **Regular checkpoints** — Easy to rollback if conflict causes damage

### Warning Signs
- Repeated lens disagreements on same topic
- Evidence that contradicts assumptions
- Constraints that seem impossible together
- Multiple agents wanting same work

---

*Conflict is information. Embrace it, document it, resolve it systematically.*
