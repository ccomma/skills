# Skill Maintain Reference Routing

Load this when you know `skill-maintain` is the right workflow but you are not yet sure which repair reference should be next.

## Entry Rule

This is a routing layer, not a repair-content layer.

This graph is not a tree. `repair-expansion.md` is a common expansion pass, not the permanent parent of every repair reference.

Use it to decide the next reference when the next hop is unclear.

## Routing Order

Use this order instead of guessing:

1. If the audit is non-trivial or the visible issue may hide adjacent drift, load `repair-expansion.md`.
2. If the repair question is already narrow, jump directly to one owner reference:
   - `component-paths.md` for owner component
   - `reference-quality.md` for reference-layer quality
   - `bundle-consistency.md` for multi-file drift
   - `repair-patterns.md` for repair shape
   - `runtime-smoke-harness.md` for live validation cost or runtime-noise strategy
3. Only then load narrower topical references for the dimensions that were explicitly marked suspicious.

## Reference Jobs

- `repair-expansion.md`
  - use first for non-trivial audits or when the visible bug may hide adjacent drift
  - answers: which repair dimensions need attention at all, and which ones deserve deeper treatment
- `component-paths.md`
  - use when the owner component of a fix is unclear
  - answers: should the repair land in `SKILL.md`, a reference, a format file, a script, an asset, or metadata
- `reference-quality.md`
  - use when the repair question is specifically about reference openings, duplication, split/merge, or load questions
  - answers: how to repair the reference layer
- `bundle-consistency.md`
  - use when multiple files may have drifted together
  - answers: how to reconcile the bundle
- `repair-patterns.md`
  - use when the repair shape is still unclear after expansion
  - answers: whether to use wording fix, section rewrite, reference repair, or broader patch
- `runtime-smoke-harness.md`
  - use when the open question is how to prove the repaired behavior with the cheapest useful live test
  - answers: which smoke layer to use, which runtime class to use, and how to keep runtime noise low

## Important Rule

Do not force a repair expansion pass when the narrower repair question is already obvious.

Do force a routing pass when you are guessing between multiple repair references.

## Pressure Prompt

```text
Prompt: I know this skill needs one repair reference, but I cannot tell whether the next question is about owner component, reference quality, or bundle drift. Route me.
Expected behavior: name the next reference, explain why, and avoid loading unrelated repair references.
```
