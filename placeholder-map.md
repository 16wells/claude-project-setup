# Placeholder Map

> **Note on the iterative-memory model.** As of the 2026-05-08 upgrade, this template uses *iterative* memory upkeep instead of session-end discipline. Memory files (`state.md`, `activity-log.md`, `decisions-log.md`, `insights.md`) are updated as the work happens, gated by checkpoint triggers documented in each project's `CLAUDE.md`. The new file is `01-context/state.md` — "what is happening right now" — and there's a per-sub-project version of it under `02-deliverables/{slug}/state.md` for retainers with multiple active sub-projects. The top-level `state.md` is the meta-pointer. See `templates/client-project/.claude/skills/project-setup/SKILL.md` for the full philosophy and the three modes (greenfield, retrofit, reconcile) the skill now supports. If you are adding a new placeholder, document it here so the project-setup skill knows what to do with it.

Every `{{TOKEN}}` that appears in `templates/client-project/` (and any other templates under `templates/`) is documented here. If you add a new template file or a new token, document it in this file too — otherwise the `project-setup` skill won't know what to do with it.

## How to Read This Map

Each row is one placeholder:
- **Token** — the exact string that appears in template files, wrapped in `{{ }}`
- **What goes in it** — what real content replaces the token
- **Format** — single line, multi-line, table rows, etc.
- **Files** — which template files use this token
- **Example** — a short, illustrative example value

## Core Identity Tokens

| Token | What goes in it | Format | Files | Example |
|---|---|---|---|---|
| `{{CLIENT_NAME}}` | Common name for the client used in running text | Single line | `CLAUDE.md`, `README.md`, `01-context/*.md`, `02-deliverables/kickoff-notes.md`, `01-context/insights.md`, `01-context/marketing-context.md`, `01-context/state.md` | `Acme Futures` |
| `{{CLIENT_LEGAL_NAME}}` | Full legal entity name | Single line | `README.md` | `Acme Futures Trading, LLC (Chicago)` |
| `{{PROJECT_NAME}}` | Short name of the engagement | Single line | `README.md`, `01-context/project-scope.md` | `Website Redesign Project` |
| `{{PRINCIPAL_CONTACT}}` | The human at the client the user works with | Single line | `README.md`, `CLAUDE.md`, `02-deliverables/kickoff-notes.md` | `Morgan Chen` |
| `{{PROJECT_START}}` | When the engagement kicked off | Single line, human-readable | `README.md` | `March 2026` |
| `{{PROJECT_STATUS}}` | One-line current state | Single line | `README.md` | `Proposal delivered, awaiting client approval` |
| `{{COMPANY_NAME}}` | The company / practice running the engagement, with principal in parens | Single line | `README.md`, `02-deliverables/kickoff-notes.md` | `Orbit Consulting (Taylor Kim)` |
| `{{LAST_UPDATED}}` | Date of last meaningful edit to the file | ISO date (YYYY-MM-DD) | `CLAUDE.md`, `01-context/decisions-log.md`, `01-context/activity-log.md`, `01-context/insights.md`, `01-context/marketing-context.md`, `01-context/state.md` | `2026-04-16` |

## Project Orientation Tokens (CLAUDE.md)

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

## Client Profile Tokens (01-context/client-profile.md)

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

## Project Scope Tokens (01-context/project-scope.md)

| Token | What goes in it | Format |
|---|---|---|
| `{{PROJECT_GOAL_BULLETS}}` | Numbered or bulleted list of what the project is trying to accomplish | List |
| `{{INVESTMENT_STRUCTURE}}` | Pricing / tier structure of the engagement. Tables work well. | Tables or prose |
| `{{PROJECT_TIMELINE}}` | Phase-by-phase timeline | Table |
| `{{DELIVERABLES_ARCHITECTURE}}` | Detailed description of what's being built — pages, features, integrations | Prose + lists |
| `{{PLATFORM_DECISIONS}}` | Platform / tech stack decisions (or deferred notes) | Prose |
| `{{CLIENT_RESPONSIBILITIES}}` | What the client needs to provide | Bulleted list |

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

## Marketing Context Tokens (01-context/marketing-context.md)

This file is **optional** — only fill and include when the engagement is marketing-led (campaigns, content production, ad strategy, rebrand). The user's call. All tokens are prefixed `PMC_` (product-marketing-context) to group them visually.

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

## Tokens That Don't Need Filling (Generic Subfolder Readmes)

The READMEs in `03-assets/`, `04-research/`, and `05-build/` are generic and do not contain placeholders. They can be used as-is for most projects. If a specific project needs custom wording (e.g., naming specific competitors in `04-research/README.md`), edit directly rather than adding new placeholders.

The rule files (`.claude/rules/iterative-memory.md`, `.cursor/rules/iterative-memory.mdc`) and the `/checkpoint` command (`.claude/commands/checkpoint.md`) are also placeholder-free. They're verbatim across every project — that's intentional.

## Adding New Placeholders

When you add a new `{{TOKEN}}` to any template file:

1. Add a row to this map documenting what goes in it.
2. If the `project-setup` skill should prompt for it, update `templates/client-project/.claude/skills/project-setup/SKILL.md` to include it in the prerequisites or data-gathering step.
3. Keep tokens UPPER_SNAKE_CASE so they're easy to grep for.

## How to Find Unfilled Placeholders in an Instantiated Project

After filling, search the project folder for any remaining `{{` to make sure nothing was missed. `$CLIENTS_ROOT` comes from `config.md` at the repo root.

```bash
grep -rn "{{" $CLIENTS_ROOT/{client-slug}/ --include="*.md"
```

Any matches are placeholders that didn't get filled. Either fill them, remove them, or replace with `TODO:` markers that explain what still needs to happen.
