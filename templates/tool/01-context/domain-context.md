# Domain Context — {{PROJECT_DISPLAY_NAME}}

> **The external world this tool plugs into.** Platform conventions, ecosystem norms, related tools, vendor APIs, file formats, regulator constraints, anything outside the tool itself that shapes design and integration decisions. This file is **optional** — fill it when the tool sits in an ecosystem with non-obvious context worth capturing centrally. Skip it (delete the file) for self-contained tools with no meaningful external context.

## When to Use This File

Create and fill this file when:
- The tool integrates with a platform that has its own conventions and quirks (Shopify apps, GTM tags, Linear webhooks, etc.)
- There are file formats, protocols, or APIs whose details bite you repeatedly
- Adjacent tools or alternatives exist worth noting (so you remember why you didn't use them)
- The tool is meant for public release — domain context informs README, marketing, and positioning

If this file exists, treat it as the single source of truth for ecosystem knowledge. Future build sessions reference this rather than re-deriving from docs each time.

## How to Build It

- **From your own usage** — most of this exists in your head from working with the platform; this is where it gets externalized
- **From official docs** — link directly, with the gotcha you found near the link
- **From experience** — capture the things you wish someone had told you before you started

Update this file as new ecosystem insights surface during the build.

---

*Last updated: {{LAST_UPDATED}}*

## The Ecosystem

**Platform / ecosystem:** {{ECOSYSTEM_PLATFORM}}

**Integration surface:** {{ECOSYSTEM_INTEGRATION_SURFACE}}  *(API, plugin, webhook, file format, CLI extension, etc.)*

**Key conventions / norms:** {{ECOSYSTEM_CONVENTIONS}}

## Adjacent Tools / Alternatives

| Tool / approach | What it does | Why we didn't go this route |
|---|---|---|
| {{ECOSYSTEM_ALTERNATIVES_ROWS}} | | |

## Constraints to Respect

> External constraints the tool must work within. Rate limits, auth schemes, platform policies, regulator rules.

{{ECOSYSTEM_CONSTRAINTS}}

## Gotchas / Hard-Won Knowledge

> The "I wish I'd known this before I started" list. Capture these as you discover them — they're the most valuable thing in this file. Examples: "API field X is documented as optional but actually required when Y," "rate limit is 100/min but resets on a 90-second window not 60," etc.

{{ECOSYSTEM_GOTCHAS}}

## Glossary

| Term | Meaning |
|------|---------|
| {{ECOSYSTEM_GLOSSARY_ROWS}} | |

## Reference Links

> The handful of docs, blog posts, or repos you keep reaching for. Inline links beat a bookmark folder.

{{ECOSYSTEM_REFERENCES}}

---

## Cross-References

- **Tool charter (what this is, who uses it):** `tool-charter.md`
- **Project scope (what's being built and when):** `project-scope.md`
- **Source material (vendor docs, related tool research):** `04-research/`
