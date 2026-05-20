#!/usr/bin/env bash
# setup.sh — interactive bootstrap for claude-project-setup.
#
# Prompts for the four ROOT paths, writes config.local.md, copies the
# user-level /project-setup slash command, and creates the destination
# directories. Idempotent — safe to re-run.
#
# Usage:
#   bash bin/setup.sh

set -euo pipefail

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
REPO_ROOT="$( cd -- "$SCRIPT_DIR/.." &> /dev/null && pwd )"
CONFIG_LOCAL="$REPO_ROOT/config.local.md"
TEMPLATE_FILE="$SCRIPT_DIR/config.local.template.md"
SOURCE_CMD="$REPO_ROOT/templates/client-project/.claude/commands/project-setup.md"
USER_CMD_DIR="$HOME/.claude/commands"
USER_CMD_TARGET="$USER_CMD_DIR/project-setup.md"

# ---- helpers ----------------------------------------------------------------

prompt_path() {
  local var_name="$1" description="$2" default="$3" input
  read -r -p "  $description [$default]: " input
  input="${input:-$default}"
  input="${input/#\~/$HOME}"
  printf -v "$var_name" '%s' "$input"
}

confirm() {
  local input
  read -r -p "$1 [y/N]: " input
  [[ "$input" =~ ^[Yy]$ ]]
}

# ---- preflight --------------------------------------------------------------

[[ -f "$TEMPLATE_FILE" ]] || { echo "✗ Missing $TEMPLATE_FILE" >&2; exit 1; }
[[ -f "$SOURCE_CMD" ]]    || { echo "✗ Missing $SOURCE_CMD" >&2; exit 1; }

echo "claude-project-setup — first-time setup"
echo "Repo detected at: $REPO_ROOT"
echo

# ---- 1. write config.local.md ----------------------------------------------

SKIP_CONFIG=0
if [[ -f "$CONFIG_LOCAL" ]]; then
  echo "config.local.md already exists."
  if ! confirm "Overwrite it?"; then
    SKIP_CONFIG=1
    echo "  ✓ keeping existing config.local.md"
    # Best-effort read existing paths so we can still mkdir + copy below.
    CLIENTS_ROOT="$(awk '/^## CLIENTS_ROOT/{f=1;next} f && /^\`\`\`/{f++; next} f==2{print; exit}' "$CONFIG_LOCAL" | tr -d '[:space:]')"
    INTERNAL_ROOT="$(awk '/^## INTERNAL_ROOT/{f=1;next} f && /^\`\`\`/{f++; next} f==2{print; exit}' "$CONFIG_LOCAL" | tr -d '[:space:]')"
    TOOLS_ROOT="$(awk '/^## TOOLS_ROOT/{f=1;next} f && /^\`\`\`/{f++; next} f==2{print; exit}' "$CONFIG_LOCAL" | tr -d '[:space:]')"
  fi
fi

if [[ "$SKIP_CONFIG" -eq 0 ]]; then
  echo
  echo "Where should new project folders live? Press Enter to accept defaults."
  prompt_path CLIENTS_ROOT  "CLIENTS_ROOT  (client engagements)" "$HOME/Sites/clients"
  prompt_path INTERNAL_ROOT "INTERNAL_ROOT (internal products) " "$HOME/Sites/projects"
  prompt_path TOOLS_ROOT    "TOOLS_ROOT    (tools)             " "$INTERNAL_ROOT"

  # Token-substitute the template into config.local.md
  awk \
    -v template_root="$REPO_ROOT" \
    -v clients_root="$CLIENTS_ROOT" \
    -v internal_root="$INTERNAL_ROOT" \
    -v tools_root="$TOOLS_ROOT" \
    '{
      gsub(/\{\{TEMPLATE_ROOT\}\}/, template_root)
      gsub(/\{\{CLIENTS_ROOT\}\}/,  clients_root)
      gsub(/\{\{INTERNAL_ROOT\}\}/, internal_root)
      gsub(/\{\{TOOLS_ROOT\}\}/,    tools_root)
      print
    }' "$TEMPLATE_FILE" > "$CONFIG_LOCAL"
  echo
  echo "  ✔ wrote $CONFIG_LOCAL"
fi

# ---- 2. mkdir destination dirs ---------------------------------------------

echo
echo "Destination directories:"
for dir in "$CLIENTS_ROOT" "$INTERNAL_ROOT" "$TOOLS_ROOT"; do
  [[ -z "$dir" ]] && continue
  if [[ -d "$dir" ]]; then
    echo "  ✓ exists  $dir"
  else
    mkdir -p "$dir"
    echo "  ✔ created $dir"
  fi
done

# ---- 3. install user-level /project-setup ----------------------------------

echo
echo "User-level slash command:"
mkdir -p "$USER_CMD_DIR"
if [[ -f "$USER_CMD_TARGET" ]] && cmp -s "$SOURCE_CMD" "$USER_CMD_TARGET"; then
  echo "  ✓ already installed at $USER_CMD_TARGET"
elif [[ -f "$USER_CMD_TARGET" ]]; then
  echo "  ! $USER_CMD_TARGET exists and differs from the repo's version"
  if confirm "  Overwrite?"; then
    cp "$SOURCE_CMD" "$USER_CMD_TARGET"
    echo "  ✔ overwrote $USER_CMD_TARGET"
  else
    echo "  ✓ kept existing"
  fi
else
  cp "$SOURCE_CMD" "$USER_CMD_TARGET"
  echo "  ✔ installed $USER_CMD_TARGET"
fi

# ---- done -------------------------------------------------------------------

echo
echo "Setup complete."
echo "Open Claude Code anywhere and run /project-setup to scaffold a project."
if [[ "$SKIP_CONFIG" -eq 0 ]]; then
  echo "Optional: edit $CONFIG_LOCAL to fill in the Principal User Identity section."
fi
