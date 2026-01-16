# Polyglot - Learn Languages Through Code

A Claude Code plugin that progressively teaches you any language through natural code interaction. No flashcards, no drills—just code and conversation.

## Installation

### From Marketplace (Recommended)

In Claude Code, add the marketplace and install the plugin:

```bash
# Add the marketplace
/plugin marketplace add brittonhayes/claude-plugins

# Install the polyglot plugin
/plugin install polyglot@brittonhayes-claude-plugins
```

### From Local Development

If you're developing or testing locally:

```bash
# Clone the repository
git clone https://github.com/brittonhayes/claude-plugins.git
cd claude-plugins

# Add as local marketplace
/plugin marketplace add .

# Install the plugin
/plugin install polyglot@brittonhayes-claude-plugins
```

### Initial Configuration

After installation, configure your target language and difficulty level:

```bash
# Set your target language and difficulty (1-10)
# The config file is in your plugin cache directory
echo '{"language": "ru", "difficulty": 3}' > config.json
```

Or simply tell Claude during a session:
```
"Switch to Spanish and set difficulty to 5"
```

### Managing the Plugin

```bash
# Update the marketplace to get latest version
/plugin marketplace update

# List installed plugins
/plugin list

# Uninstall the plugin
/plugin uninstall polyglot@brittonhayes-claude-plugins

# Remove the marketplace
/plugin marketplace remove brittonhayes-claude-plugins
```

## Quick Start

### Your First Session

Once configured, start coding with Claude Code. The skill activates automatically and begins injecting vocabulary:

```
You: How do I reverse an array in JavaScript?

Claude: You can использовать (use) the reverse() метод (method)...
```

That's it. As you code, you learn. The system tracks every word and surfaces them using spaced repetition.

### Quick Language Reference

| Code | Language | Code | Language |
|------|----------|------|----------|
| `ru` | Russian  | `es` | Spanish  |
| `de` | German   | `fr` | French   |
| `ja` | Japanese | | |

## Usage

### Change Language

Edit `polyglot/config.json` or tell Claude:

```
"Switch to Spanish"
"Learn French now"
```

Claude will update the config and begin teaching in the new language.

### Adjust Difficulty

Set difficulty from 1 (beginner) to 10 (advanced):

```bash
# Via config
cd polyglot
echo '{"language": "ru", "difficulty": 7}' > config.json

# Or tell Claude
"Make it easier"
"Set difficulty to 8"
```

**Difficulty levels**:
- **1-3**: Translation-first - "the function (функция)"
- **4-6**: Target language with anchors - "the функция (function) returns"
- **7-10**: Immersive - "создайте новую функцию for processing"

### Add Vocabulary

Ask Claude to add domain-specific terms:

```
"Add the word 'database' to my Russian vocabulary"
"Add 'recursion' in Spanish to my vocabulary"
```

Claude will use the plugin's scripts to add these terms for you.

### Check Progress

Ask Claude about your progress:

```
"How's my Russian progress?"
"Show me my Spanish vocabulary stats"
```

Example output:
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
  ...
```

### Reset Progress

To start fresh with a language:

```bash
rm ~/.polyglot/progress/ru.json
```

Next session will reload from seed vocabulary.

## How It Works

### Spaced Repetition

The system tracks three data points per term:

1. **Count**: Number of times you've encountered the term
2. **Last seen**: Unix timestamp of last exposure
3. **Mastery**: Level from 0-5 based on total exposures

When Claude starts a response, it calls `get_due` to fetch terms ready for review. The script calculates which terms are "due" using this algorithm:

```
if (current_time - last_seen) > interval_for_mastery_level:
    term is due
```

Intervals grow exponentially:
- New words (mastery 1): Review after 1 hour
- Familiar (mastery 3): Review after 1 day
- Mastered (mastery 5): Review after 7 days

This mirrors human memory: recently learned words need frequent reinforcement, while deeply learned words stay fresh longer.

### Why Contextual Learning Works

Traditional language learning isolates vocabulary from context:

```
Flashcard: "функция = function"
```

Your brain creates a weak, abstract connection. But when you encounter words in meaningful context:

```
"You can создать (create) a новую (new) функцию (function)
to validate пользовательский ввод (user input)..."
```

Your brain forms multiple anchors:
- **Semantic**: "функция relates to code organization"
- **Syntactic**: "функция is a noun, goes with создать verb"
- **Pragmatic**: "I use функция when I need to solve X problem"

Context makes vocabulary stick 3-5x faster than isolated drilling.

### Progressive Immersion

The difficulty system gradually shifts the cognitive load:

**Level 1-3**: You read English, notice foreign words
- Minimal cognitive load
- Builds passive recognition

**Level 4-6**: You read foreign words, fall back to English anchors
- Moderate cognitive load
- Builds active recall

**Level 7-10**: You read target language, occasionally anchor to English
- High cognitive load
- Builds fluency and intuition

As you advance, Claude reduces scaffolding, forcing your brain to work harder—and learn deeper.

## Scripts

All scripts follow Unix philosophy: single purpose, text streams, composability.

### `record`

Increment exposure count for vocabulary terms.

**Usage**: `record <language> <term> [term2] [term3] ...`

**Input**: Language code and one or more terms

**Output**: Silent on success (updates `~/.polyglot/progress/<lang>.json`)

**Example**:
```bash
polyglot/scripts/record ru функция переменная
```

**How it works**:
- Loads progress file (creates if missing)
- For each term: increments count, updates timestamp, recalculates mastery
- Mastery levels: count 1 → mastery 1, count 2+ → mastery 2, count 5+ → mastery 3, count 10+ → mastery 4, count 20+ → mastery 5

### `get_due`

Output vocabulary terms due for spaced repetition review.

**Usage**: `get_due <language>`

**Input**: Language code

**Output**: List of terms (one per line), max 10

**Example**:
```bash
polyglot/scripts/get_due ru
# Output:
# функция
# переменная
# цикл
```

**How it works**:
- Calculates due status based on mastery level and time since last exposure
- Intervals: mastery 1 → 1 hour, mastery 2 → 6 hours, mastery 3 → 1 day, mastery 4 → 3 days, mastery 5 → 7 days
- Returns up to 10 due terms sorted by priority
- On first run, loads seed vocabulary from `data/<lang>.json`

### `add`

Add a new vocabulary term.

**Usage**: `add <language> <term> <translation>`

**Input**: Language code, target language term, English translation

**Output**: Confirmation message

**Example**:
```bash
polyglot/scripts/add ru "база данных" database
# Output: Added: база данных = database
```

**How it works**:
- Creates new entry with count 0, mastery 0
- Will appear in `get_due` output immediately (due after 0 seconds)

### `stats`

Show learning progress statistics.

**Usage**: `stats <language>`

**Input**: Language code

**Output**: Summary statistics and top 10 reviewed terms

**Example**:
```bash
polyglot/scripts/stats es
```

**How it works**:
- Aggregates progress data using jq
- Counts terms by mastery level
- Sorts by exposure count for "top reviewed" list

### The Unix Philosophy

Each script does exactly one thing and they compose via shell pipelines:

```bash
# Get due Russian terms that contain "функц"
polyglot/scripts/get_due ru | grep функц

# Add multiple terms from a file
cat new_vocab.txt | while read term trans; do
    polyglot/scripts/add ru "$term" "$trans"
done

# Track your learning velocity
polyglot/scripts/stats ru | grep "Total exposures"
```

Small, sharp tools. Text streams. Composability. This is how software should work.

## Supported Languages

Seed vocabulary included for:

- **Russian** (`ru`): Cyrillic script, 115 programming terms
- **Spanish** (`es`): Latin script, 125 programming terms
- **German** (`de`): Latin script, 110 programming terms
- **French** (`fr`): Latin script, 120 programming terms
- **Japanese** (`ja`): Kanji/Kana script, 115 programming terms (includes romaji)

### Adding New Languages

1. Create `polyglot/data/<language_code>.json` with this structure:

```json
{
  "term": {
    "translation": "english translation",
    "count": 0,
    "last_seen": 0,
    "mastery": 0
  }
}
```

2. For non-Latin scripts, include romanization in translation:
   - `"変数": {"translation": "variable (hensū)", ...}`

3. Focus on 100-200 programming terms first

4. Use the new language: `{"language": "<code>", "difficulty": 3}`

## Requirements

- **Claude Code**: This plugin requires Claude Code to be installed
- **jq**: JSON processing tool
  - macOS: `brew install jq`
  - Linux: `apt install jq` or `yum install jq`
  - Windows: Download from https://stedolan.github.io/jq/

## Troubleshooting

**"No progress found for language"**
- Run a session first, or manually trigger: `polyglot/scripts/get_due <lang>`

**"Scripts not executing"**
- Ensure scripts are executable: `chmod +x polyglot/scripts/*`

**"jq: command not found"**
- Install jq: `brew install jq` (macOS) or `apt install jq` (Linux)

**Progress not persisting**
- Check `~/.polyglot/progress/` directory exists and is writable
- Verify JSON files are valid: `jq empty ~/.polyglot/progress/ru.json`

**Terms not appearing in responses**
- Increase difficulty level (low levels inject fewer terms)
- Check terms are due: `polyglot/scripts/get_due <lang>`
- Claude may skip injection if terms aren't contextually relevant

## Plugin Structure

```
polyglot/
├── .claude-plugin/
│   └── plugin.json       # Plugin manifest
├── SKILL.md              # Skill instructions for Claude
├── config.json           # User configuration (language, difficulty)
├── data/                 # Seed vocabulary files
│   ├── ru.json
│   ├── es.json
│   ├── de.json
│   ├── fr.json
│   └── ja.json
├── scripts/              # Unix-style utility scripts
│   ├── get_due           # Fetch terms due for review
│   ├── record            # Record vocabulary exposure
│   ├── add               # Add new vocabulary
│   └── stats             # Show progress statistics
└── README.md             # This file
```

This plugin is part of the [claude-plugins](https://github.com/brittonhayes/claude-plugins) marketplace.

## Philosophy

Language learning shouldn't feel like work. It should feel like a side effect of doing what you already love.

This plugin makes learning invisible. You code, you converse, you solve problems—and vocabulary seeps in through natural repetition in meaningful contexts.

No apps. No streaks. No gamification. Just Unix tools and spaced repetition doing what they do best: composing into something greater than the sum of their parts.

## License

MIT License - see [LICENSE](LICENSE) for details

## Author

**Britton Hayes**
- Email: britton@brittonhayes.com
- GitHub: [@brittonhayes](https://github.com/brittonhayes)

## Contributing

Contributions welcome! Please feel free to submit a Pull Request.

---

Enjoy your polyglot journey.
