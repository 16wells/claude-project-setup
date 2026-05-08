---
description: Set up a new client project, retrofit an existing folder to the template, or reconcile a folder's memory after a thread loss
argument-hint: [new|retrofit|reconcile] [client-slug-or-folder-path]
---

Handle project setup for a client engagement. There are three modes and you must determine which one applies before doing any work.

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

**Reconcile mode (memory drift after a thread loss):** A folder already conforms to the template, but `01-context/state.md` is stale, missing, or out of sync with what's actually deployed/committed. You'll rebuild `state.md` from on-disk evidence (recent commits, activity log, deliverables, git status) and flag contradictions in the other memory files for the user to resolve.

Detect mode from the argument:
- "new [slug]" → greenfield
- "retrofit [path]" or pointing at an existing folder without `state.md` → retrofit
- "reconcile [path]", "the state file is out of date", "rebuild memory" → reconcile
- Ambiguous → check whether the target path already exists, whether it has `state.md`, and ask the user to confirm before proceeding

## Step 2: Read the skill

Before doing anything, read `$TEMPLATE_ROOT/templates/client-project/.claude/skills/project-setup/SKILL.md`. That file has the full procedure for all three modes, including the prerequisite questions, the placeholder fill process, the iterative-memory file inventory, and the guardrails. Follow it.

Also read `$TEMPLATE_ROOT/placeholder-map.md` — it documents every `{{TOKEN}}` and what goes in each, including the new `state.md` tokens (`ACTIVE_SUBPROJECT_SLUG`, `INITIAL_STATE_NOTE`, `EXTERNAL_SYSTEMS_INVENTORY_HINTS`, `LAST_UPDATED_SURFACE`).

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
7. Seed `01-context/state.md` with empty sections and headers in place (filling `{{CLIENT_NAME}}`, `{{ACTIVE_SUBPROJECT_SLUG}}`, `{{INITIAL_STATE_NOTE}}`, `{{EXTERNAL_SYSTEMS_INVENTORY_HINTS}}`, `{{LAST_UPDATED}}`, `{{LAST_UPDATED_SURFACE}}`).
8. Verify `.claude/rules/iterative-memory.md`, `.cursor/rules/iterative-memory.mdc`, and `.claude/commands/checkpoint.md` all copied from the template.
9. Decide whether to fill `01-context/marketing-context.md` (marketing-led engagements) or delete it (technical/analytics-led engagements). Never leave it with unfilled `{{PMC_*}}` placeholders.
10. Report back: path created, tree, TODO markers, placeholder values used.

## Step 4: Retrofit flow (if existing folder, missing template pieces)

**Merge intelligently.** The goal is to add missing template pieces without overwriting anything the user has already put in place. The skill covers the full procedure — follow it. In short:

1. Inventory the existing folder vs. the template. Specifically check whether `01-context/state.md`, `.claude/rules/iterative-memory.md`, `.cursor/rules/iterative-memory.mdc`, and `.claude/commands/checkpoint.md` exist.
2. Detect memory drift: if `state.md` exists but is older than 7 days AND there's been git activity since, ask the user whether to switch to **reconcile** mode instead of straight retrofit.
3. Mine existing artifacts (folder contents first, then connected tools, then public sources) to gather client context before asking the user anything.
4. Propose a draft understanding for the user to confirm before writing authoritative content.
5. Show the user the plan before touching files.
6. Create missing files and fill placeholders. Always create `01-context/state.md` and `01-context/insights.md`. Only create `01-context/marketing-context.md` for marketing-led engagements.
7. Surgical additions to existing files — specifically: replace any old "Cross-Surface Continuity — Read This" section in `CLAUDE.md` with the new "Iterative Memory — Update As You Go" section, and ensure orientation table rows for `state.md`, `activity-log.md`, and `insights.md` exist.
8. Append a retrofit entry to `01-context/activity-log.md` listing exactly what was added.
9. Refresh `state.md` so it reflects the current commit and any in-flight work the agent could glean from the existing folder.
10. Report back.

## Step 5: Reconcile flow (memory drift after a thread loss)

This is the "fix me up after a thread loss" tool. Use it when the file system has drifted from reality. Full procedure is in the skill — short version:

1. Confirm scope with the user: which folder, which active sub-project.
2. Walk the evidence in order: recent git commits → recent activity-log entries → `git status` → open items in decisions-log → active sub-project's deliverables folder → existing `state.md` (if any) → any agent-transcript exports.
3. Reconstruct `state.md` from the evidence. Build the in-progress, awaiting-decision, most-recent-commit, and external-systems sections from what you find.
4. Identify contradictions in the other memory files (activity-log claims X is in flight but commit Y already landed it; decision is open in the log but settled in a commit; etc.).
5. Show the user the proposed `state.md`, the contradiction list with recommended fixes, and the diff against the existing `state.md` (if any).
6. Apply on confirmation. Append a reconcile activity-log entry. Commit with `reconcile: rebuild state.md from on-disk evidence`. Push.
7. Report back: what was written, what contradictions were resolved, what still needs the user's eye, the commit SHA.

**Never auto-overwrite in reconcile mode.** Propose, then apply on confirmation.

## Step 6: What "done" looks like

**Greenfield + retrofit:**
- No `{{PLACEHOLDER}}` tokens remain in key files (except `TODO:` markers the user will fill later)
- `01-context/state.md` exists with headers in place (or, in retrofit, reflects current reality)
- The activity log has a starting or retrofit entry
- The decisions log has something real in it
- `01-context/insights.md` exists
- `01-context/marketing-context.md` is either filled or deleted — never left partial
- Iterative-memory rule files and `/checkpoint` command are present
- The user has a clean summary of what was done and any follow-ups

**Reconcile:**
- `state.md` reflects current reality
- Contradictions in other memory files are resolved or explicitly flagged
- Commit pushed
- The user can read `CLAUDE.md` + `state.md` and resume work without chat history

Arguments: $ARGUMENTS
