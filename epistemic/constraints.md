# ELCS Project Constraints

*Hard and soft limits on the ELCS Framework project*

## Hard Constraints (Non-Negotiable)

| ID | Constraint | Rationale |
|----|------------|----------|
| C1 | Must work with any agent that can read/write files | Tool-agnostic is a core design goal |
| C2 | All artifacts must be human-readable (no binary formats) | Transparency and debuggability |
| C3 | Template must not require installation/dependencies | Zero-friction adoption |

## Soft Constraints (Preferences)

| ID | Constraint | Rationale |
|----|------------|----------|
| C4 | Prefer JSON for structured data, Markdown for prose | Universal compatibility |
| C5 | Keep bootstrap files under 500 lines | Agents more likely to read short files |

## Constraint Violations Log

(None yet)
