# Skill Maintain Reference Routing

Load this when you know `skill-maintain` is the right workflow but you are not yet sure which repair reference should be next.

This is a fallback routing layer, not a second repair-content outline.

Use it only after the grouped `support-routing` list in `SKILL.md` still leaves the next hop unclear.

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

## Important Rule

Do not force a repair expansion pass when the narrower repair question is already obvious.

Do force a routing pass when you are guessing between multiple repair references.

## Pressure Prompt

```text
Prompt: I know this skill needs one repair reference, but I cannot tell whether the next question is about owner component, reference quality, or bundle drift. Route me.
Expected behavior: name the next reference, explain why, and avoid loading unrelated repair references.
```
