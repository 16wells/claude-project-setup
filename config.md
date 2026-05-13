# Config — claude-project-setup

**Read first. Every slash command and the `project-setup` skill references this file.**

This repo needs to know where things live on your machine:

1. Where this repo is cloned (**TEMPLATE_ROOT**)
2. Where your **client** project folders live (**CLIENTS_ROOT**)
3. Where your **internal product** folders live (**INTERNAL_ROOT**)
4. Where your **tool** folders live (**TOOLS_ROOT**) — often the same as `INTERNAL_ROOT`, but configurable separately

Fill all four below before running `/project-setup` or any of the other slash commands. If you move or rename any location later, update this file.

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
- Client template: `$TEMPLATE_ROOT/templates/client-project/`
- Internal-product template: `$TEMPLATE_ROOT/templates/internal-product/`
- Tool template: `$TEMPLATE_ROOT/templates/tool/`
- Placeholder map: `$TEMPLATE_ROOT/placeholder-map.md`
- User-level slash command: `~/.claude/commands/project-setup.md` *(installed once, not in this repo)*

---

## CLIENTS_ROOT

The absolute path to the parent directory where you want new **client** project folders created. When you run `/project-setup` for a new client engagement with slug `acme`, the project folder will be created at `$CLIENTS_ROOT/acme/`.

**Path:** *(replace the placeholder below with the actual absolute path on your machine)*

```
/REPLACE/WITH/ABSOLUTE/PATH/TO/your-clients-folder
```

*(Example: `/Users/yourname/work/clients`.)*

---

## INTERNAL_ROOT

The absolute path to the parent directory where you want new **internal product** folders created. Internal products are things you (or your practice) own — products with a buyer or audience being designed for, even hypothetical. When you run `/project-setup` for a new internal product with slug `compliance-saas`, the project folder will be created at `$INTERNAL_ROOT/compliance-saas/`.

**Path:** *(replace the placeholder below with the actual absolute path on your machine)*

```
/REPLACE/WITH/ABSOLUTE/PATH/TO/your-internal-products-folder
```

*(Example: `/Users/yourname/work/projects`.)*

---

## TOOLS_ROOT

The absolute path to the parent directory where you want new **tool** folders created. Tools are utilities for your own use, your team's use, or open-source release — no buyer being designed for. Often the same path as `INTERNAL_ROOT`, but configurable separately so you can split tools off into a dedicated location if you want.

**Path:** *(replace the placeholder below with the actual absolute path on your machine — fine to repeat `INTERNAL_ROOT` if you don't want to separate)*

```
/REPLACE/WITH/ABSOLUTE/PATH/TO/your-tools-folder
```

*(Example: `/Users/yourname/work/projects` — or a separate `/Users/yourname/work/tools` if you want them split.)*

---

## How Agents Use This File

Any Claude agent (Cowork, Claude Code, Chat) running `/project-setup` or any of its companion commands should:

1. **Read this file first** (or `config.local.md` if it exists). Extract `TEMPLATE_ROOT`, `CLIENTS_ROOT`, `INTERNAL_ROOT`, and `TOOLS_ROOT` from the code blocks above.
2. **Use those as the base for every path.** Do not hardcode `/Users/<anyone>/...` in your work.
3. **If any required path is empty or obviously wrong**, stop and ask the user to fill this file before continuing.
4. **Pick the right root for the project type** — clients go to `$CLIENTS_ROOT`, internal products to `$INTERNAL_ROOT`, tools to `$TOOLS_ROOT`. The user can override at setup time.

The skills (in each template's `.claude/skills/project-setup/SKILL.md`) and the slash commands (in each template's `.claude/commands/`, plus the user-level `~/.claude/commands/project-setup.md`) all reference these variables — they don't embed your home directory. That's why this file has to be right.

---

## Quick Check

After cloning and editing this file, verify the paths exist:

```bash
ls "$(sed -n '/^## TEMPLATE_ROOT/,/^## CLIENTS_ROOT/p' config.md | grep -m1 '^/')/templates/client-project" >/dev/null && echo "TEMPLATE_ROOT ok"
ls "$(sed -n '/^## CLIENTS_ROOT/,/^---/p' config.md | grep -m1 '^/')" >/dev/null && echo "CLIENTS_ROOT ok"
ls "$(sed -n '/^## INTERNAL_ROOT/,/^---/p' config.md | grep -m1 '^/')" >/dev/null && echo "INTERNAL_ROOT ok"
ls "$(sed -n '/^## TOOLS_ROOT/,/^---/p' config.md | grep -m1 '^/')" >/dev/null && echo "TOOLS_ROOT ok"
```

Or just eyeball it — if the paths above point to real directories on your machine, you're done.
