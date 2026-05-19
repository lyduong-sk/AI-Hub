# Email Writing Agent Tutorial - Refinement Summary

## Overview
Building a 3-part tutorial series on agentic systems using an Email Writing Agent as the example, following Anthropic's Agentic Systems Workflow guideline.

### Tutorial Progression
1. **Tutorial 1 (Current):** Less Autonomous - Fixed workflow, predefined steps
2. **Tutorial 2:** Semi-Autonomous - User decisions, path variants, approval gates
3. **Tutorial 3:** Highly Autonomous - Tool selection, scripts, MCP integration, dynamic planning

---

## Tutorial 1: Email Writing Agent (Less Autonomous)

### Status: Complete (Hybrid Contract + Workflow Design)
- Step 1: Agent's purpose (role, autonomy level)
- Step 2: GOAL/DO/DON'T constraints
- Step 3: Design Workflow
  - 3.1: System I/O Bookends (user input + output contracts)
  - 3.2: Workflow Overview
  - 3.3: Workflow Diagram
- Step 4: Required Skills and Context
- Step 5: Implement the Agent
- Step 6: Evaluate and Refine
  - 6.1: Example Execution (sample input/output with trace)
  - 6.2: Evaluation & Testing (criteria + 1 test scenario)
  - 6.3: Troubleshooting (decision tree + quick fixes)
- Step 7: Security and Safety (final step, no Step 8)
  - Input Sanitization (with bash script + PreToolUse hook)
  - PII Detection and Handling
  - Output Audit Logging (JSON format to ~/.claude/logs/)
  - LLM Prompt Injection Prevention
- Real implementation files created (agent + 2 skills + bash script + hook configuration)

### Updated Approach: Hybrid Contract + Workflow Design

**Key change:** Reorganized steps to follow agent design best practices:
- **Step 1-2:** Define purpose and constraints
- **Step 3:** Design Workflow (with I/O bookends as substep 3.1)
  - Establish System I/O Bookends first (user input + agent output contracts)
  - Then design the workflow grounded by those contracts
- **Step 4:** Define Required Skills (using [open standard](https://agentskills.io/home))
- **Step 5:** Implement Agent (with proper YAML frontmatter for triggering)
- **Step 6:** Evaluate & Refine (includes example execution as substep 6.1)
- **Step 7:** Security and Safety Considerations
- **Step 8:** Next Steps

This structure prevents circular reasoning: you establish I/O boundaries first, then design the workflow within those constraints.

### Key Corrected Sections

#### 1. Project Setup Structure (CRITICAL)
[Skills](https://agentskills.io/home) must follow the [open standard structure](https://agentskills.io/home), NOT flat files:
```
.claude/
├── agents/
│   └── email_writer_agent.md
└── skills/
    ├── email_writing/
    │   ├── SKILL.md (with frontmatter: name, description, compatibility)
    │   ├── references/
    │   │   └── email_schema.json
    │   └── assets/
    │       ├── sample_input.json
    │       └── sample_output.json
    └── tone_adjustment/
        ├── SKILL.md (with frontmatter)
        └── references/
            └── tone_guidelines.md
```

**Key point:** Schemas, examples, and guidelines BELONG INSIDE skills (references/ and assets/), not at project root.

#### 2. SKILL.md Frontmatter (CRITICAL for Discovery)
Every skill MUST include:
```yaml
---
name: email-writing
description: Create clear, professional emails. Use this skill whenever: drafting email content, refining email tone, structuring messages. Specific triggers: "write an email," "draft a message," user provides email context.
compatibility: Requires LLM for reasoning. Optional: schema validation tools.
---
```

**Why it matters:** Description is the primary triggering mechanism. Be "pushy" about when to use the skill.

#### 3. Agent Definition Requirements (Step 5)
Agent must declare:
- **Role:** Clear statement of what it does
- **Inputs:** Formal JSON schema with field descriptions
- **Outputs:** Expected output format
- **Autonomy Level:** Less Autonomous (fixed steps) vs Semi/Highly
- **[Claude Code Tools](https://code.claude.com/docs/en/tools-reference):** Explicit declaration of [Read](https://code.claude.com/docs/en/tools-reference), [Skill](https://code.claude.com/docs/en/tools-reference), [Agent](https://code.claude.com/docs/en/tools-reference) tools needed
- **Process:** Fixed workflow with validation gates (not dynamic choices)
- **Constraints:** MUST DO / MUST NOT lists
- **Error Handling:** Table showing agent behavior on failures

#### 4. Skills Mapping (New Addition)
Map skills to workflow steps (from the 6-step workflow in Tutorial Step 3):

| Workflow Step | Task | Required Skill | Applied By |
|---|---|---|---|
| 2 | Identify intent and tone | email_writing skill | LLM + skill |
| 3 | Draft email content | email_writing skill | LLM + skill |
| 4 | Refine structure and grammar | tone_adjustment skill | LLM + skill |
| 5 | Validate output | Constraint checklist | Agent validation |

#### 5. Fixed Workflow (6 Steps, from Tutorial Step 3.2)

```
Step 1: Validate Input
  → Check required fields (recipient, subject, purpose, tone, key_points, sender_name)
  → Verify tone is valid enum value
  → Fail fast if input malformed

Step 2: Analyze Context (Apply email_writing skill)
  → Parse recipient, purpose, key_points
  → Identify email structure needs
  → Reference email_writing skill guidelines

Step 3: Draft Email (LLM + email_writing skill)
  → Use LLM with email_writing skill context
  → Structure: greeting + purpose + key points + closing
  → Apply professional writing guidelines

Step 4: Refine Structure and Grammar (Apply tone_adjustment skill)
  → Validate requested tone against supported tones
  → Use tone_adjustment skill to adapt language
  → Verify tone markers applied correctly

Step 5: Validate Output
  → Check subject line clarity (5-10 words, specific)
  → Verify email addresses handled correctly
  → Ensure no sensitive data leakage
  → Confirm tone matches request

Step 6: Return Output
  → Output valid JSON with subject and email_body fields
```

#### 6. Tools Allowed Declaration

| Tool | When Used | Constraints |
|------|-----------|---|
| LLM | Content generation, reasoning | Always available |
| Schema validation | Optional, after output generation | Validates against schema.json |
| Scripts | Not used | None |
| External APIs | None | Not allowed |

#### 7. Security Infrastructure (Input Validation & Logging)

**Input Sanitization via PreToolUse Hook:**
- `.claude/scripts/sanitize-input.sh` — Bash script that validates JSON input
  - Checks all required fields present (recipient, subject, purpose, tone, key_points, sender_name)
  - Validates tone enum (Professional, Friendly, Formal, Apologetic, Persuasive)
  - Scans for injection patterns (case-insensitive): "ignore previous", "disregard", "system prompt", "act as", "you are now"
  - Returns JSON result: `{"valid": true}` or `{"valid": false, "error_message": "..."}`
  - Exit code 0 (valid) or 1 (invalid)

- `.claude/settings.json` — PreToolUse hook configuration
  - Hook triggers before email_writer_agent is invoked
  - Runs sanitize-input.sh on input JSON
  - Blocks agent execution if validation fails

**Audit Logging:**
- `.claude/logs/` directory for JSON-formatted logs
- Each run writes: timestamp, agent name, input hash, tone, key_points_count, steps_completed, errors
- Location: `~/.claude/logs/email-agent.log` (JSON, one object per line)
- Uses SHA256 hash of input instead of full content (protects PII in logs)

#### 8. Step 6 Structure (Streamlined)

Step 6 (Evaluate and Refine) was condensed from 6 subsections → 3 subsections → further streamlined:

**Current structure (lean & essential):**
- 6.1: Example Execution
  - Sample Input/Output (brief JSON only)
  - Why This Output Is Correct (4-row trace table)
- 6.2: Evaluation & Testing
  - Evaluation Criteria (4 essential metrics, not 6)
  - Test Failure Scenario (1 representative case, not 4)
- 6.3: Troubleshooting
  - Trace Failures (5-row symptom → cause → check table)
  - Quick Fixes (4 actionable fixes, no detailed examples)

**Removed for brevity:**
- Comparison: Good vs. Bad output section
- 3 of 4 test scenarios (kept 1 representative case)
- Detailed refinement checklist (condensed to 4 quick fixes)
- Debug example walkthrough (integrated key points into trace table)

**Result:** Step 6 reduced to ~50% of original length, keeping only essential content. Stays focused on "what to measure" and "how to fix when broken".

---

## What Changed vs. Original

### Before
- Skills were single `.md` files (no structure)
- Schemas in separate `schemas/` folder
- Examples in separate `examples/` folder
- Context in separate `context/` folder
- Agent had generic "instructions" (no formal Role/Inputs/Outputs/Tools)
- No explicit tool declarations
- Vague error handling

### After
- Skills are folders with `SKILL.md` + `references/` + `assets/`
- Schemas/examples/context nested inside skills (proper Anthropic standard)
- Agent has formal definition matching skill-creator examples
- Tools explicitly declared per agent
- Structured error handling with fallback strategies
- Skills have proper YAML frontmatter for triggering

---

## Remaining Work for Tutorial 1

### ✅ All sections complete. Ready to start Tutorial 2.

**What was added in Task 5 (final refinement):**
- Removed Step 8 (Next Steps) to keep tutorial concise and focused
- Removed "Organizational Policy Compliance" from Step 7 (too specific)
- Implemented input sanitization via PreToolUse hook (`.claude/scripts/sanitize-input.sh`)
- Created `.claude/settings.json` with hook configuration
- Updated Step 7 Input Sanitization with actual bash script and usage examples
- Enhanced Step 7 Output Audit Logging with JSON format and example log entry
- Added `.claude/logs/` directory for audit logs

**Structure refinement:**
- Tutorial now ends at Step 7 (Security and Safety) — concise and production-ready
- Input validation is now actionable (actual bash script, not pseudo-code)
- Security and logging are integrated with Claude Code hooks, not manual post-processing
- Removed theoretical next steps; focus is on building one complete, secure agent

---

## Tutorial 2 (Semi-Autonomous) - Planning

### Key Differences from T1
- **Agent asks user** for decisions instead of computing everything
- **Path variants** - same agent, different routes based on user input
- **Approval gates** - user validates agent's proposed actions before executing
- **Feedback loops** - user can say "retry with X adjustment"
- **State management** - track conversation history and user preferences

### Example Flow
```
Input → Analyze → [USER DECISION: "Refine draft?"] → Draft → [USER APPROVAL: "Tone OK?"] → Tone Adjust → Output
```

### New Concepts for T2
- Decision trees (if/then based on user input)
- User prompt integration (agent parses user responses)
- Fallback strategies (what if user declines action)
- Cost/performance trade-offs (quick vs. careful mode)
- Graceful degradation (skip optional steps)

---

## Tutorial 3 (Highly Autonomous) - Planning

### Key Differences from T2
- **Agent decides everything** (no user prompts for standard decisions)
- **Tool selection** - agent picks which skills/scripts/APIs to use
- **Scripts + MCP** - agent calls external tools, processes results
- **Dynamic planning** - agent creates own step sequence vs. predefined
- **Error recovery** - agent retries, falls back, or escalates autonomously
- **Resource limits** - agent tracks tokens/time/cost, makes tradeoffs
- **Multi-skill coordination** - orchestrate multiple skills with dependencies

### Example Flow
```
Input → LLM analyzes → Selects skills + tools → Executes → Handles errors → Logs + returns
(All dynamically, no predefined steps)
```

### New Concepts for T3
- Tool hooks (triggering secondary workflows)
- LLM-based planning (ReAct or similar)
- Retry logic with exponential backoff
- Observability/logging for debugging
- Performance tuning (async, batching, caching)
- Resource budgeting (token limits, time limits)

---

## Current File Locations

**Tutorial Document:** `/Users/ly.duong/IdeaProjects/claude-code-tutorial/tutorial_1_email_agent_tutorial_with_agent_standards.md`

**Implementation Files (Created):**
- `.claude/agents/email_writer_agent.md` — Complete working agent with YAML frontmatter
- `.claude/skills/email_writing/SKILL.md` — Email writing skill with guidelines
- `.claude/skills/email_writing/references/email_schema.json` — Input/output schema
- `.claude/skills/email_writing/assets/sample_input.json` — Example request
- `.claude/skills/email_writing/assets/sample_output.json` — Example response
- `.claude/skills/tone_adjustment/SKILL.md` — Tone adjustment skill with tone markers
- `.claude/skills/tone_adjustment/references/tone_guidelines.md` — Comprehensive tone reference

**Security & Configuration Files (Created in Task 5):**
- `.claude/scripts/sanitize-input.sh` — Bash script for JSON validation and injection detection (executable)
- `.claude/settings.json` — PreToolUse hook configuration that triggers sanitize-input.sh before agent invocation
- `.claude/logs/.gitkeep` — Directory marker for audit logs (written to `~/.claude/logs/email-agent.log` at runtime)

---

## References Used

1. **[Claude Code Tools Reference](https://code.claude.com/docs/en/tools-reference)** - Complete reference for [Read](https://code.claude.com/docs/en/tools-reference), [Skill](https://code.claude.com/docs/en/tools-reference), [Agent](https://code.claude.com/docs/en/tools-reference) tools and permissions
2. **[Agent Skills Open Standard](https://agentskills.io/home)** - Open standard for composable, reusable skills (SKILL.md format, references/, assets/)
3. **Agentic Systems Workflow Guideline** - 8-step framework for building reliable agents
4. **Agent Development Skill** - Best practices for agent frontmatter, triggering conditions, and system prompts
5. **skill-creator examples** - Anthropic's reference implementations of agent and skill definitions

## Key Improvements in Final Version

- **Hybrid Contract Design** - Established I/O bookends (Step 3.1) before designing workflow
- **Agent Frontmatter** - Complete YAML with triggering examples (per agent-development skill best practices)
- **Real Implementation** - All agent and skill files created and functional
- **Reference Architecture** - Complete directory structure matching [open standard](https://agentskills.io/home)
- **Comprehensive Skills** - Both skills include proper SKILL.md + references + examples
- **Professional Structure** - Cleaned up icons and reorganized steps for clarity
- **Production Security** - Input validation via PreToolUse hook (not manual post-checks)
- **Actionable Code** - Bash script for sanitization instead of pseudo-code
- **Concise Tutorial** - Removed theoretical "Next Steps"; focused on building one complete, secure agent
- **Audit Logging** - Ready-to-implement JSON logging format with PII protection (hashing)

---

## How to Continue in Claude Code

**Tutorial 1 is complete with:**
- ✅ Tutorial document: `tutorial_1_email_agent_tutorial_with_agent_standards.md`
- ✅ Working agent: `.claude/agents/email_writer_agent.md`
- ✅ Working skills: `.claude/skills/{email_writing,tone_adjustment}/`

**Next steps for Tutorial 2 (Semi-Autonomous):**
1. **Plan T2 structure** - Add user decision points and approval gates to workflow
2. **Update I/O contracts** - Define intermediate schemas for different execution paths
3. **Implement conditional workflow** - Agent pauses for user decisions
4. **Add feedback loops** - User can request retries with modified parameters

---

## Key Takeaways for Tutorial Development

✅ **Skills must follow Anthropic standard** - folder structure, SKILL.md with frontmatter, references/, assets/
✅ **Agent needs formal definition** - Role, Inputs, Outputs, Autonomy Level, Tools Allowed, Process, Constraints, Error Handling
✅ **Frontmatter is critical** - description field is primary triggering mechanism
✅ **Nested structure** - put schemas/examples/context INSIDE the skill, not at project root
✅ **Fixed vs dynamic** - T1 has predefined steps with validation gates; T2/T3 add user decisions and agent planning
✅ **Progressive disclosure** - each tutorial builds on previous; reuse assets where possible

---

## Open Questions for Next Session

1. Should Tutorial 2 introduce "user approval gates" or "agent self-evaluation gates" first?
2. For Tutorial 3, should we use ReAct-style planning or simpler tool-selection patterns?
3. Should there be a Tutorial 2.5 for common edge cases (multi-turn conversations, incomplete inputs)?
4. How deep should T3 go on observability/logging for production deployment?

