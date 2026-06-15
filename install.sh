#!/usr/bin/env bash
# Symlink user-level Claude Code config (agents/skills/commands) from this repo into ~/.claude.
# Existing real directories are backed up, not destroyed.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"

mkdir -p "$CLAUDE_DIR"

for d in agents skills commands; do
  src="$REPO_DIR/$d"
  dst="$CLAUDE_DIR/$d"
  [ -d "$src" ] || continue

  if [ -L "$dst" ]; then
    rm "$dst"                       # stale symlink — recreate cleanly
  elif [ -e "$dst" ]; then
    backup="$dst.backup.$(date +%Y%m%d-%H%M%S)"
    mv "$dst" "$backup"
    echo "↪ backed up existing $dst -> $backup"
  fi

  ln -s "$src" "$dst"
  echo "✓ linked $dst -> $src"
done

echo ""
echo "Done. Restart Claude Code (or run /agents) to pick up the changes."
