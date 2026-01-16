# Context Compactor

A Star Wars-themed quiz plugin that threatens to crush your coding session like a trash compactor. Only your understanding of the code can stop the walls from closing in.

## Overview

Inspired by the trash compactor scene in Star Wars Episode IV, this plugin creates urgency around understanding your own code. When you implement features without truly comprehending them, the walls begin to close. Answer correctly to stop the compactor and save your session.

The compactor activates automatically after significant implementations, interrupting with focused questions about what you just built. Clear answers stop the walls. Weak answers slow them down. Wrong answers... well, the compactor keeps closing.

## Why This Works

**The Problem**
- Copy-pasting code without understanding it
- Implementing features on autopilot
- Missing edge cases until they become production bugs
- Moving fast but building no intuition

**The Trash Compactor Solution**

By creating artificial urgency through the compactor metaphor, you're forced to articulate your understanding immediately after implementation. The stakes feel real (even though they're not), which:

- Makes you pay attention during implementation
- Surfaces knowledge gaps before you move on
- Reinforces learning through immediate recall
- Turns passive coding into active comprehension

The trash compactor isn't punishment - it's a teaching tool disguised as mortal danger.

## Installation

```bash
# Add the marketplace
/plugin marketplace add brittonhayes/claude-plugins

# Install the plugin
/plugin install context-compactor@claude-plugins
```

## How It Works

### Automatic Activation

The compactor monitors your session and activates after:
- 50+ lines of new code
- New features or modules
- Complex refactoring
- API endpoints or services
- Significant implementation work

### The Compactor Sequence

**Stage 1: The walls begin to close**
After you complete an implementation, the compactor activates. You'll be interrupted with a focused question.

**Stage 2: Your response determines your fate**
- Strong understanding: The walls stop. Session saved.
- Partial understanding: The walls slow. One follow-up question.
- No understanding: The walls continue. Brief explanation, then the session survives (barely).

**Stage 3: Continue coding**
Whether you stopped the compactor or just survived it, the session continues. But you've learned something.

### Example Session

```
You: [Implements webhook validation with HMAC signatures]

Compactor: The walls begin to close...

Quick question: how does your HMAC validation prevent replay attacks?

You: "The HMAC validates that the payload hasn't been tampered with."

Compactor: The walls continue closing. That's integrity, not freshness.

What about someone intercepting a valid request and sending it again?

You: "Oh. We'd need a timestamp check. The HMAC proves the message is valid,
but doesn't prevent reusing it."

Compactor: The walls stop. Correct. HMAC gives you integrity and authenticity,
but not protection against replay. Add a timestamp check with a narrow window.

You live to code another day.
```

## Usage

### Manual Commands

**Trigger immediately:**
```bash
"Quiz me"
```

**Emergency override:**
```bash
"Skip the quiz"
```

The walls will stop... this time.

## Configuration

Edit `context-compactor/config.json`:

```json
{
  "frequency": "medium"
}
```

**Frequency settings:**
- `low`: Compactor activates only after major implementations
- `medium`: Regular activation after significant changes (default)
- `high`: Frequent activation, even for smaller changes

Higher frequency means more pressure, more learning, and more chances to stop the walls.

## Reference

### File Structure

```
context-compactor/
├── .claude-plugin/
│   └── plugin.json      # Plugin metadata
├── SKILL.md             # Compactor behavior instructions
├── config.json          # Frequency configuration
└── README.md            # This file
```

### Question Types

The compactor asks about:
- Design decisions and tradeoffs
- Edge cases and failure modes
- System behavior under different conditions
- Security implications
- Extension points and flexibility

It avoids:
- Trivial recall (function names, syntax)
- Yes/no questions
- Memorization tests

## Tips for Survival

1. Pay attention while you're implementing
2. Think about edge cases as you code
3. Consider what could go wrong
4. Understand the "why" behind your decisions
5. Don't just make it work - know why it works

The compactor will find you. Be ready.

## Contributing

The walls are closing in on bugs too. Help us crush them:
https://github.com/brittonhayes/claude-plugins

## License

MIT - See LICENSE file

## Author

Britton Hayes
- Email: britton@brittonhayes.com
- GitHub: [@brittonhayes](https://github.com/brittonhayes)

---

*"What an incredible smell you've discovered." - Han Solo, moments before the trash compactor activated*
