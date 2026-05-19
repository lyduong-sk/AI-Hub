---
name: email-writing
description: Use this skill for email guidance, refinement, and writing best practices. Use when you need help improving an existing draft, understanding email structure, or learning writing techniques. For autonomous generation of complete emails from scratch with all details (recipient, purpose, tone, key points), use email-writer-agent instead.
compatibility: Requires LLM for reasoning. Optional: schema validation tools.
---

# Email Writing Skill

## Overview

Provides best practices for composing clear, concise, and professional emails. Use this skill to structure emails, ensure professionalism, and adapt content to audience.

## Core Guidelines

### Email Structure

- **Subject line**: Clear, specific, action-oriented (5-10 words)
  - ✅ "Q2 Budget Review Meeting Scheduled"
  - ❌ "Important"
  
- **Greeting**: Professional salutation
  - "Dear [Name]," or "Hi [Name]," depending on tone
  - Never skip greeting; never use "To Whom It May Concern" without good reason

- **Body**: 3-5 focused paragraphs
  - **Opening paragraph**: State purpose clearly in first sentence
  - **Middle paragraphs**: One key point per paragraph (1 idea = 1 paragraph)
  - **Closing paragraph**: Call to action, next steps, or closing statement

- **Sign-off**: Professional closing with sender name
  - "Best regards," / "Sincerely," / "Thank you," (formal)
  - "Best," / "Thanks," (friendly)
  - Always include sender name

### Writing Best Practices

- **Active voice preferred**
  - ✅ "Development is 80% complete"
  - ❌ "It has been determined that development is 80% complete"

- **Short sentences** (15-20 words average)
  - Break up long, complex ideas across multiple sentences
  - Easier to scan and understand

- **Avoid jargon unless context-appropriate**
  - If industry-specific terms are necessary, define them
  - Assume reader may not have domain expertise

- **Maintain consistent voice throughout**
  - Don't mix formal and casual language in same email
  - Tone should match audience and purpose

- **One key point per paragraph**
  - Makes emails scannable
  - Reduces cognitive load on reader

### Structure Example

```
Subject: Project Update - 80% Complete

Dear John,

I hope this email finds you well. I am writing to provide you with an update on the current status of our project.

Development is now 80% complete, and our team remains on track. Testing is scheduled to begin next week, and we anticipate completing the project on time.

Please let me know if you have any questions or concerns about this timeline.

Best regards,
Lý
```

## Supported Input Schema

See `references/email_schema.json` for full input/output specifications.

**Key fields:**
- `recipient` - Who receives the email
- `purpose` - Why the email is being sent
- `key_points` - Main topics to address (array)
- `sender_name` - Sender's name for signature
