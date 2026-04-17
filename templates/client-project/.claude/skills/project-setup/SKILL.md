---
name: project-setup
description: Scaffold a new client project folder from the template, OR retrofit an existing folder to the template structure. Use when the user says "set up a new project for [client]", "scaffold a project folder", "retrofit this folder", "bring this existing project up to template", or anything similar. Supports both greenfield (new folder) and retrofit (existing folder) modes.
---

# Project Setup — Client Folder Scaffolding

This skill handles two situations:

- **Greenfield:** The user wants a new client project folder. You copy the template and fill placeholders.
- **Retrofit:** An existing project folder needs the template structure added. You merge intelligently — add what's missing, leave existing content alone.

**Before doing anything, read `$TEMPLATE_ROOT/config.local.md` first — if it exists, use those values. Otherwise fall back to `$TEMPLATE_ROOT/config.md`.** The `.local.md` variant is gitignored and holds the user's real paths and identity; `config.md` is the generic public version. Every path below is expressed relative to those two variables. Do not hardcode anyone's home directory. If the file that was actually read (either `.local.md` or `.md`) still contains `/REPLACE/WITH/...` placeholders, stop and tell the user to fill it first — the repo won't work until they do.

The default template lives at `$TEMPLATE_ROOT/templates/client-project/`. Additional templates may live as sibling directories under `$TEMPLATE_ROOT/templates/`. Instantiated projects live at `$CLIENTS_ROOT/{client-slug}/`.

## When to Use

Greenfield triggers:
- "Set up a new project for [client]"
- "Scaffold a project folder for [client]"
- "Start a new client workspace"
- "Create the folder structure for [new engagement]"

Retrofit triggers:
- "Retrofit this folder"
- "Bring this project up to the template"
- "Add the template structure to this existing project"
- The user selects an existing folder in Cowork and asks you to set it up

## Detecting Which Mode

Before doing anything, determine mode. Ask yourself:

1. Is there a target folder path already referenced?
2. Does that folder already exist?
3. Does it already have content (files, subfolders) beyond what the template would generate?

**If no folder exists → greenfield.** Proceed with the Greenfield Procedure below.

**If the folder exists and has content → retrofit.** Proceed with the Retrofit Procedure below. Do not copy the template over the existing folder — that would overwrite things.

**If ambiguous**, ask the user explicitly before choosing a mode.

## Prerequisites (both modes)

Use `AskUserQuestion` if anything important is missing. At minimum, gather:

1. **Client slug** — short, lowercase, hyphenated (e.g. `acme-futures`, `contoso-brokers`)
2. **Client legal name** — full entity name for the README
3. **Client common name** — what we actually call them in conversation
4. **Principal contact** — the human on the client side the user works with directly
5. **Project name / scope in one line** — "website redesign," "GTM audit," "CMO engagement," etc.
6. **Project start date** — ISO format
7. **Current status** — one line. "Proposal drafted," "Kickoff scheduled," "Engagement active," etc.

Additional helpful context (ask if relevant):
- Client website URL
- Social proof the client has (reviews, awards, metrics)
- Voice and communication preferences
- Investment structure / pricing tier if known
- Project-specific guardrails the user wants the agent to respect

In retrofit mode, some of these may already be answered in files like `CLAUDE.md` or `README.md`. Read first, ask only for the gaps.

## The Placeholder Map

Every `{{TOKEN}}` is documented in `$TEMPLATE_ROOT/placeholder-map.md`. Read that file before filling anything. It's the source of truth — if a token exists in a template file but not in the map, flag to the user rather than guessing.

---

## Greenfield Procedure

### Step 1: Confirm slug and target path

Confirm with the user:
- Slug: `{client-slug}`
- Target: `$CLIENTS_ROOT/{client-slug}/`

If the target folder already exists, **stop and ask the user.** This may actually be a retrofit situation.

### Step 2: Copy the template

```
cp -R "$TEMPLATE_ROOT/templates/client-project" "$CLIENTS_ROOT/{client-slug}"
find "$CLIENTS_ROOT/{client-slug}" -name ".DS_Store" -delete
```

### Step 3: Read the placeholder map

Read `$TEMPLATE_ROOT/placeholder-map.md` in full.

### Step 4: Gather the data

Use `AskUserQuestion` where needed. Collect answers for every required placeholder. For long-form fields, draft from what the user tells you, then let them refine. Do not invent facts — leave `TODO:` markers with questions if you don't know something.

### Step 5: Fill the placeholders

Use `Edit` with `replace_all: true` for each token, one file at a time:

- `CLAUDE.md`
- `README.md`
- `01-context/client-profile.md`
- `01-context/project-scope.md`
- `01-context/decisions-log.md`
- `01-context/activity-log.md`
- `01-context/insights.md` — usually just the `{{CLIENT_NAME}}` and `{{LAST_UPDATED}}` tokens; `{{INITIAL_INSIGHTS}}` can be left empty or lightly seeded
- `02-deliverables/kickoff-notes.md`

**Marketing-led engagements only:** If the project is marketing-led (campaigns, content production, rebrand, ad strategy, positioning work), also fill `01-context/marketing-context.md` with the `PMC_*` tokens. If marketing is peripheral to the project (e.g. pure technical build, analytics audit, ops engagement), **delete the `marketing-context.md` file** rather than leaving it with unfilled placeholders. Ask the user if you're unsure which category the project falls into.

Subfolder READMEs (`03-assets/`, `04-research/`, `05-build/`) are generic — skim but usually no edits needed.

### Step 6: Seed the decisions log

Pre-fill realistic rows based on what the user has shared:
- Any decisions already made (proposal / pre-sales)
- Any open decisions you can identify
- Any outstanding items you know the client owes

Don't overfill. The user will add rows as the project moves.

### Step 7: Seed the activity log

Append one entry to `01-context/activity-log.md` noting the scaffold.

### Step 8: Report back

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
- **Files that exist in both** → candidates for surgical addition (e.g., adding Cross-Surface Continuity section to an existing CLAUDE.md) but never overwrite
- **Subfolders missing** → `03-assets/{copy,photos,brand}/`, `04-research/competitors/`, `05-build/wireframes/`, `.claude/commands/`, `.claude/skills/project-setup/`
- **Files that exist here but not in the template** → leave alone, note them

### Step 2: Mine existing artifacts before asking the user anything

Retrofit is different from greenfield because the answers to most prerequisite questions are *already somewhere* — the folder, the user's other tools, or public sources. Your job is to find them, not ask. Work this hierarchy top-down, only dropping to the next tier when the current one is exhausted:

**Tier 1 — Inside the folder itself (always check first):**
- `CLAUDE.md` or `README.md` at folder root — often has client one-liner, project description, current status
- `01-context/client-profile.md` — client identity, voice, market context, contact info
- `01-context/project-scope.md` — what's being built, timeline, pricing
- `01-context/decisions-log.md` — what's been settled, what's open
- `02-deliverables/` — proposals, contracts, kickoff notes often contain the richest source material
- `03-assets/` — copy drafts reveal voice
- `04-research/` — competitor analysis reveals positioning
- Any loose `.md`, `.pdf`, `.docx` at the root — users often drop context here first

**Tier 2 — The user's connected surfaces (check if Tier 1 has gaps):**
- Second Brain / Obsidian notes on the client — search by client name
- Linear projects tagged to the client
- Fireflies meeting transcripts — kickoff calls, discovery calls
- Any prior Claude chat exports in the folder

**Tier 3 — Public sources (fill in the picture):**
- Client website — about page, practice areas, services, team bios
- Google Business Profile — reviews, hours, location, category
- LinkedIn — principal contact's background
- Trade publications or press mentions

**Tier 4 — Ask the user (last resort, and only with structure):**
Only ask the user about something after Tiers 1–3 have been checked and came up empty. When you do ask, batch the gaps into one `AskUserQuestion` call rather than pinging them repeatedly. Frame each question as "I couldn't find X in [places checked] — is it Y, Z, or something else?" so the user sees you did the work.

**Track provenance as you go.** For every significant fact you gather, note where it came from — that becomes `{{PROFILE_SOURCES}}` in `client-profile.md` and helps future agents (and the user) trace back why something is asserted. Example: "Client founded in 2008 (source: /02-deliverables/proposal.pdf, p. 2)".

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

**About the two optional/contextual files:**
- `01-context/insights.md` — always create if missing. Fill the `{{CLIENT_NAME}}` and `{{LAST_UPDATED}}` tokens. Seed `{{INITIAL_INSIGHTS}}` with any observations you gathered from Tier 1 mining (e.g. "Client's reviews consistently praise responsiveness" or "Market has consolidated around two dominant platforms"). If nothing surfaced, leave it empty — that's fine.
- `01-context/marketing-context.md` — only create if the engagement is marketing-led (campaigns, content production, rebrand, positioning). If marketing isn't the focus, do not create this file in retrofit. Ask the user if it's ambiguous.

For missing subfolders, create them with a `.gitkeep`.

For the missing `.claude/` setup, copy over `.claude/commands/` and `.claude/skills/project-setup/` from the template. These don't contain placeholders, so no filling needed.

### Step 6: Surgical additions to existing files

**For an existing `CLAUDE.md`:**
- Check whether it has the "Cross-Surface Continuity — Read This" section. If not, add it after the "How to Get Oriented on Specific Topics" table and before "Voice and Tone for Any Content You Draft."
- Check whether the orientation table has a row for `01-context/activity-log.md`. If not, add it.
- Do not modify any other content.

**For an existing `README.md`:**
- Leave alone unless the user explicitly asks for a refresh.

**For existing `01-context/*.md` files:**
- Leave alone. If any of them appear outdated but present, note that in the report — don't modify.

**For existing subfolder READMEs:**
- Leave alone.

### Step 7: Seed the activity log with a retrofit entry

Append an entry to `01-context/activity-log.md` that lists exactly what was added. Format per the template already in that file. Be specific: "Added activity-log.md, added Cross-Surface Continuity section to CLAUDE.md, created empty subfolders X/Y/Z" — not "retrofitted to template."

### Step 8: Report back

Show the user:
- What was added (files, sections, folders)
- What was left alone
- Any `TODO:` markers or unfilled placeholders remaining
- Anything that looked like it might be stale or worth a closer look

Wait for the user's review before declaring complete.

---

## Guardrails (both modes)

1. **Never overwrite existing content without asking.** In greenfield mode, don't copy over an existing folder. In retrofit mode, only add — never replace.
2. **Never invent client-specific facts.** If you don't know something, leave a `TODO:` with a question. The user will fill it.
3. **Respect the user's brand conventions.** If the user has a specific way their practice name should appear (capitalization, spacing, no suffix, etc.), follow it. Defer to any CLAUDE.md conventions already set in their existing projects.
4. **Don't guess the platform decision.** For any web project, the platform (WordPress/Divi vs. Webflow vs. other) is typically deferred. Keep it in the Open Decisions table, not the Closed one.
5. **Don't send anything to the client.** This skill is for scaffolding. Client-facing communication is always the user's call, after their review.

## What "Done" Looks Like

Both modes complete when:
- The target folder exists and has the full template structure
- No unexpected `{{PLACEHOLDER}}` tokens remain (except `TODO:` markers the user will fill)
- The decisions log has at least a few real rows
- The activity log has a starting or retrofit entry
- `01-context/insights.md` exists (even if lightly populated)
- `01-context/marketing-context.md` is either filled in (for marketing-led projects) or deleted (for everything else) — never left with unfilled placeholders
- The user has been shown the result with a clean list of TODOs and any follow-up items

## Fallback: Manual Fill

If anything in this flow breaks, the template can be filled manually. The placeholder map (`_templates/placeholder-map.md`) documents every token. Copy the folder (or create missing files) and search-replace tokens one file at a time.
