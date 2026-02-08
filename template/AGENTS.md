# ELCS-Aware Agent Instructions

> **STOP. Read this before responding to ANY user request.**

## Step 1: Check for ELCS

First, check the ELCS status of this project:

```
Check for elcs/ folder and state:

1. Does elcs/ folder exist?
   ├── NO  → Go to Step 3 (Non-ELCS Project)
   └── YES → Check elcs/state/current.json

2. Read elcs/state/current.json - what is the status?
   ├── "status": "awaiting_agent_scan" → Go to Step 2A (Needs Population)
   └── Any other status               → Go to Step 2B (Active ELCS Project)
```

---

## Step 2A: ELCS Installed but Needs Population

The ELCS structure was created by the install script, but state hasn't been populated yet.

**Your job: Scan the project and populate the state files.**

### Scan the Project

Look for and read:
- `README.md` — Project description, goals
- `package.json` / `pyproject.toml` / `Cargo.toml` — Project metadata
- `src/` or main code directories — What's already built
- Any existing documentation

### Populate State Files

Update `elcs/state/current.json`:
```json
{
  "project_name": "[from package.json or folder name]",
  "project_type": "[web app, CLI, library, API, etc.]",
  "tech_stack": ["language", "framework", "etc."],
  "adopted_at": "[keep existing timestamp]",
  "stage": 1,
  "status": "active",
  "assumptions": [
    {"id": "A1", "text": "[inferred from README]", "status": "needs_review"},
    {"id": "A2", "text": "[inferred from code]", "status": "needs_review"}
  ],
  "hypotheses": [],
  "evidence": [
    {"id": "E1", "type": "observation", "summary": "[what you found scanning]"}
  ],
  "constraints": [
    {"id": "C1", "text": "[inferred from project setup]", "status": "needs_review"}
  ],
  "notes": "State populated by agent scan on [date]"
}
```

Update `elcs/state/assumptions.md` with your findings.

### Create Population Checkpoint

Write `elcs/journal/checkpoint-001-populated.md`:
```markdown
# Checkpoint 001: State Populated

**Date**: [today]
**Stage**: 1 (Initial State)

## Project Summary
- Name: [project name]
- Type: [type]
- Stack: [technologies]

## What I Found
- [Key observations from scanning]

## Inferred Assumptions (Need Review)
- A1: [assumption]
- A2: [assumption]

## Next Steps
- Review assumptions with user
- Define explicit goals and success criteria
```

### Confirm with User

After populating, say:
> "I've scanned the project and populated the ELCS state. Here's what I found:
> - [summary]
> 
> Please review `elcs/state/current.json`. Any corrections needed?
> 
> Ready to continue working with ELCS!"

Then proceed to Step 2B.

---

## Step 2B: Active ELCS Project

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

---

### 🚨 HARD RULE: Protocol First

**Before proposing ANY solution or execution plan:**

```
┌─────────────────────────────────────────────────────────┐
│  STOP! BEFORE YOU PROPOSE ANY SOLUTION:                 │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  1. READ `elcs/PROTOCOL.md` thoroughly                  │
│     → Understand stages (A-D), rigor levels, gates     │
│                                                         │
│  2. IDENTIFY which stage and approach applies           │
│     → Solo work? Coalition? Self-selection?            │
│     → What rigor level for this risk?                  │
│                                                         │
│  3. FOLLOW the protocol's guidance                      │
│     → Distance vectors for prioritization?             │
│     → Validators needed?                               │
│     → What checkpoints required?                       │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

**The protocol is your source of truth.** If you're unsure how to proceed, re-read PROTOCOL.md.

**Periodically re-check:** If you've been working for a while, check back with PROTOCOL.md to ensure you haven't drifted from best practices.

---

### 🚨 HARD RULES: No Code Without a Token

**Before editing ANY file in src/, tests/, docs/, or config:**

```
┌─────────────────────────────────────────────────────────┐
│  STOP! BEFORE YOU EDIT ANY PROJECT FILE:                │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  1. CREATE token in elcs/tokens/open/                   │
│     → Describe what you're about to do                  │
│                                                         │
│  2. CLAIM token (move to claimed/ or set claimed_by)    │
│     → Add your agent ID and timestamp                   │
│                                                         │
│  3. NOW edit files                                      │
│     → Only after steps 1-2 are complete                 │
│                                                         │
│  4. CLOSE token with resolution                         │
│     → Document what was done, test results              │
│                                                         │
│  5. WRITE checkpoint                                    │
│     → Update journal with progress summary              │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

**NEVER:**
- ❌ Create tokens AFTER work is done (retroactive tokens)
- ❌ Edit project files without a claimed token
- ❌ Close tokens without writing a checkpoint
- ❌ Skip the compliance checklist

**The token IS the authorization to modify files — not a receipt.**

If you catch yourself about to edit a file without a token:
> STOP → Create token → Claim it → THEN proceed

---

### Pre-Edit Checklist

Before EVERY file modification, verify:

```
□ Token created in elcs/tokens/open/?
□ Token claimed with my agent ID?
□ Token summary describes this specific work?
□ Rollback plan exists (git branch, backup)?
```

If any box is unchecked, STOP and fix it first.

---

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
