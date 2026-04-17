# Activity Log — {{CLIENT_NAME}}

> **Cross-surface handoff file.** This is how a Claude agent in Cowork knows what a Claude agent in Chat (or Claude Code) already worked on, and vice versa. Every session appends one entry. Read the most recent 5–10 entries at the start of a work session before doing anything.

## How to Use This File

**At the start of a session** — scan the last few entries to see:
- What was the previous agent working on?
- What's in progress but not finished?
- Were any decisions logged that I should know about?
- Is anything queued up for me specifically?

**At the end of a session** — append a new entry with:
- Date (ISO format: `2026-04-17`)
- Surface (Cowork, Claude Code, Claude.ai Chat, or Claude.ai Project)
- What you did (brief — one or two sentences per item)
- What's in progress / partial
- What's queued for next session

**Keep entries short.** This file is read at the top of every session. If it gets bloated, it stops getting read. Aim for 5–10 lines per entry max. Details belong in the decisions log or the actual deliverable file.

**Do not duplicate the decisions log.** If a decision was made, log it in `decisions-log.md` and reference it here — don't restate it.

---

## Session Entries (newest first)

### {{LAST_UPDATED}} — Cowork — Project setup
- Scaffolded the project folder from `$TEMPLATE_ROOT/templates/client-project/`
- Filled placeholder tokens in `CLAUDE.md`, `README.md`, `01-context/*`
- **In progress:** _(nothing yet)_
- **Queued:** First working session

---

## Entry Template (copy this when adding a new entry)

```
### YYYY-MM-DD — [Surface] — [Short topic]
- [What you did — bullet per item, one sentence each]
- **In progress:** [Anything left partial — or "none"]
- **Queued:** [What the next session should pick up — or "none"]
```

---

## What Belongs Here vs. Elsewhere

| If it's... | Log it in... |
|---|---|
| A concrete decision (closed or open) | `decisions-log.md` |
| Something the client owes us | `decisions-log.md` → Outstanding From Client |
| Working state / what I did today | **This file** |
| A draft copy or asset | The actual file in `03-assets/` |
| Research findings | The appropriate file in `04-research/` |

If you're ever unsure, err toward logging it here briefly with a pointer to where the full artifact lives.
