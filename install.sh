#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Files to install: CLAUDE.md + everything it @-references
FILES=(CLAUDE.md SHAPING.md BREADBOARD_TEMPLATE.md)

usage() {
  echo "Usage: $(basename "$0") <destination-repo>"
  echo
  echo "Installs breadboard shaping instructions into a repo's .claude/ folder."
  exit 1
}

if [[ $# -ne 1 ]]; then
  usage
fi

dest="$1"

if [[ ! -d "$dest" ]]; then
  echo "Error: '$dest' is not a directory." >&2
  exit 1
fi

claude_dir="$dest/.claude"

if [[ ! -d "$claude_dir" ]]; then
  echo "Error: No .claude/ folder found in '$dest'." >&2
  echo "Run 'claude' in that repo first to initialize it, or create .claude/ manually." >&2
  exit 1
fi

# Check for collisions before copying anything
collisions=()
for f in "${FILES[@]}"; do
  if [[ -e "$claude_dir/$f" ]]; then
    collisions+=("$f")
  fi
done

if [[ ${#collisions[@]} -gt 0 ]]; then
  echo "Error: The following files already exist in $claude_dir/:" >&2
  for f in "${collisions[@]}"; do
    echo "  - $f" >&2
  done
  echo "Remove them first or use a different destination." >&2
  exit 1
fi

# Copy files
for f in "${FILES[@]}"; do
  cp "$SCRIPT_DIR/$f" "$claude_dir/$f"
  echo "  Copied $f → $claude_dir/$f"
done

echo "Done. Breadboard instructions installed."
