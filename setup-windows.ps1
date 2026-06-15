# One-shot setup for a fresh Windows machine.
# Installs the Claude Code CLI and links agents/skills/commands into ~/.claude.
# Run from inside the cloned repo (PowerShell, not CMD):
#   powershell -ExecutionPolicy Bypass -File .\setup-windows.ps1
$ErrorActionPreference = 'Stop'
$RepoDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "==> [1/2] Claude Code CLI"
$installed = (Get-Command claude -ErrorAction SilentlyContinue) -or `
             (Test-Path "$env:USERPROFILE\.local\bin\claude.exe")
if ($installed) {
    Write-Host "    already installed - skipping."
} else {
    Write-Host "    installing via official installer..."
    Invoke-RestMethod https://claude.ai/install.ps1 | Invoke-Expression
}

Write-Host "==> [2/2] Linking agents / skills / commands into ~/.claude"
& "$RepoDir\install.ps1"

Write-Host ""
Write-Host "============================================================"
Write-Host " Base setup complete."
Write-Host ""
Write-Host " Last steps (plugins need a one-time browser login):"
Write-Host "   1. Open a NEW PowerShell window"
Write-Host "   2. claude            # log in with your account"
Write-Host "   3. Inside Claude Code, paste:"
Write-Host "        /plugin marketplace add https://github.com/PabloLION/bmad-plugin"
Write-Host "        /plugin install bmad@bmad-method"
Write-Host "        /plugin marketplace add https://github.com/jnuyens/gsd-plugin"
Write-Host "        /plugin install gsd@gsd-plugin"
Write-Host "============================================================"
