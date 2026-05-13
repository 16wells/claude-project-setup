# Claude Project Setup

A template system for spinning up project folders that work seamlessly across Claude.ai chats, Cowork on the desktop, and Claude Code in the terminal. Drop a new project into a folder and every Claude surface the user works in will already know it — the goal, the decisions, the voice, what the last session worked on.

## The Problem This Solves

Working across multiple Claude surfaces is a context nightmare. Every browser chat starts blank. Every Claude Code session starts blank. Every Cowork window starts blank. You end up re-explaining the same project five times a week.

This repo is a set of folder templates plus a small handful of slash commands that fix that. Everything lives on disk, every Claude surface reads the same files, and the iterative-memory discipline (update `state.md` as work happens, append to `activity-log.md`, log decisions, drop observations in `insights.md`) is documented in every project's `CLAUDE.md`.

## The Three Templates

The repo ships three templates because not every project is a client engagement. The right template depends on **who owns the success bar** and **whether there's a buyer being designed for.**

| Template | When to use | Charter file | Optional context file |
|---|---|---|---|
| **`client-project/`** | Engagement delivered to an external client. The client owns success criteria. | `client-profile.md` | `marketing-context.md` (marketing-led engagements) |
| **`internal-product/`** | Product owned by the practice, with a buyer / audience being designed for (real or hypothetical). | `product-charter.md` | `domain-context.md` (regulated / specialized domains) |
| **`tool/`** | Utility built for own use, team use, or open-source release — no buyer being designed for. | `tool-charter.md` | `domain-context.md` (non-trivial ecosystem context) |

All three share the same `01-context/` → `02-deliverables/` → `03-assets/` → `04-research/` → `05-build/` skeleton, the same iterative-memory discipline (`state.md`, `activity-log.md`, `decisions-log.md`, `insights.md`), and the same set of slash commands. They differ in which charter file scaffolds the project and in vocabulary throughout.

**Why three rather than one?** A `client-project/` template forced onto an internal product (or a tool) ends up with awkward `client-profile.md` framing that has to be worked around in every session. Three templates with shared bones lets each type carry the framing that fits.

**Tools get the same rigor as products and engagements** — the structure isn't lighter. A pattern surfaced while building a tool often travels to client work or another internal product, and that knowledge transfer only happens if the project tracks its decisions and learnings as carefully as anything else.

## How It Works in 30 Seconds

1. Clone this repo. Edit `config.md` (or create `config.local.md`) to point at where you want your client / internal-product / tool folders created.
2. Run `/project-setup` in Claude Code (or describe the situation to Cowork/Chat). The command asks **which template type** (client / internal-product / tool), then scaffolds the right folder, populated with what you know, seeded with a `CLAUDE.md` that orients any future agent.
3. Work the project from any Claude surface. At the start of each session, the agent reads `CLAUDE.md`, `state.md`, the last few `activity-log.md` entries, and the open rows in `decisions-log.md`. As the work happens, it updates those files iteratively (not at session-end).
4. Months later, opening the folder from any surface, the agent knows exactly where things stand.

## Configure First

Before running anything, open `config.md` at the repo root and set four paths:

- `TEMPLATE_ROOT` — where this repo lives on the user's machine
- `CLIENTS_ROOT` — where new client project folders should get created
- `INTERNAL_ROOT` — where new internal-product folders should get created
- `TOOLS_ROOT` — where new tool folders should get created (often the same as `INTERNAL_ROOT`)

Every slash command and the `project-setup` skill reads `config.md` first (or `config.local.md` if it exists). If the relevant paths are wrong, nothing else works. The rest of this README refers to those as `$TEMPLATE_ROOT`, `$CLIENTS_ROOT`, `$INTERNAL_ROOT`, and `$TOOLS_ROOT`.

## What's Here

- **`config.md`** — `TEMPLATE_ROOT`, `CLIENTS_ROOT`, `INTERNAL_ROOT`, `TOOLS_ROOT`. Read first by every agent.
- **`config.local.md`** — Optional, gitignored. Holds your real paths and identity. Agents prefer this over `config.md` when present.
- **`templates/`** — The templates directory. Three subfolders: `client-project/`, `internal-product/`, `tool/`. Each is a standalone template with its own scaffolded files, `.claude/skills/project-setup/SKILL.md`, and slash commands.
- **`placeholder-map.md`** — Documents every `{{TOKEN}}` across all three templates, what it represents, and which template it belongs to. The source of truth for the fill process.

## Slash Commands

Four slash commands power this template system:

| Command | Where it lives | What it does |
|---|---|---|
| `/project-setup` | **Both** user-level (`~/.claude/commands/`) and project-level (`.claude/commands/`) | Asks which template type (client / internal-product / tool), then handles greenfield scaffold, retrofit of an existing folder, or reconcile after memory drift. |
| `/project-status` | Project-level only | Quick read on the current state — open decisions, recent activity, outstanding items. |
| `/log-decision` | Project-level only | Append a row to `01-context/decisions-log.md` (closed / open / outstanding). |
| `/log-activity` | Project-level only | Append a session entry to `01-context/activity-log.md`. |

The user-level `/project-setup` lives at `~/.claude/commands/project-setup.md`. Copy it there once per machine (see "First-time Setup" below). The project-level versions travel inside every new project automatically.

`/project-setup` is at both levels intentionally. User-level means it works when you're running Claude Code outside any project folder (the greenfield case, where the project folder doesn't exist yet). Project-level means it travels with every instantiated project, so retrofit and follow-up runs work from inside the folder.

The other three commands only make sense inside an already-set-up project, so they're project-level only — they ride along automatically when `/project-setup` creates a new folder.

## First-time Setup

One-time steps after cloning this repo:

1. Open `config.md` at the repo root and fill in `TEMPLATE_ROOT`, `CLIENTS_ROOT`, `INTERNAL_ROOT`, and `TOOLS_ROOT`. (Or create `config.local.md` with the same shape if you'd rather keep your real paths out of git.)
2. Install the user-level `/project-setup` command so it works from anywhere:

   ```bash
   mkdir -p ~/.claude/commands
   cp "$TEMPLATE_ROOT/templates/client-project/.claude/commands/project-setup.md" ~/.claude/commands/project-setup.md
   ```

   (The same command file is identical across all three templates — copy from any of them. The user-level file isn't committed to the repo; just copy the project-level version up. Both are designed to read `config.md` for paths.)

3. Confirm the destination directories exist. If not, create them: `mkdir -p "$CLIENTS_ROOT" "$INTERNAL_ROOT" "$TOOLS_ROOT"`.

## How to Start a New Project

### Option A: Use `/project-setup` (recommended)

From Claude Code, anywhere on your machine:

```
/project-setup
```

You'll be asked:
1. **Which template type** — client / internal-product / tool
2. **Mode** — new (greenfield) vs. retrofit vs. reconcile
3. **Slug, display name, and other prerequisites** specific to the chosen type

The command then calls the appropriate `project-setup` skill (each template has its own type-aware copy), which:

1. Copies the chosen template to the right destination — `$CLIENTS_ROOT/{slug}/`, `$INTERNAL_ROOT/{slug}/`, or `$TOOLS_ROOT/{slug}/`
2. Fills every `{{PLACEHOLDER}}` using the data you provide
3. Seeds the decisions log and activity log with realistic starting content
4. Initializes `state.md` so future sessions can resume cleanly
5. Shows you the result and flags anything left as a `TODO:` for you to finish

In Cowork or Claude.ai Chat, you can describe the situation in plain language — "set up a new internal product called compliance-saas" or "scaffold a tool folder for the GTM tracker" or "retrofit this folder to match the template" — and the same skill gets triggered.

### Option B: Manual fill

If the skill isn't available or you prefer to do it by hand:

```bash
# Pick the template that matches the project type
cp -R "$TEMPLATE_ROOT/templates/{client-project|internal-product|tool}" "$DESTINATION/{slug}"
find "$DESTINATION/{slug}" -name ".DS_Store" -delete
```

Then open `placeholder-map.md`, go file by file, and replace each `{{TOKEN}}` with real content. When done, search the folder for any remaining `{{` to confirm nothing was missed:

```bash
grep -rn "{{" "$DESTINATION/{slug}/" --include="*.md"
```

## How to Retrofit an Existing Project

If a project folder already exists — maybe it pre-dates the template, maybe the user created it manually, maybe it was scaffolded as a `client-project` but is actually an internal product — `/project-setup` handles it in retrofit mode:

```
/project-setup retrofit $INTERNAL_ROOT/legacy-product
```

The skill will:

1. Detect the project type from existing files (or ask if ambiguous)
2. Inventory what's in the folder vs. what the matching template provides
3. Show the user the plan before making any changes
4. Create missing files (state.md, activity log, subfolders, `.claude/` commands) from the template
5. Add missing sections to existing files (like Iterative Memory in `CLAUDE.md`) without overwriting the rest
6. Leave everything else alone
7. Append a retrofit entry to the activity log documenting exactly what was added

Rule of thumb: retrofit is **additive**, never destructive. If something would overwrite existing content, the skill stops and asks.

## How the Templates Work Across Claude Surfaces

The templates are designed so that the user can jump between Claude in a browser chat, Cowork on the desktop, and Claude Code in the terminal — and whichever surface they use next will know exactly where the previous one left off. This happens through five files in every project (regardless of template type):

1. **`CLAUDE.md`** — Read first by every Claude agent. It orients the agent on the project, the guardrails, and the voice. The agent's "who, what, why."
2. **`01-context/state.md`** — The live dashboard: what's happening *right now*, what's awaiting human decision, what external systems are in what state. Updated as work happens.
3. **`01-context/decisions-log.md`** — The ledger of closed decisions, open decisions, and outstanding external dependencies.
4. **`01-context/activity-log.md`** — The session handoff file. Each work session appends a short entry. Any agent starting a session scans recent entries to see what got done and what's queued.
5. **`01-context/insights.md`** — The working-memory scratchpad. Patterns, quirks, gotchas, half-formed observations.

Plus a sixth, optional, type-specific context file:
- `client-project/`: `01-context/marketing-context.md` (positioning, messaging, brand voice — for marketing-led engagements)
- `internal-product/`: `01-context/domain-context.md` (regulated / specialized domains, competitive landscape)
- `tool/`: `01-context/domain-context.md` (platform conventions, vendor-API gotchas, OSS-release context)

Together, these mean: **no Claude agent should ever need to re-ask the user for context that has already been established.**

## Maintaining the Templates

When you notice a pattern worth generalizing — something that would have saved time if every project folder had it — update the relevant template (or all three). Specifically:

- If a new file is useful, add it to the appropriate template(s) with appropriate `{{placeholders}}`
- If a new placeholder is introduced, document it in `placeholder-map.md` and note which template(s) it belongs to
- If the `project-setup` skill needs to handle something new, update the relevant `SKILL.md` (each template has its own copy — sync changes that apply to all three)
- If a new slash command would help, add it to each template's `.claude/commands/` (project-level, so it rides along in every instantiated project) or `~/.claude/commands/` (user-level)
- Bump the "Last updated" line in any file you touch

If you update `/project-setup` at one level (user or project), remember to sync the other and across all three templates — they're meant to be identical copies.

## Layout At a Glance

```
$TEMPLATE_ROOT/
├── README.md                           ← You are here
├── LICENSE                             ← MIT
├── CHANGELOG.md                        ← Version history
├── config.md                           ← Four ROOT paths (fill first)
├── config.local.md                     ← Optional, gitignored — personal paths + identity
├── placeholder-map.md                  ← Every {{TOKEN}} documented, by template
└── templates/                          ← All templates live here
    ├── client-project/                 ← Engagements delivered to a client
    │   ├── CLAUDE.md
    │   ├── README.md
    │   ├── .claude/
    │   │   ├── commands/{project-setup,project-status,log-decision,log-activity,checkpoint}.md
    │   │   ├── rules/iterative-memory.md
    │   │   └── skills/project-setup/SKILL.md   ← Client-specific procedure
    │   ├── .cursor/rules/iterative-memory.mdc
    │   ├── 01-context/
    │   │   ├── client-profile.md       ← Charter file (client-specific)
    │   │   ├── project-scope.md
    │   │   ├── decisions-log.md
    │   │   ├── activity-log.md
    │   │   ├── insights.md
    │   │   ├── state.md
    │   │   └── marketing-context.md    ← Optional, marketing-led only
    │   ├── 02-deliverables/
    │   ├── 03-assets/{copy,photos,brand}/
    │   ├── 04-research/competitors/
    │   └── 05-build/wireframes/
    ├── internal-product/               ← Products owned by the practice
    │   ├── (same shape as client-project, with these differences:)
    │   ├── 01-context/product-charter.md       ← Replaces client-profile.md
    │   ├── 01-context/domain-context.md        ← Replaces marketing-context.md (optional)
    │   ├── (project-scope.md uses funding/external-dependencies instead of investment/client-responsibilities)
    │   └── (CLAUDE.md, README.md, kickoff-notes.md, SKILL.md framed for internal products)
    └── tool/                           ← Utilities for own/team/public use
        ├── (same shape as client-project, with these differences:)
        ├── 01-context/tool-charter.md          ← Replaces client-profile.md
        ├── 01-context/domain-context.md        ← Replaces marketing-context.md (optional)
        ├── (project-scope.md uses resourcing/external-dependencies)
        └── (CLAUDE.md, README.md, kickoff-notes.md, SKILL.md framed for tools)
```

And at the user level:

```
~/.claude/commands/
└── project-setup.md                    ← Same command, asks for type, works from anywhere
```

## License

See `LICENSE` at the repo root. If no license is committed yet, treat this repo as source-available for personal reference only until a license is added.

---
*Built for anyone who juggles client engagements, internal products, and tools across Claude surfaces. Fork it, adapt the `CLAUDE.md` voice and guardrail sections to your own practice, and go.*
