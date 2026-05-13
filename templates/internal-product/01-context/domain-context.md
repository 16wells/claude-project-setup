# Domain Context — {{PROJECT_DISPLAY_NAME}}

> **The external world this product touches.** Markets, regulations, competitors, conventions, prior art, anything outside the product itself that shapes design and positioning decisions. This file is **optional** — fill it when the product sits in a domain with non-obvious context worth capturing centrally. Skip it (delete the file) for pure-tooling internal products that have no meaningful external context.

## When to Use This File

Create and fill this file when:
- The product operates in a regulated or specialized domain (compliance, finance, healthcare, etc.)
- There's significant competitive landscape worth documenting
- Industry conventions, jargon, or norms affect product decisions
- You want positioning, messaging, and competitive notes in one place rather than re-derived per session

If this file exists, treat it as the single source of truth for domain knowledge. Other work (positioning, copy, market research) should reference it rather than rebuilding from scratch.

## How to Build It

- **From the product owner's experience** — most of this exists in your head; this is where it gets externalized
- **From research already done** — proposals, competitive scans, regulator docs, customer conversations
- **From public sources** — competitor sites, industry publications, regulator publications, review platforms
- **Never invent.** If a section is empty after a real look, leave a `TODO:` note. Half-filled is more useful than fabricated.

Update this file as new domain insights surface during the build.

---

*Last updated: {{LAST_UPDATED}}*

## The Domain

**Domain / category:** {{DOMAIN_CATEGORY}}

**Why this domain:** {{DOMAIN_WHY}}

**Key external constraints (regulatory, technical, cultural):** {{DOMAIN_CONSTRAINTS}}

## Target Buyers / Users

- **Who's in the market:** {{DOMAIN_BUYERS}}
- **Decision-makers / influencers:** {{DOMAIN_DECISION_MAKERS}}
- **Primary use case:** {{DOMAIN_PRIMARY_USE_CASE}}
- **Jobs to be done:**
  - {{DOMAIN_JTBD}}

## Personas

| Persona | Cares about | Challenge | Value we promise |
|---------|-------------|-----------|------------------|
| {{DOMAIN_PERSONA_ROWS}} | | | |

## Problems & Pain Points

- **Core problem this product addresses:** {{DOMAIN_CORE_PROBLEM}}
- **Why current alternatives fall short:**
  - {{DOMAIN_ALT_FAILURES}}
- **What the problem costs the buyer:** {{DOMAIN_COST}}
- **Emotional dimension:** {{DOMAIN_EMOTIONAL_TENSION}}

## Competitive Landscape

- **Direct:** {{DOMAIN_DIRECT_COMPETITOR}} — falls short because {{DOMAIN_DIRECT_WHY}}
- **Secondary:** {{DOMAIN_SECONDARY_COMPETITOR}} — falls short because {{DOMAIN_SECONDARY_WHY}}
- **Indirect / status quo:** {{DOMAIN_INDIRECT_ALTERNATIVE}} — falls short because {{DOMAIN_INDIRECT_WHY}}

## Differentiation

- **Key differentiators:**
  - {{DOMAIN_DIFFERENTIATORS}}
- **How we do it differently:** {{DOMAIN_HOW_DIFFERENT}}
- **Why that's better:** {{DOMAIN_WHY_BETTER}}

## Objections

| Objection | Response |
|-----------|----------|
| {{DOMAIN_OBJECTION_ROWS}} | |

## Switching Dynamics

- **Push (what makes them leave current solution):** {{DOMAIN_PUSH}}
- **Pull (what draws them to us):** {{DOMAIN_PULL}}
- **Habit (what keeps them where they are):** {{DOMAIN_HABIT}}
- **Anxiety (what makes them hesitate to switch):** {{DOMAIN_ANXIETY}}

## Customer Language

- **How they describe the problem:**
  - "{{DOMAIN_PROBLEM_VERBATIM}}"
- **Words to use:** {{DOMAIN_USE_WORDS}}
- **Words to avoid:** {{DOMAIN_AVOID_WORDS}}
- **Glossary:**

| Term | Meaning |
|------|---------|
| {{DOMAIN_GLOSSARY_ROWS}} | |

## Brand Voice (for product marketing)

- **Tone:** {{DOMAIN_TONE}}
- **Style:** {{DOMAIN_STYLE}}
- **Personality:** {{DOMAIN_PERSONALITY}}

## Proof Points to Build Toward

- **Metrics we'd want:** {{DOMAIN_METRICS_TARGETS}}
- **Reference customers we'd want:** {{DOMAIN_REFERENCE_TARGETS}}
- **Testimonials we'd want:** {{DOMAIN_TESTIMONIAL_TARGETS}}

---

## Cross-References

- **Product charter (what this is, who it's for):** `product-charter.md`
- **Project scope (what's being built and when):** `project-scope.md`
- **Source material (competitor research, regulator docs, customer transcripts):** `04-research/`
