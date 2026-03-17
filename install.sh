#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_NAME="shape"
SKILL_FILES=(SKILL.md BREADBOARD_TEMPLATE.md)

# Install targets
CLAUDE_DIR="$HOME/.claude/skills/$SKILL_NAME"
PI_DIR="$HOME/.pi/agent/skills/$SKILL_NAME"

usage() {
  echo "Usage: $(basename "$0")"
  echo
  echo "Installs the breadboard shaping skill globally for:"
  echo "  - Claude Code  (~/.claude/skills/$SKILL_NAME/)"
  echo "  - Pi Agent     (~/.pi/agent/skills/$SKILL_NAME/)"
  exit 1
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
fi

install_skill() {
  local target_dir="$1"
  local label="$2"

  mkdir -p "$target_dir"
  for f in "${SKILL_FILES[@]}"; do
    cp "$SCRIPT_DIR/$f" "$target_dir/$f"
  done
  echo "  ✓ $label → $target_dir/"
}

echo "Installing breadboard skill..."
echo
install_skill "$CLAUDE_DIR" "Claude Code"
install_skill "$PI_DIR" "Pi Agent"
echo
echo "Done. Use /shape (Claude Code) or /skill:shape (Pi) to start shaping."
