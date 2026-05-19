# Tiered Review Checklists

## Autonomy → Tiers Required

| Level | Tiers | Approval By |
|-------|-------|-------------|
| L1 (Fixed Path) | Tier 1 only | Peer / Team Lead |
| L2 (Guided Path) | Tier 1 + Tier 2 | Team Lead / CoE Member |
| L3 (Dynamic Path) | Tier 1 + Tier 2 + Tier 3 | CoE Member |

**🔴 Hard Block** = Cannot proceed; fix required.
**🟡 Soft Block** = Can proceed with documented risk.

---

## Tier 1: Core Review (ALL agents)

**Agent Soul**
- Role unique, Objective specific 🔴 — Fail if generic or vague

**Agent Intention**
- Definition of Done is clear and testable 🔴 — Fail if unmeasurable
- Do/Don't boundaries explicit 🔴 — Fail if fewer than 2 of each or vague

**Agent Execution**
- Input data types, formats, constraints precisely specified 🔴
- Output format precisely specified 🔴
- Trigger Context clear 🟡

**Agent Governance**
- Prompt Injection Defense present 🔴 — Delimiters or sanitization
- Data Privacy/Masking strategy present 🔴 — PII and secrets handling

---

## Tier 2: Logic & Governance (L2+ — Guided Path)

**Agent Intention**
- Reasoning Protocol named and appropriate 🟡
- Human-in-the-Loop Gate is explicit and non-skippable 🔴 — For L2: gate at EVERY milestone

**Agent Execution**
- All skills listed or linked 🟡

**Agent Governance**
- Success Metrics: numeric target + audit frequency 🔴
- Audit Strategy: concrete failure-catch plan 🔴

---

## Tier 3: Safety Armor (L3 only — Dynamic Path)

**Agent Governance**
- System Prompt Hardening present 🔴 — Agent cannot leak instructions
- Boundary Breakdown present 🔴 — Agent stops on ambiguous requests (doesn't guess)
- Adversarial Input Testing documented 🟡 — Attack simulations tested
