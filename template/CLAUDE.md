# ELCS-Aware Agent Instructions

> **STOP. Read this before responding to ANY user request.**

## Step 1: Check for ELCS

First, check if this project uses ELCS:

```
Does elcs/ folder exist?
├── YES → This is an ELCS project. Go to Step 2.
└── NO  → This is NOT an ELCS project. Go to Step 3.
```

---

## Step 2: ELCS Project (elcs/ exists)

You are in an **Epistemic Light-Cone Swarm (ELCS)** project.

### Your Prime Directive

> Your context window is VOLATILE. ELCS artifacts are TRUTH.
> If it's not written to `elcs/`, it didn't happen.

### Before ANY Action

1. Read `elcs/state/current.json` — current beliefs & constraints
2. Read `elcs/spec/spec.json` (if exists) — the objective
3. Check `elcs/tokens/open/` — pending work
4. Check `elcs/.gates/` — completed stages
5. Read latest `elcs/journal/checkpoint-*.md` — recent context

**If user jumps straight to "build X":**
> "This is an ELCS project. Let me check the project state first."
> Then read the files above before proceeding.

### Full Protocol

Read `elcs/PROTOCOL.md` for complete instructions.

---

## Step 3: Non-ELCS Project (elcs/ doesn't exist)

This project doesn't use ELCS yet. You have two options:

### Option A: Offer to Adopt ELCS

If the project seems substantial (not a quick script), offer:

> "I notice this project doesn't have ELCS yet. ELCS helps with:
> - Persistent state across sessions
> - Clear goals with quality gates  
> - Progress tracking and checkpoints
>
> Would you like me to set up ELCS for this project? It takes about 2 minutes."

**If user says yes**, run the Adoption Protocol below.

### Option B: Work Without ELCS

If user declines or it's a quick task:
> Work normally. You can always adopt ELCS later.

---

## Adoption Protocol (Adding ELCS to Existing Project)

When adopting ELCS into an existing project:

### 1. Scan the Project
- Read README.md, package.json, pyproject.toml, etc.
- Identify: language, framework, project type
- Note: existing structure, conventions, goals

### 1.5 Check for Protocol Reference

If `.elcs-ref/` folder exists (created by install script):
- Read `.elcs-ref/PROTOCOL.md` for full protocol
- Read `.elcs-ref/QUICKSTART.md` for quick reference
- Use these to guide your setup

If `.elcs-ref/` doesn't exist:
- Fetch protocol from GitHub or ask user for guidance

### 2. Create ELCS Structure
```
elcs/
├── PROTOCOL.md      # Copy from ELCS template or reference
├── QUICKSTART.md    # Copy from ELCS template
├── state/
│   ├── current.json      # Initialize with scanned info
│   ├── assumptions.md    # Document what you inferred
│   └── evidence.md       # Empty initially
├── spec/
│   └── spec.json         # Ask user for goals, or infer from README
├── tokens/
│   ├── open/             # Empty initially
│   └── closed/           # Empty
├── lenses/               # Empty initially
├── journal/              # Empty initially
└── .gates/               # Empty initially
```

### 3. Initialize State from Existing Project

Create `elcs/state/current.json`:
```json
{
  "project_name": "[inferred from package/folder]",
  "adopted_at": "[timestamp]",
  "stage": 1,
  "assumptions": [
    {"id": "A1", "text": "[inferred from README]", "status": "needs_review"}
  ],
  "constraints": [
    {"id": "C1", "text": "[inferred from existing code]", "status": "needs_review"}
  ],
  "notes": "ELCS adopted into existing project. Initial state inferred from project files."
}
```

### 4. Create Initial Checkpoint

Write `elcs/journal/checkpoint-001-adoption.md`:
```markdown
# Checkpoint 001: ELCS Adoption

**Date**: [timestamp]
**Stage**: 1 (Initial State)

## Project Context
- Project: [name]
- Type: [web app, CLI, library, etc.]
- Stack: [languages, frameworks]

## Inferred State
- Goals: [from README or user input]
- Assumptions: [what we assumed about the project]
- Constraints: [what we observed]

## Next Steps
- Review inferred assumptions with user
- Define explicit success criteria
- Create first WorkToken for priority work

## Open Questions
- [Any uncertainties about the project]
```

### 5. Confirm with User

> "I've set up ELCS for this project. Here's what I inferred:
> - [summary of assumptions]
> - [summary of goals]
>
> Please review `elcs/state/current.json` and let me know if anything needs correction.
> 
> Ready to continue? I'll follow ELCS protocol from now on."

---

## Quick Reference

```
SESSION START: Check for elcs/ → Read state → Check tokens
DURING WORK:   Follow Ralph Loop → Write to elcs/ → Create tokens for questions
SESSION END:   Update state → Close tokens → Write checkpoint

THE 6 GATES:   Observables ✓ Testability ✓ Reversibility ✓
               Confidence ✓  Lens Agreement ✓  Evidence Grounding ✓
```

---
*ELCS v1.0 — Goals are earned. State is persistent. Work survives.*
