#!/usr/bin/env bash
# One-shot setup for a fresh macOS machine.
# Installs the Claude Code CLI, fixes PATH, and symlinks agents/skills/commands.
# Run from inside the cloned repo:   bash setup-mac.sh
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> [1/3] Claude Code CLI"
if command -v claude >/dev/null 2>&1 || [ -x "$HOME/.local/bin/claude" ]; then
  echo "    already installed - skipping."
else
  echo "    downloading official installer (no pipe, avoids the '|' problem)..."
  curl -fsSL https://claude.ai/install.sh -o /tmp/claude-install.sh
  bash /tmp/claude-install.sh
  rm -f /tmp/claude-install.sh
fi

echo "==> [2/3] PATH (~/.local/bin)"
if grep -qs '.local/bin' "$HOME/.zshrc" 2>/dev/null; then
  echo "    already in ~/.zshrc"
else
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
  echo "    added to ~/.zshrc"
fi
export PATH="$HOME/.local/bin:$PATH"

echo "==> [3/3] Linking agents / skills / commands into ~/.claude"
bash "$REPO_DIR/install.sh"

cat <<'NEXT'

============================================================
 Base setup complete.

 Last steps (plugins need a one-time browser login):
   1. Open a NEW terminal window   (or run:  source ~/.zshrc )
   2. claude            # log in with your Pro/Max/Team account
   3. Inside Claude Code, paste:
        /plugin marketplace add https://github.com/PabloLION/bmad-plugin
        /plugin install bmad@bmad-method
        /plugin marketplace add https://github.com/jnuyens/gsd-plugin
        /plugin install gsd@gsd-plugin
============================================================
NEXT
