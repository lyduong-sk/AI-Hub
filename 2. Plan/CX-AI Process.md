This page documents the AI-assisted SDLC used by the Solutions Engineering (SE) team. It covers three delivery stages: Development, Testing (QA), and Deployment. All AI agents are built on Claude SDK and shipped via the **Skedulo Marketplace Plugin**. Engineers review and approve every agent output — Claude accelerates, engineers decide.

*Notes: In this phase, we are only focusing on **Stage 1 - Development** and **Stage 2 - Testing** first. Other stages will be addressed later (Design, Hyper-care, Maintenance, Incident resolve and PIR/Process improvement, etc).*

**Page Owners:** Solutions Engineering Managers, @Oanh Dang *,* @Dang Huynh *,* @Thuan Nguyen *,* @Son Dang

**Contributor(s):** SE AI CoE - @Ly Duong

**Reviewer**: Russell

**Approval:** Andreas


**Last updated:** 8 Apr 2026

------

## Overview

![Screenshot 2026-04-01 at 15.39.51-20260401-083957.png](blob:https://skedulo.atlassian.net/446745b8-3f41-4933-9734-86498d6ba3c3#media-blob-url=true&id=895a0a4b-a121-496a-a79d-378395c72a2f&collection=contentId-4257939470&contextId=4257939470&width=1211&height=289&alt=Screenshot%202026-04-01%20at%2015.39.51-20260401-083957.png&clientId=dc3bf873-a494-43a7-8d8f-311953e7ad25)

TO DO: update the flowchart to add role of AI framework/Skedulo Plugin Market place and the SE AI CoE.

The SE team receives the **TDD (Technical Design Document)** from the SA team via the PS Plugin and owns three delivery stages:

| **Stage**              | **Focus**            | **AI Agents**          | **Gate**                       |
| :--------------------- | :------------------- | :--------------------- | :----------------------------- |
| Stage 1 — Development  | Design-to-Code       | TBD - AI Dev Agents    | G1 — Developer sign-off        |
| Stage 2 — Testing (QA) | Quality Verification | TBD - AI QA Agents     | G2 — QA sign-off               |
| Stage 3 — Deployment   | Production Release   | TBD - AI Deploy Agents | G3 — EM + Stakeholder Go/No-Go |

> **Shift-left testing:** QA Phase 1 (artifact generation) starts as soon as the TDD is available from the PS Plugin — before Stage 1 even begins. QA does not wait for Dev Complete.

------

## Roles & Responsibilities

| **Role**                       | **Short** | **Responsibilities**                                         |
| :----------------------------- | :-------- | :----------------------------------------------------------- |
| Engineering Manager            | EM        | Owns the escalation path and the Go/No-Go gate (G3) for production deployment. First point of escalation for blockers, risks, cross-team dependencies, and scope changes. Does not sign off Dev Complete — that accountability sits with the Developer. Surfaces risks to leadership. |
| Solutions Engineer (Developer) | DEV       | Accountable for implementation quality and delivery. Reviews and approves the AI-generated SDD, reviews AI-generated code, approves and merges every PR. **Signs off Dev Complete (G1)** — confirming all tickets closed, CI green, and code ready for QA. Executes the UAT and production deployment runbooks. Raises blockers to EM immediately. |
| QA Engineer                    | QA        | Reviews all AI-generated test artifacts, executes test cases against the QA environment, logs defects as JIRA / Linear tickets, and owns the QA sign-off. Starts Phase 1 (artifact review) in parallel with Stage 1 — does not wait for Dev Complete. |
| Claude (AI Agents)             | AI        | Operates through 21 specialised agents across Stage 1 (6), Stage 2 (8), and Stage 3 (7). Agents draft, generate, validate, and analyse — engineers review and approve every output before it is used or merged. |
| AI CoE                         | ACE       | A practice function drawn from across the SE organisation (developers, QA engineers, and engineering managers). Owns AI quality standards, prompt library governance, agent output calibration, and the enablement program. Leads pipeline quality retrospectives, develops reusable playbooks, tracks AI failures, and represents SE requirements in cross-engineering AI tool evaluation. Does not take on its own implementations — makes every delivery team more effective. See the [Agent Maturity Framework](Agent%20Maturity%20Framework.md) for governance standards. |

------

## Stage Gates Summary

| **Gate**              | **After Stage** | **Condition to Pass**                                        | **Who Approves**               |
| :-------------------- | :-------------- | :----------------------------------------------------------- | :----------------------------- |
| **G1 — Dev Complete** | Development     | SDD approved • All JIRA / Linear tickets closed • CI build green • No critical security findings • QA Phase 1 artifacts approved | Solutions Engineer (Developer) |
| **G2 — QA Sign-off**  | Testing (QA)    | All P0/P1 defects resolved • ≥95% test cases executed • All 8 agents completed • Traceability matrix complete • Test Report Dashboard published • UAT Plan approved and ready for Stage 3 | QA Engineer                    |
| **G3 — Go-live**      | Deployment      | UAT sign-off complete • All production smoke tests pass • Go-live confirmed by EM and stakeholder • Hypercare active | EM + Stakeholder               |

------

## Stage 1 — Development (Assisted by AI Dev Agents)

**Input:** TDD from PS Plugin (SA team)

**Output:** SDD v1.0 + JIRA / Linear tickets + Merged code on GitHub (CI green) + Dev Complete sign-off (G1)

The SDD Generator Agent reads the TDD and produces the Solution Design Document — the technical blueprint for implementation. The Developer reviews and approves the SDD; the EM is informed but does not sign off. The Code Generator Agent then implements each component ticket-by-ticket. The Developer reviews and approves every PR. The Developer is accountable for all deliverables; the EM owns the escalation path.

### AI Development Agents - WIP - Notes: the work/agent details need to be reviewed and confirmed!!!

EPIC: [SOLE-9437: AI Agents - Development StageScoping](https://skedulo.atlassian.net/browse/SOLE-9437)

| **#** | **Agent**                       | **What It Does**                                             | **Artifact**                     |
| :---- | :------------------------------ | :----------------------------------------------------------- | :------------------------------- |
| 1     | **SDD Generator**               | Reads TDD → drafts Solution Design Document: component breakdown, API mapping, data model, error handling per Skedulo platform spec.[SOLE-9438: 1. Plugin SkeletonIn Progress](https://skedulo.atlassian.net/browse/SOLE-9438) | SDD v1.0 draft                   |
| 2     | **Technical Spike**(SDD Review) | When the SDD reveals unknowns, researches technical options, evaluates trade-offs, and produces a recommendation note before coding starts.[SOLE-9439: 1.2 Technical Spike (SDD Review)Open](https://skedulo.atlassian.net/browse/SOLE-9439) | Spike notes · Recommendation doc |
| 3     | **Code Generator**              | For each JIRA / Linear ticket: generates feature code using the Skedulo Marketplace Plugin APIs, data transformations, error handling, and inline comments.[SOLE-9440: 2. Implementation PlanOpen](https://skedulo.atlassian.net/browse/SOLE-9440) [SOLE-9441: 3. Code + Unit Test GeneratorOpen](https://skedulo.atlassian.net/browse/SOLE-9441) | Feature code (PR)                |
| 4     | **Unit Test Generator**         | Produces unit tests for each component: happy path, error paths, and edge cases based on SDD acceptance criteria. | Unit test suite                  |
| 5     | **Code Review**                 | Reviews each PR: SDD compliance, coding standards, security patterns, naming conventions, complexity score. Posts structured review comment.[SOLE-9442: 4. Code ReviewOpen](https://skedulo.atlassian.net/browse/SOLE-9442) | PR review comment                |
| 6     | **PR Summary**                  | Generates the PR description: SDD component reference, JIRA / Linear ticket ID, change summary, and reviewer checklist.[SOLE-9443: 5. PR SummaryOpen](https://skedulo.atlassian.net/browse/SOLE-9443) | PR description                   |

**Notes:**

- The team (@Huy Tran) reviewed and decided to add a new Agent (Orchestrator Agent) for future improvement. This agent will communicate and coordinate with other agents.

[SOLE-9565: 0. Orchestrator AgentOpen](https://skedulo.atlassian.net/browse/SOLE-9565)

- We need to consider to add the Agent for capturing change request (potential change - or percentage of change compared with the original TDD, SOW when the agent implements ticket. (@Dang Huynh , @Thuan Nguyen )

TO DO:

- Create a Jira Board to manage SE Agents for each stage.
- Stage - EPIC Level
    - Stage Agent - User Story level
        - task/subtask
- Brainstorming for the best way/place to capture ideas from team when they have it, and how they can submit it. Also a process for reviewing and planning to implement it. It could be:
    - Confluence.
    - Google spreadsheet
    - Slack channel
    - Jira tickets.

### Step-by-Step Workflow

TO DO: Add a flowchart to demonstrate the workflow.

![Screenshot 2026-04-03 at 12.55.30.png](blob:https://skedulo.atlassian.net/1b0cd315-74d2-4603-908d-8b886dd34920#media-blob-url=true&id=88c6bf5b-edf1-42e9-8928-aa08567eba9d&collection=contentId-4257939470&contextId=4257939470&width=1252&height=491&alt=Screenshot%202026-04-03%20at%2012.55.30.png&clientId=dc3bf873-a494-43a7-8d8f-311953e7ad25)

| **Step** | **Action**                                                   | **Who**           | **Output**                  |
| :------- | :----------------------------------------------------------- | :---------------- | :-------------------------- |
| 1        | Claude reads the TDD and drafts the SDD: component breakdown, API mapping, data model, error handling. | Claude (AI)       | SDD draft                   |
| 2        | Developer reviews the SDD for technical accuracy and completeness. Requests changes if needed. | DEV               | Approved SDD v1.0           |
| 3        | Claude creates project tickets in JIRA / Linear — one ticket per SDD component, each with acceptance criteria. Ticket IDs are referenced in every PR and test case for full traceability. | Claude (AI)       | JIRA / Linear tickets       |
| 4        | Developer confirms sprint scope and delivery order with EM. Sprint starts. Developer is accountable for delivery. EM owns the escalation path (if any) — blockers raised to EM immediately. | DEV + EM          | Sprint plan confirmed       |
| 5        | For each ticket: Claude generates code (Skedulo API calls via Marketplace Plugin, error handling, unit tests, inline comments). | Claude (AI) + DEV | PR opened on feature branch |
| 6        | Developer reviews the PR against the SDD and ticket acceptance criteria. Developer is the final approver — Claude revises on feedback. | DEV               | PR approved and merged      |
| 7        | Repeat steps 5–6 for all tickets. CI must pass after every merge. Developer escalates blockers to EM immediately. | Claude (AI) + DEV | All tickets done; CI green  |
| 8        | Developer confirms all JIRA / Linear tickets are closed, CI is green, and all PRs are merged. **Signs off Dev Complete (G1).** Code is frozen — QA Phase 2 can now begin. EM is notified. | DEV               | Dev Complete sign-off ✓     |

------

## Stage 2 — Testing / QA (Assisted by AI QA Agents)

**Shift-left model — two triggers, two phases:**

- **Phase 1 (Artifact Generation):** Starts at TDD availability — before Stage 1 begins. UAT Plan and initial test scope are generated from TDD alone. Test cases and k6 scripts are enriched once the SDD is approved. All artifacts are ready before Dev Complete.
- **Phase 2 (Execution):** Starts after Developer signs off Dev Complete (G1) and code is deployed to the QA environment.

![Screenshot 2026-04-03 at 12.56.48.png](blob:https://skedulo.atlassian.net/a9237a8f-3797-461a-a99b-061b0e2ad968#media-blob-url=true&id=bf2757e6-0498-4242-afa3-f15353dcbcaa&collection=contentId-4257939470&contextId=4257939470&width=1262&height=245&alt=Screenshot%202026-04-03%20at%2012.56.48.png&clientId=dc3bf873-a494-43a7-8d8f-311953e7ad25)

### Triggers

| **Phase** | **Trigger**                                           | **What Starts**                                              |
| :-------- | :---------------------------------------------------- | :----------------------------------------------------------- |
| Phase 1   | TDD available from PS Plugin                          | UAT Plan and initial test scope (TDD only) → enriched with test cases + k6 scripts once SDD is approved |
| Phase 2   | Developer signs off Dev Complete (G1), code in QA env | Regression, Accessibility, Load Testing execution; Triage; Dashboard |
| Manual    | QA Engineer initiates                                 | Useful for partial re-runs (e.g. regenerating test cases after a TDD change) |

### AI QA Agents - WIP - Notes: the work/agent details need to be reviewed and confirmed!!!

EPIC: [SOLE-9445: AI Agents - Testing StageIn Progress](https://skedulo.atlassian.net/browse/SOLE-9445)

| #    | **Agent**          | **What It Does**                                             | **Artifact**                                      |
| :--- | :----------------- | :----------------------------------------------------------- | :------------------------------------------------ |
| 1    | **Orchestrator**   | Receives triggers, reads project config, and coordinates all other agents. Manages phase sequencing and parallelism. | Execution plan                                    |
| 2    | **Test Manager**   | Reads TDD + SDD → generates test scope, test plan, manual test cases (with TDD requirement ID per case), and test data sets.[SOLE-9447: Test ManagerTo Do](https://skedulo.atlassian.net/browse/SOLE-9447) | Test Plan · Test Cases · Test Data                |
| 3    | **UAT Plan**       | Reads TDD + SOW → generates customer-facing UAT test plan and UAT scripts in plain language, mapped to TDD user stories.[SOLE-9448: UAT PlanIn Progress](https://skedulo.atlassian.net/browse/SOLE-9448) | UAT Test Plan · UAT Scripts                       |
| 4    | **Load Testing**   | Reads API specs from SDD → generates k6 load test scripts and a performance test plan. Executes scripts and reports results against SDD targets. | Performance Test Plan · k6 Scripts · Load Results |
| 5    | **Regression**     | Selects relevant automation tests based on code changes. Runs scripts against the QA environment. | Automation Results                                |
| 6    | **Accessibility**  | Runs WCAG scan via axe-core (web) and Appium (mobile) against the QA environment. | Accessibility Report                              |
| 7    | **Test Triage**    | Reads all execution results and classifies each failure: flaky / environment / bug / test maintenance. | Triage Report                                     |
| 8    | **Test Reporting** | Aggregates results from all agents into the Vercel dashboard (Product view + Solutions view). | Test Report Dashboard                             |

### Step-by-Step Workflow

**Phase 1 — Artifact Generation (runs in parallel with Stage 1)**

TO DO: Add a flowchart.

![Screenshot 2026-04-03 at 12.58.22.png](blob:https://skedulo.atlassian.net/a74b9749-a3c5-4274-9e15-1c976d24dfa1#media-blob-url=true&id=8d320c21-5fa2-4bab-a308-b6184426e468&collection=contentId-4257939470&contextId=4257939470&width=1246&height=539&alt=Screenshot%202026-04-03%20at%2012.58.22.png&clientId=dc3bf873-a494-43a7-8d8f-311953e7ad25)

| **Step** | **Action**                                                   | **Who**            | **Output**                         |
| :------- | :----------------------------------------------------------- | :----------------- | :--------------------------------- |
| 1        | Orchestrator receives Phase 1 trigger (TDD available). Starts Phase 1 agents in parallel — before Stage 1 begins. | Orchestrator       | Phase 1 execution plan             |
| 2        | Test Manager reads TDD + SDD → generates test scope, test plan, manual test cases, and test data sets. | Test Manager Agent | Test Plan · Test Cases · Test Data |
| 3        | UAT Plan Agent reads TDD + SOW → generates customer-facing UAT test plan and UAT scripts. | UAT Plan Agent     | UAT Test Plan · UAT Scripts        |
| 4        | Load Testing Agent reads API specs from SDD → generates k6 scripts and performance test plan. | Load Testing Agent | Performance Test Plan · k6 Scripts |
| 5        | QA Engineer reviews all Phase 1 artifacts. Approves or requests changes. | QA Engineer + EM   | All Phase 1 artifacts approved ✓   |

**Phase 2 — Execution (starts after G1)**

TO DO: Add a flowchart.

![Screenshot 2026-04-03 at 12.59.43.png](blob:https://skedulo.atlassian.net/3e5c6433-4f0a-4226-ac92-01c208aecbb9#media-blob-url=true&id=acf21bda-c336-4a46-b764-74546f52ecb3&collection=contentId-4257939470&contextId=4257939470&width=1238&height=644&alt=Screenshot%202026-04-03%20at%2012.59.43.png&clientId=dc3bf873-a494-43a7-8d8f-311953e7ad25)

| **Step** | **Action**                                                   | **Who**             | **Output**            |
| :------- | :----------------------------------------------------------- | :------------------ | :-------------------- |
| 6        | QA Engineers execute approved manual test cases against the QA environment. Record pass / fail / blocked with evidence. | QA Engineer         | Test Execution Report |
| 7        | Regression Agent selects and runs automation tests.          | Regression Agent    | Automation Results    |
| 8        | Accessibility Agent runs WCAG scan against the QA environment. | Accessibility Agent | Accessibility Report  |
| 9        | Load Testing Agent runs k6 scripts. Reports throughput, latency, error rate vs. SDD performance targets. | Load Testing Agent  | Load Test Results     |

**Phase 3 — Analysis & Sign-off**

TO DO: Add a flowchart.

![Screenshot 2026-04-03 at 13.00.53.png](blob:https://skedulo.atlassian.net/f7fd8bbb-09b4-4162-b9c0-1f6e75e46acc#media-blob-url=true&id=4a9f216a-c59b-4a37-919f-802a7e552f51&collection=contentId-4257939470&contextId=4257939470&width=1244&height=580&alt=Screenshot%202026-04-03%20at%2013.00.53.png&clientId=dc3bf873-a494-43a7-8d8f-311953e7ad25)



| **Step** | **Action**                                                   | **Who**               | **Output**                      |
| :------- | :----------------------------------------------------------- | :-------------------- | :------------------------------ |
| 10       | Test Triage Agent classifies each failure: flaky / environment / bug / test maintenance. | Test Triage Agent     | Triage Report                   |
| 11       | Test Reporting Agent aggregates all results into the dashboard. | Test Reporting Agent  | Test Report Dashboard           |
| 12       | QA Engineer reviews Triage Report. Logs each confirmed bug as a JIRA / Linear ticket with severity (P0–P3). | QA Engineer           | Defect tickets in JIRA / Linear |
| 13       | Claude analyses each defect ticket and proposes a fix. Developer reviews, implements, and opens a fix PR. | Claude (AI) + DEV     | Fix PR merged                   |
| 14       | QA Engineer retests fixed issues. Regression Agent re-runs affected tests. Repeat steps 12–14 until all P0/P1 defects resolved. | QA + Regression Agent | Retest evidence                 |
| 15       | QA reviews dashboard: all P0/P1 defects closed, ≥95% test cases executed, all tickets traced. Signs off. EM countersigns as escalation owner. | QA + EM               | QA Sign-off ✓                   |

------

## Stage 3 — Deployment (assisted by AI Deployment Agents)

**Phase A — UAT Deployment & Acceptance:** Deploy to UAT environment → execute UAT Plan (from Stage 2 Phase 1) → Developer + QA sign off UAT.

**Phase B — Production Go/No-Go:** Environment Validation + Go/No-Go Readiness (including UAT results) → EM makes Go/No-Go decision.

**Phase C — Production Deployment & Validation:** Developer executes production runbook → Smoke Test Agent validates → Data Cleanup.

**Phase D — Stabilisation:** Rollback Agent monitors health → Release Notes published → EM + Stakeholder confirm go-live.

**Input (Phase A):** QA Sign-off (G2) + QA-approved build + UAT Plan from Stage 2

**Output (Phase A):** UAT Sign-off · UAT environment validated

**Input (Phase B):** UAT Sign-off + Approved production runbook + Agreed maintenance window

**Output (Phase B):** Deployed production release · Smoke tests passed · Go-live confirmation

> **Rollback — immediate, no approval required:**
>
> - P0 defect detected in production smoke testing
> - Any deployment step fails and cannot be resolved within 15 minutes
> - Data integrity issue detected in production

![Screenshot 2026-04-03 at 13.02.22.png](blob:https://skedulo.atlassian.net/66bdb619-3187-445e-8d84-9e3ef0ac2dfa#media-blob-url=true&id=b0754c4f-7722-4492-9889-faba5b094481&collection=contentId-4257939470&contextId=4257939470&mimeType=image%2Fpng&name=Screenshot%202026-04-03%20at%2013.02.22.png&size=218344&width=1260&height=270&alt=Screenshot%202026-04-03%20at%2013.02.22.png&clientId=dc3bf873-a494-43a7-8d8f-311953e7ad25)

### AI Deployment Agents - WIP - Notes: the work/agent details need to be reviewed and confirmed!!!

| #    | **Agent**                  | **What It Does**                                             | **Artifact**                                    |
| :--- | :------------------------- | :----------------------------------------------------------- | :---------------------------------------------- |
| 1    | **Deployment Runbook**     | Generates the full step-by-step runbook from SDD and release scope: environment setup, migration order, Marketplace Plugin config, and rollback procedure. Used for both UAT and production. | Deployment Runbook                              |
| 2    | **Environment Validation** | Runs pre-flight checks against the target environment: config values, secrets, service health, infrastructure readiness, and backup confirmation. | Pre-deployment validation report                |
| 3    | **Go/No-Go Readiness**     | Aggregates all signals: UAT sign-off, QA sign-off, CI pass rate, open blockers, and risk rating — produces readiness summary for the EM's decision. | Go/No-Go readiness summary                      |
| 4    | **Smoke Test**             | Executes smoke tests post-deployment in production: critical API endpoints and TDD core user journeys. Reports pass/fail with evidence. | Smoke test results                              |
| 5    | **Data Cleanup**           | Scripts and executes removal of seed data, migration artefacts, and test records. Generates a cleanup log for audit. | Cleanup log                                     |
| 6    | **Rollback**               | Monitors post-deployment health signals (error rate, latency, failed jobs). If thresholds are breached, executes rollback automatically — no approval needed. | Rollback log · Incident record                  |
| 7    | **Release Notes**          | Compiles release notes from merged PRs, commits, and SDD scope. Produces two versions: technical summary (team) and plain-language changelog (stakeholders). | Technical Release Notes · Stakeholder Changelog |

### Step-by-Step Workflow

**Phase A — UAT Deployment & Acceptance**

TO DO: Add a flowchart.

![Screenshot 2026-04-03 at 13.03.42.png](blob:https://skedulo.atlassian.net/5b209c99-5245-4285-ac05-f0584e494845#media-blob-url=true&id=c5dd74ea-ff0b-42a4-af61-608a2f588ed8&collection=contentId-4257939470&contextId=4257939470&mimeType=image%2Fpng&name=Screenshot%202026-04-03%20at%2013.03.42.png&size=247643&width=1099&height=575&alt=Screenshot%202026-04-03%20at%2013.03.42.png&clientId=dc3bf873-a494-43a7-8d8f-311953e7ad25)

| **Step** | **Action**                                                   | **Who**                  | **Output**            |
| :------- | :----------------------------------------------------------- | :----------------------- | :-------------------- |
| 1        | Deployment Runbook Agent generates the UAT runbook: environment setup, Marketplace Plugin config, migration order, and rollback procedure for UAT. | Deployment Runbook Agent | UAT Runbook draft     |
| 2        | Developer reviews the UAT runbook step-by-step. Validates config values and rollback triggers. | DEV                      | Reviewed UAT Runbook  |
| 3        | Developer executes the UAT runbook. Code is deployed to the UAT environment. | DEV                      | UAT environment live  |
| 4        | QA Engineer executes the UAT Plan (prepared in Stage 2 Phase 1) in the UAT environment. Developer observes and supports. Defects logged as JIRA / Linear tickets. | QA + DEV                 | UAT execution results |
| 5        | Developer and QA Engineer sign off UAT. All P0/P1 UAT defects resolved. Team cleared to proceed to production. | DEV + QA                 | UAT Sign-off ✓        |

**Phase B — Production Go/No-Go**

TO DO: Add a flowchart.

![Screenshot 2026-04-03 at 13.04.52.png](blob:https://skedulo.atlassian.net/0bbef350-ff81-4782-9364-cd3940f807d7#media-blob-url=true&id=0c062506-5f79-43e7-b9b7-6731d85f3b4d&collection=contentId-4257939470&contextId=4257939470&mimeType=image%2Fpng&name=Screenshot%202026-04-03%20at%2013.04.52.png&size=250938&width=973&height=691&alt=Screenshot%202026-04-03%20at%2013.04.52.png&clientId=dc3bf873-a494-43a7-8d8f-311953e7ad25)

| **Step** | **Action**                                                   | **Who**                          | **Output**                             |
| :------- | :----------------------------------------------------------- | :------------------------------- | :------------------------------------- |
| 6        | Deployment Runbook Agent generates production runbook. Environment Validation Agent runs pre-flight checks on the production environment. | Runbook Agent + Validation Agent | Production Runbook · Validation report |
| 7        | Go/No-Go Readiness Agent aggregates all signals: UAT sign-off, QA sign-off, CI status, open blockers, risk rating. EM reviews and makes the Go/No-Go decision. | Go/No-Go Agent + EM              | Go decision recorded ✓                 |

**Phase C — Production Deployment & Validation**

TO DO: Add a flowchart.

![Screenshot 2026-04-03 at 13.05.35.png](blob:https://skedulo.atlassian.net/9ef5bdbe-8024-44d9-a677-848b05ca23b1#media-blob-url=true&id=873d305f-bc30-4f21-8c68-88a84008e4d4&collection=contentId-4257939470&contextId=4257939470&mimeType=image%2Fpng&name=Screenshot%202026-04-03%20at%2013.05.35.png&size=268359&width=972&height=691&alt=Screenshot%202026-04-03%20at%2013.05.35.png&clientId=dc3bf873-a494-43a7-8d8f-311953e7ad25)



| **Step** | **Action**                                                   | **Who**            | **Output**               |
| :------- | :----------------------------------------------------------- | :----------------- | :----------------------- |
| 8        | Developer executes the approved production runbook step-by-step during the maintenance window. QA observes and records the execution log. | DEV + QA           | Deployment execution log |
| 9        | Smoke Test Agent executes smoke tests in production: critical API endpoints and TDD core user journeys. | Smoke Test Agent   | Smoke test results       |
| 10       | Data Cleanup Agent removes seed data, migration artefacts, and test records. | Data Cleanup Agent | Cleanup log              |

**Phase D — Stabilisation**

TO DO: Add a flowchart.

![Screenshot 2026-04-03 at 13.06.00.png](blob:https://skedulo.atlassian.net/048258d7-c083-49ba-8fe1-e91a18747e3b#media-blob-url=true&id=6ce6871c-2c09-41ae-b953-aae6084b7d9d&collection=contentId-4257939470&contextId=4257939470&mimeType=image%2Fpng&name=Screenshot%202026-04-03%20at%2013.06.00.png&size=280845&width=976&height=775&alt=Screenshot%202026-04-03%20at%2013.06.00.png&clientId=dc3bf873-a494-43a7-8d8f-311953e7ad25)

| **Step** | **Action**                                                   | **Who**             | **Output**                 |
| :------- | :----------------------------------------------------------- | :------------------ | :------------------------- |
| 11       | Rollback Agent monitors production health. If error rate, latency, or job failure thresholds are breached: executes rollback automatically, no approval needed. | Rollback Agent      | Rollback log or Health OK  |
| 12       | Release Notes Agent compiles notes from PRs, commits, and SDD scope. Produces technical summary and stakeholder changelog. | Release Notes Agent | Release Notes (2 versions) |
| 13       | All smoke tests pass, Rollback Agent reports healthy. EM and stakeholder confirm go-live. Hypercare begins. | EM + Stakeholder    | Go-live confirmation ✓     |

------

## Artifacts at a Glance

| **Stage** | **Artifact**                                      | **Drafted by**               | **Approved by** | **Where**           |
| :-------- | :------------------------------------------------ | :--------------------------- | :-------------- | :------------------ |
| Stage 1   | Solution Design Document (SDD)                    | SDD Generator Agent          | Developer       | GitHub / Confluence |
| Stage 1   | Spike notes · Recommendation doc                  | Technical Spike Agent        | Developer       | GitHub / Wiki       |
| Stage 1   | JIRA / Linear tickets                             | Claude (AI)                  | Developer       | JIRA / Linear       |
| Stage 1   | Feature code (PRs)                                | Code Generator Agent         | Developer       | GitHub              |
| Stage 1   | Unit test suite                                   | Unit Test Generator Agent    | Developer       | GitHub              |
| Stage 1   | PR review comment                                 | Code Review Agent            | Developer       | GitHub PR           |
| Stage 1   | PR description + reviewer checklist               | PR Summary Agent             | Developer       | GitHub PR           |
| Stage 2   | Agent Execution Plan                              | Orchestrator Agent           | QA Engineer     | GitHub / Wiki       |
| Stage 2   | Test Plan + Test Cases + Test Data                | Test Manager Agent           | QA              | GitHub / Test tool  |
| Stage 2   | UAT Test Plan + UAT Scripts                       | UAT Plan Agent               | QA + EM         | GitHub / Wiki       |
| Stage 2   | Performance Test Plan + k6 Scripts + Load Results | Load Testing Agent           | QA Engineer     | GitHub              |
| Stage 2   | Automation Results                                | Regression Agent             | QA Engineer     | GitHub              |
| Stage 2   | Accessibility Report                              | Accessibility Agent          | QA Engineer     | GitHub / Wiki       |
| Stage 2   | Triage Report                                     | Test Triage Agent            | QA Engineer     | GitHub / Wiki       |
| Stage 2   | Test Report Dashboard                             | Test Reporting Agent         | QA              | Vercel Dashboard    |
| Stage 2   | Defect tickets                                    | QA Engineer                  | QA              | JIRA / Linear       |
| Stage 3   | UAT Runbook                                       | Deployment Runbook Agent     | Developer       | GitHub / Wiki       |
| Stage 3   | UAT Sign-off record                               | QA Engineer + Developer      | Developer + QA  | Confluence / Wiki   |
| Stage 3   | Production Runbook                                | Deployment Runbook Agent     | Developer       | GitHub / Wiki       |
| Stage 3   | Pre-deployment validation report                  | Environment Validation Agent | EM              | Confluence / Wiki   |
| Stage 3   | Go/No-Go readiness summary                        | Go/No-Go Readiness Agent     | EM              | Confluence / Wiki   |
| Stage 3   | Smoke test results + evidence                     | Smoke Test Agent             | QA Engineer     | GitHub / Wiki       |
| Stage 3   | Data cleanup log                                  | Data Cleanup Agent           | Developer       | GitHub / Wiki       |
| Stage 3   | Release Notes (technical + stakeholder)           | Release Notes Agent          | EM              | Confluence / Email  |



What’s next:

- Standard, guideline to create Agent for SE. - [Agent Spec Template](Agent%20Spec%20Template.md)
- Define role/responsibilities for each group.
    - Stage Owner:
        - Development: Dang Huynh, Thuan
            - Kanban way
            - Development process
        - QA/Testing: Son, Oanh
            - Define Testing Knowledge: Oanh
            - Create plan: Oanh
            - Review, validate outcome: Oanh
            - Implementation: Son Dang + (Hieu Le)
    - Consultant/Contributor: Ly Duong
        - Propose (AI) Architect for implementation.
        - Define the review process.
        - Be the gate keeper, review, approval, support
- Getting feedback, make update (if any) from the team if having any roadblock, technical blocker, etc.
- Getting feedback, make update (if any) from the other stakeholders.
- Setup Jira board with EPIC, User Stories.
- Review priority for all Agents for each stage.
- Estimate time to implement Agent with Critical and High priority.
- Form team to do it.
- Plan for the next phase (Presale, Post Implementation, etc).
- **Progress**: [Solutions Engineering | Timeline](https://skedulo.atlassian.net/jira/software/c/projects/SOLE/boards/2400/timeline?timeline=WEEKS)

------

## Additional Agent Specification

### Notes:

- **Difficulty**: Difficult to do, needs lots of knowledge, takes time to implement,
- **Complexity**: Many decisions, complex decision tree/trigger points, should consider breaking into smaller agents
- **Intelligence Level**: (importance for large scale; e.g. Opus = 5x tokens compared to Haiku)
    - High => Opus/Sonnet, e.g. planning
    - Low => Haiku, e.g. implement/report
- **Priority**
    - Must: The agent is important. We need to implement this agent as soon as we can.
    - Optional: The agent is nice to have.

| **Stage** | **Agent** | **Priority** | **Difficulty** | **Complexity** | **Intelligence Level** | **Expert Owner / Agent Soul** | **Key Decision** | **Notes** |
| :-------- | :-------- | :----------- | :------------- | :------------- | :--------------------- | :---------------------------- | :--------------- | :-------- |
|           |           |              |                |                |                        |                               |                  |           |

| **Stage**   | **Agent**              | **Priority**    | **Difficulty** | **Complexity** | **Intelligence Level** | **Expert Owner / Agent Soul**                                | **Key Decision**                                             | **Notes**                                                    |
| :---------- | :--------------------- | :-------------- | :------------- | :------------- | :--------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| **Stage 1** | SDD Generator          | Must / Optional | M              | **Medium**     | **High**               | Team/People who have the best knowledge to define theDefine the workflow/behaviour of this agentDefine the skills/working examples it needs + implement those skillsDefine the identity/personalityDefine the input/ouput |                                                              | Foundational — all downstream agents depend on SDD quality. Needs deep architectural reasoning. |
| **Stage 1** | Technical Spike        |                 | M              | **Medium**     | **High**               |                                                              | Scope clear? (research + recommendation only, no implementation) | Single workflow: research → evaluate → recommend. Triggered conditionally when SDD reveals unknowns. |
| **Stage 1** | Code Generator         |                 | L              | **High**       | **High**               |                                                              | **DECOMPOSE?** Currently does: feature code + error handling + comments. Should error handling be separate? | One Agent break into multiple steps and mark which one is “workable” and which one require more “skills” if the confidence level is e.g. < 9/10 + ask for confirmation from userMain Agent: Code gen for each featureError handlingComment + docs |
| **Stage 1** | Unit Test Generator    |                 | M              | **Medium**     | **Medium**             |                                                              | Scope clear? (unit tests only, not integration or e2e)       | Single workflow but multiple decision points (happy path, error paths, edge cases). Sequential to Code Generator. |
| **Stage 1** | Code Review            |                 | M              | **High**       | **High**               |                                                              |                                                              | 4 review dimensions (compliance, standards, security, complexity). Each has independent logic. Should we reuse/revise the one from Russel? |
| **Stage 1** | PR Summary             |                 | S              | **Low**        | **Low**                |                                                              | Scope clear? (just formatting/aggregation or analysis?)      | Single workflow: aggregate PR info → format → output. No independent sub-tasks. Simple template-based. |
| **Stage 2** | Orchestrator           |                 | M              | **High**       | **High**               |                                                              |                                                              | Human integrate now? Agent Integration later?                |
| **Stage 2** | Test Manager           |                 | L              | **High**       | **High**               |                                                              | **DECOMPOSE?** Currently does: scope + plan + test cases + test data. Too big? | 4 distinct sub-tasks (scope analysis → plan → case generation → data synthesis). Different expert owners. Independent failure modes. |
| **Stage 2** | UAT Plan               |                 | M              | **Medium**     | **Medium**             |                                                              | Scope clear? (customer-facing, TDD-mapped, executable in UAT env) | Single workflow with translation step (technical → plain language). Maps to TDD stories. |
| **Stage 2** | Load Testing           |                 | M              | **Medium**     | **Medium**             |                                                              | Scope clear? (k6 script generation + execution + vs. SDD targets) | 3 distinct sub-tasks (script gen → execution → analysis). Could script gen be reused independently? |
| **Stage 2** | Regression             |                 | M              | **Medium**     | **Medium**             |                                                              | Scope clear? (test selection logic, what counts as "relevant" change?) | 2 sub-tasks (test selection + execution). Selection logic is complex but distinct from execution. |
| **Stage 2** | Accessibility          |                 | S              | **Low**        | **Medium**             |                                                              | Scope clear? (axe-core for web, Appium for mobile, WCAG standard) | Well-defined domain, mostly rules-based. Tool-driven (axe-core, Appium). Single workflow. |
| **Stage 2** | Test Triage            |                 | M              | **High**       | **High**               |                                                              | Scope clear? (failure classification logic, when it's "flaky" vs. "bug") | Multiple decision branches (flaky vs. environment vs. bug vs. maintenance). |
| **Stage 2** | Test Reporting         |                 | L              | **Low**        | **Low**                |                                                              | Scope clear? (aggregation logic, dashboard structure, Product vs. Solutions view) | Aggregation + formatting with two output variants. Straightforward orchestration. Low reasoning. |
| **Stage 3** | Deployment Runbook     |                 | M              | **Medium**     | **Medium**             |                                                              | Scope clear? (SDD → step-by-step script, but how detailed?)  | Single workflow: SDD → synthesis → runbook. Reused for UAT and production. Standard sequencing. |
| **Stage 3** | Environment Validation |                 | M              | **Medium**     | **Medium**             |                                                              | Scope clear? (what pre-flight checks? how fail/pass criteria?) | Multiple check types (config, secrets, health, backup). Each has pass/fail criteria. Gate-critical. |
| **Stage 3** | Go/No-Go Readiness     |                 | M              | **High**       | **High**               |                                                              | Scope clear? (signal aggregation logic, risk scoring, who decides?) | Aggregates 5+ signals (UAT, QA, CI, blockers, risk). Scoring logic + readiness judgment. |
| **Stage 3** | Smoke Test             |                 | M              | **Medium**     | **Medium**             |                                                              | Scope clear? (critical endpoints only, TDD core journeys, pass/fail criteria) | Single workflow: identify critical paths → execute → report. Straightforward but high stakes. |
| **Stage 3** | Data Cleanup           |                 | S              | **Low**        | **Low**                |                                                              | Scope clear? (what data types? retention policy? audit trail?) | Single workflow: identify seed data → delete → log. Straightforward execution. No decision logic. |
| **Stage 3** | Rollback               |                 | L              | **High**       | **High**               |                                                              | **DECOMPOSE?** Monitoring + decision + execution. Should execution be separate? | 3 distinct workflows (continuous monitoring + conditional decision + execution). Different cadences + failure modes. |
| **Stage 3** | Release Notes          |                 | S              | **Low**        | **Low**                |                                                              | Scope clear? (format, audience, what's included from PRs/commits?) | Aggregation + formatting. Two output templates. Simple template-based generation. |

For a standard agent:

- Each agent should track these so that we can decide if it’s a working agent => ready for shipping/update
    - Success/Rework Rate
    - Time to generate
    - Cost per run
- Feedback & Improvement loop
    - A skill/hook to self-learn/self report
    - Review agent performance
    - Re-train on failture?
    - Workflow/channel for each user to feedback failture and how they resolved them?
- Integration
    - How they interact with each other, via JSON/MD/Files/Other Artifacts
