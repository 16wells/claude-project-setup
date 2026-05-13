# {{PROJECT_DISPLAY_NAME}} — Internal Product

**Type:** Internal product owned by {{PRACTICE_NAME}}
**Stage:** {{PRODUCT_STAGE}}
**Owner:** {{PRINCIPAL_USER}}
**Project start:** {{PROJECT_START}}
**Status:** {{PROJECT_STATUS}}

## Folder Guide

- **`CLAUDE.md`** — Orientation for any Claude agent (Cowork, Claude Code, Projects). Read this first if you're an AI assistant.
- **`01-context/`** — Product charter, project scope, decisions, state, insights, optional domain context.
- **`02-deliverables/`** — Specs, design docs, kickoff notes, ADRs.
- **`03-assets/`** — Brand assets, draft copy, screenshots, marketing material.
- **`04-research/`** — Competitor analysis, regulator docs, customer transcripts, market research.
- **`05-build/`** — Architecture, wireframes, infrastructure decisions.

## Key Project Files at a Glance

| File | What it is |
|---|---|
| `01-context/product-charter.md` | What this product is, who it's for, why we're building it, success/kill criteria |
| `01-context/project-scope.md` | What's being built, funding/resourcing, timeline, tech stack |
| `01-context/decisions-log.md` | Living doc of closed and open decisions — check this first |
| `01-context/activity-log.md` | Session-by-session handoff between Cowork, Claude Code, and Chat |
| `01-context/state.md` | What's happening *right now* — in-flight work, deployed state, awaiting decisions |
| `01-context/insights.md` | Running scratchpad of patterns, quirks, and learnings (some may travel to client work or other tools) |
| `01-context/domain-context.md` | Domain knowledge — market, competitors, regulations (optional; only present when domain context is non-trivial) |

{{KEY_DELIVERABLE_LINKS}}

## Slash Commands (Claude Code)

From inside this folder in Claude Code:

- `/project-status` — concise read on current state (open decisions, recent activity, outstanding items)
- `/log-decision [closed|open|outstanding] <description>` — append a row to `decisions-log.md`
- `/log-activity <short topic>` — append a session entry to `activity-log.md` at end of work session
- `/project-setup retrofit` — bring this folder up to the current template structure (additive, never destructive)

## For Future You

If you're opening this folder three months from now and forget where anything lives, start with `CLAUDE.md`. It's written for AI agents but doubles as a project summary for the human running the product.
