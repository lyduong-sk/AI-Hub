There are many ways to build agentic systems. This guide defines the **recommended workflow** to ensure consistency, reliability, secure and scalable results.

> This workflow defines a ***general mindset.***
> *For technical implementation details, see* [***Claude Code reference***](https://code.claude.com/docs/en/overview)

# High-level steps:

Always define **Goal + Constraints before Workflow**. Start with **Less Autonomous** by default, with a  direction toward **Highly Autonomous** agents.

------

## Step 1: Understand an Agentic System & Autonomy Level?

**What is an agentic system:**

- Executes **multi-step workflow/loop** with **autonomy;**
    - There could be **multiple levels of autonomy**
- **Agent = Intention + Execution**
    - **Intention = Goal + Do + Don’t**
    - **Execution** = **Workflow + Skills + Tools**
        - **Workflow**: sequence of steps (fixed or planned; autonomy level affects dynamics)
        - **Skills**: domain/expert knowledge
        - **Tools**:
            - Built-in (bash, grep, web search, code execution, etc…).
                - [See Claude Code tools](https://code.claude.com/docs/en/tools-reference) reference
            - External (in increasing complexity): Scripts (bash/.sh) → APIs → MCP servers
    - Can range from **low autonomy → high autonomy**

**Why? Why Agentic Systems Require Autonomy?**

- **Solve complex tasks**: many real-world problems do not follow “defined” plans
- **Adapt to inputs**: handle different user’s requests
- **Scale**: ensure scaling and time saving

> Autonomy = ability to decide *what to do next*, not just execute

### Table 1: Autonomy Trade-offs Overview

| **Type**          | **Control** | **Flexibility** | **Predictability** | **Reliability** |
| ----------------- | ----------- | --------------- | ------------------ | --------------- |
| Less Autonomous   | High        | Low             | High               | High            |
| Semi-Autonomous   | Medium      | Medium          | Medium             | Medium          |
| Highly Autonomous | Low         | High            | Low                | Low             |

### Table 2: Autonomy Definitions & Use Cases

| **Type**          | **Definition (Short)**              | **Workflow Style**              | **Decision Making**     | **Use Case**                               |
| ----------------- | ----------------------------------- | ------------------------------- | ----------------------- | ------------------------------------------ |
| Less Autonomous   | Predefined, deterministic execution | Fixed steps                     | LLM executes only       | Standard workflows.                        |
| Semi-Autonomous   | Partial decision-making by LLM      | Guided + some dynamic steps     | LLM selects tools/paths | Customer support, data workflows           |
| Highly Autonomous | Fully dynamic planning              | Fully dynamic (LLM plans steps) | LLM decides everything  | Complex reasoning, research, coding agents |

**Notes**:

- Start with **Less Autonomous** and increase only if needed.
- As a strategic direction, the company aims to adopt more autonomous agents over time.
- With next-generation models such as Anthropic Mythos on the horizon, it is theoretically suggested that rigid, predefined workflows for low-autonomy agents may limit the full potential of these highly capable models.

See [Examples](https://skedulo.atlassian.net/wiki/spaces/EN/pages/4268490782/Level+of+Autonomy+Examples)

------

## Step 2: Define GOAL, DO, DON'T (Constraints)

### What to define

- **GOAL**: What success looks like (clear, testable outcome)
- **DO**: Allowed actions / expected behaviors
- **DON’T**: Constraints / boundaries to prevent bad outputs

This defines the **intent and rules** of the agent before designing how it works.

### Examples (Email Writing Agent)

**GOAL Examples:**

1. ✅ "Generate professional emails matching the user’s tone and key points—output must be ready to send immediately"
2. ✅ "Produce a complete email with greeting, clear body, and closing—no missing information or vague sections"
3. ✅ "Write emails that accurately reflect the user’s intent without adding fabricated facts or unnecessary details"

**DO Examples:**

1. ✅ "Validate all required inputs (recipient, purpose, tone, key points) before drafting"
2. ✅ "Use the tone adjustment skill to apply requested tone markers consistently throughout"
3. ✅ "Check output for completeness—greeting, purpose statement, all key points, closing with signature"

**DON’T Examples:**

1. ❌ "Include information not provided by the user (fabricating facts about projects, timelines, or decisions)"
2. ❌ "Ignore tone requests—if user asks for ‘Apologetic’, don’t make it casual or formal instead"
3. ❌ "Leak sensitive data—don’t include other people’s email addresses, phone numbers, or internal details in output"

### **Why:**

- The **higher the autonomy**, the **more dynamic** the workflow becomes—making clear goals and constraints **more critical**.

------

## Step 3: Design Workflow

1. **What is a workflow:**

- A workflow = **ordered TODO list**
- Each step = a **small executable unit**

For each step, define:

- Input: Prompt / Structure format such as JSON
- Output: Structure format such as JSON
- Decision maker (Agent .vs Human)
- Tool needed?

1. **Core Principle: Break It Down Until It Works**

- Start the workflow with a high-level task
- Break into steps
- Test output quality
- If NOT acceptable → **break steps smaller**

> Rule: If a step produces inconsistent or low-quality results → it is TOO BIG, break it further down

------

## Step 4: Fill Gaps ([Skills](https://agentskills.io/home) + Context + Tools)

- Improve steps with (identify gaps first):
    - **SKILLS (fill missing expertise)**:
        - **Less Autonomous**: explicitly specify required skills per step. Human decides.
        - **Higher Autonomous**: allow agent to select/load skills dynamically. Agent decides
    - **Context / Knowledge**:
        - Provide relevant context and knowledge if needed
    - **Tools**:
        - Choose appropriately ([Built-in tools](https://code.claude.com/docs/en/tools-reference) > Script → API → MCP)

------

## Step 5: Evaluate → Debug → Refine

1. Evaluate → find failures
2. Trace → locate weak/buggy step
3. Refine → split/add steps/tools/skills
4. Re-run evaluations

> Stop when metrics meet targets and failures are understood

------

## Step 6: Security & Safety

**Principles:**
- Check all input (user requests, files, API responses) for injection attacks
- Limit tool access — agents only get tools they need
- Hide sensitive data — no secrets, emails, or personal info in logs or output
- Log everything — track what the agent did, when, and why
- Fail safely — if unsure, reject the request

**Developer Checklist:**
- [ ] Validate user input (check for malicious patterns)
- [ ] Restrict tool permissions (use allowlists)
- [ ] Scrub logs and output (remove PII, secrets)
- [ ] Log all decisions and tool calls (structured format)
- [ ] Handle errors safely (no stack traces to users)
- [ ] Rate limit expensive operations (APIs, file reads)
- [ ] Set execution timeouts (prevent runaway loops)
- [ ] Monitor for unusual behavior (repeated failures, odd patterns)

------

## Step 7: Optimize

**Prompt:**
- Remove repetition (say things once, reference them later)
- Use 2–3 key examples instead of many
- Cache prompts for repeated requests
- Keep instructions short and action-focused

**Tools:**
- Pick the right tool (bash/grep > scripts > APIs > MCP)
- Run independent calls in parallel
- Batch multiple operations into one call
- Cache results so you don't re-fetch data

**Cost:**
- Track tokens per step to find expensive operations
- Use cheaper models (Haiku) for simple tasks, expensive models (Opus) only for complex reasoning
- Input tokens cost ~3–5x less than output tokens
- Summarize long context instead of repeating it

**Quick Metrics:**
- Email agent: 50% cost reduction (prompt caching + fewer examples)
- Code review: 70% cost reduction (downgrade to cheaper model)
- Data pipeline: 80% cost reduction (batch queries + model downgrade)