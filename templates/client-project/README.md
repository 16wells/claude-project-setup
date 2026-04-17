# {{CLIENT_NAME}} — {{PROJECT_NAME}}

**Client:** {{CLIENT_LEGAL_NAME}}
**Principal contact:** {{PRINCIPAL_CONTACT}}
**Company:** {{COMPANY_NAME}}
**Project start:** {{PROJECT_START}}
**Status:** {{PROJECT_STATUS}}

## Folder Guide

- **`CLAUDE.md`** — Orientation for any Claude agent (Cowork, Claude Code, Projects). Read this first if you're an AI assistant.
- **`01-context/`** — Client profile, project scope, and running decisions log.
- **`02-deliverables/`** — Final, client-facing documents: proposal, analyses, kickoff notes, contracts.
- **`03-assets/`** — Copy drafts, photos, brand materials (gathered as project progresses).
- **`04-research/`** — Competitor analysis, review theme extraction, SEO keyword work, market research.
- **`05-build/`** — Sitemap, wireframes, and platform decision record. Populated during design/build phase.

## Key Project Files at a Glance

| File | What it is |
|---|---|
| `01-context/client-profile.md` | Who the client is, their market, their voice |
| `01-context/project-scope.md` | What we're building, pricing/tiers, timeline |
| `01-context/decisions-log.md` | Living doc of closed and open decisions — check this first |
| `01-context/activity-log.md` | Session-by-session handoff between Cowork, Claude Code, and Chat |
| `01-context/insights.md` | Running scratchpad of patterns, quirks, and half-formed observations |
| `01-context/marketing-context.md` | Positioning and messaging (only present on marketing-led engagements) |

{{KEY_DELIVERABLE_LINKS}}

## Slash Commands (Claude Code)

From inside this folder in Claude Code:

- `/project-status` — concise read on current state (open decisions, recent activity, outstanding items)
- `/log-decision [closed|open|outstanding] <description>` — append a row to `decisions-log.md`
- `/log-activity <short topic>` — append a session entry to `activity-log.md` at end of work session
- `/project-setup retrofit` — bring this folder up to the current template structure (additive, never destructive)

## For Future You

If you're opening this folder three months from now and forget where anything lives, start with `CLAUDE.md`. It's written for AI agents but doubles as a project summary for the human running the engagement.
