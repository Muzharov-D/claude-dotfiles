# Link user-level Claude Code config (agents/skills/commands) from this repo into ~/.claude.
# Symlinks require Windows Developer Mode or an elevated shell; falls back to copy otherwise.
$ErrorActionPreference = 'Stop'

$RepoDir   = Split-Path -Parent $MyInvocation.MyCommand.Path
$ClaudeDir = if ($env:CLAUDE_CONFIG_DIR) { $env:CLAUDE_CONFIG_DIR } else { Join-Path $HOME '.claude' }

New-Item -ItemType Directory -Force -Path $ClaudeDir | Out-Null

foreach ($d in 'agents', 'skills', 'commands') {
    $src = Join-Path $RepoDir $d
    $dst = Join-Path $ClaudeDir $d
    if (-not (Test-Path $src)) { continue }

    if (Test-Path $dst) {
        $stamp  = Get-Date -Format 'yyyyMMdd-HHmmss'
        $backup = "$dst.backup.$stamp"
        Move-Item $dst $backup
        Write-Host "backed up existing $dst -> $backup"
    }

    try {
        New-Item -ItemType SymbolicLink -Path $dst -Target $src -ErrorAction Stop | Out-Null
        Write-Host "linked $dst -> $src"
    } catch {
        Copy-Item $src $dst -Recurse
        Write-Host "copied $dst (symlink unavailable; re-run this script after changes)"
    }
}

Write-Host ""
Write-Host "Done. Restart Claude Code to pick up the changes."
