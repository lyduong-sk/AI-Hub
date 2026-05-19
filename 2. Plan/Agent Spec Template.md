# [Agent Name] Specification

**Status**: Draft / Under Review / Approved
**Owner**: [Name]
**Target Autonomy**: L[1-3] (Refer to [The 3 Levels of Autonomy](https://skedulo.atlassian.net/wiki/spaces/EN/pages/4313972766/Agent+Level+of+Autonomy))
**Version**: [vX.Y.Z-Status]

------

## 1. Agent Soul

- **Role**: [e.g., Senior Technical Writer]
- **Persona**: [e.g., Concise, structured, focus on API standards]
- **Objective**: [What is the high-level goal of this agent?]

## 2. Agent Intention

### Goals

[Define success. What clear, testable outcome should the agent produce?]

### Do(s) / Don't(s)

- **Do**: [Allowed action 1]
- **Don't**: [Boundary 1]

### Reasoning Protocol

- [Refer to the [Reasoning Protocols](https://skedulo.atlassian.net/wiki/spaces/EN/pages/4313612345/Reasoning+Protocols) guide to choose the appropriate thinking style]

### Human-in-the-Loop Gate

[Where does the agent stop? e.g., Stop at every milestone (L2) vs. stop only at the final outcome (L3)]

------

## 3. Agent Execution

### Trigger Context

[When should someone use this agent? e.g., Use this when you need to turn a raw code diff into a clear PR summary]

### Model & Architecture

- **Model**: [e.g., Claude Opus 4.7 / Sonnet / Haiku]
- **Difficulty/Complexity**: [e.g., Low Difficulty / Simple mapping logic]

### Input Requirements

- **Input**: [What data does it need to start? e.g., JIRA ID, Git Diff, File Path]

### Core Workflow

[Step-by-step logic for how the agent executes its task]

1. **Step 1**: ...
2. **Step 2**: ...
    1. Skills: Skill 1, Skill 2, …
    2. Tools: Tool 1, Tool2, etc…
3. **Step 3:**
    1. Skill: Skill 1, Skill 3, …

### Skills & Tools

- **Skills**: [Link to specific skills from the Skill Catalog]
- **Tools**: [Built-in tools: bash, grep, websearch, or custom MCP servers]

### Output Specification

- **Output**: [Format of the result: Markdown, JSON, or Slack message]

------

## 4. Agent Governance

### Success Metrics

- **Target Success Rate**: [e.g., > 90%]
- **Audit Strategy**: [How do we check the "20% tail"? e.g., Monthly human review of 5% of cases]

### Security Guardrails

- **Prompt Injection Defense**: [How to prevent malicious inputs? e.g., Use delimiters and input sanitization]
- **System Prompt Hardening**: [Rules to prevent leaking instructions or system secrets]
- **Data Masking**: [How to hide sensitive data like PII or API Keys]

------

## 5. Integration

[Describe how this agent connects to other agents]
