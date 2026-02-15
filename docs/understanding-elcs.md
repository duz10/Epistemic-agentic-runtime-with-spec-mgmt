# Understanding ELCS: How We Got Here and How It Helps You Now

*Practical origin story, real-world outcomes, and how ELCS plugs into the workflows you already use.*

---

## Short Origin Story (Practical, Not Cosmic)

ELCS started as a fix for real pain: agents forget, goals drift, and progress becomes vibes. The answer was simple: **make goals and state explicit, store them in files, and force alignment before execution**. That became ELCS.

One tiny nod to Levin: **a “cognitive light cone” is just the scope of goals an agent/team can reliably pursue**. ELCS keeps that scope visible and bounded, so you don’t accidentally wander into a different project halfway through a sprint.

---

## What ELCS Does in Practice

Concrete outcomes you can expect:

- **Fewer resets** — state is in files, not memory.
- **Fewer detours** — goals are gated (measurable, testable, reversible).
- **Less rework** — lens checks catch bad assumptions early.
- **More continuity** — checkpoints make handoffs and resuming effortless.
- **Clear “why”** — every decision ties back to spec + evidence.

**Net effect:** more aligned work, less thrash, better collaboration with humans and agents.

---

## Workflow Mappings (Use What You Already Know)

### Design Thinking / NNGroup

| Phase | ELCS Mapping | Practical Output |
|------|---------------|-----------------|
| Discover | Evidence + assumptions | `elcs/state/evidence.md`, `assumptions.md` |
| Define | Goals through 6 gates | `elcs/spec/objectives.md` |
| Ideate | Lenses + tokenization | `elcs/lenses/*`, `elcs/tokens/open/*` |
| Prototype | Ralph loops + checkpoints | `elcs/journal/*` |
| Test | Validation + evidence updates | `elcs/state/evidence.md` |

### Agile

| Agile Concept | ELCS Mapping | Practical Output |
|--------------|--------------|-----------------|
| Backlog | WorkTokens | `elcs/tokens/open/*` |
| Sprint Planning | Token selection + scope | Updated token statuses |
| Sprint Work | Ralph loops | Checkpoints + state updates |
| DoD | 6-Gate criteria + evidence | Gate checks + evidence updates |
| Retro | Journal checkpoints | `elcs/journal/*` |

### Waterfall

| Waterfall Phase | ELCS Mapping | Practical Output |
|-----------------|--------------|-----------------|
| Requirements | Spec + gates | `elcs/spec/*` |
| Design | Lenses + topology | `elcs/lenses/*` |
| Build | Token execution | `elcs/tokens/*` |
| Verification | Evidence + tests | `elcs/state/evidence.md` |
| Release | Checkpoint + rollback plan | `elcs/journal/*` |

---

## Role-Based Perspectives (How It Helps Each Role)

| Role | What ELCS Gives You | Artifacts You’ll Touch |
|------|----------------------|------------------------|
| PM / Product | Goal alignment, traceability, fewer surprises | `spec/`, `tokens/`, `journal/` |
| Designer / Creative | Clear decision context, reduced rework | `lenses/`, `spec/` |
| Engineer | Concrete requirements, drift control, safe rollback | `tokens/`, `spec/`, `journal/` |
| Data / Ops | Evidence trail, measurable outcomes, auditability | `state/`, `journal/` |

---

## Agentic Workflows (Human-in-the-Loop by Design)

ELCS assumes **agents do the heavy lifting** and **humans keep direction + risk under control**.

**Typical flow:**

1. Agent reads state + spec
2. Agent proposes goals (must pass gates)
3. Human approves risk/priority
4. Agent executes tokens
5. Human reviews outputs at checkpoints

**Who does what (lightweight version):**

| Step | Agent | Human |
|------|-------|-------|
| Understand current state | ✅ | — |
| Propose next goals | ✅ | — |
| Approve scope/risk | — | ✅ |
| Execute tasks | ✅ | — |
| Review checkpoints | — | ✅ |
| Resolve disagreements | ✅ (proposal) | ✅ (decision) |

This keeps the workflow fast **and** safe: autonomy with a steering wheel.

---

## How to Start (Fast)

- **Quickstart guide:** [template/elcs/QUICKSTART.md](../template/elcs/QUICKSTART.md)
- **Template folder:** [template/](../template/)

If you want the shortest path:

```bash
cp -r template my-project
cd my-project
# open with your AI tool and start building
```

---

*ELCS aligns humans and agents to the same source of truth: the files on disk.*
