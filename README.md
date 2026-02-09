# ELCS Framework

> **Epistemic Light-Cone Swarm** — An agent-agnostic methodology for building software with AI agents

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.9+](https://img.shields.io/badge/python-3.9+-blue.svg)](https://www.python.org/downloads/)

---

## ✅ Validation Status

**ELCS has been validated** through the [GroceryBrain test case](docs/VALIDATION.md) — a complex multi-domain application involving Discord bots, OCR, database design, and self-learning store recognition.

| Metric | Result |
|--------|--------|
| Development time | ~8 hours |
| Tokens completed | 9 |
| Tests passing | 160 |
| Hypotheses validated | H6, H8, H9 |
| Domains covered | 6+ (Discord, OCR, DB, parsing, learning, AI) |

**Conclusion**: ELCS enables effective AI-assisted development of complex, multi-domain projects.

👉 [Read the full validation report →](docs/VALIDATION.md)

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
- 🔗 **Artifact Coupling** — Every action traces back to the spec
- 🚨 **Drift Detection** — Automatic checks prevent goal drift

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
# Install from GitHub (until PyPI release)
pip install git+https://github.com/duz10/Epistemic-agentic-runtime-with-spec-mgmt.git#subdirectory=generator

# Create a new project
create-elcs my-new-project
```

*Note: `uvx create-elcs` will work once published to PyPI.*

#### Option 3: Manual Setup

1. Create an `elcs/` folder in your project
2. Copy `PROTOCOL.md` and `QUICKSTART.md` from this repo's template
3. Add the appropriate bootstrap file (`CLAUDE.md`, `AGENTS.md`, etc.)
4. Start your AI agent — it will read the bootstrap and follow ELCS

#### Option 4: Adopt into Existing Project

Already have a project? Use the install script:

**Mac/Linux:**
```bash
# Clone ELCS (one time)
git clone https://github.com/duz10/Epistemic-agentic-runtime-with-spec-mgmt.git

# Install into your existing project
./Epistemic-agentic-runtime-with-spec-mgmt/install.sh ~/path/to/my-project
```

**Windows:**
```powershell
# Clone ELCS (one time)
git clone https://github.com/duz10/Epistemic-agentic-runtime-with-spec-mgmt.git

# Install into your existing project
.\Epistemic-agentic-runtime-with-spec-mgmt\install.ps1 -TargetDir C:\path\to\my-project
```

**What the script does:**
- Copies bootstrap files (CLAUDE.md, AGENTS.md, .cursorrules, etc.)
- Adds protocol reference files to `.elcs-ref/`
- Does NOT create `elcs/` folder yet (the agent does that)

**What happens next:**
1. Open your project in your AI agent
2. The agent reads the bootstrap file
3. It scans your codebase and creates `elcs/` with inferred state
4. You review and confirm, then continue working!

**No restructuring required** — ELCS lives in its own folder and doesn't touch your existing code.

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

### Automatic Behaviors

Agents following ELCS automatically:

- **Update state** when decisions are made or evidence gathered
- **Create WorkTokens** when questions arise or work is blocked
- **Write checkpoints** at milestones and before risky actions
- **Check for drift** when scope grows or confusion arises
- **Scale rigor to risk** — quick questions get light process, architecture changes get full ceremony

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

## Telemetry (Optional)

ELCS includes an optional telemetry plugin for Code-Puppy that captures observational data for debugging and analysis.

### Installation

1. Copy or symlink `resources/plugins/elcs_telemetry/` to `~/.code_puppy/plugins/`
2. Run `uvx code-puppy` as normal
3. Telemetry writes to `elcs/telemetry/events-YYYY-MM-DD.jsonl`

See [docs/TELEMETRY.md](docs/TELEMETRY.md) for full documentation.

### What's Captured

- Session lifecycle and timing
- Tool calls with arguments and duration
- File operations
- Shell commands (redacted for security)
- Agent delegation
- Confusion/uncertainty signals

### When to Use

Telemetry is the microscope, not the map. Use it when you need to dig into HOW something happened, not WHAT happened (that's what ELCS state is for).

---

## Documentation

| Document | Description |
|----------|-------------|
| [VALIDATION](docs/VALIDATION.md) | Framework validation report (GroceryBrain) |
| [QUICKSTART](template/elcs/QUICKSTART.md) | 5-minute adoption guide |
| [PROTOCOL](template/elcs/PROTOCOL.md) | Full agent operating instructions |
| [TELEMETRY](docs/TELEMETRY.md) | Telemetry plugin setup & usage |
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
| **Anti-Drift** | Built-in invariants | All stages — prevents "cone shrinkage" |

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
7. **Explainable progress** — "We did X because it reduced Y"

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
