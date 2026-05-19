---
name: agent-spec-reviewer
description: |
  Review agent specifications against the Agent Spec Template structure and tiered security checklists. Use this skill whenever you need to audit an agent spec, validate structure, check for security vulnerabilities, or assess readiness for approval. Applies Tier 1, 2, or 3 review based on autonomy level (L1/L2/L3 — Fixed Path/Guided Path/Dynamic Path). Identifies hard blocks (🔴 must fix) vs soft blocks (🟡 acceptable with documented risk). Always use when the user asks to "review an agent spec", "audit an agent", "check agent readiness", "validate my agent", "review this spec", or provides a path to an agent spec markdown file.
---

# Agent Spec Reviewer

Review agent specifications for:
1. **Template Structure** — All required sections present and substantive
2. **Autonomy Level Match** — Does the spec content match the declared L1/L2/L3?
3. **Tiered Checklists** — Tier 1/2/3 based on autonomy level
4. **Security Vulnerabilities** — Prompt injection, data masking, hardening, boundaries, adversarial testing
5. **Block Classification** — Hard blocks (🔴 must fix) vs soft blocks (🟡 acceptable with risk)

## Quick Reference: Autonomy Levels

| Level | Model | AI Role |
|-------|-------|---------|
| **L1** | Fixed Path | Executes only (human defines every step) |
| **L2** | Guided Path | Fills tactical steps (human gates every milestone) |
| **L3** | Dynamic Path | Owns reasoning (human audits final result) |

Read `references/autonomy-levels.md` for mismatch red flags.

## Process

1. **Read spec** → extract metadata, autonomy level, all sections
2. **Validate structure** → all required sections present and substantive (not placeholders)
3. **Check autonomy match** → does content match declared level?
4. **Run tier checklists** → L1→Tier 1 only; L2→Tier 1+2; L3→Tier 1+2+3
5. **Assess vulnerabilities** → prompt injection, masking, hardening, boundaries, testing
6. **Generate report** → clear verdict with hard/soft blocks and recommendations

## Output Format

```
# Agent Spec Review: [Agent Name]

**Autonomy Level**: L[1/2/3] — [Fixed/Guided/Dynamic] Path
**Overall Status**: ✅ READY / ⚠️ NEEDS FIXES / 🔴 BLOCKED

[Executive Summary]

## Structure Validation
[Present/Missing/Incomplete for each section]

## Autonomy Level Match
[Does content match declared level?]

## Tier 1 / Tier 2 / Tier 3 Results
[Each item: ✅ PASS | 🔴 HARD BLOCK | 🟡 SOFT BLOCK + evidence]

## Security Assessment
[Prompt injection, masking, hardening, boundaries, testing]

## Hard Blocks — Must Fix
[Numbered list with specific fix guidance]

## Soft Blocks — Acceptable with Risk
[Numbered list]

## Recommendations
[Prioritized next steps]
```

Read reference files as needed:
- `references/autonomy-levels.md` — Level definitions and mismatch red flags
- `references/template-structure.md` — Required sections and what's "substantive"
- `references/checklist-tiers.md` — Detailed tier checklists
- `references/vulnerability-checks.md` — Security checks
