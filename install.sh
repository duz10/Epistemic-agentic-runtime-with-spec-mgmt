#!/bin/bash

# ELCS Install Script
# Adopts ELCS into an existing project

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Get the directory where this script lives
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TEMPLATE_DIR="$SCRIPT_DIR/template"

echo -e "${CYAN}"
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║                    ELCS Install Script                     ║"
echo "║         Adopt ELCS into your existing project              ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check for target directory argument
if [ -z "$1" ]; then
    echo -e "${RED}Error: Please provide a target project directory${NC}"
    echo ""
    echo "Usage: ./install.sh /path/to/your/project"
    echo ""
    echo "This will set up ELCS in your existing project."
    exit 1
fi

TARGET_DIR="$1"

# Check if target exists
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${RED}Error: Directory does not exist: $TARGET_DIR${NC}"
    exit 1
fi

# Check if ELCS is already fully installed
if [ -f "$TARGET_DIR/elcs/PROTOCOL.md" ]; then
    echo -e "${YELLOW}ELCS is already installed in $TARGET_DIR${NC}"
    echo ""
    read -p "Reinstall/update ELCS? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 0
    fi
fi

echo -e "${GREEN}Installing ELCS to: $TARGET_DIR${NC}"
echo ""

# ============================================================
# STEP 1: Handle bootstrap files (don't destroy existing!)
# ============================================================
echo -e "${CYAN}Step 1: Bootstrap files${NC}"

handle_bootstrap_file() {
    local filename="$1"
    local source="$TEMPLATE_DIR/$filename"
    local target="$TARGET_DIR/$filename"
    
    if [ -f "$target" ]; then
        # File exists - check if it's already ELCS-aware
        if grep -q "ELCS" "$target" 2>/dev/null; then
            echo "  ⏭️  $filename (already ELCS-aware, skipping)"
        else
            # Backup and append
            cp "$target" "$target.backup"
            echo "" >> "$target"
            echo "# ============================================================" >> "$target"
            echo "# ELCS INSTRUCTIONS (added by install script)" >> "$target"
            echo "# ============================================================" >> "$target"
            cat "$source" >> "$target"
            echo "  ✓ $filename (appended ELCS instructions, backup saved)"
        fi
    else
        # File doesn't exist - copy it
        cp "$source" "$target"
        echo "  ✓ $filename (created)"
    fi
}

handle_bootstrap_file "CLAUDE.md"
handle_bootstrap_file "AGENTS.md"

# For dotfiles, just copy if they don't exist (less likely to have custom content)
if [ ! -f "$TARGET_DIR/.cursorrules" ]; then
    cp "$TEMPLATE_DIR/.cursorrules" "$TARGET_DIR/"
    echo "  ✓ .cursorrules (created)"
else
    echo "  ⏭️  .cursorrules (exists, skipping)"
fi

if [ ! -f "$TARGET_DIR/.windsurfrules" ]; then
    cp "$TEMPLATE_DIR/.windsurfrules" "$TARGET_DIR/"
    echo "  ✓ .windsurfrules (created)"
else
    echo "  ⏭️  .windsurfrules (exists, skipping)"
fi

# ============================================================
# STEP 2: Create elcs/ directory structure
# ============================================================
echo ""
echo -e "${CYAN}Step 2: Creating elcs/ directory structure${NC}"

mkdir -p "$TARGET_DIR/elcs/state"
mkdir -p "$TARGET_DIR/elcs/spec"
mkdir -p "$TARGET_DIR/elcs/tokens/open"
mkdir -p "$TARGET_DIR/elcs/tokens/closed"
mkdir -p "$TARGET_DIR/elcs/lenses"
mkdir -p "$TARGET_DIR/elcs/journal"
mkdir -p "$TARGET_DIR/elcs/.gates"
mkdir -p "$TARGET_DIR/elcs/archives"

echo "  ✓ elcs/ folder structure created"

# ============================================================
# STEP 3: Copy protocol files
# ============================================================
echo ""
echo -e "${CYAN}Step 3: Copying protocol files${NC}"

cp "$TEMPLATE_DIR/elcs/PROTOCOL.md" "$TARGET_DIR/elcs/"
echo "  ✓ PROTOCOL.md"

cp "$TEMPLATE_DIR/elcs/QUICKSTART.md" "$TARGET_DIR/elcs/"
echo "  ✓ QUICKSTART.md"

# ============================================================
# STEP 4: Create initial state files (for agent to populate)
# ============================================================
echo ""
echo -e "${CYAN}Step 4: Creating initial state files${NC}"

# Create current.json with adoption marker
cat > "$TARGET_DIR/elcs/state/current.json" << 'EOF'
{
  "project_name": "TODO: Agent will populate from project scan",
  "adopted_at": "TIMESTAMP_PLACEHOLDER",
  "stage": 0,
  "status": "awaiting_agent_scan",
  "assumptions": [],
  "hypotheses": [],
  "evidence": [],
  "constraints": [],
  "notes": "ELCS installed via script. Agent should scan project and populate this state."
}
EOF
# Replace timestamp placeholder
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s/TIMESTAMP_PLACEHOLDER/$(date -u +"%Y-%m-%dT%H:%M:%SZ")/" "$TARGET_DIR/elcs/state/current.json"
else
    sed -i "s/TIMESTAMP_PLACEHOLDER/$(date -u +"%Y-%m-%dT%H:%M:%SZ")/" "$TARGET_DIR/elcs/state/current.json"
fi
echo "  ✓ state/current.json (template for agent to populate)"

# Create empty assumptions.md
cat > "$TARGET_DIR/elcs/state/assumptions.md" << 'EOF'
# Assumptions

> Document all assumptions here. Agent will populate during project scan.

## Pending Review

*None yet - agent will add assumptions after scanning the project.*
EOF
echo "  ✓ state/assumptions.md"

# Create empty evidence.md
cat > "$TARGET_DIR/elcs/state/evidence.md" << 'EOF'
# Evidence

> Document all evidence here.

## Gathered Evidence

*None yet - agent will add evidence as work progresses.*
EOF
echo "  ✓ state/evidence.md"

# ============================================================
# STEP 5: Create adoption checkpoint
# ============================================================
echo ""
echo -e "${CYAN}Step 5: Creating adoption checkpoint${NC}"

CHECKPOINT_DATE=$(date +"%Y-%m-%d")
CHECKPOINT_FILE="$TARGET_DIR/elcs/journal/checkpoint-000-adoption.md"

cat > "$CHECKPOINT_FILE" << EOF
# Checkpoint 000: ELCS Adoption

**Date**: $CHECKPOINT_DATE
**Stage**: 0 (Awaiting Agent Scan)
**Status**: ELCS structure installed, awaiting agent to scan and populate state

## What Happened

ELCS was installed into this existing project via the install script.

## What's Next

When you open this project with an AI agent (Claude Code, Cursor, etc.):

1. The agent will read CLAUDE.md or AGENTS.md
2. It will see elcs/ exists but state is unpopulated
3. It should scan the project (README, package.json, etc.)
4. It will populate state/current.json with inferred information
5. You review and confirm, then continue working!

## Manual Trigger

If the agent doesn't auto-scan, say:
> "Please scan this project and populate the ELCS state files"

---
*Checkpoint created by ELCS install script*
EOF
echo "  ✓ journal/checkpoint-000-adoption.md"

# ============================================================
# STEP 6: Add elcs to .gitignore recommendations
# ============================================================
echo ""
echo -e "${CYAN}Step 6: Git recommendations${NC}"

if [ -f "$TARGET_DIR/.gitignore" ]; then
    if ! grep -q "elcs/archives" "$TARGET_DIR/.gitignore" 2>/dev/null; then
        echo "" >> "$TARGET_DIR/.gitignore"
        echo "# ELCS - large archives (optional, uncomment if needed)" >> "$TARGET_DIR/.gitignore"
        echo "# elcs/archives/" >> "$TARGET_DIR/.gitignore"
        echo "  ✓ Added ELCS recommendations to .gitignore"
    else
        echo "  ⏭️  .gitignore already has ELCS entries"
    fi
else
    echo "  ℹ️  No .gitignore found (optional: add elcs/archives/ if archives get large)"
fi

# ============================================================
# DONE!
# ============================================================
echo ""
echo -e "${GREEN}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                 ✅ ELCS Installation Complete!             ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "Installed to: $TARGET_DIR"
echo ""
echo -e "${CYAN}What was created:${NC}"
echo "  📁 elcs/                  - ELCS artifact directory"
echo "  📁 elcs/state/            - Epistemic state (beliefs, evidence)"
echo "  📁 elcs/spec/             - Project specification"
echo "  📁 elcs/tokens/           - Work coordination"
echo "  📁 elcs/journal/          - Progress checkpoints"
echo "  📄 CLAUDE.md / AGENTS.md  - Agent bootstrap files"
echo ""
echo -e "${CYAN}Next steps:${NC}"
echo "  1. Open $TARGET_DIR in your AI agent"
echo "  2. The agent will scan your project and populate ELCS state"
echo "  3. Review the inferred state and start working!"
echo ""
echo -e "${YELLOW}Tip: If agent doesn't auto-scan, say:${NC}"
echo '  "Please scan this project and populate the ELCS state files"'
echo ""
