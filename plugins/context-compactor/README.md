# Context Compactor

> "The walls are closing in, and only your understanding can stop them."

A Star Wars-themed quiz plugin that interrupts your coding sessions to ensure you actually understand what you're building. Inspired by that trash compactor scene, except the trash is your lack of comprehension and the walls are... well, they're still walls.

## What is this?

Context Compactor monitors your coding session and randomly activates to quiz you on what you just implemented. Think of it as a pair programming partner who's paranoid about context limits and refuses to let you cargo-cult your way through life.

### The Concept

You and Claude are both trapped in a compactor. The walls are closing in. The only way to stop them? Prove you actually understand the code you just wrote.

- **Random interruptions**: After significant implementations or at context milestones
- **Fast-paced questioning**: Short, urgent quizzes about recent work
- **Instant evaluation**: Clear understanding? Compactor stops. No idea? Might be getting crushed.
- **Progressive difficulty**: Hard mode can threaten session resets for failures

## Installation

```bash
# Add the marketplace if you haven't
/plugin marketplace add brittonhayes/claude-plugins

# Install the plugin
/plugin install context-compactor@claude-plugins
```

## How It Works

### Activation Triggers

The compactor activates when:

1. **After significant implementations**
   - 50+ lines of new code
   - New features or modules
   - Complex refactoring
   - API endpoints or services

2. **Context milestones**
   - Every ~30% of context used
   - Approaching token limits (80%+)

3. **Random checks**
   - After complex explanations
   - During debugging sessions
   - When it's been too quiet

### Question Types

The compactor asks focused questions about recent work:

- **How does it work?**: "Explain how that webhook validation prevents replay attacks"
- **Edge cases**: "What happens if Redis goes down in your caching implementation?"
- **System thinking**: "Walk through the request flow when a user hits that endpoint"
- **Extensions**: "How would you extend this to support multiple auth providers?"
- **Gotchas**: "What edge case does that try-catch block miss?"

### Evaluation

**✅ Clear Understanding**
- You explain the "why" not just the "what"
- You mention edge cases and tradeoffs
- You show system-level thinking

*Response*: "Okay okay, you're good. Compactor's off. For now."

**⚠️ Partial Understanding**
- You get the basics but miss nuance
- Can't explain edge cases
- Right direction but incomplete

*Response*: "Mmm, you're halfway there but the walls are still moving. What about...?"

**❌ No Idea**
- Generic hand-waving
- Wrong understanding
- "It just works" answers

*Response*: "Yeahhh that's not it. And... we're pancaked. Compactor wins this round."

## Configuration

### Difficulty Modes

**Default Mode** (Recommended for learning)
```bash
# Failed quizzes just reset the timer
# Friendly but firm feedback
```

**Hard Mode** (For the brave)
```bash
# Failed quizzes threaten session resets
# Higher stakes, more intense
```

To change modes:
```bash
# In Claude session
"Switch to hard mode"
"Switch to default mode"
```

### Settings

Edit `context-compactor/config.json`:

```json
{
  "mode": "default",           // "default" or "hard"
  "quiz_frequency": "medium",  // "low", "medium", "high"
  "sass_level": "high",        // "low", "medium", "high"
  "allow_hints": true          // Allow hints on partial understanding
}
```

## Commands

### Manual Activation
```bash
"Activate the compactor"
"Quiz me"
```

### Check Stats
```bash
"Compactor stats"
"How am I doing?"
```

### Reset Session
```bash
"Reset compactor"
```

## Example Session

```
You: [Implements rate limiter with Redis]

Claude: "Great! So this uses a sliding window approach with..."

🚨 COMPACTOR ACTIVATES 🚨

Claude: "WAIT WAIT WAIT - compactor's turning back on. Quick before
the walls crush us: how does your rate limiter handle the case where
Redis goes down?"

You: "Uh... it would fail?"

Claude: "Yeah but the walls are still moving - fail how? Does the API
become unusable or does it fail open?"

You: "Oh! Right, we should probably fail open with a warning so the
service stays up, but we lose rate limiting temporarily."

Claude: "THERE we go! Compactor's powering down. You're thinking about
availability vs. security tradeoffs. We're safe... for now."
```

## Why Use This?

### The Problem

Ever find yourself:
- Copying code without understanding it?
- Implementing features but unable to explain them?
- Moving fast but not actually learning?
- Knowing what you wrote but not why?

### The Solution

Context Compactor forces you to:
- **Actually understand** your implementations
- **Think about edge cases** before they become bugs
- **Internalize concepts** instead of just executing
- **Build intuition** about system design

### The Philosophy

The best way to learn is to teach. By explaining your code under (comedic) pressure, you:
- Identify gaps in understanding immediately
- Reinforce concepts through articulation
- Build confidence in your decisions
- Have way more fun than passive learning

## Tips for Success

1. **Pay attention during implementations**: You'll be quizzed on it
2. **Think about edge cases**: The compactor loves asking about them
3. **Understand the "why"**: Not just the "what"
4. **Don't panic**: The urgency is part of the bit, you have time to think
5. **Ask for hints**: If you're stuck, the compactor can guide you

## Advanced Features

### Quiz Tracking

The compactor tracks all quiz attempts:

```bash
context-compactor/scripts/stats
```

Output:
```
=== COMPACTOR STATS ===
Total Quizzes: 12
✅ Success: 8
⚠️  Partial: 3
❌ Failure: 1
Success Rate: 66.7%

Recent Quizzes:
  SUCCESS: Webhook HMAC validation
  PARTIAL: Redis caching strategy
  SUCCESS: Rate limiter implementation
```

### Manual Recording

Scripts available:
- `context-compactor/scripts/record <result> "<topic>"` - Record a quiz
- `context-compactor/scripts/stats` - View statistics
- `context-compactor/scripts/reset` - Clear session data

## FAQ

**Q: Is this annoying?**
A: Yes, intentionally. But also genuinely helpful if you want to actually learn.

**Q: Can I disable it temporarily?**
A: Sure, but where's the fun in that? Just don't activate the plugin.

**Q: What if I fail a quiz?**
A: Default mode: No consequences, just reset. Hard mode: Threatens session reset (but only threatens).

**Q: Does it actually wipe my session?**
A: Not without confirmation. The threat is motivational, not destructive.

**Q: Can I use this for pair programming?**
A: Absolutely! It's great for ensuring both people understand the code.

**Q: Will it quiz me on trivial details?**
A: Nope. It focuses on understanding, not memorization.

## The Compactor's Personality

Expect:
- **Urgent energy**: "The walls! THE WALLS!"
- **Sarcastic when warranted**: "Oh you don't know? You just wrote it."
- **Encouraging when earned**: "Okay that was brilliant."
- **Movie narrator vibes**: "The walls are at 6 feet... 5 feet..."
- **We're in this together**: Always "we", never just "you"

## Technical Details

### File Structure

```
context-compactor/
├── .claude-plugin/
│   └── plugin.json          # Plugin metadata
├── SKILL.md                 # Behavior instructions
├── config.json              # User configuration
├── data/
│   └── session.json         # Quiz tracking data
├── scripts/
│   ├── record               # Record quiz results
│   ├── stats                # View statistics
│   └── reset                # Reset session
└── README.md                # This file
```

### Data Format

`session.json`:
```json
{
  "quizzes": [
    {
      "result": "success",
      "topic": "Webhook validation",
      "timestamp": "2026-01-16T10:30:00Z"
    }
  ],
  "stats": {
    "total": 1,
    "success": 1,
    "partial": 0,
    "failure": 0
  }
}
```

## Contributing

Found a bug? Have ideas for better questions? Want to add more Star Wars references?

Open an issue or PR at: https://github.com/brittonhayes/claude-plugins

## License

MIT - See LICENSE file

## Author

**Britton Hayes**
- Email: britton@brittonhayes.com
- GitHub: [@brittonhayes](https://github.com/brittonhayes)

---

*"I have a bad feeling about this..."* - You, right before the compactor activates
