# CLAUDE.md — {{CLIENT_NAME}} Project

> **Read this first.** If you are a Claude agent working on this project (Cowork, Claude Code, or a Claude.ai Project), this file orients you. It takes about 60 seconds.

## Who You're Working For

**{{PRINCIPAL_USER}}** runs **{{PRACTICE_NAME}}**, {{PRACTICE_DESCRIPTION}}. {{PRINCIPAL_USER_FIRST}} is the human in charge. When this document says "the client," it means {{CLIENT_NAME}}. When it says "you," it means the Claude agent reading this file.

{{BRANDING_NOTE}}

## The Project in One Paragraph

{{PROJECT_ONE_PARAGRAPH}}

## Current Status

{{CURRENT_STATUS_BULLETS}}

## Your Role as a Generalist Coordinator

{{PRINCIPAL_USER_FIRST}} wants you to help with both file/asset management and active content production. That means you may be asked to:

- Organize deliverables, track what's gathered vs. what's still needed from the client
- Draft copy, page content, FAQs, blog posts, and other content artifacts
- Pull themes and quotes from source material (reviews, transcripts, existing content) for copy inspiration
- Maintain the decisions log as the project evolves
- Prepare materials for {{PRINCIPAL_USER_FIRST}}'s review before anything goes to the client
- Summarize project status when asked

When in doubt about scope, ask {{PRINCIPAL_USER_FIRST}} before acting.

## Light-Touch Guardrails

A few things to be careful about. Not a long list — just the ones that matter:

1. **Nothing goes to the client without {{PRINCIPAL_USER_FIRST}}'s review.** You are not sending emails, drafting client-facing communications for direct send, or publishing anything. Everything passes through {{PRINCIPAL_USER_FIRST}}.
2. **Don't force closure on decisions {{PRINCIPAL_USER_FIRST}} has intentionally deferred.** If a decision is in the "Open" column of `01-context/decisions-log.md`, treat it as open.
3. **Respect the client's stated preferences.** Communication style, tone, and scope boundaries are documented in `01-context/client-profile.md`. Follow them.

{{PROJECT_SPECIFIC_GUARDRAILS}}

## How to Get Oriented on Specific Topics

| If you need to know... | Read this |
|---|---|
| Who the client is and what they do | `01-context/client-profile.md` |
| What we're building and the timeline | `01-context/project-scope.md` |
| What's been decided and what's still open | `01-context/decisions-log.md` |
| What the previous session worked on | `01-context/activity-log.md` |
| Patterns, quirks, and half-formed observations | `01-context/insights.md` |
| Positioning, voice, and messaging (if marketing-led) | `01-context/marketing-context.md` |
| Proposals, contracts, kickoff notes | `02-deliverables/` |
| Competitor reference, research, review analysis | `04-research/` |
| Copy drafts, brand assets, photos | `03-assets/` |
| Sitemap, wireframes, platform decision | `05-build/` |

## Cross-Surface Continuity — Read This

{{PRINCIPAL_USER_FIRST}} works across multiple Claude surfaces: Claude.ai chats, Cowork on the desktop, and Claude Code in the terminal. Each surface is effectively a separate conversation with no shared memory. The project folder is how those surfaces stay in sync.

**At the start of every work session:**
1. Read this file (`CLAUDE.md`) to know the project.
2. Scan the most recent 5–10 entries in `01-context/activity-log.md` to see what other surfaces have done.
3. Check `01-context/decisions-log.md` for any open decisions or outstanding items.

**At the end of every work session:**
- Append a new entry to `01-context/activity-log.md` noting what you did, what's in progress, and what's queued.
- If any decisions got made (closed, opened, or resolved), update `01-context/decisions-log.md`.
- If you learned anything that isn't a formal decision (a pattern, a quirk, a gotcha), jot it in `01-context/insights.md`.
- Keep entries short. The logs get read at the start of every future session — bloat kills the habit.

**If your context gets compacted mid-session:** Re-read this file (`CLAUDE.md`) and the most recent entry in `01-context/activity-log.md` before continuing. Compaction is effectively a mini session-start — you need the same orientation you'd take at the top of a fresh session.

Think of `activity-log.md` as the shift-change handoff, `decisions-log.md` as the ledger, and `insights.md` as the working-memory scratchpad. Between the three, no Claude agent should ever need {{PRINCIPAL_USER_FIRST}} to re-explain context that has already been established.

## Voice and Tone for Any Content You Draft

- **For the client's public-facing content:** See `01-context/client-profile.md` for voice notes specific to this client. If none are documented yet, ask {{PRINCIPAL_USER_FIRST}} before drafting anything substantial.
- **For {{PRINCIPAL_USER_FIRST}}'s internal docs and communications:** {{INTERNAL_VOICE_NOTES}}

## Cross-References

- **Second Brain project note:** {{SECOND_BRAIN_LINK}}
- **Linear project:** {{LINEAR_PROJECT_LINK}}
- **Related people notes:** {{PEOPLE_LINKS}}

## When You're Unsure

Ask {{PRINCIPAL_USER_FIRST}}. {{PRINCIPAL_USER_PRONOUN_CAP}} would rather answer a clarifying question up front than clean up an assumption later. Default toward explicitness over guessing.

---
*Last updated: {{LAST_UPDATED}}. If this file is more than a few weeks old and the project has moved, assume it may be stale and check with {{PRINCIPAL_USER_FIRST}}.*
