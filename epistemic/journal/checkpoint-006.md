# Checkpoint 006: Telemetry Finalization & Documentation

**Date**: 2025-01-11
**Stage**: Documentation & Distribution
**State Version**: 10

---

## Summary

Finalized the telemetry plugin for distribution. Added to ELCS resources, documented installation process, and identified known limitations.

---

## What Was Done

1. **Documented token usage gap (E18)** - Actual API tokens not available via callback, but estimated tokens can be calculated
2. **Added plugin to resources/** - Users can now copy/symlink from ELCS repo
3. **Created TELEMETRY.md** - Full documentation with philosophy, setup, and usage
4. **Updated PROTOCOL.md** - Added telemetry section with quick start

---

## Distribution Model

```
ELCS Repo
└── resources/
    └── plugins/
        └── elcs_telemetry/     ← Source of truth
            ├── __init__.py
            ├── register_callbacks.py
            ├── telemetry_writer.py
            └── README.md

User's Machine
└── ~/.code_puppy/
    └── plugins/
        └── elcs_telemetry/     ← Symlink or copy
```

Users can:
1. **Symlink** (recommended) - Changes in ELCS repo auto-propagate
2. **Copy** - Standalone, requires manual updates

---

## Known Limitations Documented

| Limitation | Workaround | Future Path |
|------------|------------|-------------|
| No actual token count | Estimate: chars / 4 | PR to code-puppy |
| No tool success/failure | Check session success | Wire up post_tool_call |

---

## Files Created/Modified

| File | Action |
|------|--------|
| `resources/plugins/elcs_telemetry/*` | Created (4 files) |
| `docs/TELEMETRY.md` | Created |
| `epistemic/evidence.md` | Added E18 |
| `epistemic/state.json` | v9 → v10 |

---

*Checkpoint by code-puppy-1083ba*
