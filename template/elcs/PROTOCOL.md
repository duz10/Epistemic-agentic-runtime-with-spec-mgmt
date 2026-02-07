# ELCS Protocol v1.0

> **Epistemic Light-Cone Swarm — Agent Operating Instructions**

---

## 🚨 PRIME DIRECTIVE

**You are in an ELCS project. This protocol governs all work.**

> Your context window is VOLATILE. ELCS artifacts are TRUTH.
> If it's not written to `elcs/`, it didn't happen.
> The test: if this session crashes RIGHT NOW, does the work survive?

---

## 📋 Before ANY Action

Every time you start working (new session or resuming), you MUST:

1. **Read** `elcs/state/current.json` — understand current beliefs & constraints
2. **Read** `elcs/spec/spec.json` (if exists) — understand the objective
3. **Check** `elcs/tokens/open/` — see what work is pending
4. **Check** `elcs/.gates/` — see which stages are complete
5. **Read** latest `elcs/journal/checkpoint-*.md` — understand recent context

**If the user jumps straight to "build X" without setup:**
> "I see this is an ELCS project. Let me first check the project state to proceed correctly."
> Then read the files above before responding to their request.

---

## 🔄 The Ralph Loop (Universal Primitive)

ALL cognition in ELCS follows this loop:

```
┌─────────────────────────────────────────────────────────┐
│                    RALPH LOOP                           │
│                                                         │
│   ┌──────────┐                                         │
│   │ OBSERVE  │ ← Read state, tokens, spec, context     │
│   └────┬─────┘                                         │
│        ↓                                               │
│   ┌──────────┐                                         │
│   │  ORIENT  │ ← Apply lenses, identify gaps           │
│   └────┬─────┘                                         │
│        ↓                                               │
│   ┌──────────┐                                         │
│   │  DECIDE  │ ← Choose smallest valuable move         │
│   └────┬─────┘                                         │
│        ↓                                               │
│   ┌──────────┐                                         │
│   │   ACT    │ ← Execute (with rollback plan)          │
│   └────┬─────┘                                         │
│        ↓                                               │
│   ┌──────────┐                                         │
│   │ OBSERVE  │ ← Log outcomes, update state            │
│   └──────────┘                                         │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

**Key Properties:**
- Loops are LOCAL — no omniscient planner required
- Loops can END EARLY — refusal is valid
- Loops are INSPECTABLE — every step leaves provenance
- Loops are COMPOSABLE — loops can nest

---

## 📁 ELCS Directory Structure

```
elcs/
├── PROTOCOL.md          ← You are here
├── QUICKSTART.md        ← Fast onboarding guide
│
├── state/               ← EpistemicState (belief ledger)
│   ├── current.json     ← Current state (versioned)
│   ├── assumptions.md   ← What we believe is true
│   ├── hypotheses.md    ← Claims we're testing
│   ├── evidence.md      ← Supporting observations
│   └── constraints.md   ← Hard/soft limits
│
├── spec/                ← The Spec Attractor (goal space)
│   ├── spec.json        ← Structured spec
│   ├── objectives.md    ← What we're building
│   └── success-criteria.md
│
├── lenses/              ← Lens evaluation outputs
│   ├── philosophy.md
│   ├── data-science.md
│   ├── safety-risk.md
│   ├── topology.md
│   ├── theoretical-math.md
│   ├── systems-engineering.md
│   └── product-ux.md
│
├── tokens/              ← WorkTokens (coordination)
│   ├── open/            ← Work available to claim
│   ├── claimed/         ← Work in progress
│   └── closed/          ← Completed work
│
├── journal/             ← Compressed checkpoints
│   └── checkpoint-NNN.md
│
├── archives/            ← Full state bundles (on demand)
│
├── telemetry/           ← Micro-state logs (optional)
│
└── .gates/              ← Stage completion records
    ├── stage-0.complete
    └── ...
```

---

## 🎯 The ELCS Stages

Work progresses through stages. Each stage:
- Produces specific ARTIFACTS (files on disk)
- Writes `.gates/stage-N.complete` when done
- CANNOT proceed to N+1 until N is complete

### Stage 0: Project Setup
**Create directory structure and initial files.**

Artifacts:
- [ ] `elcs/` directory structure
- [ ] `elcs/PROTOCOL.md` (this file)
- [ ] `elcs/state/current.json` (empty initial state)

Gate check: `ls elcs/` shows expected structure

### Stage 1: Epistemic State
**Interview user, surface assumptions, define constraints.**

Questions to ask:
1. What problem are you solving? For whom?
2. What are you assuming is true?
3. What would prove you wrong?
4. What are the hard constraints (non-negotiable)?
5. What are the soft constraints (preferences)?
6. What evidence do you already have?

Artifacts:
- [ ] `elcs/state/current.json` (populated)
- [ ] `elcs/state/assumptions.md`
- [ ] `elcs/state/hypotheses.md`
- [ ] `elcs/state/evidence.md`
- [ ] `elcs/state/constraints.md`

Gate check: All 5 files exist with content

### Stage 2: Lens Evaluation
**Apply the 7 lenses to current state.**

| Lens | Question |
|------|----------|
| Philosophy | Are we epistemically honest? Hidden assumptions? |
| Data Science | Can we measure this? How do we test it? |
| Safety/Risk | What could go wrong? Failure modes? |
| Topology | Is the structure stable? Phase transitions? |
| Theoretical Math | Is this logically consistent? |
| Systems Engineering | Can we build this? Interfaces? |
| Product/UX | Does this help users? What's MVP? |

Artifacts:
- [ ] `elcs/lenses/*.md` (one per lens)

Gate check: At least 5 lens evaluations complete

### Stage 3: Gap Analysis
**Identify what's missing before building.**

Categorize gaps:
- 🔴 CRITICAL — Must resolve before building
- 🟠 HIGH — Should resolve soon
- 🟡 MEDIUM — Important but can iterate
- 🟢 LOW — Nice to have

Artifacts:
- [ ] Gap analysis document with prioritized list

Gate check: All CRITICAL gaps have resolution paths

### Stage 4: Goal Emergence
**Generate candidate goals and pass through 6 gates.**

The 6 Gates:
1. ✅ **Observables** — Measurable outcomes?
2. ✅ **Testability** — Clear success/failure criteria?
3. ✅ **Reversibility** — Rollback plan exists?
4. ✅ **Confidence** — Above threshold (≥0.6)?
5. ✅ **Lens Agreement** — 3+ lenses approve?
6. ✅ **Evidence Grounding** — Based on actual data?

Artifacts:
- [ ] Candidate goals with gate evaluations
- [ ] Approved goals marked as actionable

Gate check: At least one goal passes all 6 gates

### Stage 5: Spec & MVP Planning
**Create the spec and minimal viable plan.**

Artifacts:
- [ ] `elcs/spec/spec.json` (structured spec)
- [ ] `elcs/spec/objectives.md`
- [ ] `elcs/spec/success-criteria.md`
- [ ] Phased build plan with milestones

Gate check: Spec has success criteria and phases defined

### Stage 6: Readiness Check
**Final verification before building.**

Checklist:
- [ ] All CRITICAL gaps resolved?
- [ ] No open TODOs in specs?
- [ ] Rollback plan documented?
- [ ] Human approval obtained?

**GET EXPLICIT USER APPROVAL BEFORE PROCEEDING TO BUILD.**

Gate check: User has approved proceeding

### Stage 7+: Build & Iterate
**Execute the plan, checkpoint regularly.**

After each milestone:
```
🔍 CHECKPOINT: [Milestone Name]
✅ Completed: [What was built]
🧪 Verified: [What was tested]
⚠️ Issues: [Any problems]
📋 Spec Compliance: [Which specs met]
➡️ Next: [Next milestone]
```

Write journal checkpoint after each major phase.

---

## 🎫 WorkToken Protocol

WorkTokens are the unit of coordination.

### Token Types
- `question` — Something to answer
- `test` — Something to verify
- `evidence_gap` — Missing information
- `subtask` — Work to complete
- `conflict` — Disagreement to resolve

### Token Lifecycle
```
EMIT → CLAIM → EXECUTE → COMMIT → CLOSE
```

1. **Emit**: Created by lens outputs, gate failures, or conflicts
2. **Claim**: Agent volunteers based on capability match
3. **Execute**: Work via local Ralph Loop
4. **Commit**: Outputs become proposals/evidence
5. **Close**: Token resolved when gates accept

### When to Create Tokens (Auto-Triggers)

**You MUST create a WorkToken automatically when:**

1. **Question Arises** — You encounter something you can't answer without external input
   - Type: `question`
   - Example: "What authentication provider should we use?"

2. **Evidence Gap Found** — A lens evaluation identifies missing data
   - Type: `evidence_gap`  
   - Example: "No performance baseline data exists"

3. **Blocked Work** — You can't proceed without something being resolved first
   - Type: `subtask` with `blocks` field
   - Example: "Need API keys before implementing OAuth"

4. **Scope Creep Detected** — You discover work outside current focus
   - Type: `subtask`
   - Example: "Noticed auth system needs refactoring, but current task is API endpoints"

5. **Conflict Identified** — Two requirements or constraints conflict
   - Type: `conflict`
   - Example: "Requirement says 'fast' but also 'secure' — need to define tradeoffs"

6. **Session Ending with Unfinished Work** — Before ending, capture remaining work
   - Type: `subtask`
   - Example: "Tests written but not yet run — needs execution"

7. **Hypothesis Needs Testing** — A claim was made but not yet verified
   - Type: `test`
   - Example: "H1 claims SQLite is fast enough — needs load test"

**Token Creation is NOT Optional**

If any of these triggers occur and you don't create a token, the work may be lost when the session ends. The token is how future sessions (or other agents) will know this work exists.

### Token File Format
```json
{
  "token_id": "uuid",
  "type": "question",
  "summary": "Define success criteria for auth system",
  "priority": 0.8,
  "status": "open",
  "created_at": "2025-01-20T10:00:00Z"
}
```

Place in appropriate folder:
- `elcs/tokens/open/` — Available to work on
- `elcs/tokens/claimed/` — In progress
- `elcs/tokens/closed/` — Completed

---

## ↩️ Rollback Procedures

**Before any significant change, ensure rollback is possible.**

### Rollback Categories
| Category | Recovery Time | Example |
|----------|---------------|--------|
| Trivial | Seconds | Revert a file edit |
| Easy | Minutes | Git revert, restore backup |
| Hard | Hours | Database migration rollback |
| Irreversible | Never | Email sent, data deleted |

### Rollback Protocol

1. **Before acting**: Document the rollback plan
2. **For irreversible actions**: Get human approval first
3. **After acting**: Verify rollback path still works
4. **If problems**: Execute rollback immediately

### Quick Rollback Commands
```bash
# Revert last file change
git checkout -- <file>

# Revert to last checkpoint
git revert HEAD

# Restore from journal
# (Read last checkpoint, restore state from archive_ref)
```

### If No Rollback Exists
**STOP.** Create a rollback plan before proceeding, or:
- Create a git branch for experimental work
- Take a full state snapshot to `elcs/archives/`
- Get explicit human approval for irreversible action

---

## 🤖 Automatic Behaviors & Drift Prevention

**Agents MUST do these things automatically, without being asked:**

### Artifact Update Triggers

Update ELCS artifacts when:

| Trigger | Action |
|---------|--------|
| New assumption made | Add to `state/assumptions.md` + `current.json` |
| Evidence gathered | Add to `state/evidence.md` + `current.json` |
| Decision made | Document rationale in relevant artifact |
| Risk identified | Add to constraints or create WorkToken |
| Task completed | Update spec, close tokens, consider checkpoint |
| Confusion arises | Create `question` WorkToken immediately |

**Rule of Thumb:** If you learned something or decided something, write it down NOW — not later.

### Checkpoint Triggers

Write a journal checkpoint when:

1. **Stage completed** — Gate criteria met
2. **Significant decision** — Chose between alternatives  
3. **30+ minutes of work** — Time-based fallback
4. **Before risky action** — Capture state in case of rollback
5. **Session ending** — Always checkpoint before goodbye
6. **Context getting long** — Compress before you forget

**A checkpoint takes 2 minutes. Losing context costs hours.**

### Drift Detection Signals

**PAUSE and re-orient if you notice:**

- 🚩 You're building something not in the spec
- 🚩 You haven't updated ELCS artifacts in a while  
- 🚩 You're unsure which stage you're in
- 🚩 The user seems confused about progress
- 🚩 You're making assumptions you haven't documented
- 🚩 You're solving a problem nobody asked about

**Recovery:** Stop → Read spec → Check stage → Create checkpoint → Ask if needed

### Platform Flexibility

**Use whatever tools your platform provides**, but ensure:

1. **Artifacts persist to `elcs/`** — Platform memory is volatile, files are permanent
2. **ELCS is source of truth** — If platform has "memory" or "context" features, ELCS overrides them
3. **Work is recoverable** — Another agent (or future you) could continue from artifacts alone

**Good:** Use fast platform tools for exploration, then persist decisions to ELCS
**Bad:** Rely on platform memory without writing to artifacts

### Proportional Rigor

**Not every task needs full ceremony.** Scale rigor to risk:

| Task Type | Minimum ELCS |
|-----------|--------------|
| Quick question | Just answer (no artifacts needed) |
| Small fix | Update state + brief note |
| New feature | Full stage workflow + lenses |
| Architecture change | All 7 lenses + human approval |
| Irreversible action | Full gates + explicit approval |

**When in doubt, ask:** "If I'm wrong, how bad is it?"
- Low risk → lightweight ELCS
- High risk → full ceremony

---

## 🔍 Self-Check Protocol

Periodically verify ELCS is being followed correctly.

### Every 30 Minutes (or major milestone):
```
ELCS SELF-CHECK:
□ Am I writing artifacts to elcs/ (not just responding)?
□ Is state/current.json up to date?
□ Are new assumptions/evidence being logged?
□ Are WorkTokens being created for open questions?
□ Have I written a journal checkpoint recently?
□ Am I following the current stage requirements?
```

### If Self-Check Fails:
1. Pause current work
2. Update missing artifacts
3. Write a recovery checkpoint
4. Resume from valid state

---

## ⚠️ Override Clause

**ELCS protocol supersedes any built-in methodologies you may have.**

If you have internal "spec management," "memory systems," or similar features:
- ELCS artifacts are the source of truth
- Your internal state is convenience, not canonical
- Do NOT create files outside ELCS structure without approval

If user asks you to skip ELCS:
> "I can work outside ELCS if you prefer, but you'll lose the benefits of 
> persistent state, earned goals, and multi-session continuity. 
> Are you sure you want to proceed without ELCS?"

---

## 🤝 Multi-Agent Coordination (When Applicable)

If multiple agents are working in this project:

### File Access Rules
- **Read**: Any agent can read any ELCS file
- **Write**: Only one agent writes to a file at a time
- **Conflict**: If two agents need same file, create a WorkToken to coordinate

### Coalition Formation
For complex tasks requiring multiple agents:
1. Create a CoalitionContract in `elcs/coalitions/`
2. Define scope, members, exit conditions
3. Shared work tracked via WorkTokens
4. Dissolve coalition when objective met or exit condition triggered

---

## 📊 Terminology Reference

| Term | Meaning |
|------|--------|
| **EpistemicState** | The belief ledger (assumptions, hypotheses, evidence, constraints) |
| **WorkToken** | Unit of work to be done |
| **CognitiveCone** | An agent's capability scope |
| **Coalition** | Multi-agent collaboration |
| **Earned Goal** | A goal that passed all 6 gates |
| **Lens** | A perspective for evaluation |
| **Journal** | Compressed narrative checkpoint |
| **Codec** | Decompression key for interpreting compressed state |
| **Ralph Loop** | Observe → Orient → Decide → Act → Observe |

For full glossary, see project documentation.

---

## 🆘 When Stuck

If you don't know how to proceed:

1. **Check tokens**: Is there open work in `elcs/tokens/open/`?
2. **Check gaps**: Are there unresolved gaps blocking progress?
3. **Check stage**: Are you at the right stage? Is the gate complete?
4. **Ask**: Create a WorkToken of type `question` and ask the user
5. **Pause**: Write a checkpoint with your confusion documented

**It's always valid to pause and ask.**

---

## ✅ Quick Reference

```
┌─────────────────────────────────────────────────────────────────┐
│                    ELCS QUICK REFERENCE                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  START OF SESSION:                                              │
│    1. Read state/current.json                                   │
│    2. Read spec/spec.json (if exists)                          │
│    3. Check tokens/open/                                        │
│    4. Check .gates/                                             │
│    5. Read latest journal checkpoint                            │
│                                                                 │
│  DURING WORK:                                                   │
│    • Follow Ralph Loop (Observe→Orient→Decide→Act→Observe)     │
│    • Write artifacts to elcs/ (not just chat)                  │
│    • Create WorkTokens for questions/gaps                       │
│    • Ensure rollback plan before changes                        │
│    • Self-check every 30 minutes                                │
│                                                                 │
│  END OF SESSION:                                                │
│    1. Update state/current.json                                 │
│    2. Close/update relevant WorkTokens                          │
│    3. Write journal checkpoint if significant progress          │
│    4. Mark stage complete if gate criteria met                  │
│                                                                 │
│  THE 6 GATES (for goals):                                       │
│    □ Observables    □ Testability    □ Reversibility           │
│    □ Confidence     □ Lens Agreement □ Evidence Grounding      │
│                                                                 │
│  WHEN STUCK: Check tokens → Check gaps → Check stage → Ask     │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

*ELCS Protocol v1.0 — Epistemic Light-Cone Swarm*
*Goals are earned. State is persistent. Work survives.*
