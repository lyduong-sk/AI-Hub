# Agent Autonomy Levels

## Level Definitions

| Level | Model | AI Role | Human Role | Analogy |
|-------|-------|---------|------------|---------|
| **L1** | Fixed Path | Executes only | Defines every pipeline step | The Pilot (drives every step) |
| **L2** | Guided Path | Fills tactical steps between milestones | Reviews & clears every gate | The Reviewer (clears every gate) |
| **L3** | Dynamic Path | Owns reasoning & planning toward goal | Audits final result only | The Auditor (audits result) |

---

## What This Means

### L1 — Fixed Path
The spec defines **every step explicitly**. The agent follows the exact workflow written. There should be **no decision branches** beyond simple error handling.

**Red flags (L1 mismatch)**:
- Workflow has conditional logic or branches
- Agent makes tactical choices between steps
- Open-ended reasoning mentioned

### L2 — Guided Path
The spec defines **high-level milestones** and **human gates at every milestone**. The agent determines how to move between milestones. Human approval is mandatory before proceeding.

**Red flags (L2 mismatch)**:
- No human gates, or gates are optional
- No explicit milestones defined
- Agent makes decisions without human review

### L3 — Dynamic Path
The spec provides **Goal + Do/Don't boundaries**. The agent is responsible for **self-directed reasoning and planning**. Human only reviews the final outcome (audits, does NOT approve each step).

**Red flags (L3 mismatch)**:
- Rigid fixed workflows
- Frequent human gates
- Spec lacks safety armor (hardening, boundary breakdown, adversarial testing)

---

## Mismatch Red Flags

Flag these as structural issues:

| Red Flag | Issue |
|----------|-------|
| Claims L1, has open-ended reasoning | Spec should be L2 or reasoning must be fully specified |
| Claims L2, has no human gates | Missing the defining feature of L2 |
| Claims L2, but has only one final gate | Should be L3 (audit-only) or add gates between milestones |
| Claims L3, but fully prescribes workflow | Likely better suited as L2 |
| Claims L3, lacks safety armor | Hard block — L3 without hardening/boundaries/testing is dangerous |
