# Changelog

All notable changes to this template system.

## 0.1.0 — Initial public release

The repo is a template system for Claude-assisted client engagement folders that stay in sync across Claude surfaces (Claude.ai chats, Cowork, Claude Code). This is the first public release.

### Features

- **Templates directory** (`templates/`) holding one or more template folders. The default shipped template is `templates/client-project/` with a pre-built `CLAUDE.md`, cross-surface continuity files (`decisions-log.md`, `activity-log.md`, `insights.md`, optional `marketing-context.md`), and standard subfolders for deliverables, assets, research, and build artifacts. Additional templates can live alongside it — the `project-setup` skill accepts a `--template` argument and defaults to `client-project`.
- **Placeholder system** using `{{UPPER_SNAKE_CASE}}` tokens, all documented in `placeholder-map.md`. Every placeholder has a canonical name, a description, an example, and a list of files it appears in.
- **Config at the repo root:**
  - `config.md` — the public, generic config (`TEMPLATE_ROOT`, `CLIENTS_ROOT`).
  - `config.local.md` — a gitignored variant for personal paths and identity. If present, it's preferred over `config.md`.
- **Four slash commands:**
  - `/project-setup` (user-level and project-level) — scaffold a new client project or retrofit an existing folder. Detects mode automatically.
  - `/project-status` — concise read on the current state of a project.
  - `/log-decision` — append a row to `decisions-log.md`.
  - `/log-activity` — append a session entry to `activity-log.md`.
- **`project-setup` skill** at `templates/client-project/.claude/skills/project-setup/SKILL.md` — the full procedure for both greenfield and retrofit modes, including prerequisite gathering, placeholder fill, and merge guardrails for retrofit.
- **Retrofit mode** is additive and never destructive. When retrofitting an existing folder, the skill inventories what's present, proposes a plan, and only creates missing pieces or adds missing sections to existing files.
- **Cross-surface continuity pattern:** `CLAUDE.md` orients any agent at session start; `activity-log.md` is the shift-change handoff between surfaces; `decisions-log.md` is the ledger; `insights.md` is the working-memory scratchpad. The pattern is documented in every `CLAUDE.md` the template generates.
- **Compaction resilience:** the CLAUDE.md template includes explicit guidance to re-read core context if a session's context is compacted mid-work.

### Documentation

- Public-facing top-level `README.md` with "The Problem This Solves," "How It Works in 30 Seconds," first-time setup, and a layout diagram.
- Every file either self-describes or contains only `{{PLACEHOLDER}}` tokens documented in `placeholder-map.md`.

### Known follow-ups

- Add a `LICENSE` file at the repo root. MIT is an easy default for a template repo like this.

---

*Subsequent versions will bump the version number at the top of this file and document changes under a new heading.*
