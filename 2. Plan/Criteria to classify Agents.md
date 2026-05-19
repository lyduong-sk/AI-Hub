# Criteria to classify Agents

This document provides an objective framework to categorize agents in Phase 1 (Development) and Phase 2 (Testing). Every new agent must be scored against this matrix to determine its required **Autonomy Level (L1-L3)** and **Review Rigor**.

---

## 1. The Classification Scorecard

We evaluate agents across three dimensions. Use the highest matching level for each dimension.

### A. Intelligence (Reasoning Depth)
| Score | Level | Description | Example |
| :--- | :--- | :--- | :--- |
| **1** | **Low (S)** | Fixed path. Simple mapping or template filling. | PR Summary |
| **3** | **Med (M)** | Branching path. Needs to choose between several fixed options. | Unit Test Generator |
| **5** | **High (L)** | Dynamic path. Needs to create a plan based on ambiguous input. | SDD Generator |

### B. Complexity (Context Breadth)
| Score | Level | Description | Example |
| :--- | :--- | :--- | :--- |
| **1** | **Low** | Single file or single source of data. | PR Summary |
| **3** | **Med** | Multiple files or 2-3 integrated systems (e.g. Git + JIRA). | Technical Spike |
| **5** | **High** | System-wide context or complex dependency trees. | Regression Selector |

### C. Risk (Impact of Failure)
| Score | Level | Description | Example |
| :--- | :--- | :--- | :--- |
| **1** | **Low** | Informational only. No impact on code or tests. | Test Reporting |
| **3** | **Med** | Affects non-production artifacts (Tests, Docs, Spikes). | Unit Test Generator |
| **5** | **High** | Affects code logic, security, or system architecture. | SDD Generator |

---

## 2. Autonomy Mapping

Sum the scores from the three dimensions above to find the target **Autonomy Level**.

| Total Score | Target Level | Governance Strategy |
| :--- | :--- | :--- |
| **3 - 6** | **L1: Less Autonomous** | Fixed path. 100% human-driven. Peer review only. |
| **7 - 11** | **L2: Semi-Autonomous** | Guided path. Human reviews tactical gates. CoE member review. |
| **12 - 15** | **L3: Highly Autonomous** | Dynamic path. Mandatory Safety Stress Test. CoE Lead approval. |

---

## 3. Master Classification (Phase 1 & 2)

Based on the [Agent List](AgentList.md), here is the proposed classification for the current roadmap:

| Stage | Agent | Intel | Context | Risk | Total | Tier | Why? |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **P1** | **PR Summary** | 1 | 1 | 1 | **3** | **L1** | Pure aggregation/formatting. |
| **P1** | **Code Review** | 5 | 5 | 3 | **13** | **L3** | Deep reasoning + broad repo context. |
| **P1** | **SDD Gen** | 5 | 5 | 5 | **15** | **L3** | Foundation for all downstream work. |
| **P1** | **Unit Test Gen** | 3 | 3 | 3 | **9** | **L2** | Logic-based but lower production risk. |
| **P1** | **Tech Spike** | 3 | 3 | 3 | **9** | **L2** | Research focus, medium risk. |
| **P1** | **Code Generator**| 5 | 5 | 5 | **15** | **L3** | **CAUTION**: High risk. Decompose into L1/L2 steps. |
| **P2** | **Test Triage** | 5 | 5 | 3 | **13** | **L3** | High-variance branching logic. |
| **P2** | **Regression** | 3 | 5 | 3 | **11** | **L2** | Complex context, but fixed selection logic. |
| **P2** | **Accessibility** | 1 | 3 | 3 | **7** | **L2** | Tool-driven (axe-core) but compliance risk. |
| **P2** | **Test Reporting**| 1 | 1 | 1 | **3** | **L1** | Straightforward aggregation. |
| **P2** | **UAT Plan** | 3 | 3 | 3 | **9** | **L2** | Translation logic (Tech -> Plain English). |
| **P2** | **Test Manager** | 5 | 5 | 5 | **15** | **L3** | **CAUTION**: Too broad. Decompose into sub-agents. |

---

## 4. Evaluation Guide (The "Sense" Check)

Before proceeding with an L3 agent, always ask:
1.  **Decomposition?**: Can this L3 agent be broken into three L1/L2 agents? (e.g. *Test Manager* -> *Planner* + *Generator*).
2.  **Reasoning Ceiling?**: Does the task require >80% accuracy to be useful? If yes, it must remain L2 with a mandatory human gate.
3.  **Context Overload?**: Does the agent need more than 50 files to reason? If yes, it is "Too Complex" and needs a specialized **Skill** to filter context first.
