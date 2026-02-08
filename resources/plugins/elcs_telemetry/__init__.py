"""ELCS Telemetry Plugin for Code-Puppy.

Captures tool calls, session lifecycle, and other events via callback hooks.
Writes JSONL telemetry to the current project's elcs/telemetry/ directory.

This plugin is OBSERVATIONAL - it does not modify agent behavior.
"""

__version__ = "0.1.0"
