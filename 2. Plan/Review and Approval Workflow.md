# Review & Approval Workflow

This document defines the tiered checklists used to approve Agent Specifications. The checklist groups match the **Soul / Intention / Execution / Governance** structure of the [Agent Spec Template](Agent%20Spec%20Template.md).

---

## 1. Tiers of Review

| Autonomy Level | Mandatory Checklists | Approval By |
| :--- | :--- | :--- |
| **L1: Less Autonomous** | **Tier 1 (Core) Only** | Peer / Team Lead |
| **L2: Semi-Autonomous** | **Tier 1 + Tier 2** | Team Lead / CoE Member |
| **L3: Highly Autonomous**| **Tier 1 + Tier 2 + Tier 3** | CoE Member |

---

## 2. Block Definitions

*   🔴 **Hard Block**: The agent **cannot proceed** until this is fixed. These are non-negotiable safety or quality gates.
*   🟡 **Soft Block**: The agent **can proceed** but the risk must be documented and accepted by the approver.

---

## 3. Checklist Tiers

### Tier 1: The Core Review (Mandatory for ALL)

**Agent Soul**
- [ ] **Role & Objective**: Is the role unique and the objective specific? 🔴

**Agent Intention**
- [ ] **Definition of Done**: Is the success outcome clear and testable? 🔴
- [ ] **Do(s) / Don't(s)**: Are the boundaries clear? 🔴

**Agent Execution**
- [ ] **Input / Output**: Are input data and output format precisely specified? 🔴
- [ ] **Trigger Context**: Is it clear *when* to use this agent? 🟡

**Agent Governance (The Safety Basement)**
- [ ] **Prompt Injection Defense**: (Baseline) Are delimiters (###) used to isolate inputs? 🔴
- [ ] **Data Privacy/Masking**: (Baseline) Does the agent scrub potential PII or secrets? 🔴

---

### Tier 2: Logic & Governance Review (Mandatory for L2, L3)

**Agent Intention**
- [ ] **Reasoning Protocol**: Is a standard style (ReAct/CoT/etc) linked and appropriate? 🟡
- [ ] **Human-in-the-Loop Gate**: Is there a clear, non-skippable gate for the human? 🔴

**Agent Execution**
- [ ] **Skills & Tools**: Are all required modular skills listed or linked? 🟡

**Agent Governance**
- [ ] **Success Metrics**: Are rework rates and target success rates defined? 🔴
- [ ] **Audit Strategy**: Is there a plan for catching the "20% tail" failures? 🔴

---

### Tier 3: The Safety Stress Test (Mandatory for L3 ONLY)

**Agent Governance (The Safety Armor)**
- [ ] **System Prompt Hardening**: Is the agent protected from leaking its own instructions? 🔴
- [ ] **Boundary Breakdown**: Does the agent stop if presented with a high-ambiguity request? 🔴
- [ ] **Adversarial Input**: Have we simulated "attack" inputs to test robustness? 🟡

---

## 4. How to use
Reviewers should use these checklists to verify that the **Agent Intention** correctly derivaes the **Agent Execution** from the **Agent Soul**.
