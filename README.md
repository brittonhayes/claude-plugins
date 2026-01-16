# Claude Plugins by Britton Hayes

A collection of Claude Code plugins for enhanced productivity and learning.

## Installation

Add this marketplace to Claude Code:

```bash
/plugin marketplace add brittonhayes/claude-plugins
```

## Available Plugins

### Polyglot - Language Learning Through Code

Learn any language naturally through coding sessions using spaced repetition and contextual vocabulary injection.

**Install:**
```bash
/plugin install polyglot@brittonhayes-claude-plugins
```

**Features:**
- Progressive vocabulary injection during natural code conversations
- Spaced repetition system with mastery tracking
- Support for Russian, Spanish, German, French, and Japanese
- Adjustable difficulty levels (1-10)
- Unix-style scripts for vocabulary management

**Quick Start:**
```
# After installation, configure your language
"Switch to Spanish and set difficulty to 5"

# Start coding and learning
"How do I reverse an array in JavaScript?"
Claude: "You can usar (use) the reverse() método (method)..."
```

[Full Documentation →](plugins/polyglot/README.md)

---

### Context Compactor - Learn Through Pressure

A Star Wars trash compactor-themed plugin that quizzes you on your code. Claude is trapped in a compactor, and the only way to stop the walls from closing is for you to explain what you just built.

**Install:**
```bash
/plugin install context-compactor@brittonhayes-claude-plugins
```

**Features:**
- Activates after significant code implementations (50+ lines, new features, APIs)
- Tests understanding vs. memorization through urgent questioning
- Configurable frequency settings (low/medium/high)
- Panicked, urgent, and genuinely funny tone
- Manual quiz trigger and skip commands

**Quick Start:**
```
# After installation, just start coding
# The compactor activates after significant implementations

🚨 COMPACTOR ACTIVATES 🚨
Claude: "WAIT WAIT WAIT - the compactor is turning on!
Quick, before we both get crushed - how does that
webhook validation prevent replay attacks??"

# Trigger a quiz manually
"Quiz me"

# Skip the current quiz
"Skip the quiz"
```

[Full Documentation →](plugins/context-compactor/README.md)

---

## Plugin Management

```bash
# Update marketplace to get latest versions
/plugin marketplace update

# List installed plugins
/plugin list

# Uninstall a plugin
/plugin uninstall polyglot@brittonhayes-claude-plugins

# Remove this marketplace
/plugin marketplace remove brittonhayes-claude-plugins
```

## For Developers

### Repository Structure

```
claude-plugins/
├── .claude-plugin/
│   └── marketplace.json      # Marketplace manifest
├── plugins/
│   ├── polyglot/             # Polyglot plugin
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── SKILL.md
│   │   ├── config.json
│   │   ├── data/
│   │   ├── scripts/
│   │   └── README.md
│   └── context-compactor/    # Context Compactor plugin
│       ├── .claude-plugin/
│       │   └── plugin.json
│       ├── SKILL.md
│       ├── config.json
│       ├── data/
│       ├── scripts/
│       └── README.md
└── README.md                 # This file
```

### Testing Locally

```bash
# Clone the repository
git clone https://github.com/brittonhayes/claude-plugins.git
cd claude-plugins

# Add as local marketplace
/plugin marketplace add .

# Install a plugin
/plugin install polyglot@brittonhayes-claude-plugins
```

### Contributing

Contributions welcome! Please feel free to submit a Pull Request.

## License

MIT License - see [LICENSE](LICENSE) for details

## Author

**Britton Hayes**
- Email: britton@brittonhayes.com
- GitHub: [@brittonhayes](https://github.com/brittonhayes)

---

**More plugins coming soon!**
