---
name: polyglot
description: Manual controls for the polyglot language learning system. Use this skill to switch languages, adjust difficulty, add vocabulary, or check progress. Vocabulary injection happens automatically via hooks.
user-invocable: true
---

# Polyglot Language Learning Skill

This skill provides manual controls for the polyglot language learning system. Vocabulary injection happens automatically in the background via hooks - this skill is for when users want to explicitly manage their learning.

## Available Commands

When a user invokes this skill or asks about language learning, help them with these commands:

### Switch Language

**User says**: "Switch to Spanish", "Learn French now", "Change language to Japanese"

**Action**: Update the config file with the new language code:

```bash
CONFIG_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/polyglot/config.json"
# Read current config, update language, write back
jq '.language = "es"' "$CONFIG_FILE" > tmp.$$.json && mv tmp.$$.json "$CONFIG_FILE"
```

**Language codes**: `ru` (Russian), `es` (Spanish), `de` (German), `fr` (French), `ja` (Japanese)

### Adjust Difficulty

**User says**: "Make it easier", "Set difficulty to 8", "I want more immersion"

**Action**: Update the difficulty level (1-10) in config:

```bash
CONFIG_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/polyglot/config.json"
jq '.difficulty = 8' "$CONFIG_FILE" > tmp.$$.json && mv tmp.$$.json "$CONFIG_FILE"
```

**Difficulty levels**:
- **1-3 (Beginner)**: Translation-first - "the function (функция)"
- **4-6 (Intermediate)**: Target language with anchor - "the функция (function) returns"
- **7-10 (Advanced)**: Immersive - "создайте новую функцию for processing"

### Add Vocabulary

**User says**: "Add the word 'database' to my vocabulary", "Add 'recursion' in Russian"

**Action**: Run the add script:

```bash
bash "${CLAUDE_PLUGIN_ROOT}/skills/polyglot/scripts/add" <language> "<term>" "<translation>"
```

**Example**:
```bash
bash "${CLAUDE_PLUGIN_ROOT}/skills/polyglot/scripts/add" ru "база данных" "database"
```

### Check Progress

**User says**: "How's my Russian?", "Show my Spanish progress", "What vocabulary have I learned?"

**Action**: Run the stats script:

```bash
bash "${CLAUDE_PLUGIN_ROOT}/skills/polyglot/scripts/stats" <language>
```

**Example output**:
```
Language: ru
Total vocabulary: 120
Seen at least once: 45
Familiar (mastery ≥3): 18
Mastered (mastery 5): 5
Total exposures: 234

Top 10 most reviewed:
  функция: 23x (mastery: 4)
  переменная: 19x (mastery: 4)
  массив: 15x (mastery: 3)
```

### Get Due Terms

**User says**: "What words should I review?", "What's due for practice?"

**Action**: Run the get_due script:

```bash
bash "${CLAUDE_PLUGIN_ROOT}/skills/polyglot/scripts/get_due" <language>
```

### Initialize Config

**User says**: "Set up polyglot", "Initialize my config"

**Action**: Run the init script:

```bash
bash "${CLAUDE_PLUGIN_ROOT}/skills/polyglot/scripts/init"
```

This creates `~/.config/polyglot/config.json` with default settings.

## How Always-On Learning Works

The polyglot plugin uses hooks for automatic vocabulary injection:

1. **SessionStart hook**: Loads your config and fetches due vocabulary terms
2. **UserPromptSubmit hook**: Injects vocabulary naturally into every response
3. **Stop hook**: Records which terms you were exposed to for spaced repetition

You don't need to do anything - vocabulary appears naturally as you code. Use this skill only when you want to change settings or check progress.

## Vocabulary Tracking

The system tracks:
- **Count**: Number of times you've seen each term
- **Last seen**: When you last encountered the term
- **Mastery**: Level 1-5 based on total exposures

Terms reappear based on spaced repetition intervals:
- Mastery 1 (new): After 1 hour
- Mastery 2: After 6 hours
- Mastery 3 (familiar): After 1 day
- Mastery 4: After 3 days
- Mastery 5 (mastered): After 7 days

## Script Locations

All scripts are in `${CLAUDE_PLUGIN_ROOT}/skills/polyglot/scripts/`:
- `init` - Initialize user configuration
- `get_due` - Fetch terms due for review
- `record` - Record vocabulary exposure
- `add` - Add new vocabulary term
- `stats` - Show progress statistics
