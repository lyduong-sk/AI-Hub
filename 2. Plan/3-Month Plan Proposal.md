# 3-Month Strategy

## 1. Purpose

- This document is a 3-month SE AI CoE roadmap proposal.
- It should explain the direction, the priorities, and the execution approach.

## 2. Current Position

- The [CX-AI Process](https://skedulo.atlassian.net/wiki/spaces/EN/pages/4257939470/WIP+-+Solutions+Engineering+-+AI-Assisted+Development+Process) is the operating model draft.
- The [Agent Mindset](https://skedulo.atlassian.net/wiki/spaces/EN/pages/4266524703/How+to+create+an+Agent+-+Agent+Mindset+v1) and [tutorial](https://skedulo.atlassian.net/wiki/spaces/EN/pages/4290183184/Tutorial+1+Build+an+Email+Writing+Agent+for+Professional+Emails.) materials are the enablement assets.
- What is still needed is a 3-month delivery plan and a [standardized agent framework](https://skedulo.atlassian.net/wiki/spaces/EN/folder/4312137759).

## 3. What / Why

### High level goal

- Improve AI adoption rate
- Build useful, controlled, scalable AI-assisted delivery for QA/Dev

### What we are doing

- Start with easy agents first.
- Define the SE AI CoE governance and standards (L1-L3 Framework).
- Define the Agent Specification framework (Goal/Do/Don't).
- Build a high-quality skill repository to improve agent knowledge.
- Build the core Development and QA agents first, starting at **Level 1 (Less Autonomous)**.
- Improve the agents to **Level 2 (Semi)** or **Level 3 (Highly)** based on audit loop feedback.

### Why we are doing it

- To avoid fragmented agent design across teams.
- To standardize quality, review, and approval.
- To reduce rework and unclear ownership.
- To learn step by step with easy agents first.
- To create a repeatable path from pilot to scale.

## 4. How We Will Do It

### Week 1-2: Governance and Standards

- Define the agent spec template (Goal/Do/Don't).
- Define the review and approval workflow (The "Reviewer" gate).
- Define metrics and the feedback loop (The "Audit Loop" for L3).
- Define the [The 3 Levels of Autonomy](The%203%20Levels%20of%20Autonomy.md).
- Define the skill catalog standard.

### Week 2-8: Build and Validate Core Agents

- **New Agents:** Finalize high-priority **Level 1 (Less)** Development and QA agents to harden the basic pipelines.
- **Existing Agents:** Transition stable agents to **Level 2 (Semi)** or **Level 3 (Highly)** by improving their reasoning and tool-use capabilities.
- **Skill Repo:** Build a high-quality skill repository so agent expertise is shared and reusable.
- **Test & Review:** 
  - Run pilot use cases.
  - Capture defects, gaps, and decision-tree issues.

### Week 9-12: Finalize the Baseline Agents

- Complete the baseline Development and QA agent suite.
- Harden decision trees and verify "Don't" constraints via a formal audit loop.
- Increase autonomy to **Level 3 (Highly)** only for agents that hit the >80% accuracy threshold.
- Prepare rollout guidance and the Phase 2 plan.

## 5. Success Criteria

- Standard agent specification (Goal/Do/Don't) adopted.
- Review and Audit workflows defined and used.
- Core Development and QA agents delivered at their target maturity.
- "80% Ceiling" metrics and "Audit Loops" in place.
- Autonomy increased only based on stability and roi.
- A pilot rollout result is ready at the end of the 3 months.

## 6. Scope

### In Scope

- Development agents.
- QA agents.
- Standards, governance, metrics, and pilot rollout.

### Out of Scope

- Later lifecycle stages unless needed for dependencies.
- Full autonomy.
- Detailed standards, workflow docs, and agent specs. 
  - These will be in linked follow-up docs.

## 7. Notes on Autonomy

- Autonomy is the level of **Logic Delegation** in an agent. It is the result of:
  - Correctness (Benchmark performance)
  - Controllability (Goal/Do/Don't constraints)
  - Auditability (Persistence of reasoning)
  - Path Independence (The 0% to 80% logic scale)
- To improve autonomy, we must improve the points above first.
- **The 80% Rule**: We aim for 80% delegation, acknowledging that the human must always manage the remaining 20% "failure tail."

---

## 8. Master Agent Specification Table

| Stage | Agent | Priority | Difficulty | Complexity | Autonomy | Expert Owner (Soul) | Key Decision |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Phase 1** | PR Summary | P0 | Low | Low | L1 | Release Coordinator | Mapping code diffs to business value. |
| **Phase 1** | Release Notes | P1 | Low | Med | L1 | Product Communicator | Filtering technical noise for client-facing notes. |
| **Phase 2** | Test Reporting| P1 | Med | Med | L2 | QA Lead | Aggregating logs into a "Risk" verdict. |
| **Phase 2** | Accessibility | P2 | Med | High | L2 | Compliance Officer | Identifying non-compliant UI patterns in diffs. |
| **Phase 3** | Smoke Test | P2 | High | High | L3 | Quality Gatekeeper | Selecting high-impact tests based on code risk. |

> [!NOTE]
> **Decomposition Rule**: Phase 3 agents like the Smoke Test Architect may be decomposed into smaller L1/L2 sub-agents if the reasoning ceiling is hit during Phase 2.
