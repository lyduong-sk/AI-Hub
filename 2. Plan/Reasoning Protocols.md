# Reasoning Protocols

This guide defines the "Thinking Styles" used by AI Agents in the SE AI CoE. Selecting a protocol helps ensure the agent finishes its task without skipping logical steps or violating constraints.

## 1. Catalog of Protocols

### **Chain-of-Thought (CoT)**
*   **Definition**: The agent writes out its thinking step-by-step before giving the final answer.
*   **Simple Meaning**: "Think carefully before you speak."
*   **When to use**: For logic-heavy tasks where one small mistake ruins the whole result (e.g., refactoring complex code, math, or logic puzzles).

### **ReAct (Reason + Act)**
*   **Definition**: The agent thinks, performs an action (tool use), receives the result, and then thinks again to plan the next move.
*   **Simple Meaning**: "Look around, take a step, and check where you are."
*   **When to use**: For any agent that needs to use tools (e.g., searching files with grep, calling an API, searching the web). This is the **standard protocol** for most agents.

### **Reflexion**
*   **Definition**: The agent completes the task, then reviews its own output to find mistakes or improvements before showing it to the human.
*   **Simple Meaning**: "Proofread your own work."
*   **When to use**: When high quality is more important than speed (e.g., writing customer-facing documentation, creating release notes).

### **Plan-then-Execute**
*   **Definition**: The agent creates a full "TODO list" or plan for the entire task first, then follows that plan step-by-step.
*   **Simple Meaning**: "Make a plan before you start working."
*   **When to use**: For long or complex tasks with many dependencies (e.g., creating a new software module from an SDD).

---

## 2. Choosing a Protocol by Autonomy Level

| Autonomy Level | Mandatory Protocols | Recommendation |
| :--- | :--- | :--- |
| **L1: Less Autonomous** | Optional | Usually direct execution is enough. Use **CoT** if the prompt is long. |
| **L2: Semi-Autonomous** | Suggested | Use **ReAct** if using tools, or **Reflexion** if providing drafts. |
| **L3: Highly Autonomous**| **Mandatory**| Use **Plan-then-Execute** or **ReAct**. The agent must be able to justify its path. |

