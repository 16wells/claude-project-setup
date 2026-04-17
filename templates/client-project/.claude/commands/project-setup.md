---
description: Set up a new client project, or retrofit an existing folder to the template structure
argument-hint: [new|retrofit] [client-slug-or-folder-path]
---

Handle project setup for a client engagement. There are two modes and you must determine which one applies before doing any work.

## Step 0: Read config first

Before anything else, read `$TEMPLATE_ROOT/config.local.md` first — if it exists, use those values. Otherwise fall back to `$TEMPLATE_ROOT/config.md` at the root of the cloned `claude-project-setup` repo. The `.local.md` variant is gitignored and holds the user's real paths and identity; `config.md` is the generic public version.

That file defines:

- `TEMPLATE_ROOT` — the absolute path to the cloned repo on this machine
- `CLIENTS_ROOT` — the absolute path to the directory where client project folders live

Every path in this command is expressed relative to those two variables. Do not hardcode anyone's home directory.

If the file that was actually read (either `.local.md` or `.md`) is missing or either variable is empty, stop and ask the user to fill it before continuing. If the file still contains `/REPLACE/WITH/...` placeholders, stop and tell the user to fill it first — the repo won't work until they do.

## Step 1: Determine the mode

**Greenfield mode (new project):** There is no existing folder at `$CLIENTS_ROOT/{slug}/`. You'll create one from the template.

**Retrofit mode (existing folder):** A folder already exists — either a legacy project that pre-dates the template, or one the user created manually and selected in Cowork. You'll add missing template pieces without stomping existing content.

Detect mode from the argument:
- If the user says "new [slug]" → greenfield
- If the user says "retrofit [path]" or points at an existing folder → retrofit
- If ambiguous, check whether the target path already exists and ask the user to confirm before proceeding

## Step 2: Read the skill

Before doing anything, read `$TEMPLATE_ROOT/templates/client-project/.claude/skills/project-setup/SKILL.md`. That file has the full procedure for both modes, including the prerequisite questions, the placeholder fill process, and the guardrails. Follow it.

Also read `$TEMPLATE_ROOT/placeholder-map.md` — it documents every `{{TOKEN}}` and what goes in each.

## Step 3: Greenfield flow (if new project)

1. Ask the user for the prerequisites listed in the skill (client slug, legal name, common name, principal contact, project name, start date, current status, plus any helpful context).
2. Confirm target path: `$CLIENTS_ROOT/{client-slug}/`. Stop and ask if the folder already exists.
3. Copy the template folder:
   ```
   cp -R "$TEMPLATE_ROOT/templates/client-project" "$CLIENTS_ROOT/{client-slug}"
   find "$CLIENTS_ROOT/{client-slug}" -name ".DS_Store" -delete
   ```
4. Fill every `{{PLACEHOLDER}}` per the placeholder map. Use `Edit` with `replace_all: true`. For anything you don't know, leave a `TODO: [question]` marker.
5. Seed `01-context/decisions-log.md` with any real decisions, open questions, and client-owed items you know about.
6. Seed `01-context/activity-log.md` with an opening entry noting the scaffold.
7. Decide whether to fill `01-context/marketing-context.md` (marketing-led engagements) or delete it (technical/analytics-led engagements). Never leave it with unfilled `{{PMC_*}}` placeholders.
8. Report back: path created, tree, TODO markers, placeholder values used.

## Step 4: Retrofit flow (if existing folder)

**Merge intelligently.** The goal is to add missing template pieces without overwriting anything the user has already put in place. The skill covers the full procedure — follow it. In short:

1. Inventory the existing folder vs. the template.
2. Mine existing artifacts (folder contents first, then connected tools, then public sources) to gather client context before asking the user anything.
3. Propose a draft understanding for the user to confirm before writing authoritative content.
4. Show the user the plan before touching files.
5. Create missing files and fill placeholders. Always create `01-context/insights.md`. Only create `01-context/marketing-context.md` for marketing-led engagements.
6. Surgical additions to existing files — specifically, add the Cross-Surface Continuity section to `CLAUDE.md` if missing, and the orientation-table rows for `activity-log.md` and `insights.md`.
7. Append a retrofit entry to `01-context/activity-log.md` listing exactly what was added.
8. Report back.

## Step 5: What "done" looks like

Same for both modes:
- No `{{PLACEHOLDER}}` tokens remain in key files (except `TODO:` markers the user will fill later)
- The activity log has a starting or retrofit entry
- The decisions log has something real in it
- `01-context/insights.md` exists
- `01-context/marketing-context.md` is either filled or deleted — never left partial
- The user has a clean summary of what was done and any follow-ups

Arguments: $ARGUMENTS
