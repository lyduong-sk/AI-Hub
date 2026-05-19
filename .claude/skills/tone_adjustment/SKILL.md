---
name: tone-adjustment
description: Adapt email tone to match context and requirements. Use this skill when: refining draft emails, adjusting formality level, ensuring tone alignment with recipient, or user specifies tone (Professional, Friendly, Formal, Apologetic, Persuasive). Triggers: tone specification or tone misalignment.
compatibility: Requires LLM for interpretation and rewriting.
---

# Tone Adjustment Skill

## Overview

Adapts email content to match the desired tone. Use when refining drafts to ensure tone alignment with context and recipient relationship.

## Supported Tones

| Tone | Characteristics | Word Markers | Use Case |
|------|---|---|---|
| **Professional** | Formal, respectful, measured | utilize, implement, appreciate, inform, scheduled, remains | Business updates, formal requests, stakeholder communication |
| **Friendly** | Warm, conversational, approachable | use, try, thanks, happy, great, looking forward | Team updates, casual collaboration, internal communication |
| **Formal** | Structured, ceremonial, reserved | hereby, regarding, consequently, concerning, moreover | Legal, official communications, formal announcements |
| **Apologetic** | Regretful, solution-focused, empathetic | sorry, understand, rectify, appreciate your patience | Addressing issues, recovery communications, apologies |
| **Persuasive** | Compelling, benefit-focused, confident | opportunity, advantage, recommend, suggest, consider, would benefit | Proposals, calls-to-action, sales communications |

## Tone Adaptation Markers

### Word Choice
- **Professional**: "utilize" vs Friendly: "use"
- **Formal**: "hereby" vs Professional: "we"
- **Apologetic**: "sorry" vs Neutral: "we regret"
- **Persuasive**: "opportunity" vs Neutral: "option"

### Punctuation
- **Formal**: End all sentences with periods; avoid exclamation marks
- **Friendly**: Occasional exclamation marks for enthusiasm (1 per 3-4 sentences)
- **Apologetic**: Exclamation marks minimal; focus on empathy markers
- **Professional**: Consistent periods; rare exclamation marks

### Sentence Length
- **Formal**: Varied length with longer compound sentences
- **Friendly**: Shorter, punchier sentences (10-15 words)
- **Professional**: Mix of short and medium (15-20 words)
- **Persuasive**: Short declarative sentences followed by benefit explanations

### Personal Pronouns
- **Formal**: Minimize "I/we"; use passive voice more
- **Friendly**: Use "we" naturally; occasional "I" is OK
- **Professional**: Balanced use of "we" and passive voice
- **Apologetic**: Frequent "I" (take responsibility) and "we" (team solidarity)
- **Persuasive**: Balance "you" (benefit to reader) and "we" (team capability)

## Tone Examples

Same email in different tones:

### Professional Tone
```
Dear Sarah,

I hope this email finds you well. I wanted to inform you that we have completed the Q2 budget review. The review is ready for discussion at your earliest convenience. I appreciate your patience as we worked through the allocations.

Please let me know your availability for a meeting.

Best regards,
Lý
```

### Friendly Tone
```
Hi Sarah,

Hope you're having a great day! Just wanted to let you know we've wrapped up the Q2 budget review. It's ready whenever you want to chat about it. Thanks for giving us time to work through the details!

Let me know what works for you, and we can set up a quick call.

Best,
Lý
```

### Formal Tone
```
Dear Ms. Sarah,

This is to inform you that the Q2 budget review has been completed and is hereby available for your review. The review addresses all requested allocations and is ready for discussion at your convenience.

Kindly advise of your availability to discuss the findings.

Sincerely,
Lý
```

### Apologetic Tone
```
Dear Sarah,

I sincerely apologize for the delay in completing the Q2 budget review. I understand how important this is to our planning process, and I appreciate your patience. We have now resolved the issues that were holding up our work.

I'm committed to rectifying this delay and am ready to discuss the review at whatever time is most convenient for you.

Thank you for your understanding.

Best regards,
Lý
```

## How to Apply Tone

1. **Identify the base email structure** (subject, greeting, body, closing)
2. **Apply tone word markers** from the table above
3. **Adjust sentence length** according to tone guidelines
4. **Review pronoun usage** to match tone requirements
5. **Check punctuation** for tone consistency
6. **Verify formality level** matches tone specification
