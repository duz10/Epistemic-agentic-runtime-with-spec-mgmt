# ELCS Install Script for Windows
# Adopts ELCS into an existing project

param(
    [Parameter(Mandatory=$false)]
    [string]$TargetDir
)

# Get the directory where this script lives
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$TemplateDir = Join-Path $ScriptDir "template"

Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                    ELCS Install Script                     ║" -ForegroundColor Cyan
Write-Host "║         Adopt ELCS into your existing project              ║" -ForegroundColor Cyan
Write-Host "╚═══════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Check for target directory argument
if (-not $TargetDir) {
    Write-Host "Error: Please provide a target project directory" -ForegroundColor Red
    Write-Host ""
    Write-Host "Usage: .\install.ps1 -TargetDir C:\path\to\your\project"
    Write-Host ""
    Write-Host "This will set up ELCS in your existing project."
    exit 1
}

# Check if target exists
if (-not (Test-Path $TargetDir -PathType Container)) {
    Write-Host "Error: Directory does not exist: $TargetDir" -ForegroundColor Red
    exit 1
}

# Check if ELCS is already fully installed
$ProtocolFile = Join-Path $TargetDir "elcs\PROTOCOL.md"
if (Test-Path $ProtocolFile) {
    Write-Host "ELCS is already installed in $TargetDir" -ForegroundColor Yellow
    Write-Host ""
    $response = Read-Host "Reinstall/update ELCS? (y/N)"
    if ($response -notmatch "^[Yy]$") {
        Write-Host "Aborted."
        exit 0
    }
}

Write-Host "Installing ELCS to: $TargetDir" -ForegroundColor Green
Write-Host ""

# ============================================================
# STEP 1: Handle bootstrap files (don't destroy existing!)
# ============================================================
Write-Host "Step 1: Bootstrap files" -ForegroundColor Cyan

function Handle-BootstrapFile {
    param([string]$Filename)
    
    $Source = Join-Path $TemplateDir $Filename
    $Target = Join-Path $TargetDir $Filename
    
    if (Test-Path $Target) {
        # File exists - check if it's already ELCS-aware
        $Content = Get-Content $Target -Raw -ErrorAction SilentlyContinue
        if ($Content -match "ELCS") {
            Write-Host "  => $Filename (already ELCS-aware, skipping)"
        } else {
            # Backup and append
            Copy-Item $Target "$Target.backup" -Force
            Add-Content $Target ""
            Add-Content $Target "# ============================================================"
            Add-Content $Target "# ELCS INSTRUCTIONS (added by install script)"
            Add-Content $Target "# ============================================================"
            Get-Content $Source | Add-Content $Target
            Write-Host "  + $Filename (appended ELCS instructions, backup saved)"
        }
    } else {
        # File doesn't exist - copy it
        Copy-Item $Source $Target -Force
        Write-Host "  + $Filename (created)"
    }
}

Handle-BootstrapFile "CLAUDE.md"
Handle-BootstrapFile "AGENTS.md"

# For dotfiles, just copy if they don't exist
$CursorRules = Join-Path $TargetDir ".cursorrules"
if (-not (Test-Path $CursorRules)) {
    Copy-Item (Join-Path $TemplateDir ".cursorrules") $TargetDir -Force
    Write-Host "  + .cursorrules (created)"
} else {
    Write-Host "  => .cursorrules (exists, skipping)"
}

$WindsurfRules = Join-Path $TargetDir ".windsurfrules"
if (-not (Test-Path $WindsurfRules)) {
    Copy-Item (Join-Path $TemplateDir ".windsurfrules") $TargetDir -Force
    Write-Host "  + .windsurfrules (created)"
} else {
    Write-Host "  => .windsurfrules (exists, skipping)"
}

# ============================================================
# STEP 2: Create elcs/ directory structure
# ============================================================
Write-Host ""
Write-Host "Step 2: Creating elcs/ directory structure" -ForegroundColor Cyan

$ElcsDirs = @(
    "elcs\state",
    "elcs\spec",
    "elcs\tokens\open",
    "elcs\tokens\closed",
    "elcs\lenses",
    "elcs\journal",
    "elcs\.gates",
    "elcs\archives"
)

foreach ($Dir in $ElcsDirs) {
    $FullPath = Join-Path $TargetDir $Dir
    New-Item -ItemType Directory -Path $FullPath -Force | Out-Null
}

Write-Host "  + elcs/ folder structure created"

# ============================================================
# STEP 3: Copy protocol files
# ============================================================
Write-Host ""
Write-Host "Step 3: Copying protocol files" -ForegroundColor Cyan

Copy-Item (Join-Path $TemplateDir "elcs\PROTOCOL.md") (Join-Path $TargetDir "elcs") -Force
Write-Host "  + PROTOCOL.md"

Copy-Item (Join-Path $TemplateDir "elcs\QUICKSTART.md") (Join-Path $TargetDir "elcs") -Force
Write-Host "  + QUICKSTART.md"

# ============================================================
# STEP 4: Create initial state files (for agent to populate)
# ============================================================
Write-Host ""
Write-Host "Step 4: Creating initial state files" -ForegroundColor Cyan

$Timestamp = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

$CurrentJson = @"
{
  "project_name": "TODO: Agent will populate from project scan",
  "adopted_at": "$Timestamp",
  "stage": 0,
  "status": "awaiting_agent_scan",
  "assumptions": [],
  "hypotheses": [],
  "evidence": [],
  "constraints": [],
  "notes": "ELCS installed via script. Agent should scan project and populate this state."
}
"@
$CurrentJson | Out-File (Join-Path $TargetDir "elcs\state\current.json") -Encoding utf8
Write-Host "  + state/current.json (template for agent to populate)"

$AssumptionsMd = @"
# Assumptions

> Document all assumptions here. Agent will populate during project scan.

## Pending Review

*None yet - agent will add assumptions after scanning the project.*
"@
$AssumptionsMd | Out-File (Join-Path $TargetDir "elcs\state\assumptions.md") -Encoding utf8
Write-Host "  + state/assumptions.md"

$EvidenceMd = @"
# Evidence

> Document all evidence here.

## Gathered Evidence

*None yet - agent will add evidence as work progresses.*
"@
$EvidenceMd | Out-File (Join-Path $TargetDir "elcs\state\evidence.md") -Encoding utf8
Write-Host "  + state/evidence.md"

# ============================================================
# STEP 5: Create adoption checkpoint
# ============================================================
Write-Host ""
Write-Host "Step 5: Creating adoption checkpoint" -ForegroundColor Cyan

$CheckpointDate = (Get-Date).ToString("yyyy-MM-dd")
$CheckpointContent = @"
# Checkpoint 000: ELCS Adoption

**Date**: $CheckpointDate
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
"@
$CheckpointContent | Out-File (Join-Path $TargetDir "elcs\journal\checkpoint-000-adoption.md") -Encoding utf8
Write-Host "  + journal/checkpoint-000-adoption.md"

# ============================================================
# STEP 6: Add elcs to .gitignore recommendations
# ============================================================
Write-Host ""
Write-Host "Step 6: Git recommendations" -ForegroundColor Cyan

$GitIgnore = Join-Path $TargetDir ".gitignore"
if (Test-Path $GitIgnore) {
    $GitIgnoreContent = Get-Content $GitIgnore -Raw -ErrorAction SilentlyContinue
    if ($GitIgnoreContent -notmatch "elcs/archives") {
        Add-Content $GitIgnore ""
        Add-Content $GitIgnore "# ELCS - large archives (optional, uncomment if needed)"
        Add-Content $GitIgnore "# elcs/archives/"
        Write-Host "  + Added ELCS recommendations to .gitignore"
    } else {
        Write-Host "  => .gitignore already has ELCS entries"
    }
} else {
    Write-Host "  i No .gitignore found (optional: add elcs/archives/ if archives get large)"
}

# ============================================================
# DONE!
# ============================================================
Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║                 ELCS Installation Complete!                ║" -ForegroundColor Green
Write-Host "╚═══════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""
Write-Host "Installed to: $TargetDir"
Write-Host ""
Write-Host "What was created:" -ForegroundColor Cyan
Write-Host "  elcs/                  - ELCS artifact directory"
Write-Host "  elcs/state/            - Epistemic state (beliefs, evidence)"
Write-Host "  elcs/spec/             - Project specification"
Write-Host "  elcs/tokens/           - Work coordination"
Write-Host "  elcs/journal/          - Progress checkpoints"
Write-Host "  CLAUDE.md / AGENTS.md  - Agent bootstrap files"
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  1. Open $TargetDir in your AI agent"
Write-Host "  2. The agent will scan your project and populate ELCS state"
Write-Host "  3. Review the inferred state and start working!"
Write-Host ""
Write-Host "Tip: If agent doesn't auto-scan, say:" -ForegroundColor Yellow
Write-Host '  "Please scan this project and populate the ELCS state files"'
Write-Host ""
