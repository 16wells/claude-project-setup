# Placeholder Map

> **Note on the iterative-memory model.** As of the 2026-05-08 upgrade, the templates use *iterative* memory upkeep instead of session-end discipline. Memory files (`state.md`, `activity-log.md`, `decisions-log.md`, `insights.md`) are updated as the work happens, gated by checkpoint triggers documented in each project's `CLAUDE.md`. The file `01-context/state.md` — "what is happening right now" — is the live dashboard, with a per-sub-project version under `02-deliverables/{slug}/state.md` for retainers with multiple active sub-projects.
>
> **Note on the three templates.** As of the 2026-05-12 upgrade, this repo ships three templates: `client-project/` (engagements delivered to a client), `internal-product/` (products owned by the practice with a buyer being designed for), and `tool/` (utilities for own/team/public use, no buyer being designed for). See each template's `.claude/skills/project-setup/SKILL.md` for the full procedure for that type.

Every `{{TOKEN}}` that appears in any template under `templates/` is documented here. Some tokens are shared across all three templates (identity, principal-user, iterative-memory). Others are type-specific — `{{CLIENT_*}}` and `{{PMC_*}}` only appear in `client-project/`; `{{PRODUCT_*}}` and `{{DOMAIN_*}}` only in `internal-product/`; `{{TOOL_*}}` and `{{ECOSYSTEM_*}}` only in `tool/`.

If you add a new template file or a new token, document it here too — otherwise the `project-setup` skill won't know what to do with it.

## Token Naming Convention by Template

| Template | Display-name token | Charter file token-prefix | Optional context file token-prefix |
|---|---|---|---|
| `client-project/` | `{{CLIENT_NAME}}` | `{{CLIENT_*}}` (in `client-profile.md`) | `{{PMC_*}}` (in `marketing-context.md`) |
| `internal-product/` | `{{PROJECT_DISPLAY_NAME}}` | `{{PRODUCT_*}}` (in `product-charter.md`) | `{{DOMAIN_*}}` (in `domain-context.md`) |
| `tool/` | `{{PROJECT_DISPLAY_NAME}}` | `{{TOOL_*}}` (in `tool-charter.md`) | `{{ECOSYSTEM_*}}` (in `domain-context.md`) |

## How to Read This Map

Each row is one placeholder:
- **Token** — the exact string that appears in template files, wrapped in `{{ }}`
- **What goes in it** — what real content replaces the token
- **Format** — single line, multi-line, table rows, etc.
- **Files** — which template files use this token
- **Example** — a short, illustrative example value

## Core Identity Tokens

| Token | What goes in it | Format | Templates | Example |
|---|---|---|---|---|
| `{{CLIENT_NAME}}` | Common name for the client used in running text | Single line | `client-project/` only | `Acme Futures` |
| `{{CLIENT_LEGAL_NAME}}` | Full legal entity name | Single line | `client-project/` only | `Acme Futures Trading, LLC (Chicago)` |
| `{{PROJECT_DISPLAY_NAME}}` | Display name for the product or tool, used in running text and headers | Single line | `internal-product/`, `tool/` | `Compliance Review SaaS` / `GTM Form Tracker` |
| `{{PROJECT_NAME}}` | Short name of the engagement (legacy — used in client `README.md`) | Single line | `client-project/` only | `Website Redesign Project` |
| `{{PRINCIPAL_CONTACT}}` | The human at the client the user works with | Single line | `client-project/` only | `Morgan Chen` |
| `{{PROJECT_START}}` | When the engagement / build kicked off | Single line, human-readable | All three | `March 2026` |
| `{{PROJECT_STATUS}}` | One-line current state | Single line | All three | `Proposal delivered` / `MVP in development` / `Working but rough` |
| `{{COMPANY_NAME}}` | The company / practice running the engagement, with principal in parens | Single line | `client-project/` only | `Orbit Consulting (Taylor Kim)` |
| `{{LAST_UPDATED}}` | Date of last meaningful edit to the file | ISO date (YYYY-MM-DD) | All three | `2026-04-16` |

## Project Orientation Tokens (CLAUDE.md)

These appear in `CLAUDE.md` across all three templates.

| Token | What goes in it | Format | Example |
|---|---|---|---|
| `{{PRINCIPAL_USER}}` | Full name of the human running the engagement | Single line | `Taylor Kim` |
| `{{PRINCIPAL_USER_FIRST}}` | First name used conversationally throughout CLAUDE.md | Single word | `Taylor` |
| `{{PRINCIPAL_USER_PRONOUN_CAP}}` | Subject pronoun, capitalized, used mid-sentence when starting a new clause | He / She / They | `He` |
| `{{PRACTICE_NAME}}` | Name of the user's practice, agency, or company | Single line | `Orbit Consulting` |
| `{{PRACTICE_DESCRIPTION}}` | Short clause describing what the practice is | Single line (no period) | `a digital marketing consulting practice` |
| `{{BRANDING_NOTE}}` | Optional one-paragraph note about brand conventions (capitalization, spelling, no-suffix rules, etc.). Leave empty if no conventions to enforce. | One paragraph, or empty | `**Important branding note:** The company name is always written as OneWord — no spaces, no hyphens, no suffix.` |
| `{{INTERNAL_VOICE_NOTES}}` | How to write in the user's internal voice for drafts, docs, internal communications | Short paragraph | `Plainspoken, direct, warm. Lead with "why" before "how." Avoid filler verbs like leverage, streamline, unlock. If the user uses one of those, fine — don't initiate.` |
| `{{PROJECT_ONE_PARAGRAPH}}` | A dense paragraph describing what the project is, who it's for, why it matters. Should give a new agent enough to operate intelligently. | One long paragraph | See `CLAUDE.md` of a real project |
| `{{CURRENT_STATUS_BULLETS}}` | 3–6 bullets on current state — what's delivered, what's pending, what's deferred | Bulleted list | See `CLAUDE.md` of a real project |
| `{{PROJECT_SPECIFIC_GUARDRAILS}}` | Numbered list of guardrails unique to this engagement beyond the three generic ones. Can be empty if nothing project-specific. | Numbered list, or empty | See `CLAUDE.md` of a real project |
| `{{SECOND_BRAIN_LINK}}` | Link or file path to the project note in the user's Second Brain / note system | URL or path, or "TBD" | `obsidian://open?vault=YourVault&file=projects%2Facme-futures` |
| `{{LINEAR_PROJECT_LINK}}` | Link to the project in Linear if one exists | URL, or "none" | `https://linear.app/your-org/project/acme-futures` |
| `{{PEOPLE_LINKS}}` | Links to any people-note files relevant to the project | List of links, or "none" | `[Morgan Chen](path/to/note)` |

## Client Profile Tokens (`templates/client-project/01-context/client-profile.md`)

Only present in `client-project/`.

| Token | What goes in it | Format |
|---|---|---|
| `{{CLIENT_BUSINESS_DESCRIPTION}}` | What the client does, where they are, what they sell, who their customers are | 1–3 paragraphs |
| `{{CLIENT_WEBSITE}}` | Current website URL | Single line |
| `{{CLIENT_SOCIAL_PROOF}}` | Reviews, awards, notable metrics, press mentions | Bulleted list |
| `{{PRINCIPAL_DETAILS}}` | Background on the principal contact — experience, credentials, personal context that matters | Short prose with bullets |
| `{{CLIENT_VOICE_NOTES}}` | How the client talks, what words they use, what tone to write in for their public-facing content | Bullets |
| `{{MARKET_CONTEXT}}` | Competitive landscape, industry dynamics, named competitors if relevant | 1–3 paragraphs |
| `{{STRATEGIC_POSITIONING}}` | The thesis for how the client wins in their market | Short prose |
| `{{TRUST_SIGNALS}}` | Specific proof points to feature in marketing | Bulleted list |
| `{{PROFILE_SOURCES}}` | Where the profile data came from (reviews, website, client call, etc.) | Bulleted list |

## Product Charter Tokens (`templates/internal-product/01-context/product-charter.md`)

Only present in `internal-product/`.

| Token | What goes in it | Format |
|---|---|---|
| `{{PRODUCT_ONELINER}}` | One-sentence description of the product | Single line |
| `{{PRODUCT_WHAT_IT_DOES}}` | What the product actually does for users | Short prose |
| `{{PRODUCT_STAGE}}` | Stage in the lifecycle | Single line: `idea` / `discovery` / `MVP` / `live` / `sunset` |
| `{{PRODUCT_WHY}}` | Strategic rationale — why the practice is building this | 1–2 paragraphs |
| `{{PRODUCT_BUYER}}` | Who buys or uses the product (real or hypothetical) | Short prose |
| `{{PRODUCT_DECISION_MAKERS}}` | Who inside the buyer org decides | Short prose |
| `{{PRODUCT_PRIMARY_JOB}}` | The job the buyer hires the product for | Single line |
| `{{PRODUCT_ANTI_PERSONA}}` | Who this is *not* for | Short prose |
| `{{PRODUCT_SUCCESS_CRITERIA}}` | What "this worked" looks like — specific, measurable | Bulleted list |
| `{{PRODUCT_KILL_CRITERIA}}` | When we'd shut this down or pivot | Bulleted list |
| `{{PRODUCT_BUSINESS_MODEL}}` | How it makes money / creates value | Short prose |
| `{{PRODUCT_PRICING_THINKING}}` | Current pricing hypothesis | Short prose |
| `{{PRODUCT_TRUST_SIGNALS}}` | Credibility / proof points to build toward | Bulleted list |
| `{{CHARTER_SOURCES}}` | Where the charter data came from | Bulleted list |

## Tool Charter Tokens (`templates/tool/01-context/tool-charter.md`)

Only present in `tool/`.

| Token | What goes in it | Format |
|---|---|---|
| `{{TOOL_ONELINER}}` | One-sentence description of the tool | Single line |
| `{{TOOL_WHAT_IT_DOES}}` | What the tool actually does | Short prose |
| `{{TOOL_STAGE}}` | Stage in the lifecycle | Single line: `idea` / `prototype` / `working` / `used in production` / `sunset` |
| `{{TOOL_WHY}}` | Why the tool exists — friction it removes, leverage it creates | 1–2 paragraphs |
| `{{TOOL_USERS}}` | Who uses it | Short prose: `self` / `team` / `contractors` / `external` / `public OSS` |
| `{{TOOL_PRIMARY_USE_CASE}}` | The main job the tool does | Single line |
| `{{TOOL_SECONDARY_USE_CASES}}` | Other valid uses | Bulleted list |
| `{{TOOL_ANTI_USE}}` | What this tool is *not* for | Short prose |
| `{{TOOL_IN_SCOPE}}` | Features / capabilities in scope | Bulleted list |
| `{{TOOL_OUT_OF_SCOPE}}` | Explicitly out of scope | Bulleted list |
| `{{TOOL_LATER}}` | Maybe-later parking lot | Bulleted list |
| `{{TOOL_SUCCESS_CRITERIA}}` | What "this is working" looks like | Bulleted list |
| `{{TOOL_SUNSET_CRITERIA}}` | When we'd stop using or deprecate it | Bulleted list |
| `{{TOOL_REUSE_KNOWLEDGE}}` | Patterns / techniques worth carrying to other projects | Bulleted list |
| `{{CHARTER_SOURCES}}` | Where the charter data came from | Bulleted list |

## Project Scope Tokens (01-context/project-scope.md)

Used in all three templates with slight variations:

| Token | What goes in it | Format | Templates |
|---|---|---|---|
| `{{PROJECT_GOAL_BULLETS}}` | Numbered or bulleted list of what the project is trying to accomplish | List | All three |
| `{{INVESTMENT_STRUCTURE}}` | Pricing / tier structure of the engagement | Tables or prose | `client-project/` only |
| `{{FUNDING_RESOURCING}}` | How the build is paid for and who's working on it | Prose | `internal-product/`, `tool/` |
| `{{PROJECT_TIMELINE}}` | Phase-by-phase timeline | Table | All three |
| `{{DELIVERABLES_ARCHITECTURE}}` | Detailed description of what's being built — pages, features, integrations | Prose + lists | All three |
| `{{PLATFORM_DECISIONS}}` | Platform / tech stack decisions (or deferred notes) | Prose | All three |
| `{{CLIENT_RESPONSIBILITIES}}` | What the client needs to provide | Bulleted list | `client-project/` only |
| `{{EXTERNAL_DEPENDENCIES}}` | What the project needs from outside itself (vendor accounts, API access, design assets, etc.) | Bulleted list | `internal-product/`, `tool/` |

## Decisions Log Tokens (01-context/decisions-log.md)

| Token | What goes in it | Format |
|---|---|---|
| `{{CLOSED_DECISIONS_ROWS}}` | Pipe-delimited rows for the Closed Decisions table | Markdown table rows |
| `{{OPEN_DECISIONS_ROWS}}` | Pipe-delimited rows for the Open Decisions table | Markdown table rows |
| `{{OUTSTANDING_ROWS}}` | Pipe-delimited rows for the Outstanding From Client table | Markdown table rows |

**Row format for Closed:** `| YYYY-MM | Decision | Rationale |`
**Row format for Open:** `| YYYY-MM | Decision | Notes |`
**Row format for Outstanding:** `| Item | ⏳ Pending or ✅ Received | Notes |`

## Kickoff Notes Tokens (02-deliverables/kickoff-notes.md)

| Token | What goes in it | Format |
|---|---|---|
| `{{KICKOFF_AGENDA}}` | Numbered list of agenda priorities for the kickoff meeting | Numbered list |

## README Tokens (README.md)

| Token | What goes in it | Format |
|---|---|---|
| `{{KEY_DELIVERABLE_LINKS}}` | A small section listing the 2–3 most important deliverable files with links | Table or bulleted list |

## Insights Tokens (01-context/insights.md)

| Token | What goes in it | Format |
|---|---|---|
| `{{INITIAL_INSIGHTS}}` | Any observations or assumptions from project setup worth capturing before active work starts. Fine to leave empty if nothing specific yet. | Bulleted list, or empty |

## State Tokens (01-context/state.md)

The state file is the live in-flight dashboard. Most of its content is filled iteratively as the project moves, not at scaffolding time. Only a few tokens get filled when the file is first created.

| Token | What goes in it | Format |
|---|---|---|
| `{{ACTIVE_SUBPROJECT_SLUG}}` | Slug of the sub-project that is currently active. For greenfield with no work yet, use `none-yet`. For a single-project engagement, the project slug. For multi-sub-project retainers, the slug of whichever sub-project is in flight. | Single token (lowercase, hyphenated) |
| `{{INITIAL_STATE_NOTE}}` | A one- or two-line note about the project's starting condition. Fine to leave empty after the first real session. Greenfield default: "Project just kicked off — no in-flight work yet. Awaiting first working session." | Short prose, or empty |
| `{{EXTERNAL_SYSTEMS_INVENTORY_HINTS}}` | One-line hint about what external systems this engagement is expected to touch — sets the agent up to populate the inventory tables below it. Empty for advisory engagements. | Short prose, or empty |
| `{{LAST_UPDATED_SURFACE}}` | Which surface last touched the state file. Useful for cross-surface debugging. | One of: Cowork / Claude Code / Cursor / Claude.ai chat |

The deeper tables (Deployed Services, Cloud Resources, Third-Party API State, Secrets, Scheduled Jobs, Production Data State, Open Risks, Resume Notes) are filled iteratively — empty rows when the file is first created. Per-sub-project state files under `02-deliverables/{slug}/state.md` follow the same shape and are created on demand by the sub-project's first working session.

## Marketing Context Tokens (`templates/client-project/01-context/marketing-context.md`)

Only present in `client-project/`. **Optional** — only fill and include when the engagement is marketing-led (campaigns, content production, ad strategy, rebrand). The user's call. All tokens are prefixed `PMC_` (product-marketing-context) to group them visually.

| Token | What goes in it | Format |
|---|---|---|
| `{{PMC_ONELINER}}` | One-sentence description of what the client sells | Single line |
| `{{PMC_WHAT_IT_DOES}}` | What the product/service actually does for customers | Short prose |
| `{{PMC_CATEGORY}}` | Category the product sits in (e.g. "trading platform," "personal injury law") | Single line |
| `{{PMC_PRODUCT_TYPE}}` | Type (service, software, physical product, etc.) | Single line |
| `{{PMC_BUSINESS_MODEL}}` | How they make money (subscription, contingency, fee-based, etc.) | Single line |
| `{{PMC_TARGET}}` | Who the client sells to — companies, individuals, firmographics | Short prose |
| `{{PMC_DECISION_MAKERS}}` | Who inside the target actually decides to buy | Short prose |
| `{{PMC_PRIMARY_USE_CASE}}` | The main reason customers engage | Single line |
| `{{PMC_JTBD}}` | Jobs-to-be-done bullets | Bulleted list |
| `{{PMC_USE_CASES}}` | Specific use cases or scenarios | Bulleted list |
| `{{PMC_PERSONA_ROWS}}` | Markdown table rows for the Personas table | Pipe-delimited rows |
| `{{PMC_CORE_PROBLEM}}` | The central problem the client solves | Short prose |
| `{{PMC_ALT_FAILURES}}` | Why alternatives fall short | Bulleted list |
| `{{PMC_COST}}` | What the problem costs customers if unaddressed | Short prose |
| `{{PMC_EMOTIONAL_TENSION}}` | Emotional dimension of the problem | Short prose |
| `{{PMC_DIRECT_COMPETITOR}}` / `{{PMC_DIRECT_WHY}}` | Direct competitor name and why they fall short | Single lines |
| `{{PMC_SECONDARY_COMPETITOR}}` / `{{PMC_SECONDARY_WHY}}` | Secondary alternative and why it falls short | Single lines |
| `{{PMC_INDIRECT_ALTERNATIVE}}` / `{{PMC_INDIRECT_WHY}}` | Indirect alternative and why it falls short | Single lines |
| `{{PMC_DIFFERENTIATORS}}` | Key differentiators bullets | Bulleted list |
| `{{PMC_HOW_DIFFERENT}}` / `{{PMC_WHY_BETTER}}` / `{{PMC_WHY_CHOSEN}}` | Differentiation narrative | Short prose each |
| `{{PMC_OBJECTION_ROWS}}` | Markdown table rows for Objections table | Pipe-delimited rows |
| `{{PMC_ANTI_PERSONA}}` | Who this client is explicitly NOT for | Short prose |
| `{{PMC_PUSH}}` / `{{PMC_PULL}}` / `{{PMC_HABIT}}` / `{{PMC_ANXIETY}}` | Switching dynamics narrative | Short prose each |
| `{{PMC_PROBLEM_VERBATIM}}` | Customer verbatim describing the problem | Quoted line |
| `{{PMC_US_VERBATIM}}` | Customer verbatim describing the client | Quoted line |
| `{{PMC_USE_WORDS}}` / `{{PMC_AVOID_WORDS}}` | Language dos and don'ts | Short lists |
| `{{PMC_GLOSSARY_ROWS}}` | Rows for the Glossary table | Pipe-delimited rows |
| `{{PMC_TONE}}` / `{{PMC_STYLE}}` / `{{PMC_PERSONALITY}}` | Brand voice descriptors | Short prose each |
| `{{PMC_METRICS}}` | Notable metrics the client can cite | Short prose or bullets |
| `{{PMC_REFERENCE_CUSTOMERS}}` | Name-dropable customers | Short list |
| `{{PMC_TESTIMONIAL_QUOTE}}` / `{{PMC_TESTIMONIAL_ATTRIBUTION}}` | One representative testimonial and who said it | Quoted line + attribution |
| `{{PMC_VALUE_THEME_ROWS}}` | Rows for the Value Themes table | Pipe-delimited rows |
| `{{PMC_BUSINESS_GOAL}}` / `{{PMC_CONVERSION_ACTION}}` / `{{PMC_CURRENT_METRICS}}` | The business outcome the marketing work should drive, the conversion event, and current baselines | Short prose each |

If a PMC_ section can't be filled from available material, leave the token in place with a `TODO:` note — better empty than fabricated.

## Domain Context Tokens (`templates/internal-product/01-context/domain-context.md`)

Only present in `internal-product/`. **Optional** — fill when the product sits in a domain with non-trivial external context (regulator constraints, competitive landscape, industry conventions). Delete the file if the product is purely tooling-focused.

| Token | What goes in it | Format |
|---|---|---|
| `{{DOMAIN_CATEGORY}}` | The domain / category the product sits in | Single line |
| `{{DOMAIN_WHY}}` | Why this domain — strategic fit | Short prose |
| `{{DOMAIN_CONSTRAINTS}}` | Regulator / technical / cultural constraints worth noting | Short prose or bullets |
| `{{DOMAIN_BUYERS}}` | Who's in the market | Short prose |
| `{{DOMAIN_DECISION_MAKERS}}` | Who inside target orgs decides | Short prose |
| `{{DOMAIN_PRIMARY_USE_CASE}}` | Main use case | Single line |
| `{{DOMAIN_JTBD}}` | Jobs to be done | Bulleted list |
| `{{DOMAIN_PERSONA_ROWS}}` | Markdown table rows for the Personas table | Pipe-delimited rows |
| `{{DOMAIN_CORE_PROBLEM}}` | Central problem the product addresses | Short prose |
| `{{DOMAIN_ALT_FAILURES}}` | Why current alternatives fall short | Bulleted list |
| `{{DOMAIN_COST}}` | What the problem costs the buyer | Short prose |
| `{{DOMAIN_EMOTIONAL_TENSION}}` | Emotional dimension of the problem | Short prose |
| `{{DOMAIN_DIRECT_COMPETITOR}}` / `{{DOMAIN_DIRECT_WHY}}` | Direct competitor and why short | Single lines |
| `{{DOMAIN_SECONDARY_COMPETITOR}}` / `{{DOMAIN_SECONDARY_WHY}}` | Secondary alternative | Single lines |
| `{{DOMAIN_INDIRECT_ALTERNATIVE}}` / `{{DOMAIN_INDIRECT_WHY}}` | Status quo / indirect alt | Single lines |
| `{{DOMAIN_DIFFERENTIATORS}}` | Key differentiators | Bulleted list |
| `{{DOMAIN_HOW_DIFFERENT}}` / `{{DOMAIN_WHY_BETTER}}` | Differentiation narrative | Short prose each |
| `{{DOMAIN_OBJECTION_ROWS}}` | Markdown table rows for Objections table | Pipe-delimited rows |
| `{{DOMAIN_PUSH}}` / `{{DOMAIN_PULL}}` / `{{DOMAIN_HABIT}}` / `{{DOMAIN_ANXIETY}}` | Switching dynamics | Short prose each |
| `{{DOMAIN_PROBLEM_VERBATIM}}` | Customer verbatim | Quoted line |
| `{{DOMAIN_USE_WORDS}}` / `{{DOMAIN_AVOID_WORDS}}` | Language dos and don'ts | Short lists |
| `{{DOMAIN_GLOSSARY_ROWS}}` | Glossary table rows | Pipe-delimited rows |
| `{{DOMAIN_TONE}}` / `{{DOMAIN_STYLE}}` / `{{DOMAIN_PERSONALITY}}` | Brand voice descriptors | Short prose each |
| `{{DOMAIN_METRICS_TARGETS}}` / `{{DOMAIN_REFERENCE_TARGETS}}` / `{{DOMAIN_TESTIMONIAL_TARGETS}}` | Proof points to build toward | Short prose each |

If a `DOMAIN_*` section can't be filled from available material, leave the token in place with a `TODO:` note — better empty than fabricated.

## Ecosystem Context Tokens (`templates/tool/01-context/domain-context.md`)

Only present in `tool/`. **Optional** — fill when the tool plugs into a non-trivial ecosystem (vendor APIs with gotchas, platform conventions, OSS release context). Delete the file if the tool is self-contained.

| Token | What goes in it | Format |
|---|---|---|
| `{{ECOSYSTEM_PLATFORM}}` | Platform / ecosystem the tool plugs into | Single line |
| `{{ECOSYSTEM_INTEGRATION_SURFACE}}` | API / plugin / webhook / file format / CLI extension / etc. | Single line |
| `{{ECOSYSTEM_CONVENTIONS}}` | Key conventions / norms in the ecosystem | Short prose or bullets |
| `{{ECOSYSTEM_ALTERNATIVES_ROWS}}` | Markdown table rows for adjacent tools / alternatives | Pipe-delimited rows |
| `{{ECOSYSTEM_CONSTRAINTS}}` | Rate limits, auth schemes, platform policies, regulator rules | Short prose or bullets |
| `{{ECOSYSTEM_GOTCHAS}}` | Hard-won knowledge — "I wish I'd known this before I started" | Bulleted list |
| `{{ECOSYSTEM_GLOSSARY_ROWS}}` | Glossary table rows | Pipe-delimited rows |
| `{{ECOSYSTEM_REFERENCES}}` | Reference links — docs, blog posts, repos | Bulleted list |

## Internal-Product / Tool Charter Sources

Both `internal-product/01-context/product-charter.md` and `tool/01-context/tool-charter.md` use `{{CHARTER_SOURCES}}` — see the charter token tables above.

## Tokens That Don't Need Filling (Generic Subfolder Readmes)

The READMEs in `03-assets/`, `04-research/`, and `05-build/` are generic and do not contain placeholders. They can be used as-is for most projects. If a specific project needs custom wording (e.g., naming specific competitors in `04-research/README.md`), edit directly rather than adding new placeholders.

The rule files (`.claude/rules/iterative-memory.md`, `.cursor/rules/iterative-memory.mdc`) and the `/checkpoint` command (`.claude/commands/checkpoint.md`) are also placeholder-free. They're verbatim across every project — that's intentional.

## Adding New Placeholders

When you add a new `{{TOKEN}}` to any template file:

1. Add a row to this map documenting what goes in it.
2. If the `project-setup` skill should prompt for it, update `templates/client-project/.claude/skills/project-setup/SKILL.md` to include it in the prerequisites or data-gathering step.
3. Keep tokens UPPER_SNAKE_CASE so they're easy to grep for.

## How to Find Unfilled Placeholders in an Instantiated Project

After filling, search the project folder for any remaining `{{` to make sure nothing was missed. The root path depends on the project type — `$CLIENTS_ROOT`, `$INTERNAL_ROOT`, or `$TOOLS_ROOT` (all defined in `config.md` / `config.local.md` at the repo root).

```bash
# Replace ROOT with $CLIENTS_ROOT, $INTERNAL_ROOT, or $TOOLS_ROOT depending on type
grep -rn "{{" $ROOT/{project-slug}/ --include="*.md"
```

Any matches are placeholders that didn't get filled. Either fill them, remove them, or replace with `TODO:` markers that explain what still needs to happen.
