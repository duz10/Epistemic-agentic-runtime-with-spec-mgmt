# ELCS Scaling Stages

*How ELCS grows from single developer to multi-agent coalitions*

---

## Overview

ELCS scales operationally through 5 stages:

```
┌────────────────────────────────────────────────────────┐
│                   SCALING STAGES                        │
├────────────────────────────────────────────────────────┤
│                                                        │
│  Stage E: Formal Spaces + Topology                    │
│  │ Reachability analysis, obstruction detection       │
│  │                                                    │
│  Stage D: Metric-Driven Emergence                     │
│  │ Tokens and distance vectors drive coordination     │
│  │                                                    │
│  Stage C: Coalitions + Contracts                      │
│  │ Multi-agent teams with formal agreements           │
│  │                                                    │
│  Stage B: Handoffs & Validators                       │
│  │ Multiple agents, quality gates                     │
│  │                                                    │
│  Stage A: Single Agent + Human   ← START HERE         │
│  (One active agent, human approval for risk)          │
│                                                        │
└────────────────────────────────────────────────────────┘
```

---

## Stage A: Single Agent + Human

### Description
One active agent executing Ralph loops. Human provides approval for high-risk actions and course corrections.

### Characteristics
- Single agent reads/writes ELCS artifacts
- Human reviews proposals before major commits
- Simple file-based coordination
- No agent-to-agent coordination needed

### Who It's For
- Solo developers
- Learning ELCS
- Small well-defined projects
- Rapid prototyping

### Success Metric
> You can pause/resume long efforts without losing context.

### What You Need
- ELCS template structure
- PROTOCOL.md followed by agent
- Human available for approval gates
- Regular journal checkpoints

### Example Workflow
```
Human: "Build a REST API for user management"
    ↓
Agent: Reads ELCS state, creates spec
    ↓
Agent: Applies lenses, identifies gaps
    ↓
Agent: Proposes goals through 6 gates
    ↓
Human: Approves goals
    ↓
Agent: Executes build phases
    ↓
Agent: Checkpoints regularly
    ↓
Human: Reviews and approves commits
```

---

## Stage B: Handoffs & Validators

### Description
Multiple agents participate, claiming tokens based on capability. Validator agents enforce quality gates.

### Characteristics
- Multiple specialized agents
- Token claiming based on capability match
- Validator roles (test runner, security checker, linter)
- Still acceptable to have lightweight dispatcher
- Not yet emergent coordination

### Who It's For
- Projects with distinct concerns (frontend/backend/testing)
- Teams wanting quality gates
- When one agent isn't enough

### Success Metric
> Throughput rises without quality dropping.

### What You Add
- Agent capability declarations
- Validator agents with blocking power
- Token routing logic
- Handoff protocols

### Example Workflow
```
Token: "Implement auth endpoint"
    ↓
Code Agent: Claims token, implements
    ↓
Code Agent: Marks token as "needs validation"
    ↓
Test Agent: Claims validation, runs tests
    ↓
Test Agent: Approves or rejects
    ↓
Security Agent: Reviews for vulnerabilities
    ↓
Token: Closed when all validators pass
```

### Validator Types
| Validator | What It Checks | Blocking? |
|-----------|---------------|----------|
| Test Runner | Tests pass | Yes |
| Security | No known vulnerabilities | Yes |
| Linter | Code style | No (advisory) |
| Coverage | Test coverage threshold | Configurable |
| Docs | Documentation exists | No (advisory) |

---

## Stage C: Coalitions + Contracts

### Description
Agents form temporary teams (coalitions) to tackle multi-domain tokens. CoalitionContracts define the coupling.

### Characteristics
- Coalition formation for complex tasks
- Formal contracts with scope and exit conditions
- Shared cognitive cones
- Explicit rollback plans per coalition
- Budget pooling and tracking

### Who It's For
- Complex multi-domain features
- Projects requiring tight agent coordination
- When handoffs aren't enough

### Success Metric
> Larger projects become feasible without a central executive agent.

### What You Add
- CoalitionContract schema
- Coalition formation protocol
- Shared state within coalitions
- Dissolution triggers

### Coalition Formation Protocol
```
1. Token requires multiple cones
    ↓
2. Agent A proposes coalition
    ↓
3. Agent B accepts with capability offer
    ↓
4. Contract created:
   - Purpose: Token resolution
   - Members: [A, B]
   - Scope: Specific files/tools
   - Exit: Token complete or timeout
   - Rollback: Git branch
    ↓
5. Coalition works via shared tokens
    ↓
6. Exit condition met → dissolution
```

### Example Contract
```json
{
  "coalition_id": "auth-impl-001",
  "purpose": "Implement OAuth2 authentication",
  "members": ["backend-agent", "security-agent"],
  "scope": {
    "files": ["src/auth/**", "tests/auth/**"],
    "tools": ["read_file", "write_file", "run_tests"],
    "writes_allowed": true
  },
  "exit_conditions": ["objective_complete", "budget_exhausted"],
  "rollback_plan": "git revert to branch main",
  "budgets": {"time_seconds": 3600}
}
```

---

## Stage D: Metric-Driven Emergence

### Description
Coordination emerges from distance vectors and token priorities. No central dispatcher needed.

### Characteristics
- Distance vectors guide work selection
- Agents self-select based on "can I reduce distance?"
- Token markets (bidding, cost/benefit)
- Drift detection via global metrics
- Exploration budget for novel approaches

### Who It's For
- Large-scale projects
- Multi-team coordination
- When explicit orchestration is bottleneck

### Success Metric
> Coordination remains coherent even when you remove a manager agent.

### What You Add
- Distance vector computation
- Self-selection protocols
- Token market mechanics
- Drift detection alerts

### How It Works
```
┌─────────────────────────────────────────────────────────┐
│              METRIC-DRIVEN COORDINATION                 │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  1. System computes DistanceVector                     │
│     {criteria: 5, risks: 2, gaps: 3, blocked: 1}      │
│                                                         │
│  2. Each agent evaluates:                              │
│     "Can I reduce any component?"                      │
│                                                         │
│  3. Agents bid on tokens they can help with           │
│                                                         │
│  4. Work happens (Ralph loops)                         │
│                                                         │
│  5. DistanceVector recomputed                          │
│     {criteria: 4, risks: 1, gaps: 2, blocked: 0}      │
│                                                         │
│  6. Drift check: Did global distance decrease?         │
│     - Yes → healthy                                    │
│     - No → investigate (local gains, global loss)     │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### Drift Detection
```
If: Agent improved local metric
But: Global distance increased
Then: "Cone shrinkage" warning

Action: Review agent's work
        Possibly rollback
        Adjust coupling strength
```

---

## Stage E: Formal Spaces + Topology

### Description
Full formal problem space definitions enable reachability analysis and obstruction detection.

### Characteristics
- Formal transforms with preconditions
- Reachability computation
- Obstruction detection
- Path dependence tracking
- Metric composition across spaces

### Who It's For
- Very large projects
- Research projects
- Framework development
- When dead ends are expensive

### Success Metric
> Fewer dead ends, earlier detection of contradictory specs/constraints.

### What You Add
- ProblemSpaceDefinitions
- Transform schemas
- Reachability algorithms
- Obstruction detectors

### Example: Obstruction Detection
```
Current state: {auth: "password", 2fa: "none"}
Target state: {auth: "oauth", 2fa: "totp"}

Transforms available:
- enable_oauth (requires: 2fa ≠ none)
- enable_totp (requires: auth = oauth)

Analysis:
- Can't enable_oauth first (2fa = none)
- Can't enable_totp first (auth ≠ oauth)
- OBSTRUCTION DETECTED

Resolution:
- Need new transform: enable_totp_for_password_auth
- Or: Relax preconditions
```

---

## Scaling Decision Guide

### When to Move from A → B
| Signal | What's Happening |
|--------|------------------|
| One agent is bottleneck | Need parallelism |
| Quality issues slipping through | Need validators |
| "Agent can't do this domain" | Need specialists |

### When to Move from B → C
| Signal | What's Happening |
|--------|------------------|
| Handoffs are error-prone | Need tighter coupling |
| Complex tokens need multiple skills | Need coalitions |
| Coordination overhead is high | Need formal contracts |

### When to Move from C → D
| Signal | What's Happening |
|--------|------------------|
| Dispatcher is bottleneck | Need self-organization |
| "Who should do this?" takes too long | Need market signals |
| Coalition management overhead | Need emergent coordination |

### When to Move from D → E
| Signal | What's Happening |
|--------|------------------|
| Frequent dead ends | Need path analysis |
| "Is this even possible?" questions | Need reachability |
| Expensive failed attempts | Need obstruction detection |

---

## Stage Compatibility

| Feature | A | B | C | D | E |
|---------|---|---|---|---|---|
| EpistemicState | ✓ | ✓ | ✓ | ✓ | ✓ |
| WorkTokens | ✓ | ✓ | ✓ | ✓ | ✓ |
| 6 Gates | ✓ | ✓ | ✓ | ✓ | ✓ |
| Lenses | ✓ | ✓ | ✓ | ✓ | ✓ |
| Journal | ✓ | ✓ | ✓ | ✓ | ✓ |
| Multiple Agents | - | ✓ | ✓ | ✓ | ✓ |
| Validators | - | ✓ | ✓ | ✓ | ✓ |
| Coalitions | - | - | ✓ | ✓ | ✓ |
| Distance Vector | - | - | ○ | ✓ | ✓ |
| Self-Selection | - | - | - | ✓ | ✓ |
| Formal Spaces | - | - | - | - | ✓ |
| Reachability | - | - | - | - | ✓ |

(○ = optional)

---

## Anti-Patterns

### Premature Scaling
**Problem**: Jumping to Stage C before Stage A works.
**Result**: Complexity without benefit.
**Fix**: Master each stage before advancing.

### Cone Shrinkage
**Problem**: Agents optimize locally, harm globally.
**Result**: "Progress" that doesn't help.
**Fix**: Distance vector drift detection, coupling strength.

### Coalition Sprawl
**Problem**: Too many coalitions, unclear boundaries.
**Result**: Coordination overhead exceeds benefit.
**Fix**: Clear exit conditions, automatic dissolution.

### Metric Goodharting
**Problem**: Agents game metrics.
**Result**: Metrics improve, reality doesn't.
**Fix**: Multiple balanced metrics, Philosophy lens review.

---

*Scale when simple fails. Not before.*
