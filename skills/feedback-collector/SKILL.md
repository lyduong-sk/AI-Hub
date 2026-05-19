---
name: feedback_collector
description: >
  Use this skill in TWO modes during coding sessions:

  (1) BASELINE COMMIT — As soon as you deliver the first complete, working implementation or
  working version of code. Automatically commit with the exact message "=== Agent Base Output ==="
  to mark the checkpoint. This captures the agent's initial output BEFORE user review or changes.
  Triggers when the user says or implies: "baseline", "save as baseline", "mark [this] as baseline",
  "commit what you just did" (in baseline context), "checkpoint", or "mark base output". Always run
  automatically when you finish a complete implementation — if you didn't auto-trigger, the user can
  explicitly ask with any of these phrases.

  (2) SESSION RETROSPECTIVE & FEEDBACK COLLECTION — At the end of a coding session, when the user
  signals they want to stop, assess, or close out the work. This measures agent quality and trust
  for CoE tracking. Triggers ALWAYS when the user explicitly says: "collect feedback" OR "session
  feedback" OR "session retrospective" OR "end session feedback" OR "log the session" OR "capture
  what we learned" OR "we're done [with the session]" OR any form of /feedback_collector invocation.
  Also triggers if the user clearly signals session closure with phrases like "let me wrap this up",
  "we're finished", "final assessment", "retrospective", or "feedback [in closing context]".
  CRITICAL: Do NOT assume session end — only trigger when feedback/session-end intent is unmistakable.
  If unsure, ask the user rather than trigger.
---

# feedback_collector

A two-mode skill for tracking agent quality across sessions. It captures the data that allows
the CoE to measure whether agents are improving and whether teams trust them enough to increase
their autonomy.

---

## Mode 1: Baseline Commit

**When to run:** As soon as you have delivered a first complete, working implementation in a
session — before the user has had a chance to review and edit it.

**Steps:**

1. Stage all current changes:
   ```bash
   git add -A
   ```

2. Commit with the exact baseline message:
   ```bash
   git commit -m "=== Agent Base Output ==="
   ```

3. Confirm to the user:
   > "Baseline committed. I'll compare against this when we collect session feedback at the end."

**Edge cases:**
- If there are no uncommitted changes (nothing to commit), skip the commit and note: "No changes to commit for baseline — git is already up to date."
- If git is not initialised in the project, skip and note: "No git repo found — baseline commit skipped."
- If the baseline commit already exists in this session, do not create a duplicate.

---

## Mode 2: Session Retrospective (Feedback Collection)

**When to run:** When the user signals the session is ending and wants to capture feedback.

### Step 1: Read the Git Context

Run these commands to gather evidence:

```bash
# Find the baseline commit hash
git log --oneline | grep "=== Agent Base Output ===" | head -1

# Show what changed since baseline (or since HEAD if no baseline)
git diff --stat <baseline-hash>..HEAD 2>/dev/null || git diff --stat HEAD

# Show session history
git log --oneline -10
```

Note the baseline commit hash (or "not found"), the diff stats (files changed, insertions, deletions),
and the list of commits made during this session.

### Step 2: Auto-Generate Three Drafts from Conversation

Read back through the entire conversation and extract the following. These are ALWAYS generated —
never skip them even if the conversation was short.

**Draft A — Session Summary**
What was accomplished: the task asked, what was built or changed, which tools/files/APIs were
involved. 2-4 sentences.

**Draft B — Skill Feedback (General)**
Patterns or failures that would help improve this type of agent skill for everyone, not just
this project. Focus on: where the agent got stuck, what it misunderstood, what it had to be
corrected on, what information the user had to provide to unblock progress.

Example: "Agent initially misread the GraphQL schema structure — user had to provide the custom
resolver pattern manually before it could proceed. Suggest adding schema introspection as a
first step."

**Draft C — Project Context**
Knowledge specific to this project that a future session should know upfront. Focus on: domain
knowledge the user provided, project-specific conventions, gotchas, architecture decisions
clarified during the session.

Example: "Auth uses an internal JWT lib (not standard middleware). The custom resolver pattern
is in /src/resolvers/base.ts. Do not use the standard Express auth pattern here."

### Step 3: Present Drafts for Confirmation

Show the user all three drafts clearly and ask them to confirm, edit, or clear each one.
Present them in a readable format — not as a wall of text. The user does NOT need to write
anything from scratch; they just review and adjust.

Example presentation:

```
Here's what I've captured from our session. Please review and let me know if anything
needs to change — or just confirm and I'll save it.

**Session Summary:**
[Draft A text]

**Skill Feedback (to improve the agent generally):**
[Draft B text]

**Project Context (to save for this project):**
[Draft C text]

**Git diff since baseline:**
[diff --stat output, or "baseline not found — showing uncommitted changes"]
```

Wait for the user to confirm or provide edits before proceeding.

### Step 4: Collect Ratings

Use `AskUserQuestion` with these questions (ask them together in one call):

1. **Trust score** — "How confident were you in the quality of the agent's output?"
   Options: `1 – Very low / 2 – Low / 3 – Moderate / 4 – High / 5 – Very high`

2. **Correction rate** — "How much did you have to correct after the first output?" 
   (Show the git diff stat numbers as context before this question)
   Options: `1 – None / 2 – Minor change / 3 – Medium change / 4 – Big change / 5 – Complete rework`

3. **Root cause** (only ask if trust score ≤ 3) — "What was the main reason for the low score?"
   Options: `Logic – Agent misunderstood the task / Guidance – Instructions were too vague / Tooling – A bash/grep/tool failed / Other`

### Step 5: Save the Feedback Files

**File 1: Session record**

Save to `.feedback/sessions/YYYY-MM-DD-HHmm-session.md` in the current project directory.
Create the `.feedback/sessions/` directory if it doesn't exist.

```markdown
---
date: {ISO timestamp}
trust_score: {1-5}
correction_rate: {1-5}
root_cause: {logic|guidance|tooling|other|null}
baseline_commit: {hash or "not found"}
---

## Session Summary
{Draft A — confirmed by user}

## Git Context
{git diff --stat output}
Baseline commit: {hash or "not found"}

## Skill Feedback (General)
{Draft B — confirmed by user}

## Project Context
{Draft C — confirmed by user}
```

**File 2: Running index**

Append one line to `.feedback/index.md` (create if it doesn't exist, with a header row first):

```
| {date} | Trust: {score}/5 | Correction: {rate}/5 | Root cause: {value or —} | [Session]({relative path to session file}) |
```

If the file is new, prepend:
```
| Date | Trust | Correction | Root Cause | Link |
|------|-------|------------|------------|------|
```

### Step 6: Save Project Context to Memory

If Draft C (project context) has substantive content, also write it to the project memory system
so it's available in future sessions.

Save to: `~/.claude/projects/{encoded-project-path}/memory/project_context_{YYYYMMDD}.md`

Use this frontmatter:
```markdown
---
name: Project context from {date}
description: Project-specific knowledge captured during session on {date}
type: project
---

{Draft C content}
```

### Step 7: Confirm to User

Summarise what was saved:

```
Feedback captured:
- Trust: {score}/5 | Correction: {rate}/5{root cause if applicable}
- Saved to: .feedback/sessions/{filename}
- Index updated: .feedback/index.md
{- Project context saved to memory if applicable}
```

---

## Notes

- The `.feedback/` folder should be committed to the repo so the team can review session history.
- Never delete or overwrite existing session files — always append to the index.
- If the user declines to answer any question, record it as `null` in the session file.
- Keep the whole interaction brief — the user just finished a session and wants to close out, not fill in a form.
