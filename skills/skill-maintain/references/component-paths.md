# Skill Maintain Component Paths

Load this when deciding which bundle component should receive the repair.

## Routing Position

- common upstream:
  - `reference-routing.md`
  - `repair-expansion.md`
- if the real question is specifically reference quality, jump to `reference-quality.md`
- if the real question is bundle-wide drift, jump to `bundle-consistency.md`
- if the owner is already clear and only the repair style is unclear, jump to `repair-patterns.md`

## Repair Path

- Repair `SKILL.md` when the failure is about first read:
  - trigger
  - kernel sentence
  - strongest thing
  - first move
  - dominant path
  - wrong-scope boundary
  - hard invariant
- Repair a `reference` when optional depth is vague, duplicated, mixed, or missing a clear load question.
- Repair a `format file` when a repeated artifact shape is drifting, ritualized, or no longer the smallest stable good shape.
- Repair a `script` when deterministic helper logic is stale, unmentioned, too broad, or doing policy work that belongs in prose.
- Repair an `asset` when a template or resource is stale, wrongly selected, or being pasted into context instead of used as a resource.
- Repair `bundle metadata` when naming, reachability, publishability, or entry-surface alignment has drifted across files.

## Kernel Necessity Check

Before keeping a non-core component, ask:

- if this component vanished, would the loss be kernel clarity, kernel stability, kernel verification, or only explanation comfort
- if it merged with its nearest neighbor, what exact confusion or collision would return
- if the answer is only explanation comfort, should this component survive the repair at all

## Escalation Clue

If one finding crosses three or more component types, stop and ask whether this is redesign rather than maintenance.

## Distinction

Use this file for one drift at a time.

Do not use this file to decide whether the bundle as a whole has drifted together. That is the job of `bundle-consistency.md`.

## Pressure Prompt

```text
Prompt: The main skill is fine, but one reference, one format file, and the metadata all drifted in different ways. Decide where each fix belongs.
Expected behavior: route each fix to one owner component instead of patching everything everywhere.
```
