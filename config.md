# Config — claude-project-setup

**Read first. Every slash command and the `project-setup` skill references this file.**

This repo needs to know two things to work on your machine:

1. Where this repo is cloned (**TEMPLATE_ROOT**)
2. Where your client project folders live on your machine (**CLIENTS_ROOT**)

Fill both below before running `/project-setup` or any of the other slash commands. If you move or rename either location later, update this file.

## Prefer `config.local.md` for personal info

If you want to keep your real paths and identity out of git (e.g. you're the maintainer pushing this repo publicly, or you share the repo with teammates who each have their own setup), create a **`config.local.md`** file at the repo root with the same structure as this file. That file is gitignored.

Agents read `config.local.md` first if it exists, and fall back to `config.md` otherwise. Keep `config.md` as the public-facing placeholder; keep your real values in `config.local.md`.

---

## TEMPLATE_ROOT

The absolute path to this repo on your machine. Everything else in the repo is addressed relative to this.

**Path:** *(replace the placeholder below with the actual absolute path on your machine)*

```
/REPLACE/WITH/ABSOLUTE/PATH/TO/claude-project-setup
```

*(Example: `/Users/yourname/code/claude-project-setup`. On Windows: `C:\code\claude-project-setup`.)*

**Derived paths (don't edit, agents compute these from TEMPLATE_ROOT):**

- Templates directory: `$TEMPLATE_ROOT/templates/`
- Default template folder: `$TEMPLATE_ROOT/templates/client-project/`
- Placeholder map: `$TEMPLATE_ROOT/placeholder-map.md`
- User-level slash command: `~/.claude/commands/project-setup.md` *(installed once, not in this repo)*

---

## CLIENTS_ROOT

The absolute path to the parent directory where you want new client project folders created. When you run `/project-setup` for a new client with slug `acme`, the project folder will be created at `$CLIENTS_ROOT/acme/`.

**Path:** *(replace the placeholder below with the actual absolute path on your machine)*

```
/REPLACE/WITH/ABSOLUTE/PATH/TO/your-clients-folder
```

*(Example: `/Users/yourname/work/clients`.)*

---

## How Agents Use This File

Any Claude agent (Cowork, Claude Code, Chat) running `/project-setup` or any of its companion commands should:

1. **Read this file first.** Extract `TEMPLATE_ROOT` and `CLIENTS_ROOT` from the code blocks above.
2. **Use those as the base for every path.** Do not hardcode `/Users/<anyone>/...` in your work.
3. **If either path is empty or obviously wrong**, stop and ask the user to fill this file before continuing.

The skill (`templates/client-project/.claude/skills/project-setup/SKILL.md`) and the slash commands (`templates/client-project/.claude/commands/*.md`, `~/.claude/commands/project-setup.md`) all reference `$TEMPLATE_ROOT` and `$CLIENTS_ROOT` — they don't embed your home directory. That's why this file has to be right.

---

## Quick Check

After cloning and editing this file, verify both paths exist:

```bash
ls "$(sed -n '/^## TEMPLATE_ROOT/,/^## CLIENTS_ROOT/p' config.md | grep -m1 '^/')/templates/client-project" >/dev/null && echo "TEMPLATE_ROOT ok"
ls "$(sed -n '/^## CLIENTS_ROOT/,/^---/p' config.md | grep -m1 '^/')" >/dev/null && echo "CLIENTS_ROOT ok"
```

Or just eyeball it — if the paths above point to real directories on your machine, you're done.
