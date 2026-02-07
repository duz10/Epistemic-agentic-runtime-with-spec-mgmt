# ELCS Project

> Powered by the **Epistemic Light-Cone Swarm** framework

## Quick Start

1. Open this folder in your AI-assisted IDE or terminal
2. Your AI agent will read the bootstrap files automatically
3. Tell your agent what you want to build
4. The agent follows ELCS protocol from then on

## What's ELCS?

ELCS is a **methodology for building software with AI agents** that provides:

- 📋 **Persistent state** — Work survives across sessions
- 🎯 **Earned goals** — Goals pass 6 quality gates before becoming actionable
- 🔍 **Multi-lens evaluation** — 7 perspectives catch what you might miss
- 🎫 **Token coordination** — Clear tracking of what needs to be done
- ↩️ **Rollback procedures** — Every change can be undone
- 📓 **Journal checkpoints** — Never lose context

## Project Structure

```
elcs/                    ← All ELCS artifacts live here
├── PROTOCOL.md          ← Full agent instructions
├── QUICKSTART.md        ← 5-minute guide
├── state/               ← What we believe (epistemic state)
├── spec/                ← What we're building (goals)
├── lenses/              ← Perspective evaluations
├── tokens/              ← Work items (open/claimed/closed)
├── journal/             ← Progress checkpoints
└── .gates/              ← Stage completion records

src/                     ← Your code goes here
docs/                    ← Your documentation
tests/                   ← Your tests
```

## Working with Your AI Agent

### Starting a New Project
```
Please help me initialize this ELCS project.
I want to build [describe your idea].
```

### Resuming Work
```
Read the latest journal checkpoint and catch me up.
```

### Checking Progress
```
What stage are we at? What tokens are open?
```

### Ending a Session
```
Please update the state and write a checkpoint before we stop.
```

## Learn More

- **Quick start**: `elcs/QUICKSTART.md`
- **Full protocol**: `elcs/PROTOCOL.md`
- **ELCS Framework**: https://github.com/your-org/elcs-framework

---

*Built with ELCS v1.0*
