# Metrics and Feedback Loop

To prove the value of our agents and safely increase their autonomy, we must track their performance and use failures to make them smarter.

---

## 1. Core Metrics

Every agent in the CoE must track these four baseline metrics:

| Metric | Simple Definition | Target (Baseline) |
| :--- | :--- | :--- |
| **Success Rate** | % of runs where the agent finished and was "useful." | > 80% |
| **Correction Rate**| % of characters/words the human had to manually fix. | < 20% |
| **Review Ratio** | Time spent reviewing vs. Time saved by the AI. | Review < 20% total |
| **Cost per Run** | Total tokens/API costs for one complete execution. | < $0.50 (for L1/L2) |

---

## 2. User Engagement & Trust

We must measure the developer's experience to ensure the agents are useful and trusted.

| Metric | Simple Definition | Target |
| :--- | :--- | :--- |
| **Adoption Rate** | % of the target team using the agent weekly. | > 40% (Phase 1) |
| **Trust Score** | User rating (1-5) on "How much do you trust this output?" | Avg > 4.2 |
| **Trust Gap** | The time difference between the *AI draft* and the *final human save*. | Decreasing over time |
| **Net Satisfaction** | Qualitative feedback: "Does this save you mental energy?" | Positive Sentiment |

---

## 3. The Feedback Loop (The "Retrospective")

To scale, we move from "Manual Audits" to **"Mandatory User Retrospectives."**

### The `skill_feedback_collector`
Every agent must implement a feedback skill at the end of the human-in-the-loop gate.

1.  **Automated Catch**: The agent compares the *Initial Draft* vs. the *Human Final Version*.
2.  **User Prompt**: If Correction Rate > 10%, the user **must** provide a root cause via a simple CLI/UI prompt:
    *   **Logic**: "The agent didn't understand the task."
    *   **Guidance**: "The Agent Spec/Instructions were too vague."
    *   **Tooling**: "The bash/grep/jira tool failed."
3.  **Submission**: Data is sent to the CoE "Logic Failure" repository for weekly review.

---

## 4. Autonomy Promotion (Moving up the Tiers)

We only increase an agent's level (e.g., L1 to L2) when it proves it is stable.

*   **Move to L2 (Semi-Autonomous)**:
    *   Minimum 50 successful runs in production.
    *   Consistent Success Rate > 90%.
*   **Move to L3 (Highly Autonomous)**:
    *   Minimum 200 successful runs in production.
    *   Rework Rate < 2% (The "Audit Loop" is catching nothing).
    *   Passed a fresh **Safety Stress Test**.

---

## 5. Governance Roles

*   **Engineering Manager**: Reviews the **Cost** metrics.
*   **CoE Member**: Reviews the **Correction Rate** and manages the **Refinement** of the Specs.
*   **Developer**: Provides the raw feedback during the **Human-in-the-Loop** gate.
