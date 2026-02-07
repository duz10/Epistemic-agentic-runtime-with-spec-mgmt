# Why ELCS?

*The problem ELCS solves and why you should care*

---

## The Problem

Building software with AI agents is powerful but frustrating:

### 1. Context Window Death
Your conversation ends. Everything the agent knew is gone.
Next session: "Sorry, I don't have context from our previous conversation."

### 2. Goal Drift
You start building one thing. Somehow you end up with something else.
No one can explain how you got here.

### 3. Vibes-Based Progress
"Are we making progress?" 
"I think so?"
No measurable metrics. No clear milestones.

### 4. The "Just Build It" Trap
Agent starts coding immediately. 
Halfway through: "Wait, what were the requirements again?"
Rework. Frustration. Wasted tokens.

### 5. Multi-Session Amnesia
Day 1: Great progress!
Day 2: "Let me re-read everything from scratch..."
Day 3: Agent forgets what it learned on Day 2.

---

## The ELCS Solution

### 1. Persistent Artifacts
Everything lives in files. Sessions end, files remain.
Next session: Agent reads state, picks up exactly where you left off.

### 2. Earned Goals (6 Gates)
Goals aren't assumed. They're validated:
- Measurable? ✓
- Testable? ✓  
- Reversible? ✓
- Confident? ✓
- Multi-perspective approval? ✓
- Evidence-based? ✓

No more accidental tangents.

### 3. Quantified Progress
- Tokens track work items
- Stages gate progress
- Journal checkpoints capture state
- Distance vectors measure remaining work

You always know where you are.

### 4. Lenses Before Building
7 perspectives evaluate every major decision:
- Philosophy catches hidden assumptions
- Safety catches failure modes
- Product catches "building the wrong thing"

Think first, build right.

### 5. Journal Checkpoints
Compressed summaries of progress.
New session? Read the last checkpoint.
Full context recovery in seconds.

---

## Who ELCS Is For

### ✅ You Should Use ELCS If:
- You work on projects across multiple sessions
- You use AI agents for real development (not just Q&A)
- You've lost context and had to re-explain things
- You want traceability ("why did we decide this?")
- You work with multiple agents or people
- You care about quality over speed

### ❌ ELCS Might Be Overkill If:
- Single-session throwaway tasks
- Quick questions or experiments
- You're just learning AI tools
- The overhead isn't worth it for your use case

---

## The Trade-off

**ELCS costs**: ~10% overhead to maintain artifacts

**ELCS saves**: 
- 50%+ time on context recovery
- Countless hours on rework from bad decisions
- Sanity from knowing where you are

For any project lasting more than one session, ELCS pays for itself.

---

## The Core Insight

> Your AI agent's memory is volatile.
> Files on disk are persistent.
> Make the files the source of truth.

This simple idea — **artifacts over memory** — enables everything else:
- Cross-session continuity
- Multi-agent coordination
- Auditable decisions
- Recoverable state

---

## Try It

```bash
uvx create-elcs myproject
cd myproject
# Open in your AI IDE
# Start building with persistent state
```

Five minutes to set up. Unlimited sessions of preserved context.

---

*ELCS: Because your AI's memory shouldn't be your bottleneck.*
