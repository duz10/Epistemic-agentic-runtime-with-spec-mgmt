"""Telemetry writer - handles JSONL output to elcs/telemetry/."""

import json
import logging
from datetime import datetime, timezone
from pathlib import Path
from typing import Any

logger = logging.getLogger(__name__)


class TelemetryWriter:
    """Writes telemetry events to JSONL files in elcs/telemetry/."""
    
    def __init__(self):
        """Initialize writer, detecting ELCS project in current directory."""
        self._telemetry_dir: Path | None = None
        self._current_file: Path | None = None
        self._detect_elcs_project()
    
    def _detect_elcs_project(self) -> None:
        """Detect if current directory is an ELCS project."""
        cwd = Path.cwd()
        
        # Check current directory and up to 3 parent levels
        for _ in range(4):
            elcs_dir = cwd / "elcs"
            if elcs_dir.is_dir():
                self._telemetry_dir = elcs_dir / "telemetry"
                self._telemetry_dir.mkdir(exist_ok=True)
                logger.info(f"ELCS Telemetry: Writing to {self._telemetry_dir}")
                return
            
            parent = cwd.parent
            if parent == cwd:  # Reached root
                break
            cwd = parent
        
        logger.debug("ELCS Telemetry: No elcs/ folder found, telemetry disabled")
    
    def is_active(self) -> bool:
        """Check if telemetry is active (ELCS project detected)."""
        return self._telemetry_dir is not None
    
    def _get_current_file(self) -> Path | None:
        """Get the current day's telemetry file."""
        if not self._telemetry_dir:
            return None
        
        today = datetime.now(timezone.utc).strftime("%Y-%m-%d")
        return self._telemetry_dir / f"events-{today}.jsonl"
    
    def emit(self, event_data: dict[str, Any]) -> None:
        """Emit a telemetry event to the JSONL file."""
        if not self.is_active():
            return
        
        file_path = self._get_current_file()
        if not file_path:
            return
        
        # Add timestamp
        event = {
            "ts": datetime.now(timezone.utc).isoformat(),
            **event_data,
        }
        
        try:
            # Append to file (JSONL format - one JSON object per line)
            with open(file_path, "a", encoding="utf-8") as f:
                f.write(json.dumps(event, default=str) + "\n")
        except Exception as e:
            logger.warning(f"ELCS Telemetry: Failed to write event: {e}")
