# Skill Calibration & Benchmarking

To ensure high-quality agent outputs, skills must be calibrated before being used in **L3 (Highly Autonomous)** agents. This process ensures that "Logic Delegation" is safe and measurable.

## 1. Calibration Levels

| Level | Definition | Usage |
| :--- | :--- | :--- |
| **Draft** | Logic is defined; no formal testing has been conducted. | Suitable for **L1** agents only. Requires 100% human review. |
| **Calibrated** | Tested against a minimum of 10 gold-standard scenarios with >80% accuracy. | Suitable for **L2** agents. Human reviews the "Gate." |
| **Production** | Hardened logic with a failure rate <5% in real-world SE delivery. | Mandatory for **L3** agents. Human audits 5-10% of results. |

## 2. The Calibration Process

Expert Owners (e.g., QA Lead, Release Coordinator) are responsible for maintaining a "Golden Set" of inputs/outputs for their skills.

1.  **Golden Set Creation**: Collect 10-20 real-world examples of "Perfect" outcomes for the skill.
2.  **Blind Testing**: Run the skill logic against these inputs.
3.  **Accuracy Scoring**:
    *   **Correct**: Matches the Golden Set.
    *   **Minor Deviation**: Valid result but different formatting.
    *   **Failure**: Hallucination, logic error, or safety violation.
4.  **Promotion**: A skill is promoted to `Production` only after hitting the <5% failure threshold over 30 consecutive runs.

## 3. Skill Retirement

If a skill's accuracy falls below 80% due to platform changes (e.g., Skedulo API updates), the Expert Owner must downgrade it to `Draft` and notify all dependent Agent Owners.
