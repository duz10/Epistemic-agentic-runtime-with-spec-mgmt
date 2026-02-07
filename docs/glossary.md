# ELCS Glossary

*Authoritative definitions for all ELCS terminology*

> ⚠️ **ELCS uses specific terminology to prevent confusion with other methodologies.**
> When in an ELCS project, these definitions supersede any similar terms from other systems.

---

## Core Concepts

### Cognitive Light Cone
The **largest goal an agent can pursue** in terms of problem scope and time horizon. Inspired by Michael Levin's work on collective intelligence. Coalitions can *enlarge* the light cone by coupling multiple agents.

### CognitiveCone
A formal structure describing an agent's capabilities:
- **Spaces**: What problem domains it operates in
- **Horizon**: How far ahead it can plan (depth, time)
- **Budgets**: Resource limits (tokens, tool calls, time)
- **Commitments**: Risk tolerance, evidence requirements

### Coalition
A temporary grouping of agents working together on a shared objective. Coalitions *couple* their cognitive cones to tackle larger goals than any single agent could.

### CoalitionContract
A formal agreement defining:
- Purpose (spec/objective being pursued)
- Members (which agents are coupled)
- Shared scope (files, tools, write permissions)
- Exit conditions (when the coalition dissolves)
- Rollback plan (how to undo if things go wrong)
- Budgets (combined resource limits)

---

## Epistemic Primitives

### EpistemicState
The central belief ledger containing:
- **Assumptions**: What we believe is true (with confidence scores)
- **Hypotheses**: Falsifiable claims we're testing
- **Evidence**: Observations supporting/refuting beliefs
- **Constraints**: Hard and soft limits
- **Preferences**: Weighted priorities

### Assumption
An explicit belief held with a confidence score (0.0–1.0). Assumptions can be:
- **Active**: Currently in effect
- **Revised**: Updated based on new evidence
- **Retired**: No longer relevant

### Hypothesis
A falsifiable claim with:
- **Claim**: What we're asserting
- **Confidence**: How sure we are (0.0–1.0)
- **Falsification criteria**: What would prove us wrong
- **Status**: Untested → Testing → Confirmed/Rejected

### Evidence
Observations, measurements, or data that support or refute hypotheses. Every piece of evidence has:
- **Type**: Observation, measurement, experiment, user input
- **Summary**: What was observed
- **Provenance**: Where it came from (traceable)

### Constraint
A limit on what the system can do:
- **Hard constraint**: Non-negotiable (must not violate)
- **Soft constraint**: Preferred but can be relaxed if justified

---

## Coordination Primitives

### WorkToken
The fundamental unit of coordination. A WorkToken represents:
- A **question** to answer
- A **test** to run
- An **evidence gap** to fill
- A **subtask** to complete
- A **conflict** to resolve

WorkTokens have:
- **Type**: question | test | evidence_gap | subtask | conflict
- **Priority**: Urgency ranking
- **Budget**: Resource limits for resolution
- **Status**: open → claimed → done | blocked
- **Required outputs**: What must be produced

### Token Lifecycle
1. **Emit**: Created by lens outputs, gate failures, or conflicts
2. **Claim**: An agent/coalition volunteers based on cone match
3. **Execute**: Work is done via local Ralph Loop
4. **Commit**: Outputs become proposals/evidence
5. **Close**: Token resolved when gates accept updated state

---

## Lenses (Perspectives)

### Lens
A formal perspective that evaluates state from a specific domain. Each lens:
- Defines what it attends to
- Specifies what risks and gaps look like
- Emits WorkTokens for unresolved issues

### Lens Output
The structured result of lens evaluation:
- **risk_flags**: Identified risks with severity
- **questions**: Open questions raised
- **tests_requested**: Tests that should be run
- **evidence_gaps**: Missing information
- **constraints_delta**: New constraints to add

### The 7 Core Lenses

| Lens | Focus |
|------|-------|
| **Philosophy** | Epistemic honesty, hidden assumptions, category errors |
| **Data Science** | Measurability, testability, confounding risks |
| **Safety/Risk** | Failure modes, reversibility, runaway prevention |
| **Topology** | Structure stability, phase transitions, path dependence |
| **Theoretical Math** | Logical consistency, minimal axioms, counterexamples |
| **Systems Engineering** | Buildability, interfaces, failure recovery |
| **Product/UX** | User value, adoption, MVP definition |

---

## Goals & Gates

### Earned Goal
A goal that has passed all 6 gates. Goals are *outputs* of the epistemic process, not inputs. You don't start with goals—you earn them.

### The 6 Gates
Every candidate goal must pass:

| Gate | Question |
|------|----------|
| **1. Observables** | Does this goal have measurable outcomes? |
| **2. Testability** | Does it have clear success/failure criteria? |
| **3. Reversibility** | Is there a rollback plan if it fails? |
| **4. Confidence** | Is confidence above threshold (≥0.6)? |
| **5. Lens Agreement** | Do 3+ lenses approve? |
| **6. Evidence Grounding** | Is it based on actual evidence? |

---

## Memory & Compression

### Journal
Compressed narrative checkpoints of what happened. Journals capture:
- Key learnings
- Assumption changes
- Constraint discoveries
- Hypothesis outcomes
- Artifact links

### Archives
Full state bundles stored for later retrieval. Archives contain:
- Complete telemetry
- Full epistemic state snapshot
- All artifacts produced

### Codec (DecompressionKey)
Metadata that allows future agents to correctly interpret compressed state. Includes:
- Glossary (term definitions)
- Retrieval queries (how to find related info)
- Artifact index (what files exist)
- Assumption map (context for beliefs)

### TelemetryLog
Append-only event stream capturing micro-state. High fidelity, expensive, rarely read directly. The source of truth for replay/recovery.

---

## The Ralph Loop

### Ralph Loop (Observe → Orient → Decide → Act → Observe)
The universal primitive for all cognition in ELCS. Everything is a Ralph loop.

1. **Observe**: Read current state + new information
2. **Orient**: Interpret via lenses/preferences
3. **Decide**: Propose action/test/interaction/refusal
4. **Act**: Perform reversible move or gated commitment
5. **Observe**: Log outcomes and update state

### Key Properties
- **Loops are local**: No omniscient planner required
- **Loops can end early**: Refusal is valid
- **Loops are inspectable**: Every step leaves provenance
- **Loops are composable**: Loops can nest (agents calling agents)

---

## Progressive Formalization

### Level 0 — Epistemic Substrate Only (Minimum Viable ELCS)
- EpistemicState, Lenses, Goal Gates
- WorkTokens from lens outputs
- Journal + Archives + Telemetry

### Level 1 — Distance Vector
- Add DistanceVector computed from artifacts
- Enables self-selection for work

### Level 2 — Named Spaces
- SpecSpace, EvidenceSpace, RiskSpace, ExecutionSpace
- Improved modularity for decentralization

### Level 3 — Formal Problem Spaces
- Formal state schemas, goal regions, metrics, transforms
- Topology lens becomes concrete

### Level 4 — Space DSL (Advanced)
- Learned spaces, metric evolution
- Research/framework mode

---

## Scaling Stages

### Stage A — Single Agent + Human
One active agent, human approval for high-risk actions.

### Stage B — Handoffs & Validators
Multiple agents claiming tokens, validator roles for quality.

### Stage C — Coalitions + Contracts
Coalition formation for multi-space tokens.

### Stage D — Metric-Driven Emergence
Tokens and distance vectors drive coordination.

### Stage E — Formal Spaces + Topology
Reachability analysis, obstruction detection.

---

## Anti-Patterns

### Cone Shrinkage
When agents optimize local metrics because coupling to global goals weakened. The ELCS equivalent of "agentic cancer."

### Infinite Sensemaking
Endless analysis without commitment. Prevented by:
- Information budgets
- Forced artifacts
- Pause triggers
- Human override

### Preference Drift
Gradual change in preferences without explicit justification. Detected via diff artifacts and periodic identity checks.

---

*Last updated: Stage 1 completion*
