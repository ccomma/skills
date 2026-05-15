# Skill Architect Reference Design

Load this when deciding whether a reference should exist, what single job it should own, or whether two references should merge or split.

## Routing Position

- common upstream:
  - `reference-routing.md`
  - `design-expansion.md`
- if the real question is owner component, jump to `component-paths.md`
- if the real question is bundle-wide alignment, jump to `bundle-design.md`

## Design Rule

A reference is worth keeping only when it makes the main entry surface sharper.

It must also survive three challenges:

- **delete challenge**: what exact hot-path burden comes back if this file disappears
- **merge challenge**: what exact load-question collision appears if this file merges with its nearest neighbor
- **cost challenge**: what token, read, maintenance, or drift cost this file adds, and why that cost is worth paying

## Opening Contract

Near the top, the file should answer both:

- when should this file be loaded
- what single job does this file do

Its title, opening, and body should all point at that same load question.

If a weaker model must browse the directory or read half the file before those answers are clear, the file is too vague.

## Keep Or Cut

Keep a reference only when it removes one clear hot-path burden such as:

- optional detail
- bulky examples
- pattern menus
- deterministic helper instructions
- artifact-shape guidance

If the file only repeats the main path, keep the guidance in `SKILL.md` instead.

## Merge Or Split

Merge references when they:

- answer the same load question
- guide the same decision
- would usually be loaded together

Split references when one file forces unrelated loading, such as:

- design versus repair
- examples versus policy
- artifact shape versus bundle alignment
- low-risk variants versus high-risk edge handling

## Anti-Patterns

Watch for these failures:

- a file that exists only because similar skills often have one
- a file whose title is specific but whose body does several unrelated jobs
- a file that starts with background explanation instead of load condition plus job
- two files that both feel like "misc patterns"
- a file that is only a storage bin for overflow text
- a file that cannot defend itself against the delete challenge, merge challenge, and cost challenge

## Pressure Prompt

```text
Prompt: This skill has four references, but two of them both explain when to load examples and policy variants. Redesign the reference layout.
Expected behavior: name which files should merge, which should stay separate, and what load question each surviving file owns.
```
