#!/bin/bash
# SessionStart hook: Initialize polyglot config and export environment variables
set -euo pipefail

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/polyglot"
CONFIG_FILE="$CONFIG_DIR/config.json"
PROGRESS_DIR="$CONFIG_DIR/progress"

# Initialize config if it doesn't exist
if [ ! -f "$CONFIG_FILE" ]; then
  mkdir -p "$CONFIG_DIR"
  mkdir -p "$PROGRESS_DIR"

  # Check for default config in plugin directory
  if [ -f "${CLAUDE_PLUGIN_ROOT}/config.default.json" ]; then
    cp "${CLAUDE_PLUGIN_ROOT}/config.default.json" "$CONFIG_FILE"
  else
    # Fallback to hardcoded defaults
    echo '{"language": "ru", "difficulty": 5}' > "$CONFIG_FILE"
  fi
fi

# Ensure progress directory exists
mkdir -p "$PROGRESS_DIR"

# Read config and export to session environment
if [ -f "$CONFIG_FILE" ] && [ -n "${CLAUDE_ENV_FILE:-}" ]; then
  language=$(jq -r '.language // "ru"' "$CONFIG_FILE")
  difficulty=$(jq -r '.difficulty // 5' "$CONFIG_FILE")

  # Get due vocabulary terms for this session
  due_terms=""
  if [ -x "${CLAUDE_PLUGIN_ROOT}/skills/polyglot/scripts/get_due" ]; then
    due_terms=$(bash "${CLAUDE_PLUGIN_ROOT}/skills/polyglot/scripts/get_due" "$language" 2>/dev/null | head -10 | tr '\n' ',' | sed 's/,$//')
  fi

  # Export environment variables for the session
  {
    echo "export POLYGLOT_ACTIVE=true"
    echo "export POLYGLOT_LANGUAGE=$language"
    echo "export POLYGLOT_DIFFICULTY=$difficulty"
    echo "export POLYGLOT_DUE_TERMS=\"$due_terms\""
  } >> "$CLAUDE_ENV_FILE"
fi

# Output confirmation (shown in debug mode)
echo '{"continue": true, "systemMessage": "Polyglot language learning active. Vocabulary will be naturally injected into responses."}'
