# Agent Spec Template Structure

## Required Sections

### Metadata
- **Status**: Draft / Under Review / Approved
- **Owner**: Person or team
- **Target Autonomy**: L1 / L2 / L3
- **Version**: vX.Y.Z-Status

### 1. Agent Soul
- **Role**: Specific, not generic ("Senior Data Quality Analyst" not "Agent")
- **Persona**: Communication style and personality
- **Objective**: High-level macro goal

### 2. Agent Intention
- **Goals**: Clear, testable outcomes ("CSV report with 5 metrics" not "analyze data")
- **Do(s) / Don't(s)**: 2+ explicit allowed actions AND 2+ explicit forbidden actions
- **Reasoning Protocol**: Named thinking style appropriate to complexity (ReAct, CoT, etc.)
- **Human-in-the-Loop Gate**: Specific checkpoint(s) — for L2 this is EVERY milestone; for L3 it's final audit only

### 3. Agent Execution
- **Trigger Context**: When/why to invoke (specific scenario)
- **Model & Architecture**: Named Claude model, complexity level
- **Input Requirements**: Data types, formats, size limits, encoding, required fields
- **Core Workflow**: Numbered steps; each lists skills/tools used
- **Skills & Tools**: Itemized list matching workflow references
- **Output Specification**: Exact format (JSON schema, markdown structure, file type)

### 4. Agent Governance
- **Success Metrics**: Target success rate (numeric %) + audit strategy (frequency + method)
- **Security Guardrails**: Prompt Injection Defense + System Prompt Hardening + Data Masking

### 5. Integration
- How agent connects to others (sparse OK for standalone)

---

## What Counts as Substantive

✅ **Pass** — Actual values, not placeholders. Relevant to agent. Provides actionable detail.

❌ **Fail** — Placeholder text (`[To be determined]`, `[e.g., ...]`). Generic boilerplate. Missing required sub-field. Vague language ("works with data" vs "processes UTF-8 CSV files up to 1GB").
