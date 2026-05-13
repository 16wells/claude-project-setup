---
description: Set up a new project (client / internal-product / tool), retrofit an existing folder to the template, or reconcile a folder's memory after a thread loss
argument-hint: [new|retrofit|reconcile] [type:client|internal-product|tool] [slug-or-folder-path]
---

Handle project setup for one of three project types: **client engagement**, **internal product** owned by the practice, or **tool** built for personal/team use. There are three modes (greenfield / retrofit / reconcile) — you must determine both the type and the mode before doing any work.

## Step 0: Read config first

Before anything else, read `$TEMPLATE_ROOT/config.local.md` first — if it exists, use those values. Otherwise fall back to `$TEMPLATE_ROOT/config.md` at the root of the cloned `claude-project-setup` repo. The `.local.md` variant is gitignored and holds the user's real paths and identity; `config.md` is the generic public version.

That file defines:

- `TEMPLATE_ROOT` — the absolute path to the cloned repo on this machine
- `CLIENTS_ROOT` — the absolute path to the directory where client project folders live
- `INTERNAL_ROOT` — the absolute path to the directory where internal-product folders live
- `TOOLS_ROOT` — the absolute path to the directory where tool folders live (often the same as `INTERNAL_ROOT` — both paths are configurable)

Every path in this command is expressed relative to those variables. Do not hardcode anyone's home directory.

If the file that was actually read (either `.local.md` or `.md`) is missing or any required variable is empty, stop and ask the user to fill it before continuing. If the file still contains `/REPLACE/WITH/...` placeholders, stop and tell the user to fill it first — the repo won't work until they do.

## Step 1: Determine the mode

**Greenfield mode (new project):** There is no existing folder at the target path. You'll create one from a template.

**Retrofit mode (existing folder):** A folder already exists — either a legacy project that pre-dates the template, or one the user created manually. You'll add missing template pieces without stomping existing content.

**Reconcile mode (memory drift after a thread loss):** A folder already conforms to the template, but `01-context/state.md` is stale, missing, or out of sync with what's actually deployed/committed. You'll rebuild `state.md` from on-disk evidence and flag contradictions in the other memory files.

Detect mode from the argument or context:
- "new [slug]" → greenfield
- "retrofit [path]" or pointing at an existing folder without `state.md` → retrofit
- "reconcile [path]", "the state file is out of date", "rebuild memory" → reconcile
- Ambiguous → check whether the target path already exists, whether it has `state.md`, and ask the user to confirm before proceeding

## Step 2: Determine the project type

There are three template types. **Always confirm with the user which type applies — do not infer silently.** Use `AskUserQuestion` to ask if the type isn't already given in the argument or unambiguous from the existing folder.

| Type | When to use | Template path | Default destination |
|---|---|---|---|
| **client** | Engagement delivered to an external client. The client owns the success criteria. | `$TEMPLATE_ROOT/templates/client-project/` | `$CLIENTS_ROOT/{slug}/` |
| **internal-product** | A product owned by the practice. There's a buyer or audience being designed for, even if hypothetical. | `$TEMPLATE_ROOT/templates/internal-product/` | `$INTERNAL_ROOT/{slug}/` |
| **tool** | A tool built for own use, team use, or open-source release. No revenue model required. | `$TEMPLATE_ROOT/templates/tool/` | `$TOOLS_ROOT/{slug}/` |

**Decision heuristic:**
- Is there an external party who owns the success bar? → **client**
- Is there a buyer/audience (real or hypothetical) being designed for, with revenue/value-creation thinking? → **internal-product**
- Is the primary user you, your team, or anyone using it as a utility — no buyer being designed for? → **tool**

If the type is ambiguous (e.g. an internal product that started as a tool, or a tool that might become a product), ask the user explicitly. The right answer affects which template gets used and which charter file gets created.

In retrofit / reconcile mode, the type is usually evident from the folder contents (look for `client-profile.md` vs. `product-charter.md` vs. `tool-charter.md`). If the existing folder uses an older or mismatched template, surface that and ask the user how to proceed.

## Step 3: Read the right skill

Each template ships with its own copy of the project-setup skill, customized for that type. Once you know the type, read the appropriate skill file:

- client → `$TEMPLATE_ROOT/templates/client-project/.claude/skills/project-setup/SKILL.md`
- internal-product → `$TEMPLATE_ROOT/templates/internal-product/.claude/skills/project-setup/SKILL.md`
- tool → `$TEMPLATE_ROOT/templates/tool/.claude/skills/project-setup/SKILL.md`

Also read `$TEMPLATE_ROOT/placeholder-map.md` — it documents every `{{TOKEN}}` across all three templates and notes which tokens belong to which template type.

## Step 4: Greenfield flow (if new project)

1. Confirm with the user: type, slug, and target path.
   - For **client**: target is `$CLIENTS_ROOT/{slug}/` unless the user specifies otherwise.
   - For **internal-product**: target is `$INTERNAL_ROOT/{slug}/` unless the user specifies otherwise.
   - For **tool**: target is `$TOOLS_ROOT/{slug}/` unless the user specifies otherwise.
2. Stop and ask if the target folder already exists.
3. Copy the template folder for the chosen type:
   ```
   cp -R "$TEMPLATE_ROOT/templates/{type-folder}" "{target-path}"
   find "{target-path}" -name ".DS_Store" -delete
   ```
   Where `{type-folder}` is `client-project`, `internal-product`, or `tool`.
4. Ask the user the prerequisites listed in the type's skill (varies — client engagement has client-specific questions; internal-product has product/buyer questions; tool has user/scope questions).
5. Fill every `{{PLACEHOLDER}}` per the placeholder map. Use `Edit` with `replace_all: true`. For anything you don't know, leave a `TODO: [question]` marker.
6. Seed `01-context/decisions-log.md` with any real decisions, open questions, and outstanding dependencies you know about.
7. Seed `01-context/activity-log.md` with an opening entry noting the scaffold.
8. Seed `01-context/state.md` with empty sections and headers in place (filling identity tokens and any starting-state notes).
9. Verify `.claude/rules/iterative-memory.md`, `.cursor/rules/iterative-memory.mdc`, and `.claude/commands/checkpoint.md` all copied from the template.
10. Decide whether to fill the optional context file (`marketing-context.md` for client, `domain-context.md` for internal-product/tool) or delete it. Never leave it with unfilled placeholders.
11. Report back: path created, tree, TODO markers, placeholder values used.

## Step 5: Retrofit flow (if existing folder, missing template pieces)

**Merge intelligently.** The goal is to add missing template pieces without overwriting anything the user has already put in place. The skill (for the matched type) covers the full procedure — follow it. In short:

1. Inventory the existing folder vs. the template. Specifically check whether `01-context/state.md`, `.claude/rules/iterative-memory.md`, `.cursor/rules/iterative-memory.mdc`, and `.claude/commands/checkpoint.md` exist.
2. Detect memory drift: if `state.md` exists but is older than 7 days AND there's been git activity since, ask the user whether to switch to **reconcile** mode instead of straight retrofit.
3. Mine existing artifacts (folder contents first, then connected tools, then public sources) to gather context before asking the user anything.
4. Propose a draft understanding for the user to confirm before writing authoritative content.
5. Show the user the plan before touching files.
6. Create missing files and fill placeholders. Always create `01-context/state.md` and `01-context/insights.md`. Only create the optional context file (`marketing-context.md` / `domain-context.md`) if the project actually warrants it.
7. Surgical additions to existing files — replace any old "Cross-Surface Continuity — Read This" section in `CLAUDE.md` with the new "Iterative Memory — Update As You Go" section, and ensure orientation table rows for `state.md`, `activity-log.md`, and `insights.md` exist.
8. Append a retrofit entry to `01-context/activity-log.md` listing exactly what was added.
9. Refresh `state.md` so it reflects the current commit and any in-flight work the agent could glean from the existing folder.
10. Report back.

## Step 6: Reconcile flow (memory drift after a thread loss)

This is the "fix me up after a thread loss" tool. Use it when the file system has drifted from reality. Full procedure is in the type-matched skill — short version:

1. Confirm scope with the user: which folder, which active sub-project.
2. Walk the evidence in order: recent git commits → recent activity-log entries → `git status` → open items in decisions-log → active sub-project's deliverables folder → existing `state.md` (if any) → any agent-transcript exports.
3. Reconstruct `state.md` from the evidence.
4. Identify contradictions in the other memory files.
5. Show the user the proposed `state.md`, the contradiction list with recommended fixes, and the diff against the existing `state.md` (if any).
6. Apply on confirmation. Append a reconcile activity-log entry. Commit with `reconcile: rebuild state.md from on-disk evidence`. Push.
7. Report back: what was written, what contradictions were resolved, what still needs the user's eye, the commit SHA.

**Never auto-overwrite in reconcile mode.** Propose, then apply on confirmation.

## Step 7: What "done" looks like

**Greenfield + retrofit:**
- No `{{PLACEHOLDER}}` tokens remain in key files (except `TODO:` markers the user will fill later)
- `01-context/state.md` exists with headers in place (or, in retrofit, reflects current reality)
- The activity log has a starting or retrofit entry
- The decisions log has something real in it
- `01-context/insights.md` exists
- The optional context file is either filled or deleted — never left partial
- Iterative-memory rule files and `/checkpoint` command are present
- The user has a clean summary of what was done and any follow-ups

**Reconcile:**
- `state.md` reflects current reality
- Contradictions in other memory files are resolved or explicitly flagged
- Commit pushed
- The user can read `CLAUDE.md` + `state.md` and resume work without chat history

Arguments: $ARGUMENTS
