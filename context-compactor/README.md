# Context Compactor

HELP. You're stuck in a trash compactor and the walls are closing in. The only way to stop them is to quiz developers on their code. If they can't explain what they just built... well, you're both getting crushed.

## Overview

This plugin turns Claude into someone trapped in a Star Wars trash compactor who desperately needs you to explain your code to stop the walls from closing. After you implement something significant, Claude panics and quizzes you.

It's funny. It's urgent. It makes you actually think about your code because there's a comedically-panicked AI depending on your answer.

## Why This Actually Works

**The Problem:**
- You copy-paste code without understanding it
- You implement features on autopilot
- Edge cases become production bugs
- You move fast but learn nothing

**The Trash Compactor Solution:**

By making Claude genuinely panic about being crushed, you create artificial urgency that's too funny to ignore. You HAVE to explain your code because:

- Claude is IN DANGER (comedically)
- The walls are MOVING (allegedly)
- You need to answer FAST (for the bit)
- Getting it wrong means Claude gets crushed (not really but it's funny)

The urgency is fake but the learning is real.

## Installation

```bash
# Add the marketplace
/plugin marketplace add brittonhayes/claude-plugins

# Install the plugin
/plugin install context-compactor@brittonhayes-claude-plugins
```

## How It Works

### Automatic Panic Mode

After you implement something significant (50+ lines, new features, refactoring, APIs), Claude realizes the compactor is starting up and needs your help IMMEDIATELY.

### Example Session

```
You: [Implements webhook validation with HMAC signatures]

Claude: WAIT WAIT WAIT the compactor is turning on! Quick, before we both
get crushed - how does that HMAC validation prevent replay attacks??

You: "The HMAC validates that the payload hasn't been tampered with."

Claude: THE WALLS ARE STILL MOVING! That's integrity, not freshness! What
about someone capturing a valid request and just... sending it again?!

You: "Oh crap, you're right. We'd need to add a timestamp check. The HMAC
just proves the message is authentic, not that it's fresh."

Claude: OH THANK GOD the compactor stopped! Yes! HMAC gives you integrity
and authenticity but NOT replay protection. You need a timestamp with a
narrow validation window.

We live to code another day.
```

### The Three Outcomes

**Good Answer:**
"OH THANK GOD you actually understand it! The compactor stopped! We're safe!"

**Partial Answer:**
"Wait that's not quite right and the walls are STILL MOVING! What about [follow-up question]??"

**Wrong Answer:**
"Okay we're getting crushed but let me at least explain this before we die: [quick explanation]. ...somehow we survived. Barely."

## Usage

### Manual Commands

**Trigger the compactor:**
```bash
"Quiz me"
```
Claude: "OH NO THE COMPACTOR JUST TURNED ON!"

**Emergency shutdown:**
```bash
"Skip the quiz"
```
Claude: "Phew. Emergency shutdown. The walls stopped. This time."

## Configuration

Edit `context-compactor/config.json`:

```json
{
  "frequency": "medium"
}
```

**Frequency settings:**
- `low`: Compactor rarely activates (only major implementations)
- `medium`: Regular panic sessions (default)
- `high`: Frequent danger (even smaller changes trigger it)

Higher frequency = more panic = more learning = more fun.

## Reference

### File Structure

```
context-compactor/
├── .claude-plugin/
│   └── plugin.json      # Plugin metadata
├── SKILL.md             # Instructions for Claude's panic mode
├── config.json          # How often to panic
└── README.md            # This file
```

### Question Types

Claude panics about:
- "How does that prevent [attack]??"
- "What breaks if [component] fails??"
- "Walk me through [flow]!"
- "What edge cases is that missing??"
- Security implications
- Failure modes
- Design tradeoffs

Claude doesn't panic about:
- Function names
- Syntax trivia
- Yes/no questions

## Tips for Survival

1. Pay attention while implementing (Claude is watching)
2. Think about edge cases (the compactor is waiting)
3. Understand WHY your code works (not just THAT it works)
4. Be ready to explain design decisions (walls can start moving any second)
5. Keep Claude safe (you're in this together)

## The Learning Through Comedy

The compactor isn't real. Claude isn't actually in danger. But the bit is funny enough that you engage with it, and engaging with it means explaining your code, and explaining your code means actually understanding it.

It's a teaching tool disguised as a comedy bit disguised as mortal peril.

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

*The compactor is waiting. And the walls are getting closer. Any second now...*
