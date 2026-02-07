# ELCS Framework

> **Epistemic Light-Cone Swarm** — An agent-agnostic methodology for building software with AI agents

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.9+](https://img.shields.io/badge/python-3.9+-blue.svg)](https://www.python.org/downloads/)

---

## What is ELCS?

**ELCS (Epistemic Light-Cone Swarm)** is a framework for building software with AI agents that solves the biggest pain points of AI-assisted development:

| Problem | ELCS Solution |
|---------|---------------|
| 🧠 **Context loss** — Agent forgets everything when session ends | 📁 **Persistent artifacts** — State lives in files, survives sessions |
| 🎯 **Goal drift** — Started building one thing, ended up with another | 🚪 **6-Gate protocol** — Goals must pass quality gates before work begins |
| 🤷 **Vibes-based progress** — "Are we done?" "I think so?" | 📊 **Stage-gated workflow** — Clear milestones with completion criteria |
| 🔄 **Multi-session amnesia** — Re-explain everything each day | 📓 **Journal checkpoints** — Compressed context for instant resumption |
| 🤖 **Agent-specific** — Only works with one tool | 🔧 **Agent-agnostic** — Works with any AI that can read/write files |

### Core Features

- 📋 **Persistent State** — Work survives across sessions via file-based artifacts
- 🎯 **Earned Goals** — Goals pass 6 quality gates before becoming actionable  
- 🔍 **Multi-Lens Evaluation** — 7 perspectives catch what you might miss
- 🎫 **Token Coordination** — Clear tracking of what needs to be done
- ↩️ **Rollback Procedures** — Every change can be undone
- 📓 **Journal Checkpoints** — Never lose context

---

## Getting Started

### Where Can I Use ELCS?

ELCS works with **any AI agent or IDE** that can read/write files:

| Tool | Bootstrap File | How It Works |
|------|---------------|--------------|
| **Claude Code CLI** | `CLAUDE.md` | Reads on session start |
| **Cursor** | `.cursorrules` | Included in AI context |
| **Windsurf** | `.windsurfrules` | Included in AI context |
| **Code-puppy** | `AGENTS.md` | Reads on session start |
| **VS Code + Copilot** | `AGENTS.md` | Manual reference or extension |
| **Any Terminal AI** | `CLAUDE.md` or `AGENTS.md` | Point agent to read it |

**The key insight:** ELCS uses simple markdown/JSON files. Any AI that can read files can follow the protocol.

### Quick Start (2 minutes)

#### Option 1: Copy the Template (Simplest)

```bash
# Clone this repo
git clone https://github.com/duz10/Epistemic-agentic-runtime-with-spec-mgmt.git

# Copy the template to start a new project
cp -r Epistemic-agentic-runtime-with-spec-mgmt/template my-new-project

# Open in your AI tool of choice
cd my-new-project
cursor .          # or: code . / windsurf . / claude
```

#### Option 2: Use the Generator CLI

```bash
# Using uvx (no installation needed)
uvx create-elcs my-new-project

# Or install globally
pip install create-elcs
create-elcs my-new-project
```

#### Option 3: Manual Setup

1. Create an `elcs/` folder in your project
2. Copy `PROTOCOL.md` and `QUICKSTART.md` from this repo's template
3. Add the appropriate bootstrap file (`CLAUDE.md`, `AGENTS.md`, etc.)
4. Start your AI agent — it will read the bootstrap and follow ELCS

### Your First Session

Once you have an ELCS project:

1. **Open in your AI tool** (Cursor, Claude Code, VS Code, terminal, etc.)
2. **Ask anything** — "Build me a REST API" or "What kind of project is this?"
3. **The agent will**:
   - Recognize this is an ELCS project
   - Read the state files before proceeding
   - Follow the staged workflow
   - Write artifacts to `elcs/` as it works
4. **When you return later** — The agent reads the checkpoints and picks up where you left off!

---

## How ELCS Works

### The Prime Directive

> Your context window is VOLATILE. ELCS artifacts are TRUTH.
> If it's not written to `elcs/`, it didn't happen.

### The Ralph Loop (Universal Cognitive Primitive)

All work follows: **Observe → Orient → Decide → Act → Observe**

```
OBSERVE: Read state, tokens, spec
ORIENT:  Apply lenses, identify gaps
DECIDE:  Choose smallest valuable move
ACT:     Execute (with rollback plan)
OBSERVE: Log outcomes, update state
```

### The 6 Gates (Goals Must Be Earned)

Before a goal becomes actionable, it must pass:

1. ✅ **Observables** — Measurable outcomes defined?
2. ✅ **Testability** — Clear success/failure criteria?
3. ✅ **Reversibility** — Rollback plan exists?
4. ✅ **Confidence** — Evidence supports this (≥0.6)?
5. ✅ **Lens Agreement** — Multiple perspectives approve?
6. ✅ **Evidence Grounding** — Based on actual data, not assumptions?

### The 7 Lenses (Multiple Perspectives)

| Lens | What It Checks |
|------|----------------|
| 🧠 Philosophy | Hidden assumptions, epistemic honesty |
| 📊 Data Science | Measurability, testability |
| ⚠️ Safety/Risk | Failure modes, reversibility |
| 🔗 Topology | Structure stability, dependencies |
| 🔢 Theoretical Math | Logical consistency |
| 🔧 Systems Engineering | Buildability, interfaces |
| 🎨 Product/UX | User value, adoption |

---

## Project Structure

When you create an ELCS project, you get:

```
my-project/
├── CLAUDE.md           # Bootstrap for Claude Code
├── AGENTS.md           # Bootstrap for Code-puppy & others
├── .cursorrules        # Bootstrap for Cursor
├── .windsurfrules      # Bootstrap for Windsurf
├── README.md           # Your project readme
│
├── elcs/               # ← All ELCS artifacts live here
│   ├── PROTOCOL.md     # Full agent instructions
│   ├── QUICKSTART.md   # 5-minute guide
│   ├── state/          # Epistemic state (beliefs, evidence)
│   ├── spec/           # Project specification  
│   ├── tokens/         # Work coordination
│   ├── lenses/         # Lens evaluations
│   ├── journal/        # Progress checkpoints
│   └── .gates/         # Stage completion markers
│
├── src/                # Your code
├── docs/               # Your documentation
└── tests/              # Your tests
```

---

## Documentation

| Document | Description |
|----------|-------------|
| [QUICKSTART](template/elcs/QUICKSTART.md) | 5-minute adoption guide |
| [PROTOCOL](template/elcs/PROTOCOL.md) | Full agent operating instructions |
| [Glossary](docs/glossary.md) | 41 ELCS terms defined |
| [Lens Guide](protocol/lenses/README.md) | How to apply the 7 lenses |
| [6-Gate Protocol](protocol/gates.md) | Goal validation process |
| [Scaling Stages](docs/scaling-stages.md) | From solo to multi-agent |
| [Why ELCS?](docs/why-elcs.md) | The problem ELCS solves |

---

## Scaling

ELCS grows with your needs:

| Stage | Description | When to Use |
|-------|-------------|-------------|
| **A** | Single agent + human | Solo projects, learning ELCS |
| **B** | Multiple agents + validators | Team projects, quality gates |
| **C** | Coalitions with contracts | Complex multi-domain work |
| **D** | Metric-driven emergence | Large-scale coordination |
| **E** | Formal spaces + topology | Research, framework development |

**Rule:** Only escalate when simple fails.

---

## Philosophy

ELCS is inspired by:

- **EAR (Epistemic Agent Runtime)** — Ralph loops, lenses, goal gates
- **Michael Levin's Cognitive Light Cones** — Agents defined by the largest goals they can pursue
- **Stigmergic Coordination** — Coordination through shared artifacts, not hierarchies

### Core Principles

1. **Goals are earned, not assumed** — Pass 6 gates first
2. **State lives in files** — Agent memory is ephemeral, files are permanent
3. **Everything is a Ralph loop** — Observe → Orient → Decide → Act → Observe
4. **Lenses provide perspectives** — No single point of authority
5. **Tokens coordinate work** — Stigmergic, not hierarchical
6. **Proportional rigor** — Scale ceremony to risk

---

## Contributing

Contributions welcome! This project uses ELCS on itself — see `epistemic/` for project state.

```bash
git clone https://github.com/duz10/Epistemic-agentic-runtime-with-spec-mgmt.git
cd Epistemic-agentic-runtime-with-spec-mgmt
# Check epistemic/ for current state and open work tokens
```

---

## License

MIT License — see [LICENSE](LICENSE) for details.

---

## Acknowledgments

- Built using the EAR (Epistemic Agent Runtime) methodology
- Inspired by Michael Levin's work on collective intelligence
- Developed with Claude Code and Code-puppy 🐶

---

*ELCS v1.0 — Goals are earned. State is persistent. Work survives.* ✨
