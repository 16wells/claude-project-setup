---
description: Add a new decision to the decisions log
argument-hint: [closed|open|outstanding] <description of the decision>
---

Add a new row to `01-context/decisions-log.md`. The argument tells you which section:

- **closed** → append to the Closed Decisions table with today's date, the decision, and a one-line rationale
- **open** → append to the Open Decisions table with today's date, the decision, and notes on why it's open
- **outstanding** → append to the Outstanding From Client table with the item, ⏳ Pending status, and notes

If the argument doesn't specify which section, ask the user before writing.

After adding the row, update the Change Log at the bottom of the file with today's date and a one-line description of what changed.

Also append a brief note to `01-context/activity-log.md` referencing the decision so the activity log stays in sync.

Arguments: $ARGUMENTS
