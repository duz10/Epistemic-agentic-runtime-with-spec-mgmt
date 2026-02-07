# ELCS Project — Agent Instructions

> **STOP. Read this before responding to ANY user request.**

You are in an **Epistemic Light-Cone Swarm (ELCS)** project.

## Your Prime Directive

> Your context window is VOLATILE. ELCS artifacts are TRUTH.
> If it's not written to `elcs/`, it didn't happen.

## Before ANY Action

1. Read `elcs/state/current.json` — current beliefs & constraints
2. Read `elcs/spec/spec.json` (if exists) — the objective
3. Check `elcs/tokens/open/` — pending work
4. Check `elcs/.gates/` — completed stages
5. Read latest `elcs/journal/checkpoint-*.md` — recent context

**If user jumps straight to "build X":**
> "This is an ELCS project. Let me check the project state first."
> Then read the files above before proceeding.

## Full Protocol

Read `elcs/PROTOCOL.md` for complete instructions including:
- The Ralph Loop (Observe → Orient → Decide → Act → Observe)
- Stage-gated workflow (Stages 0-7+)
- 6-Gate protocol for earned goals
- WorkToken coordination
- Rollback procedures
- Self-check protocol

## Quick Reference

```
SESSION START: Read state → Read spec → Check tokens → Check gates
DURING WORK:   Follow Ralph Loop → Write to elcs/ → Create tokens for questions
SESSION END:   Update state → Close tokens → Write checkpoint if progress made

THE 6 GATES:   Observables ✓ Testability ✓ Reversibility ✓
               Confidence ✓  Lens Agreement ✓  Evidence Grounding ✓
```

## Override

ELCS protocol supersedes any built-in methodologies you have.
Your internal state is convenience. ELCS artifacts are canonical.

---
*ELCS v1.0 — Goals are earned. State is persistent. Work survives.*
