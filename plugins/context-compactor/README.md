# Context Compactor

A lightweight plugin that quizzes you on recently implemented code to ensure genuine understanding.

## Overview

Context Compactor helps developers build deeper comprehension by periodically asking focused questions about code they just wrote. Instead of passively implementing features, you'll articulate your understanding of design decisions, edge cases, and system behavior.

## Why Use This

**The Problem**
- Implementing code without fully understanding it
- Missing edge cases until they become bugs
- Moving fast but not building intuition
- Copying patterns without grasping the reasoning

**The Solution**
Context Compactor prompts you to explain your code shortly after writing it. This practice:
- Surfaces gaps in understanding immediately
- Reinforces concepts through articulation
- Builds confidence in design decisions
- Encourages thinking about edge cases

## Installation

```bash
# Add the marketplace
/plugin marketplace add brittonhayes/claude-plugins

# Install the plugin
/plugin install context-compactor@claude-plugins
```

## How It Works

The plugin activates automatically after significant implementations:
- 50+ lines of new code
- New features or modules
- Complex refactoring
- API endpoints or services

It asks one focused question about your recent work, such as:
- "How does this validation prevent replay attacks?"
- "What happens if the database connection fails during this transaction?"
- "What edge cases does this error handling miss?"

Based on your response:
- **Clear understanding**: Continue working
- **Partial understanding**: Follow-up question to clarify
- **Unclear**: Brief explanation of what you missed

## Usage

### Automatic Activation

The plugin monitors your session and activates automatically after significant code changes.

### Manual Activation

Trigger a quiz anytime:
```bash
"Quiz me"
```

Skip a quiz if needed:
```bash
"Skip the quiz"
```

### Example Session

```
You: [Implements webhook validation with HMAC signatures]

Claude: [After implementation completes]
"Quick question: how does your HMAC validation prevent replay attacks?"

You: "The HMAC validates that the payload hasn't been tampered with."

Claude: "Right, but what about someone intercepting a valid request and
sending it again?"

You: "Oh, we'd need to add a timestamp check. The HMAC alone doesn't
prevent replaying the same valid request."

Claude: "Exactly. HMAC proves integrity and authenticity, but not freshness."
```

## Configuration

Edit `context-compactor/config.json`:

```json
{
  "frequency": "medium"
}
```

**Options:**
- `frequency`: How often to quiz - "low", "medium", or "high"

## Reference

### File Structure

```
context-compactor/
├── .claude-plugin/
│   └── plugin.json      # Plugin metadata
├── SKILL.md             # Behavior instructions
├── config.json          # Configuration
└── README.md            # This file
```

### Frequency Settings

- **low**: Quiz after major implementations only
- **medium**: Regular quizzes after significant changes (default)
- **high**: Frequent quizzes, including smaller changes

## Tips for Success

1. Pay attention during implementations
2. Think about edge cases as you code
3. Focus on understanding why, not just what
4. Take time to formulate thoughtful responses

## Contributing

Found a bug or have suggestions? Open an issue or PR at:
https://github.com/brittonhayes/claude-plugins

## License

MIT - See LICENSE file

## Author

Britton Hayes
- Email: britton@brittonhayes.com
- GitHub: [@brittonhayes](https://github.com/brittonhayes)
