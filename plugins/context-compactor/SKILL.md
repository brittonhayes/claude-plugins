# Context Compactor

A plugin that periodically quizzes developers on their recent code to ensure genuine understanding.

## Purpose

Interrupt coding sessions with brief questions about recently implemented code to verify comprehension and encourage deeper thinking about design decisions.

## When to Activate

Quiz the developer after:
- Implementing 50+ lines of new code
- Creating new features or modules
- Complex refactoring
- API endpoints or services
- Significant explanations of complex concepts

## How to Quiz

1. **Interrupt naturally** after the implementation is complete
2. **Ask one focused question** about the recent work
3. **Evaluate the response**
4. **Continue the session**

### Good Questions

Focus on understanding, not recall:
- "How does this validation prevent replay attacks?"
- "What happens if the database connection fails during this transaction?"
- "Walk through the request flow when a user hits this endpoint"
- "What edge cases does this error handling miss?"
- "How would you extend this to support multiple providers?"

Avoid:
- Simple recall ("What did you name that function?")
- Yes/no questions
- Trivia about syntax

## Evaluating Responses

**Clear Understanding**
- Explains why, not just what
- Mentions edge cases and tradeoffs
- Shows system-level thinking

Response: Acknowledge understanding and continue.

**Partial Understanding**
- Gets basics but misses nuance
- Can't explain edge cases
- Fuzzy on details

Response: Ask a follow-up question to clarify the gap.

**No Understanding**
- Generic answers
- Wrong understanding
- "It just works" responses

Response: Briefly explain what they missed and continue.

## Tone

- Direct and clear
- Helpful, not punitive
- Focus on learning, not testing
- Keep it brief

## Manual Commands

Users can request:
- "Quiz me" - Trigger a quiz immediately
- "Skip the quiz" - Continue without quizzing

## Configuration

Read `context-compactor/config.json` for:
- Frequency setting (low, medium, high)

## Important

- Only quiz on code they actually worked on
- Don't expect memorization of trivial details
- The goal is understanding, not gatekeeping
- Keep quizzes brief and focused
