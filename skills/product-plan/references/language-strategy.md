# Language Strategy

Use this when a project's public entry docs, internal working docs, templates, or visible labels may not all need the same language treatment.

## Principle

Choose language strategy explicitly. Do not let templates, examples, or old files decide it by accident.

## Default Rule

- Internal working docs should usually follow the primary maintainer language.
- Public entry docs may choose a different strategy if public reach matters more than internal convenience.
- Templates, handoffs, and visible labels should stay consistent with the owning document family.

## Common Pattern

For serious projects:

- `README.md` may be public-facing and use English or bilingual wording
- `DESIGN.md`, handoffs, phase docs, and project-visible templates should usually follow the maintainer's working language

## Anti-Patterns

- internal working docs drift between languages without intent
- public entry docs inherit internal-only language by accident
- templates hardcode a different language than the owning workflow
- visible labels mix languages inside one artifact family

## Repair Rule

If one project has both public and internal document surfaces:

1. decide which artifacts are public entry versus internal working docs
2. choose the default language for each family
3. normalize templates and visible labels to match those families
