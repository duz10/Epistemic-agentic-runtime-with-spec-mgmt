# ELCS Progressive Formalization

*Ship shallow, grow deep — how ELCS scales with your needs*

---

## The Core Idea

ELCS is designed to work at different levels of formalization:

- **Start simple** (Level 0): Just the basics
- **Add structure as needed** (Levels 1-4): Only when you see problems that require it
- **Never add complexity for its own sake**: Each level must solve a real problem

```
┌────────────────────────────────────────────────────────┐
│                  FORMALIZATION LEVELS                   │
├────────────────────────────────────────────────────────┤
│                                                        │
│  Level 4: Space DSL + Learned Spaces                  │
│  │ (Research / Framework mode)                        │
│  │                                                    │
│  Level 3: Formal Problem Spaces                       │
│  │ (Reachability analysis, obstruction detection)     │
│  │                                                    │
│  Level 2: Named Spaces                                │
│  │ (SpecSpace, EvidenceSpace, RiskSpace, etc.)       │
│  │                                                    │
│  Level 1: Distance Vector                             │
│  │ (Quantified progress tracking)                    │
│  │                                                    │
│  Level 0: Epistemic Substrate   ← START HERE          │
│  (State, Lenses, Gates, Tokens, Journal)             │
│                                                        │
└────────────────────────────────────────────────────────┘
```

---

## Level 0: Epistemic Substrate (Minimum Viable ELCS)

### What You Get
- EpistemicState (assumptions, hypotheses, evidence, constraints)
- 7 Lenses for evaluation
- 6-Gate protocol for earned goals
- WorkTokens for coordination
- Journal + Archives for memory
- Stage-gated workflow

### When It's Enough
- Single developer projects
- Well-defined scope
- Low coordination complexity
- Learning ELCS for the first time

### What You Don't Need Yet
- Formal "spaces" or distance calculations
- Coalition contracts
- Telemetry infrastructure
- Metric-driven coordination

---

## Level 1: Distance Vector

### What You Add
A **DistanceVector** computed from your existing artifacts:

```json
{
  "distance_vector": {
    "success_criteria_remaining": 5,
    "critical_risks": 2,
    "evidence_gaps": 3,
    "rollback_readiness": 0.8,
    "blocked_tokens": 1
  },
  "computed_at": "2025-01-20T10:00:00Z"
}
```

### Why It Helps
- Agents can self-select work by asking: "Can I reduce a component?"
- Progress becomes quantified, not just vibes
- Coordination emerges naturally

### When to Upgrade
Escalate to Level 1 when you see:
- Confusion about what to work on next
- Difficulty measuring progress
- Multiple agents needing coordination signals

### Implementation
Simple script that reads artifacts and computes:
```python
def compute_distance_vector():
    return {
        "success_criteria_remaining": count_pending_criteria(),
        "critical_risks": count_critical_risks(),
        "evidence_gaps": count_evidence_gaps(),
        "rollback_readiness": assess_rollback_coverage(),
        "blocked_tokens": count_blocked_tokens()
    }
```

---

## Level 2: Named Spaces

### What You Add
Explicit space labels for different concern domains:

| Space | What It Tracks |
|-------|---------------|
| **SpecSpace** | Deliverables, tasks, success criteria |
| **EvidenceSpace** | Hypotheses, confidence, evidence coverage |
| **RiskSpace** | Reversibility, blast radius, drift risk |
| **ExecutionSpace** | Token backlog, budgets, loop depth |

### Why It Helps
- Lenses declare which space(s) they write to
- Decentralization becomes safer (clear boundaries)
- Debugging becomes easier (which space has the problem?)

### When to Upgrade
Escalate to Level 2 when you see:
- Multiple agents stepping on each other
- Unclear who owns what
- Need for better modularity

### Implementation
Add space tags to artifacts:
```json
{
  "token_id": "uuid",
  "spaces": ["spec_space", "execution_space"],
  "summary": "Define API contracts"
}
```

---

## Level 3: Formal Problem Spaces

### What You Add
Full formal definitions for each space:

```yaml
problem_space:
  id: "spec_space.v1"
  state_schema: "SpecStateV1"
  goal_region_schema: "SpecGoalV1"
  metric:
    type: "multiobjective"
    components:
      - {name: "success_criteria_remaining", direction: "minimize"}
      - {name: "open_questions", direction: "minimize"}
  transforms:
    - {id: "propose_spec_patch", type: "spec_edit"}
    - {id: "create_work_token", type: "coordination"}
```

### Why It Helps
- Topology lens can do real reachability analysis
- Path dependence becomes explicit
- Obstruction detection becomes possible

### When to Upgrade
Escalate to Level 3 when you see:
- Topology lens frequently returns "unclear"
- Dead ends that waste significant effort
- Need for formal constraint satisfaction

### This Is Advanced
Most projects never need Level 3. It's for:
- Large-scale multi-team coordination
- Research projects exploring the space
- Building reusable coordination patterns

---

## Level 4: Space DSL + Learned Spaces

### What You Add
- Domain-specific language for defining spaces
- Ability to learn/evolve spaces from data
- Cross-space metric composition

### Why It Helps
- Spaces can evolve with the project
- Patterns can be extracted and reused
- Meta-learning about coordination

### When to Upgrade
Almost never. This is for:
- ELCS framework development itself
- Research into coordination patterns
- Multi-project portfolio management

### Warning
This level has significant complexity cost. Only adopt if:
- You have strong evidence it's needed
- You've mastered Levels 0-2
- You have resources for ongoing maintenance

---

## Escalation Criteria

**Only move up a level when you see repeated failures that the next level would prevent.**

### Level 0 → Level 1
| Signal | What's Happening |
|--------|------------------|
| "What should I work on?" confusion | No coordination signal |
| "Are we making progress?" uncertainty | No quantified metrics |
| Multiple agents duplicating work | No self-selection mechanism |

### Level 1 → Level 2
| Signal | What's Happening |
|--------|------------------|
| Agents stepping on each other | Unclear boundaries |
| "Which lens owns this?" confusion | No space ownership |
| Debugging coordination failures is hard | No modularity |

### Level 2 → Level 3
| Signal | What's Happening |
|--------|------------------|
| Frequent dead ends | No obstruction detection |
| "Is this even reachable?" questions | No path analysis |
| Order-dependent failures | Untracked path dependence |

### Level 3 → Level 4
| Signal | What's Happening |
|--------|------------------|
| Patterns repeat across projects | No pattern extraction |
| Space definitions feel limiting | Need evolution |
| Portfolio-level coordination needed | Multi-project scope |

---

## Complexity Guardrails

**Rules for staying sane:**

1. **No microstate obsession**: Telemetry is truth, but decisions must be coarse-grained
2. **Map/territory discipline**: Metrics are hypotheses, not reality
3. **Budgets everywhere**: Everything has limits
4. **Compression includes keys**: Every summary must be decompress-able
5. **Human legibility wins**: If you can't explain it simply, don't ship it

---

## Quick Decision Tree

```
START: Do you have basic ELCS working?
│
├─ NO → Stay at Level 0, get basics working
│
└─ YES → Are agents confused about what to work on?
    │
    ├─ NO → Stay at current level
    │
    └─ YES → Is it a prioritization problem?
        │
        ├─ YES → Add Distance Vector (Level 1)
        │
        └─ NO → Is it a boundary/ownership problem?
            │
            ├─ YES → Add Named Spaces (Level 2)
            │
            └─ NO → Is it a path/reachability problem?
                │
                ├─ YES → Consider Formal Spaces (Level 3)
                │
                └─ NO → You might have a different problem
```

---

*Add complexity only when simple fails. Measure the failure first.*
