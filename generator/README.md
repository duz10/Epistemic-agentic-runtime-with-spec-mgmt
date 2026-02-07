# create-elcs

CLI generator for ELCS (Epistemic Light-Cone Swarm) projects.

## Installation

```bash
# Using pip
pip install create-elcs

# Using uvx (no install needed)
uvx create-elcs myproject
```

## Usage

```bash
# Create new project in current directory
create-elcs myproject

# Create in specific location
create-elcs myproject --path ~/projects

# Minimal output (just prints path)
create-elcs myproject --quiet
```

## What It Creates

```
myproject/
├── CLAUDE.md           # Claude Code bootstrap
├── .cursorrules        # Cursor bootstrap
├── .windsurfrules      # Windsurf bootstrap
├── README.md           # Project readme
└── elcs/
    ├── PROTOCOL.md     # Full ELCS protocol
    ├── QUICKSTART.md   # 5-minute guide
    ├── state/          # Epistemic state
    ├── spec/           # Project spec
    ├── tokens/         # Work coordination
    ├── journal/        # Checkpoints
    └── ...
```

## Next Steps

After creating a project:

1. `cd myproject`
2. Open in Claude Code, Cursor, or your preferred AI-assisted IDE
3. Your agent will read the ELCS protocol automatically
4. Start building with persistent state!

## Learn More

- [ELCS Framework](https://github.com/duz10/elcs-framework)
- [ELCS Protocol](../template/elcs/PROTOCOL.md)
