# State — {{PROJECT_DISPLAY_NAME}}

> **What is happening right now.** This file is the single source of truth for the project's *in-flight* reality. A fresh agent reading just `CLAUDE.md` + this file should be able to pick up where the last session left off, without consulting any chat history.
>
> Keep this file lean — **~200 lines max.** When detail ages out, move it to `activity-log.md` (chronology) or to the relevant deliverable file. This file is not a second activity log.

---

## Active Sub-Project

**Sub-project:** {{ACTIVE_SUBPROJECT_SLUG}}
**Folder:** `02-deliverables/{{ACTIVE_SUBPROJECT_SLUG}}/`
**Per-sub-project state file:** `02-deliverables/{{ACTIVE_SUBPROJECT_SLUG}}/state.md` *(if multiple sub-projects exist on this engagement, each has its own; this top-level file is the meta-pointer)*

{{INITIAL_STATE_NOTE}}

---

## In-Progress Work

> What is actively being worked on right now — the next concrete action, the surface it's happening on, and the step within that work.

- **Focus:**
- **Surface:** *(Cowork / Claude Code / Cursor / Claude.ai chat)*
- **Step:**
- **Last touched file(s):**

---

## Awaiting Human Decision

> Open questions blocking forward motion. Each item should state the question and the explicit options on the table — not "we need to discuss X" but "X: option A is …, option B is …, leaning toward A because …."

| Opened | Question | Options on the table | Leaning |
|---|---|---|---|
| | | | |

If nothing is awaiting a decision, write "None — agent is unblocked."

---

## Most Recent Commit

- **SHA:**
- **Subject:**
- **What it landed:**
- **What it intentionally did NOT land:** *(scope cuts, deferred work, known-broken corners — call them out so the next reader doesn't think they were missed)*

---

## External Systems State

> For technical projects, an inventory of real-world resources the project has touched. The file system alone won't show you what's live in AWS, what's stored in Secrets Manager, or whether the cron is currently scheduled. This section bridges that gap.
>
> If the project is purely advisory (strategy, copy, audits) and touches no external systems, write "None — engagement is advisory."

{{EXTERNAL_SYSTEMS_INVENTORY_HINTS}}

### Deployed Services
| Service | Environment | Identifier | Status | Notes |
|---|---|---|---|---|
| | | | | |

### Cloud Resources
| Resource | Provider | Identifier (ARN / ID / name) | Region | Notes |
|---|---|---|---|---|
| | | | | |

### Third-Party API State
| API | Account / tenant | What's configured | Notes |
|---|---|---|---|
| | | | |

### Secrets / Environment Variables
| Name | Where stored | Purpose | Last rotated |
|---|---|---|---|
| | | | |

### Scheduled / Recurring Jobs
| Job | Cadence | Mode (live / dry-run / paused) | Last run | Next run |
|---|---|---|---|---|
| | | | | |

### Production Data State
> If the project mutates real data, what state is it in? Any in-flight regression, partial recovery, or known divergence between source and target.

---

## Open Risks / Known Mid-Recovery Items

> Things that are explicitly half-done. The "I bumped into this and it's not fixed yet" list. Resolve and remove items as they get cleaned up.

- *(none / list)*

---

## Resume Notes for the Next Agent

> The shortest possible "do this next" message — what the next session should do first. One or two bullets. If it's longer than that, the active work is in `02-deliverables/{slug}/`, the chronology is in `activity-log.md`, and this section just points there.

---

*Last updated: {{LAST_UPDATED}} by {{LAST_UPDATED_SURFACE}}*
