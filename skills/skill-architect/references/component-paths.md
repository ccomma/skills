# Skill Architect Component Paths

Load this when deciding where one piece of guidance should live inside a skill bundle.

## Routing Position

- common upstream:
  - `reference-routing.md`
  - `design-expansion.md`
- if the real question is whether a reference should exist or split, jump to `reference-design.md`
- if the real question is bundle-wide alignment, jump to `bundle-design.md`

## Distinction

Use this file for one piece of guidance at a time.

Do not use this file to choose the whole bundle shape. That is the job of `bundle-design.md`.

## Component Path

- Keep it in `SKILL.md` when a weaker model must see it on first read:
  - trigger
  - first move
  - dominant path
  - wrong-scope boundary
  - hard invariant
  - explicit routing to conditional components
- Put it in a `reference` when it is conditional depth:
  - examples
  - variants
  - longer checklists
  - edge handling
  - deeper explanation
  - topic-specific policy
- Put it in a `format file` when the skill repeatedly creates or updates one artifact shape and quality depends on stable structure.
- Put it in a `script` when the work is deterministic, repeated, or fragile to re-describe each time.
- Put it in an `asset` when the output shape is best carried by a real template, starter file, media resource, or boilerplate.
- Put it in `bundle metadata` when the issue is naming, publishability, installability, reachability, or entry-surface alignment across files.

## Anti-Patterns

- keeping first-read behavior in a reference
- creating a reference only because similar skills have one
- splitting one load question across two references
- using a script for policy judgment that belongs in prose
- creating a format file for a shape that the skill rarely emits
- loading assets as long context when they should stay external resources

## Pressure Prompt

```text
Prompt: This bundle repeats the same rule in SKILL.md, a reference, and a format file. Decide where that rule really belongs.
Expected behavior: name one owner component and cut the redundant copies.
```
