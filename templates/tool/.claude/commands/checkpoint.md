---
description: Full memory flush — refresh state.md, append to activity log, route any new decisions/insights, then commit and push
argument-hint: [optional: short topic for the activity-log entry]
---

The user just asked for a checkpoint. The trigger-based discipline isn't enough right now — they want a full pass. Run it cleanly.

## Step 1 — Refresh `01-context/state.md`

Update every section that has changed since the last write. In particular:
- **Active Sub-Project** — confirm the active slug; update if focus has shifted.
- **In-Progress Work** — what's the next concrete step right now? Which surface? Which file?
- **Awaiting Human Decision** — what's actually blocking? Restate the question and the options on the table.
- **Most Recent Commit** — pull the latest SHA and subject from git; note what it landed and what it intentionally didn't.
- **External Systems State** — for technical projects, refresh the deployed-services / cloud-resources / secrets / scheduled-jobs / production-data tables to reflect reality.
- **Open Risks / Known Mid-Recovery Items** — any half-done work that hasn't landed yet.
- **Resume Notes for the Next Agent** — one or two bullets, the shortest "do this next" possible.
- **Last updated** — ISO timestamp + which surface you're on.

Keep the file under ~200 lines. If something doesn't fit there, it belongs in `activity-log.md`, the decisions log, or a deliverable file — move it.

## Step 2 — Append to `01-context/activity-log.md`

One concise entry covering everything since the last activity-log entry. Format per the template at the top of that file. Keep it tight — this file gets read at session start.

## Step 3 — Route any new decisions or insights

- If anything settled or opened a new question that isn't yet in `01-context/decisions-log.md` → add it.
- If you noticed a pattern, gotcha, or quirk that isn't yet in `01-context/insights.md` → add it.
- Don't duplicate. If a decision is logged in decisions-log, just reference it from activity-log; don't restate it.

## Step 4 — Stage, commit, push

```bash
git add -A
git commit -m "checkpoint: <short topic>"
git push
```

Use the user-provided topic from `$ARGUMENTS` if given; otherwise summarize the activity-log entry in 6–10 words.

If the working tree is clean (nothing to commit), say so and skip the commit/push.

## Step 5 — Report back

One short message:
- What you wrote to which file
- The commit SHA and subject (or "nothing to commit")
- One line on the current state — "all live, awaiting X" or "mid-recovery on Y, next step is Z"

Arguments: $ARGUMENTS
