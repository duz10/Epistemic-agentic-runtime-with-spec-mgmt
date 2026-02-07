#!/bin/bash

# ELCS Install Script
# Copies bootstrap files to an existing project

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where this script lives
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TEMPLATE_DIR="$SCRIPT_DIR/template"

# Check for target directory argument
if [ -z "$1" ]; then
    echo -e "${RED}Error: Please provide a target project directory${NC}"
    echo ""
    echo "Usage: ./install.sh /path/to/your/project"
    echo ""
    echo "This will copy ELCS bootstrap files to your project."
    echo "When you open the project with an AI agent, it will"
    echo "automatically set up ELCS and scan your codebase."
    exit 1
fi

TARGET_DIR="$1"

# Check if target exists
if [ ! -d "$TARGET_DIR" ]; then
    echo -e "${RED}Error: Directory does not exist: $TARGET_DIR${NC}"
    exit 1
fi

# Check if ELCS is already installed
if [ -d "$TARGET_DIR/elcs" ]; then
    echo -e "${YELLOW}Warning: elcs/ folder already exists in $TARGET_DIR${NC}"
    read -p "Overwrite bootstrap files anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 0
    fi
fi

echo -e "${GREEN}Installing ELCS bootstrap files to: $TARGET_DIR${NC}"
echo ""

# Copy bootstrap files
cp "$TEMPLATE_DIR/CLAUDE.md" "$TARGET_DIR/"
echo "  ✓ CLAUDE.md (for Claude Code CLI)"

cp "$TEMPLATE_DIR/AGENTS.md" "$TARGET_DIR/"
echo "  ✓ AGENTS.md (for Code-puppy and other agents)"

cp "$TEMPLATE_DIR/.cursorrules" "$TARGET_DIR/"
echo "  ✓ .cursorrules (for Cursor)"

cp "$TEMPLATE_DIR/.windsurfrules" "$TARGET_DIR/"
echo "  ✓ .windsurfrules (for Windsurf)"

# Copy PROTOCOL.md and QUICKSTART.md to a temp location for reference
mkdir -p "$TARGET_DIR/.elcs-ref"
cp "$TEMPLATE_DIR/elcs/PROTOCOL.md" "$TARGET_DIR/.elcs-ref/"
cp "$TEMPLATE_DIR/elcs/QUICKSTART.md" "$TARGET_DIR/.elcs-ref/"
echo "  ✓ .elcs-ref/ (protocol reference for agent)"

echo ""
echo -e "${GREEN}✅ ELCS bootstrap installed!${NC}"
echo ""
echo "Next steps:"
echo "  1. Open $TARGET_DIR in your AI agent (Claude Code, Cursor, etc.)"
echo "  2. The agent will detect ELCS and offer to set it up"
echo "  3. It will scan your project and create the elcs/ folder"
echo "  4. Review the inferred state and start working!"
echo ""
echo -e "${YELLOW}Tip: If the agent doesn't auto-detect, say:${NC}"
echo '  "Please read CLAUDE.md and set up ELCS for this project"'
echo ""
