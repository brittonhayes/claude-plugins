#!/bin/bash
# Stop hook: Record vocabulary exposure from the session
set -euo pipefail

# Read hook input from stdin
input=$(cat)

# Get transcript path from input
transcript_path=$(echo "$input" | jq -r '.transcript_path // empty')

# Get language from environment or config
language="${POLYGLOT_LANGUAGE:-}"
if [ -z "$language" ]; then
  CONFIG_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/polyglot/config.json"
  if [ -f "$CONFIG_FILE" ]; then
    language=$(jq -r '.language // "ru"' "$CONFIG_FILE")
  else
    language="ru"
  fi
fi

# Extract terms from transcript if available
# Look for polyglot tracking comments: <!-- polyglot:terms_used:term1,term2,term3 -->
terms_to_record=""

if [ -n "$transcript_path" ] && [ -f "$transcript_path" ]; then
  # Extract all polyglot tracking comments from transcript
  terms_to_record=$(grep -oE '<!-- polyglot:terms_used:[^>]+ -->' "$transcript_path" 2>/dev/null \
    | sed 's/<!-- polyglot:terms_used://g' \
    | sed 's/ -->//g' \
    | tr ',' '\n' \
    | sort -u \
    | tr '\n' ' ' \
    | xargs)
fi

# Record the terms if any were found
if [ -n "$terms_to_record" ]; then
  record_script="${CLAUDE_PLUGIN_ROOT}/skills/polyglot/scripts/record"
  if [ -x "$record_script" ]; then
    # shellcheck disable=SC2086
    bash "$record_script" "$language" $terms_to_record 2>/dev/null || true
  fi
fi

# Output success
echo '{"continue": true}'
