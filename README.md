# Claude Project Setup

A template system for spinning up client engagement folders that work seamlessly across Claude.ai chats, Cowork on the desktop, and Claude Code in the terminal. Drop a new client into a folder and every Claude surface the user works in will already know the project — the goal, the decisions, the voice, what the last session worked on.

## The Problem This Solves

Working with a client across multiple Claude surfaces is a context nightmare. Every browser chat starts blank. Every Claude Code session starts blank. Every Cowork window starts blank. You end up re-explaining the same client, the same project, the same open decisions five times a week.

This repo is a folder template plus a small handful of slash commands that fix that. Everything lives on disk, every Claude surface reads the same files, and the handoff discipline (append to `activity-log.md`, update `decisions-log.md`, drop observations in `insights.md`) is enforced by commands you invoke at the end of a session.

## How It Works in 30 Seconds

1. Clone this repo. Edit `config.md` to point at where you want client folders created.
2. Run `/project-setup` in Claude Code (or describe the situation to Cowork/Chat). A new client folder gets scaffolded from the template, populated with what you know about the client, and seeded with a `CLAUDE.md` that orients any future agent.
3. Work the project from any Claude surface. At the start of each session, the agent reads `CLAUDE.md`, the last few `activity-log.md` entries, and the open rows in `decisions-log.md`. At the end of each session, it logs what it did.
4. Months later, opening the folder from any surface, the agent knows exactly where things stand.

## Configure First

Before running anything, open `config.md` at the repo root and set two paths:

- `TEMPLATE_ROOT` — where this repo lives on the user's machine
- `CLIENTS_ROOT` — where new client project folders should get created

Every slash command and the `project-setup` skill reads `config.md` first. If those paths are wrong, nothing else works. The rest of this README refers to those as `$TEMPLATE_ROOT` and `$CLIENTS_ROOT`.

## What's Here

- **`config.md`** — TEMPLATE_ROOT and CLIENTS_ROOT. Read first by every agent.
- **`templates/`** — The templates directory. Each subfolder is a template. The repo ships with one: `templates/client-project/`. Copy a template (or let `/project-setup` copy it) to start a new engagement. Every file in a template either describes itself or contains `{{PLACEHOLDER}}` tokens that get filled in during setup. Drop new templates in next to `client-project/` as you build them.
- **`placeholder-map.md`** — Documents every `{{TOKEN}}` in the template, what it represents, and which files it appears in. The source of truth for the fill process.

## Slash Commands

Four slash commands power this template system:

| Command | Where it lives | What it does |
|---|---|---|
| `/project-setup` | **Both** user-level (`~/.claude/commands/`) and project-level (`.claude/commands/`) | Smart command that detects greenfield vs. retrofit. Use for spinning up new projects or bringing existing folders up to the template. |
| `/project-status` | Project-level only | Quick read on the current state of the project — open decisions, recent activity, outstanding items |
| `/log-decision` | Project-level only | Append a row to `01-context/decisions-log.md` (closed / open / outstanding) |
| `/log-activity` | Project-level only | Append a session entry to `01-context/activity-log.md` |

The user-level `/project-setup` lives at `~/.claude/commands/project-setup.md`. Copy it there once per machine (see "First-time Setup" below). The project-level versions travel inside every new project automatically.

`/project-setup` is at both levels intentionally. User-level means it works when you're running Claude Code outside any project folder (the greenfield case, where the project folder doesn't exist yet). Project-level means it travels with every instantiated project, so retrofit and follow-up runs work from inside the folder.

The other three commands only make sense inside an already-set-up project, so they're project-level only — they ride along automatically when `/project-setup` creates a new folder.

## First-time Setup

One-time steps after cloning this repo:

1. Open `config.md` at the repo root and fill in `TEMPLATE_ROOT` and `CLIENTS_ROOT`.
2. Install the user-level `/project-setup` command so it works from anywhere:

   ```bash
   mkdir -p ~/.claude/commands
   cp "$TEMPLATE_ROOT/templates/client-project/.claude/commands/project-setup.md" ~/.claude/commands/project-setup.md
   ```

   (On a fresh clone the user-level file isn't committed to the repo — just copy the project-level version up. Both are designed to read `config.md` for paths.)

3. Confirm `$CLIENTS_ROOT` exists. If not, create it: `mkdir -p "$CLIENTS_ROOT"`.

## How to Start a New Project

### Option A: Use `/project-setup` (recommended)

From Claude Code, anywhere on your machine:

```
/project-setup
```

You'll be asked what mode (new vs. retrofit), the client slug, name, scope, and other prerequisites. The command calls the `project-setup` skill, which:

1. Copies the chosen template (default: `templates/client-project/`) to `$CLIENTS_ROOT/{client-slug}/` (greenfield) or inventories the existing folder (retrofit)
2. Fills every `{{PLACEHOLDER}}` using the data you provide
3. Seeds the decisions log and activity log with realistic starting content
4. Shows you the result and flags anything it left as a `TODO:` for you to finish

In Cowork or Claude.ai Chat, you can describe the situation in plain language — "set up a new project for Acme Futures" or "retrofit this folder to match the template" — and the same skill gets triggered.

### Option B: Manual fill

If the skill isn't available or you prefer to do it by hand:

```bash
cp -R "$TEMPLATE_ROOT/templates/client-project" "$CLIENTS_ROOT/{client-slug}"
find "$CLIENTS_ROOT/{client-slug}" -name ".DS_Store" -delete
```

Then open `placeholder-map.md`, go file by file, and replace each `{{TOKEN}}` with real content. When done, search the folder for any remaining `{{` to confirm nothing was missed:

```bash
grep -rn "{{" "$CLIENTS_ROOT/{client-slug}/" --include="*.md"
```

## How to Retrofit an Existing Project

If a project folder already exists — maybe it pre-dates the template, maybe the user created it manually — `/project-setup` handles it in retrofit mode:

```
/project-setup retrofit $CLIENTS_ROOT/legacy-client
```

The skill will:

1. Inventory what's in the folder vs. what the template provides
2. Show the user the plan before making any changes
3. Create missing files (activity log, subfolders, `.claude/` commands) from the template
4. Add missing sections to existing files (like Cross-Surface Continuity in `CLAUDE.md`) without overwriting the rest
5. Leave everything else alone
6. Append a retrofit entry to the activity log documenting exactly what was added

Rule of thumb: retrofit is **additive**, never destructive. If something would overwrite existing content, the skill stops and asks.

## How the Template Works Across Claude Surfaces

The template is designed so that the user can jump between Claude in a browser chat, Cowork on the desktop, and Claude Code in the terminal — and whichever surface they use next will know exactly where the previous one left off. This happens through four files:

1. **`CLAUDE.md`** — Read first by every Claude agent. It orients the agent on the client, the project, the guardrails, and the voice. This file is the agent's "who, what, why" for the engagement.
2. **`01-context/decisions-log.md`** — The ledger of closed decisions, open decisions, and outstanding items from the client. Checked at the start of any work session to know the current state of the engagement.
3. **`01-context/activity-log.md`** — The session handoff file. Each work session appends a short entry (via `/log-activity` or by hand). Any agent starting a session scans recent entries to see what got done and what's queued.
4. **`01-context/insights.md`** — The working-memory scratchpad. Patterns, quirks, gotchas, and half-formed observations that aren't formal decisions but would be lost if not captured. Updated opportunistically during work sessions.

Optionally, for marketing-led engagements:

5. **`01-context/marketing-context.md`** — Positioning, messaging, brand voice, competitive landscape. A single source of truth that other marketing content references rather than re-deriving.

Together, these files mean: **no Claude agent should ever need to re-ask the user for context that has already been established.**

The `/log-decision` and `/log-activity` slash commands exist to make that discipline frictionless — one command appends a properly-formatted row.

## Maintaining the Template

When you notice a pattern worth generalizing — something that would have saved time if every project folder had it — update the template. Specifically:

- If a new file is useful, add it to `templates/client-project/` with appropriate `{{placeholders}}` (or to whichever template it belongs in)
- If a new placeholder is introduced, document it in `placeholder-map.md`
- If the `project-setup` skill needs to handle something new, update its `SKILL.md`
- If a new slash command would help, add it to `templates/client-project/.claude/commands/` (project-level, so it rides along in every instantiated project) or `~/.claude/commands/` (user-level, available anywhere on your machine), depending on when you'd want to use it
- Bump the "Last updated" line in any file you touch

If you update `/project-setup` at one level (user or project), remember to sync the other — they're meant to be identical copies.

## Layout At a Glance

```
$TEMPLATE_ROOT/
├── README.md                           ← You are here
├── LICENSE                             ← MIT
├── CHANGELOG.md                        ← Version history
├── config.md                           ← TEMPLATE_ROOT + CLIENTS_ROOT (fill first)
├── config.local.md                     ← Optional, gitignored — personal paths + identity
├── placeholder-map.md                  ← Every {{TOKEN}} documented
└── templates/                          ← All templates live here
    └── client-project/                 ← The default template (copy this to start a new project)
        ├── CLAUDE.md                   ← Agent orientation (filled per client)
        ├── README.md                   ← Human-readable project summary
        ├── .claude/
        │   ├── commands/
        │   │   ├── project-setup.md    ← Greenfield + retrofit (project-level copy)
        │   │   ├── project-status.md   ← Quick project status read
        │   │   ├── log-decision.md     ← Append to decisions log
        │   │   └── log-activity.md     ← Append to activity log
        │   └── skills/project-setup/   ← The scaffold-a-new-project skill
        ├── 01-context/
        │   ├── client-profile.md
        │   ├── project-scope.md
        │   ├── decisions-log.md        ← Closed/open/outstanding ledger
        │   ├── activity-log.md         ← Cross-surface session handoff
        │   ├── insights.md             ← Patterns, quirks, observations
        │   └── marketing-context.md    ← Positioning (optional, marketing-led)
        ├── 02-deliverables/            ← Final client-facing artifacts
        ├── 03-assets/{copy,photos,brand}/
        ├── 04-research/competitors/
        └── 05-build/wireframes/
```

Future templates would live alongside `client-project/`:

```
templates/
├── client-project/
├── internal-project/         ← (hypothetical)
└── content-production/       ← (hypothetical)
```

And at the user level:

```
~/.claude/commands/
└── project-setup.md                    ← Same command, works from anywhere
```

## License

See `LICENSE` at the repo root. If no license is committed yet, treat this repo as source-available for personal reference only until a license is added.

---
*Built for anyone who juggles multiple client engagements across Claude surfaces. Fork it, adapt the `CLAUDE.md` voice and guardrail sections to your own practice, and go.*
