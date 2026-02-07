# ELCS Install Script for Windows
# Copies bootstrap files to an existing project

param(
    [Parameter(Mandatory=$false)]
    [string]$TargetDir
)

# Get the directory where this script lives
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$TemplateDir = Join-Path $ScriptDir "template"

# Check for target directory argument
if (-not $TargetDir) {
    Write-Host "Error: Please provide a target project directory" -ForegroundColor Red
    Write-Host ""
    Write-Host "Usage: .\install.ps1 -TargetDir C:\path\to\your\project"
    Write-Host ""
    Write-Host "This will copy ELCS bootstrap files to your project."
    Write-Host "When you open the project with an AI agent, it will"
    Write-Host "automatically set up ELCS and scan your codebase."
    exit 1
}

# Check if target exists
if (-not (Test-Path $TargetDir -PathType Container)) {
    Write-Host "Error: Directory does not exist: $TargetDir" -ForegroundColor Red
    exit 1
}

# Check if ELCS is already installed
$ElcsDir = Join-Path $TargetDir "elcs"
if (Test-Path $ElcsDir) {
    Write-Host "Warning: elcs/ folder already exists in $TargetDir" -ForegroundColor Yellow
    $response = Read-Host "Overwrite bootstrap files anyway? (y/N)"
    if ($response -notmatch "^[Yy]$") {
        Write-Host "Aborted."
        exit 0
    }
}

Write-Host "Installing ELCS bootstrap files to: $TargetDir" -ForegroundColor Green
Write-Host ""

# Copy bootstrap files
Copy-Item (Join-Path $TemplateDir "CLAUDE.md") -Destination $TargetDir -Force
Write-Host "  ✓ CLAUDE.md (for Claude Code CLI)"

Copy-Item (Join-Path $TemplateDir "AGENTS.md") -Destination $TargetDir -Force
Write-Host "  ✓ AGENTS.md (for Code-puppy and other agents)"

Copy-Item (Join-Path $TemplateDir ".cursorrules") -Destination $TargetDir -Force
Write-Host "  ✓ .cursorrules (for Cursor)"

Copy-Item (Join-Path $TemplateDir ".windsurfrules") -Destination $TargetDir -Force
Write-Host "  ✓ .windsurfrules (for Windsurf)"

# Copy PROTOCOL.md and QUICKSTART.md to a temp location for reference
$RefDir = Join-Path $TargetDir ".elcs-ref"
New-Item -ItemType Directory -Path $RefDir -Force | Out-Null
Copy-Item (Join-Path $TemplateDir "elcs\PROTOCOL.md") -Destination $RefDir -Force
Copy-Item (Join-Path $TemplateDir "elcs\QUICKSTART.md") -Destination $RefDir -Force
Write-Host "  ✓ .elcs-ref/ (protocol reference for agent)"

Write-Host ""
Write-Host "✅ ELCS bootstrap installed!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Open $TargetDir in your AI agent (Claude Code, Cursor, etc.)"
Write-Host "  2. The agent will detect ELCS and offer to set it up"
Write-Host "  3. It will scan your project and create the elcs/ folder"
Write-Host "  4. Review the inferred state and start working!"
Write-Host ""
Write-Host "Tip: If the agent doesn't auto-detect, say:" -ForegroundColor Yellow
Write-Host '  "Please read CLAUDE.md and set up ELCS for this project"'
Write-Host ""
