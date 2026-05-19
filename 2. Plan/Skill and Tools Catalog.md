# Skill and Tools Catalog

This catalog is the central repository for reusable logic (**Skills**) and system interactions (**Tools**). By centralizing these components, we ensure consistency across the organization and prevent "Logic Fragmentation."

---

## 1. Generic Skills

These skills provide the "brains" for common engineering tasks and should be standard across all agents.

| ID | Plain English Name | Expert Owner | Status | What it does | When to Use |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `collect_feedback` | **Collect Session Feedback** | ? | **TODO** | Capture user retrospectives and quality of the agent work during session. | Mandatory end-of-session requirement for all agents. |
| `confidence_check` | **Self-Correction Check** | ? | **TODO** | Performs a self-audit and requests human clarification. | When agent confidence falls below the 80% threshold. |
| `cost_estimation` | **Estimate Session Cost** | ? | **TODO** | Calculates token consumption for the session. | When tracking the economic impact of agent usage. |
| `agent_security` | **Agent Security Scan** | ? | **TODO** | Scans context for PII, prompt injections, and vulnerabilities. | Before every high-risk output or external API call. |
| `impact_analysis` | **Map Code Impact** | ? | **TODO** | Correlates code diffs against requirement documents. | To detect regressions or missing business logic in PRs. |

---

## 2. Skedulo Pulse Platform Skills

Deeply technical skills specific to building on the Skedulo Pulse platform. Use these to ensure agents follow Skedulo architecture.

### Development Skills
| ID | Plain English Name | Expert Owner | Status | What it does | When to Use |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `sked_api` | **Execute API Queries** | ? | **TODO** | Knowledge for https://docs.skedulo.com/skedulo-api/ | For custom data fetching not supported by EQL. |
| `sked_eql_builder` | **Draft EQL Queries** | ? | **TODO** | Constructs valid EQL syntax. | Fetching data using Skedulo's native filtering logic. |
| `sked_webhook` | **Manage Webhooks** | ? | **TODO** | Configures external HTTP callbacks, crons. | For building event-driven external integrations. |
| `sked_trigger_action` | **Create Trigger Actions** | ? | **TODO** | Configures external HTTP callbacks. | Implementing server-side logic (e.g., on Job insert). |
| `sked_schema_mgr` | **Define Custom Schema** | ? | **TODO** | Modifies the Vocabulary and custom object definitions. | When adding custom fields or objects to a tenant. |
| `sked_cli` | **Execute CLI Actions** | ? | **TODO** | Any thing relates to Sked CLI | For automated packaging, deployment, and log fetching. |

### QA Skills
| ID | Plain English Name | Expert Owner | Status | What it does | When to Use |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `generate_mock_data` | **Generate Mock Data** | ? | **TODO** | Generates valid mock data sets for Skedulo objects. | For creating realistic demo data or unit test inputs. |


## 3. Existing Marketplace Library (Reference)

These are ready-to-use agents and tools found in the `skedulo-plugin-marketplace`. Do not "reinvent" these; reference them in your Agent Specs.

### Specialized Agents
| Easy Name | Original Folder | Primary Purpose |
| :--- | :--- | :--- |
| **Issue-to-PR Developer** | `ai-engineer` | Full automation: reading a ticket to opening a verified PR. |
| **Test Automation Creator** | `pulse-qa` | Automates Playwright E2E tests and Page Object creation. |
| **Product Doc Writer** | `product-management` | Turns messy research/specs into clean PRDs and tickets. |
| **Exec Status Reporter** | `project-manager` | Distills complex repo activity into board-level summaries. |
| **System Documenter** | `as-built` | Maps out complex platform implementations (UML, Mermaid). |

### Common Marketplace Skills (Technical IDs)
| Parent Agent | ID | When to Use |
| :--- | :--- | :--- |
| `ai-engineer` | `bug_triage` | Investigating if a bug is reproducible and finding root causes. |
| `ai-engineer` | `security_audit` | Deep scanning for security leaks, logic flaws, or edge cases. |
| `pulse-qa` | `page_object_gen` | Auto-detecting UI elements to create Playwright locators. |
| `pulse-qa` | `csv_test_parser` | Converting manual spreadsheet test plans into structured execution steps. |
| `as-built` | `mermaid_generator` | Automatically generating Mermaid diagrams from source code or logic. |

### Global Tools (MCP Servers)
| Tool ID | Connection | When to use |
| :--- | :--- | :--- |
| `tool_github` | **GitHub Access** | For any Git operations beyond basic local commits. |
| `tool_jira` | **Jira Access** | For reading/writing/commenting on project management tickets. |
| `tool_figma` | **Figma Access** | To extract CSS, images, or logic from designer handoffs. |
| `tool_playwright` | **Browser Runner** | For clicking through the UI or taking screenshots for verification. |
| `tool_skedulo_cli` | **Platform CLI** | For advanced platform management (deploying packages, logs). |
| `tool_bash` | **Shell Execution** | For local file manipulation, running tests, or git commands. |
| `tool_filesystem` | **Direct File I/O** | For reading/writing source code files directly. |

---

## 4. How to add a Skill
1.  Verify the logic doesn't already exist in this catalog.
2.  Draft the logic following the [Reasoning Protocols](file:///Users/ly.duong/IdeaProjects/AI-CoE/2. Plan/Reasoning Protocols.md).
3.  Register it here with a `Draft` status using `snake_case` naming (no prefix).
4.  Follow the [Skill Calibration](file:///Users/ly.duong/IdeaProjects/AI-CoE/2. Plan/Skill%20Calibration.md) process before moving to L3 autonomy.
