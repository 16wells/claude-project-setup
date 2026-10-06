# Drive Index — {{CLIENT_NAME}}

> **Cold storage.** Everything {{CLIENT_NAME}}-related that isn't needed day to day lives in Google Drive, not in this folder. Read this file when you're looking for an old deck, export, or meeting note. Don't crawl Drive; go to the folder named here.

**Location (local Drive mount):**
`{{DRIVE_CLIENT_FOLDER}}`

**Rule:** anything that leaves this repo goes there, into the matching subfolder. Nothing from Drive gets copied back here unless it's being actively worked on.

## What's There (as of {{DRIVE_INDEX_DATE}})

| Subfolder | What it holds |
|---|---|
| `meeting-notes/` | Gemini / Fireflies / Granola notes and recordings |
| `exports/` | Raw data pulls (CRM, billing, analytics, crawls) |
| `archive/` | Superseded deliverables, old decks, prior-engagement material |

## Where New Things Land

- **Gemini meeting notes** auto-save to `My Drive/Meeting Notes/` and `My Drive/Google Meet/Meet Recordings/`, not here. Sweep client items into `meeting-notes/` quarterly.
- **Claude-generated decks/docs** saved to Drive land at the Drive root. Move them into the matching subfolder.

## Not in Drive

- **Second Brain** (Obsidian vault at `~/Sites/organization/second-brain/`) is a separate system. Nothing moves between the two.
- **Task tracker:** {{LINEAR_PROJECT_LINK}}
