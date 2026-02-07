# ELCS Lens Guide

*How to apply the 7 core lenses*

---

## What Are Lenses?

Lenses are **typed evaluators** — formal perspectives that analyze state and proposals from specific domains. Each lens:

- Defines what it attends to
- Specifies what risks and gaps look like
- Produces structured output (risk flags, questions, tests, constraints)
- Contributes to goal gate voting

**Lenses are not "smart people." They are systematic checks.**

---

## The 7 Core Lenses

| # | Lens | Domain | Key Question |
|---|------|--------|-------------|
| 1 | Philosophy | Epistemic honesty | Are we being honest about what we know? |
| 2 | Data Science | Measurement | Can we measure and test this? |
| 3 | Safety/Risk | Failure modes | What could go wrong? |
| 4 | Topology | Structure | Is the structure stable? |
| 5 | Theoretical Math | Consistency | Is this logically sound? |
| 6 | Systems Engineering | Buildability | Can we actually build this? |
| 7 | Product/UX | User value | Does this help users? |

---

## Lens Output Format

Every lens produces this structure:

```json
{
  "lens_id": "philosophy",
  "evaluated_at": "2025-01-20T10:00:00Z",
  "target": {"type": "spec", "id": "uuid"},
  
  "risk_flags": [
    {"severity": "medium", "text": "Hidden assumption detected"}
  ],
  "questions": [
    "What does 'fast' mean operationally?"
  ],
  "tests_requested": [
    {"id": "T1", "text": "Define metrics for 'fast'"}
  ],
  "evidence_gaps": [
    "No data on actual user latency tolerance"
  ],
  "constraints_delta": [
    {"op": "add", "constraint": {"severity": "soft", "text": "Define SLA before launch"}}
  ],
  "approval": {
    "approved": true,
    "conditions": ["Define 'fast' operationally"]
  }
}
```

---

## Lens 1: Philosophy 🧠

**Domain**: Epistemic honesty, assumptions, meaning

### What It Checks
- Hidden assumptions
- Category errors (confusing model with reality)
- Overconfidence without justification
- Vague or undefined terms
- Circular reasoning

### Questions It Asks
- What are we assuming is true?
- What would change our mind?
- Are we using terms consistently?
- Are we confusing "useful" with "true"?

### Red Flags
- 🔴 "We just know this is right"
- 🔴 No falsification criteria for hypotheses
- 🟠 Confidence scores without evidence links
- 🟠 Terms used without definition

### Sample Evaluation
```markdown
### Philosophy Lens Evaluation

**Target**: Auth system spec

**Hidden Assumptions**:
- Users have email addresses
- OAuth providers are reliable
- Session tokens are secure

**Undefined Terms**:
- "secure" — needs operational definition
- "fast login" — what's the latency target?

**Epistemic Humility Check**:
⚠️ High confidence (0.9) on security without penetration test data

**Recommendation**: Define "secure" and "fast" operationally before proceeding.
```

---

## Lens 2: Data Science 📊

**Domain**: Measurement, testing, experiment design

### What It Checks
- Identifiability (can we measure this?)
- Confounding risks
- Goodhart effects (gaming metrics)
- Statistical power
- Reproducibility

### Questions It Asks
- How will we know if this worked?
- What metrics will we track?
- What could confound our measurements?
- Do we have enough data?

### Red Flags
- 🔴 No success metrics defined
- 🔴 "We'll know it when we see it"
- 🟠 Single metric without balancing
- 🟠 No baseline data

### Sample Evaluation
```markdown
### Data Science Lens Evaluation

**Target**: "Improve user engagement"

**Measurability Assessment**:
| Metric | Measurable? | Confounds |
|--------|-------------|----------|
| DAU | ✅ | Seasonality, marketing |
| Time on site | ✅ | Auto-play, stuck users |
| "Engagement" | ❌ | Not defined |

**Recommendations**:
1. Define "engagement" as composite metric
2. Establish baseline before changes
3. Plan A/B test with holdout group
```

---

## Lens 3: Safety/Risk ⚠️

**Domain**: Failure modes, reversibility, runaway prevention

### What It Checks
- What can go wrong?
- Blast radius of failures
- Recovery procedures
- Runaway loops
- Abuse vectors

### Questions It Asks
- What's the worst case?
- Can we undo this?
- How do we detect failure?
- Who gets hurt if this breaks?

### Red Flags
- 🔴 Irreversible action without human gate
- 🔴 No rollback plan
- 🔴 Unbounded recursion possible
- 🟠 Missing error handling
- 🟠 No circuit breakers

### Special Power
**Safety lens has VETO power on critical risks.**

### Sample Evaluation
```markdown
### Safety/Risk Lens Evaluation

**Target**: Payment processing feature

**Failure Mode Analysis**:
| Mode | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Double charge | Low | High | Idempotency keys |
| Payment lost | Low | Critical | Transaction logging |
| Timeout | Medium | Medium | Retry with backoff |

**Reversibility**: Hard (refunds take days)

**CRITICAL**: Must implement idempotency before launch.

**Approval**: Conditional — requires idempotency implementation
```

---

## Lens 4: Topology 🔗

**Domain**: Structure, stability, phase transitions

### What It Checks
- Dependency structure
- Connected components
- Path dependence (order matters?)
- Phase transitions (small change → big effect?)
- Obstructions (impossible mappings)

### Questions It Asks
- What depends on what?
- Is this structure stable?
- Does order matter?
- Are there tipping points?

### Red Flags
- 🔴 Circular dependencies
- 🟠 Single point of failure
- 🟠 Tightly coupled components
- 🟡 Path-dependent decisions without documentation

### Sample Evaluation
```markdown
### Topology Lens Evaluation

**Target**: Microservices architecture

**Dependency Graph**:
```
API Gateway → Auth Service → User DB
           → Payment Service → Payment Gateway
                            → User DB (shared!)
```

**Findings**:
- User DB is single point of failure
- Payment → Auth dependency creates coupling
- No circuit breakers between services

**Phase Transition Risk**:
If User DB fails, both Auth and Payment fail simultaneously.

**Recommendation**: Add caching and circuit breakers.
```

---

## Lens 5: Theoretical Math 🔢

**Domain**: Logical consistency, minimal axioms

### What It Checks
- Do assumptions conflict?
- Is the system overdetermined?
- Are there counterexamples?
- What's the minimal axiom set?

### Questions It Asks
- Can all constraints be satisfied simultaneously?
- What must be true for this to work?
- What would be a counterexample?

### Red Flags
- 🔴 Contradictory constraints
- 🔴 Impossible requirements
- 🟠 Unnecessary assumptions
- 🟡 Missing edge cases

### Sample Evaluation
```markdown
### Theoretical Math Lens Evaluation

**Target**: Scheduling algorithm

**Consistency Check**:
- C1: "All meetings must have buffers" ✓
- C2: "Back-to-back meetings allowed for VIPs" ✓
- C1 ∧ C2: Consistent (VIPs are exception to C1)

**Minimal Axiom Set**:
1. Meetings have start/end times
2. Users have calendars
3. Conflicts are detectable
4. VIP status is binary

**Counterexample Search**:
What if a meeting spans midnight? → Need date handling

**Recommendation**: Add date boundary handling.
```

---

## Lens 6: Systems Engineering 🔧

**Domain**: Buildability, interfaces, operations

### What It Checks
- Can we actually build this?
- What are the interfaces?
- How do we deploy/operate?
- What are the failure recovery procedures?

### Questions It Asks
- What's the tech stack?
- How do components communicate?
- How do we deploy updates?
- How do we monitor?

### Red Flags
- 🔴 No deployment plan
- 🔴 Missing error handling
- 🟠 Unclear interfaces
- 🟠 No monitoring strategy

### Sample Evaluation
```markdown
### Systems Engineering Lens Evaluation

**Target**: New API endpoint

**Interface Specification**:
- Input: JSON body with `{userId, action}`
- Output: JSON `{success, data?, error?}`
- Auth: Bearer token required

**Deployment**:
- Blue-green deployment via CI/CD
- Feature flag for gradual rollout
- Rollback: revert to previous container

**Observability**:
- Logging: Structured JSON logs
- Metrics: Request count, latency, error rate
- Alerting: PagerDuty on 5xx rate > 1%

**Approval**: ✅ Approved
```

---

## Lens 7: Product/UX 🎨

**Domain**: User value, adoption, experience

### What It Checks
- Does this solve a real user problem?
- Is it usable?
- Will users adopt it?
- What's the MVP?

### Questions It Asks
- Who is this for?
- What pain does it solve?
- How will users discover this?
- What's the minimum viable version?

### Red Flags
- 🔴 No clear user benefit
- 🔴 Solution looking for a problem
- 🟠 Complex onboarding
- 🟠 No adoption strategy

### Sample Evaluation
```markdown
### Product/UX Lens Evaluation

**Target**: Export to PDF feature

**User Value**:
- Users requested this (Evidence: E23, E24)
- Solves "I need to share reports" pain
- Competitive table stakes

**Adoption Path**:
- Discoverable via "Share" button
- No onboarding needed (familiar pattern)
- Progressive enhancement (can add options later)

**MVP Definition**:
- Single-page export: Yes
- Multi-page: v2
- Custom formatting: v3

**Approval**: ✅ Approved for MVP scope
```

---

## Applying Lenses

### When to Apply
- **Stage 2**: Apply all 7 to initial state
- **Before major decisions**: At least 3 lenses
- **For high-risk changes**: All 7 lenses
- **For quick checks**: Safety + Product minimum

### How to Apply
1. Select lens
2. Review target (spec, proposal, state)
3. Work through lens-specific questions
4. Document findings in structured format
5. Aggregate into LensOutput JSON

### Minimum Lens Coverage

| Decision Type | Required Lenses |
|---------------|----------------|
| Quick feature | Product, Safety |
| Architecture change | All 7 |
| Security feature | Safety, Systems, Math |
| UX change | Product, Philosophy |
| Performance optimization | Systems, Data Science |

---

*Lenses don't make decisions. They surface what you might have missed.*
