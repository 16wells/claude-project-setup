# {{PROJECT_DISPLAY_NAME}} — Tool

> **About this README.** This is the project-memory README, scaffolded for AI agents and future-you. The actual user-facing README for the tool itself (installation, usage, examples) is the primary doc — it should grow into the substantive entry point. This file orients the project context.

**Type:** Tool built by {{PRACTICE_NAME}}
**Stage:** {{TOOL_STAGE}}
**Owner:** {{PRINCIPAL_USER}}
**Project start:** {{PROJECT_START}}
**Status:** {{PROJECT_STATUS}}

## Folder Guide

- **`CLAUDE.md`** — Orientation for any Claude agent (Cowork, Claude Code, Projects). Read this first if you're an AI assistant.
- **`01-context/`** — Tool charter, project scope, decisions, state, insights, optional ecosystem context.
- **`02-deliverables/`** — Specs, design docs, kickoff notes, ADRs.
- **`03-assets/`** — Brand assets, screenshots, draft docs, marketing material.
- **`04-research/`** — Vendor docs, related-tool analysis, platform research.
- **`05-build/`** — Architecture, infrastructure decisions, deployment notes.

## Key Project Files at a Glance

| File | What it is |
|---|---|
| `01-context/tool-charter.md` | What this tool is, who uses it, why it exists, scope boundaries, success/sunset criteria |
| `01-context/project-scope.md` | What's being built, resourcing, timeline, tech stack |
| `01-context/decisions-log.md` | Living doc of closed and open decisions — check this first |
| `01-context/activity-log.md` | Session-by-session handoff between Cowork, Claude Code, and Chat |
| `01-context/state.md` | What's happening *right now* — in-flight work, deployed state, awaiting decisions |
| `01-context/insights.md` | Running scratchpad of patterns, quirks, and learnings (some may travel to client work or other tools) |
| `01-context/domain-context.md` | Ecosystem knowledge — platform conventions, vendor APIs, gotchas (optional; only present when ecosystem context is non-trivial) |

{{KEY_DELIVERABLE_LINKS}}

## Slash Commands (Claude Code)

From inside this folder in Claude Code:

- `/project-status` — concise read on current state (open decisions, recent activity, outstanding items)
- `/log-decision [closed|open|outstanding] <description>` — append a row to `decisions-log.md`
- `/log-activity <short topic>` — append a session entry to `activity-log.md` at end of work session
- `/project-setup retrofit` — bring this folder up to the current template structure (additive, never destructive)

## For Future You

If you're opening this folder three months from now and forget where anything lives, start with `CLAUDE.md`. It's written for AI agents but doubles as a project summary for the human maintaining the tool.
