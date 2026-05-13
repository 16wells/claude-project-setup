---
name: project-setup
description: Scaffold a new internal-product project folder from the internal-product template, retrofit an existing folder to the template structure, or reconcile a folder's memory files after a thread loss. This is the **internal-product variant** of the project-setup skill — for client engagements use `templates/client-project/.claude/skills/project-setup/`; for tools use `templates/tool/.claude/skills/project-setup/`. Use when scaffolding internal products owned by the practice (a SaaS, a digital product, a paid offering being built in-house). Supports three modes: greenfield (new folder), retrofit (existing folder, add missing pieces), and reconcile (rebuild state.md and re-sync memory after the file system drifted from reality).
---

# Project Setup — Internal Product Folder Scaffolding

> **This skill handles internal products** owned by the practice — products with a buyer/audience being designed for. For client engagements, use `$TEMPLATE_ROOT/templates/client-project/.claude/skills/project-setup/SKILL.md`. For tools (own use, team use, open source) without a buyer being designed for, use `$TEMPLATE_ROOT/templates/tool/.claude/skills/project-setup/SKILL.md`.

This skill handles three situations:

- **Greenfield:** The user wants a new internal-product folder. You copy the template and fill placeholders.
- **Retrofit:** An existing internal-product folder needs the template structure added. You merge intelligently — add what's missing, leave existing content alone.
- **Reconcile:** An existing folder's memory has drifted from reality (long technical session, thread loss, in-flight state never made it to disk). You rebuild `state.md` and re-sync the other memory files from git history, the activity log, and on-disk evidence.

**Before doing anything, read `$TEMPLATE_ROOT/config.local.md` first — if it exists, use those values. Otherwise fall back to `$TEMPLATE_ROOT/config.md`.** The `.local.md` variant is gitignored and holds the user's real paths and identity; `config.md` is the generic public version. Every path below is expressed relative to those two variables. Do not hardcode anyone's home directory. If the file that was actually read (either `.local.md` or `.md`) still contains `/REPLACE/WITH/...` placeholders, stop and tell the user to fill it first — the repo won't work until they do.

The template lives at `$TEMPLATE_ROOT/templates/internal-product/`. Instantiated projects live at `$INTERNAL_ROOT/{project-slug}/`.

## When to Use

Greenfield triggers:
- "Set up a new internal product"
- "Scaffold a folder for [product idea]"
- "Start a new in-house product workspace"
- "Create the folder structure for [new product we're building]"

Retrofit triggers:
- "Retrofit this folder" (and the folder is an internal product)
- "Bring this product project up to the template"
- "Add the template structure to this existing product folder"
- The user selects an existing folder in Cowork and asks you to set it up

Reconcile triggers:
- "Reconcile this folder's memory"
- "The state file is out of date"
- "Rebuild memory from git history"
- "I had a long session and the folder doesn't reflect reality anymore"
- Auto-prompt: during retrofit, if `01-context/state.md` exists but is older than 7 days AND there's been git activity since, offer reconcile mode.

## Detecting Which Mode

Before doing anything, determine mode. Ask yourself:

1. Is there a target folder path already referenced?
2. Does that folder already exist?
3. Does it already have content (files, subfolders) beyond what the template would generate?
4. Does it already conform to the template (i.e., has `01-context/state.md` and the iterative-memory rule)?

**Decision tree:**

- **No folder exists → greenfield.**
- **Folder exists, missing template files → retrofit.**
- **Folder exists, conforms to template, but `state.md` is stale or the user asks to rebuild memory → reconcile.**
- **Ambiguous → ask the user explicitly.**

## Prerequisites (greenfield + retrofit)

Use `AskUserQuestion` if anything important is missing. At minimum, gather:

1. **Project slug** — short, lowercase, hyphenated (e.g. `compliance-saas`, `gtm-tracker-pro`)
2. **Product display name** — the name used in running text (often a polished version of the slug)
3. **One-liner** — what the product is in one sentence
4. **Stage** — idea / discovery / MVP / live / sunset
5. **Why we're building it** — the strategic rationale for the practice
6. **Buyer / user hypothesis** — who's expected to buy or use it (real or hypothetical)
7. **Project start date** — ISO format
8. **Current status** — one line. "Concept stage," "MVP in development," "Beta with N users," etc.

Additional helpful context (ask if relevant):
- Business model thinking (subscription, one-time, value-based, etc.)
- Success criteria — what "this worked" looks like
- Kill criteria — when would we shut it down
- Domain / category and any non-trivial domain context (regulator constraints, ecosystem norms)
- Project-specific guardrails the user wants the agent to respect

In retrofit mode, some of these may already be answered in files like `CLAUDE.md`, `README.md`, or any pitch/spec docs in the folder. Read first, ask only for the gaps.

## The Placeholder Map

Every `{{TOKEN}}` is documented in `$TEMPLATE_ROOT/placeholder-map.md`. Read that file before filling anything. It's the source of truth — if a token exists in a template file but not in the map, flag to the user rather than guessing.

---

## Greenfield Procedure

### Step 1: Confirm slug and target path

Confirm with the user:
- Slug: `{project-slug}`
- Target: `$INTERNAL_ROOT/{project-slug}/`

If the target folder already exists, **stop and ask the user.** This may actually be a retrofit situation.

### Step 2: Copy the template

```
cp -R "$TEMPLATE_ROOT/templates/internal-product" "$INTERNAL_ROOT/{project-slug}"
find "$INTERNAL_ROOT/{project-slug}" -name ".DS_Store" -delete
```

### Step 3: Read the placeholder map

Read `$TEMPLATE_ROOT/placeholder-map.md` in full. Note the section on internal-product-specific tokens (`PRODUCT_*`, `DOMAIN_*`).

### Step 4: Gather the data

Use `AskUserQuestion` where needed. Collect answers for every required placeholder. For long-form fields, draft from what the user tells you, then let them refine. Do not invent facts — leave `TODO:` markers with questions if you don't know something.

### Step 5: Fill the placeholders

Use `Edit` with `replace_all: true` for each token, one file at a time:

- `CLAUDE.md`
- `README.md`
- `01-context/product-charter.md`
- `01-context/project-scope.md`
- `01-context/decisions-log.md`
- `01-context/activity-log.md`
- `01-context/insights.md` — usually just the `{{PROJECT_DISPLAY_NAME}}` and `{{LAST_UPDATED}}` tokens; `{{INITIAL_INSIGHTS}}` can be left empty or lightly seeded
- `01-context/state.md` — sections empty, headers in place. Fill `{{PROJECT_DISPLAY_NAME}}`, `{{LAST_UPDATED}}`, `{{LAST_UPDATED_SURFACE}}`, and `{{ACTIVE_SUBPROJECT_SLUG}}`. If there's no active sub-project yet, leave that as `none-yet` or similar. `{{INITIAL_STATE_NOTE}}` can be a one-line "Project just kicked off — no in-flight work." `{{EXTERNAL_SYSTEMS_INVENTORY_HINTS}}` can be left empty or seeded with any platforms the product is expected to touch (e.g., "Will likely touch: AWS Lambda, Stripe API, Postgres.")
- `02-deliverables/kickoff-notes.md`

**Domain-context-worthy products only:** If the product sits in a regulated/specialized domain or has significant competitive landscape worth documenting (compliance, finance, healthcare, etc.), also fill `01-context/domain-context.md` with the `DOMAIN_*` tokens. For pure-tooling internal products with no meaningful external context, **delete the `domain-context.md` file** rather than leaving it with unfilled placeholders. Ask the user if you're unsure.

Subfolder READMEs (`03-assets/`, `04-research/`, `05-build/`) are generic — skim but usually no edits needed.

### Step 6: Seed the decisions log

Pre-fill realistic rows based on what the user has shared:
- Any decisions already made (tech stack, hosting, business model)
- Any open decisions you can identify
- Any outstanding external dependencies you know about (vendor accounts, API access, design assets)

Don't overfill. The user will add rows as the project moves.

### Step 7: Seed the activity log

Append one entry to `01-context/activity-log.md` noting the scaffold.

### Step 8: Confirm the iterative-memory rules and `/checkpoint` command are in place

The template includes:
- `.claude/rules/iterative-memory.md` — always-on rule for Claude Code / Cowork
- `.cursor/rules/iterative-memory.mdc` — always-on rule for Cursor
- `.claude/commands/checkpoint.md` — the `/checkpoint` slash command

Verify these copied over. They are essential to the iterative model — without them, agents will fall back to session-end discipline.

### Step 9: Report back

Show the user:
- Folder path that was created
- Tree of what got generated
- Any `TODO:` markers
- Summary of placeholder values used

Wait for the user's review before declaring complete.

---

## Retrofit Procedure

**Core principle: merge intelligently, never overwrite silently.** The user has already put effort into this folder. Your job is to add missing template pieces, not to second-guess what they've built.

### Step 1: Inventory the existing folder

Compare the existing folder to the template structure. Produce an inventory of:

- **Files that exist in the template but not in this folder** → candidates to create
- **Files that exist in both** → candidates for surgical addition (e.g., adding the new "Iterative Memory — Update As You Go" section to an existing CLAUDE.md) but never overwrite
- **Subfolders missing** → `03-assets/{copy,photos,brand}/`, `04-research/competitors/`, `05-build/wireframes/`, `.claude/commands/`, `.claude/rules/`, `.claude/skills/project-setup/`, `.cursor/rules/`
- **Files that exist here but not in the template** → leave alone, note them

**Memory-drift detection.** If `01-context/state.md` already exists, check:
- When was it last updated? (`Last updated: …` line in the file, or git log)
- Has there been git activity since that timestamp?
- If the gap is > 7 days OR there are uncommitted changes since the last state.md write, flag this as **memory drift** and ask the user whether to switch into the **reconcile** mode below before continuing the retrofit.

### Step 2: Mine existing artifacts before asking the user anything

Retrofit is different from greenfield because the answers to most prerequisite questions are *already somewhere* — the folder, the user's other tools, or public sources. Your job is to find them, not ask. Work this hierarchy top-down, only dropping to the next tier when the current one is exhausted:

**Tier 1 — Inside the folder itself (always check first):**
- `CLAUDE.md` or `README.md` at folder root — often has product one-liner, current status
- `01-context/product-charter.md` — product identity, buyer, why-we're-building, success criteria
- `01-context/project-scope.md` — what's being built, timeline, tech stack
- `01-context/decisions-log.md` — what's been settled, what's open
- `01-context/activity-log.md` — chronology of recent work
- `01-context/state.md` (if it exists) — current in-flight state
- `02-deliverables/` — specs, design docs, ADRs often contain the richest source material; sub-project subfolders are where active technical work lives
- `03-assets/` — draft copy reveals voice and positioning
- `04-research/` — competitor analysis reveals positioning
- Any loose `.md`, `.pdf`, `.docx` at the root — users often drop context here first

**Tier 2 — The user's connected surfaces (check if Tier 1 has gaps):**
- Second Brain / Obsidian notes on the product
- Linear projects tagged to the product
- Fireflies meeting transcripts — strategy sessions, design discussions
- Any prior Claude chat exports in the folder

**Tier 3 — Public sources (fill in the picture):**
- Existing landing page or marketing site for the product (if any)
- Competitor sites
- Industry publications or regulator docs (if domain has external constraints)

**Tier 4 — Ask the user (last resort, and only with structure):**
Only ask the user about something after Tiers 1–3 have been checked and came up empty. When you do ask, batch the gaps into one `AskUserQuestion` call rather than pinging them repeatedly. Frame each question as "I couldn't find X in [places checked] — is it Y, Z, or something else?" so the user sees you did the work.

**Track provenance as you go.** For every significant fact you gather, note where it came from — that becomes `{{CHARTER_SOURCES}}` in `product-charter.md` and helps future agents (and the user) trace back why something is asserted. Example: "MVP scope decided in /02-deliverables/2026-04-roadmap.md".

### Step 3: Propose a draft understanding for the user to confirm

Before writing anything authoritative into `CLAUDE.md` or the `01-context/` files, produce a short "here's what I think I know" summary for the user. Include:

- The one-paragraph project description you'd put in `CLAUDE.md`
- Current status bullets as you understand them
- Any project-specific guardrails you inferred
- A list of gaps where you're still guessing, and what you'd put in each

The user confirms, corrects, or fills gaps. Only then do you commit content to files. This prevents the agent from hard-coding a wrong understanding across multiple files that the user then has to untangle.

### Step 4: Show the user the plan

Before making any changes to files, tell the user:
- What you'll create (new files, empty subfolders with `.gitkeep`)
- What you'll modify (surgical additions to existing files)
- What you'll leave untouched

Wait for the user's confirmation before proceeding.

### Step 5: Create missing files and folders

For each missing file, copy from the template and then fill placeholders using the understanding the user confirmed in Step 3. Leave `TODO:` markers only for things that remained genuinely unknown after Tiers 1–4 and the draft-understanding review.

**About the new and contextual files:**
- `01-context/state.md` — **always create if missing.** This is the central piece of the iterative-memory upgrade. If you can build a real state from existing artifacts (recent commits, last few activity-log entries, contents of an active `02-deliverables/{slug}/` subfolder), do — that's effectively a reconcile pass folded into the retrofit. If nothing's in flight, leave the sections empty with headers in place.
- `01-context/insights.md` — always create if missing. Fill the `{{PROJECT_DISPLAY_NAME}}` and `{{LAST_UPDATED}}` tokens. Seed `{{INITIAL_INSIGHTS}}` with any observations you gathered from Tier 1 mining. If nothing surfaced, leave it empty.
- `01-context/domain-context.md` — only create if the product sits in a domain with non-trivial external context (regulator constraints, competitive landscape, industry conventions). If the product is purely tooling-focused with no meaningful external context, do not create this file in retrofit. Ask the user if it's ambiguous.

For missing subfolders, create them with a `.gitkeep`.

For the missing `.claude/` setup, copy over `.claude/commands/` (including `checkpoint.md`), `.claude/rules/` (including `iterative-memory.md`), and `.claude/skills/project-setup/` from the template. Also copy `.cursor/rules/iterative-memory.mdc`. These don't contain placeholders, so no filling needed.

### Step 6: Surgical additions to existing files

**For an existing `CLAUDE.md`:**
- If it has the old "Cross-Surface Continuity — Read This" section (session-end-discipline language), replace it with the new "Iterative Memory — Update As You Go" section from the template. Leave everything else in CLAUDE.md alone.
- If it has neither section, insert the new "Iterative Memory — Update As You Go" section after the "How to Get Oriented on Specific Topics" table and before "Voice and Tone for Any Content You Draft."
- Check whether the orientation table has rows for `state.md`, `activity-log.md`, and `insights.md`. Add any that are missing.
- Do not modify any other content.

**For an existing `README.md`:**
- Leave alone unless the user explicitly asks for a refresh.

**For existing `01-context/*.md` files:**
- Leave alone. If any of them appear outdated but present, note that in the report — don't modify.

**For existing subfolder READMEs:**
- Leave alone.

### Step 7: Seed the activity log with a retrofit entry

Append an entry to `01-context/activity-log.md` that lists exactly what was added. Format per the template already in that file. Be specific: "Added state.md, added iterative-memory rule files, replaced Cross-Surface Continuity section in CLAUDE.md with Iterative Memory section, created /checkpoint command" — not "retrofitted to template."

### Step 8: Refresh `state.md`

If you created or updated `state.md`, do one final pass to make sure it actually reflects the most recent commit, the active sub-project, and any in-flight work. Stamp the `Last updated` line.

### Step 9: Report back

Show the user:
- What was added (files, sections, folders)
- What was left alone
- Any `TODO:` markers or unfilled placeholders remaining
- Anything that looked like it might be stale or worth a closer look
- Whether you also ran a reconcile pass on `state.md` (and if so, the diff for the user's review)

Wait for the user's review before declaring complete.

---

## Reconcile Procedure

**Use case:** the file system has drifted from reality. The user just came out of a long technical session, a multi-stage deploy, an incident response, or a thread that ended unexpectedly. `state.md` either doesn't exist, is empty, or describes a project state that's hours or days behind what's actually deployed and committed. This is the "fix me up after a thread loss" tool.

**Core principle: never auto-overwrite. Propose, then apply on confirmation.**

### Step 1: Confirm scope

Ask the user briefly:
- Which folder are we reconciling?
- Which sub-project is "active" right now (if the engagement has multiple sub-projects under `02-deliverables/`)?

If only one sub-project exists, infer it. If multiple, ask.

### Step 2: Walk the evidence

Pull from these sources, in order:

1. **Recent git commits.** `git log --oneline -n 20` — read subjects. For the most recent 3–5, also read the full commit body and diff stat. These tell you what's actually landed.
2. **Recent activity-log entries.** Last 5–10 from `01-context/activity-log.md`. These tell you the agent's stated narrative.
3. **`git status`** for uncommitted state. Anything dirty here is in-flight by definition.
4. **Open items in `decisions-log.md`** with their last-updated timestamps. Anything still in the Open or Outstanding section is awaiting human input.
5. **The active sub-project's own deliverables folder** — `02-deliverables/{active-slug}/`. Recently-modified files here are the substantive work. Look for files like `*-recovery-plan.md`, `*-checklist.md`, `*-run-summary-*.md`, `regression-*.md` — these often *are* the in-flight state, written by the user mid-session.
6. **Existing `01-context/state.md`** if it exists — what does it currently claim? Note what it says so you can call out divergence.
7. **Agent transcript exports if they exist in the folder** (e.g., dropped under `01-context/transcripts/` or at the folder root) — look for the most recent and pull the headline events.

For each piece of evidence, note its **timestamp** and **what it tells you**. Build a working timeline.

### Step 3: Reconstruct the current state

From the evidence, build a draft `state.md` covering:
- **Active sub-project** — which slug, link to its deliverables folder
- **In-progress work** — what's being worked on right now, on which surface, on which step. Use the most recent activity-log entry + uncommitted git changes to triangulate.
- **Awaiting human decision** — pull from open decisions and from any `*-options.md` or "decision needed" markers in deliverables
- **Most recent commit** — SHA, subject, what it landed, and (if you can infer from the diff) what it intentionally didn't
- **External systems state** — for technical projects, scan deliverable files for AWS/cloud/secrets/schedule mentions. Build the inventory tables from what you find. For each entry, note where the evidence came from.
- **Open risks / known mid-recovery items** — anything in deliverables that says "regression," "recovery," "rollback," "in flight," "partial," etc., and isn't yet marked resolved
- **Resume notes for the next agent** — one or two bullets, the shortest "do this next"
- **Last updated** — current timestamp + the surface you're on

### Step 4: Identify contradictions

Cross-check the rebuilt `state.md` against `activity-log.md`, `decisions-log.md`, and `insights.md`. Flag anything where:
- `activity-log.md` says X is in progress, but recent commits show X already landed
- `decisions-log.md` shows an open decision that's actually been settled in a commit
- `insights.md` references a state of play that's been overtaken by events
- A deliverable file describes a "current" plan that's been executed

These contradictions are not for you to silently fix. **List them** for the user to review and resolve manually or to direct you to update.

### Step 5: Show the user the proposal

Produce three things, in this order:

1. **The rebuilt `state.md` content** — full text, ready to write
2. **The list of contradictions** in other memory files, with a recommended action for each ("close decision X as settled — landed in commit abc123" / "update activity-log entry from 2026-04-30 to note that Y was completed")
3. **The diff** between the old `state.md` (if any) and the proposed new one

Do not write any of this yet.

### Step 6: Apply on confirmation

Once the user confirms (with corrections), write the new `state.md`, apply the agreed-on contradiction fixes, and append an activity-log entry that says "reconciled memory after [reason]: rebuilt state.md, resolved N contradictions."

Then commit:
```
git add -A
git commit -m "reconcile: rebuild state.md from on-disk evidence"
git push
```

### Step 7: Report back

- New `state.md` written (path)
- Contradictions resolved (count, with summaries)
- What still looks ambiguous and needs the user's eye
- The commit SHA

---

## Guardrails (all modes)

1. **Never overwrite existing content without asking.** In greenfield, don't copy over an existing folder. In retrofit, only add — never replace (except for the explicit Cross-Surface-Continuity-to-Iterative-Memory swap in CLAUDE.md, which is the documented surgical update). In reconcile, propose then apply.
2. **Never invent product-specific facts.** If you don't know something, leave a `TODO:` with a question. The user will fill it.
3. **Respect the user's brand conventions.** If the user has a specific way their practice name should appear (capitalization, spacing, no suffix, etc.), follow it. Defer to any CLAUDE.md conventions already set in their existing projects.
4. **Don't guess the tech stack.** Platform/framework choices are often deferred. Keep them in the Open Decisions table, not the Closed one.
5. **Don't impose checkpoint discipline on subagents mid-flight.** If you spawn a subagent, let it work to its natural pause point (the next "report back to parent") and flush memory then — not in the middle of its run.

## What "Done" Looks Like

**Greenfield + retrofit complete when:**
- The target folder exists and has the full template structure including `01-context/state.md`, `.claude/rules/iterative-memory.md`, `.cursor/rules/iterative-memory.mdc`, and `.claude/commands/checkpoint.md`
- No unexpected `{{PLACEHOLDER}}` tokens remain (except `TODO:` markers the user will fill)
- The decisions log has at least a few real rows
- The activity log has a starting or retrofit entry
- `01-context/state.md` exists and reflects current reality (or, if greenfield, has empty sections with headers)
- `01-context/insights.md` exists (even if lightly populated)
- `01-context/domain-context.md` is either filled in (for products with non-trivial external context) or deleted (for everything else) — never left with unfilled placeholders
- The user has been shown the result with a clean list of TODOs and any follow-up items

**Reconcile complete when:**
- `state.md` reflects current reality (commits, in-flight work, deployed resources, awaiting-decision items)
- Contradictions in other memory files are resolved or explicitly flagged for the user
- The reconcile pass has been committed and pushed
- The user can read just `CLAUDE.md` + `state.md` and resume work without needing chat history

## Fallback: Manual Fill

If anything in this flow breaks, the template can be filled manually. The placeholder map (`$TEMPLATE_ROOT/placeholder-map.md`) documents every token. Copy the folder (or create missing files) and search-replace tokens one file at a time.
