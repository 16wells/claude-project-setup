# Local Config — PERSONAL, NOT COMMITTED

**This file is gitignored.** It holds your actual paths and identity so the repo stays generic in public and personalized on your machine.

Agents read this file **first**. If it exists, use it and ignore `config.md`. If it doesn't exist, fall back to `config.md`.

---

## TEMPLATE_ROOT

```
{{TEMPLATE_ROOT}}
```

## CLIENTS_ROOT

```
{{CLIENTS_ROOT}}
```

## INTERNAL_ROOT

```
{{INTERNAL_ROOT}}
```

## TOOLS_ROOT

```
{{TOOLS_ROOT}}
```

---

## Principal User Identity (optional — fill in if you want personalized defaults)

When scaffolding a new project, these values become defaults for the corresponding CLAUDE.md placeholders. Leave the `TODO:` text if you'd rather be prompted per-project.

| Placeholder | Value |
|---|---|
| `{{PRINCIPAL_USER}}` | TODO: your full name |
| `{{PRINCIPAL_USER_FIRST}}` | TODO: first name |
| `{{PRINCIPAL_USER_PRONOUN_CAP}}` | TODO: They / He / She |
| `{{PRACTICE_NAME}}` | TODO: your practice or company name |
| `{{PRACTICE_DESCRIPTION}}` | TODO: one-line description of what you do |
| `{{COMPANY_NAME}}` | TODO: same as PRACTICE_NAME unless different legal entity |
| `{{BRANDING_NOTE}}` | TODO: any brand-naming guardrails (capitalization, never call it X, etc.) |
| `{{INTERNAL_VOICE_NOTES}}` | TODO: tone, forbidden words, references — anything that shapes Claude's voice for this practice |

---

*If you share this repo with a teammate, they should run `bin/setup.sh` to create their own `config.local.md` — never commit yours.*
