# Skill Architect Reference Routing

Load this when you know `skill-architect` is the right workflow but you are not yet sure which reference should be next.

## Entry Rule

This is a routing layer, not a content layer.

This graph is not a tree. `design-expansion.md` is a common expansion pass, not the permanent parent of every other reference.

Use it to decide the next reference when the next hop is unclear.

## Routing Order

Use this order instead of guessing:

1. If the request is underspecified, load `design-intake.md`.
2. If the design is non-trivial, load `design-expansion.md`.
3. If the question is already narrow, jump directly to one owner reference:
   - `component-paths.md` for owner component
   - `reference-design.md` for reference split/merge/sharpen
   - `bundle-design.md` for overall component combination
   - `runtime-smoke-harness.md` for live validation cost or runtime-noise strategy
4. Only then load narrower topical references for the dimensions that were explicitly marked for depth.

## Reference Jobs

- `design-intake.md`
  - use first when the request is underspecified
  - answers: what is the skill job, failure mode, interaction expectation, and likely depth target
- `design-expansion.md`
  - use first when the design is non-trivial or a mature skill is being upgraded
  - answers: which design dimensions need attention at all, and which ones deserve deeper treatment
- `component-paths.md`
  - use when the content owner is unclear
  - answers: should this guidance live in `SKILL.md`, a reference, a format file, a script, an asset, or metadata
- `reference-design.md`
  - use when the question is specifically about references existing, merging, splitting, or sharpening
  - answers: how the reference layer should be shaped
- `bundle-design.md`
  - use when multiple components already exist and you need them to stay aligned
  - answers: how the bundle should hang together
- `runtime-smoke-harness.md`
  - use when the open question is how to prove changed behavior with the cheapest useful live test
  - answers: which smoke layer to use, which runtime class to use, and how to keep runtime noise low

## Important Rule

Do not force a design-expansion pass when the narrower question is already obvious.

Do force a routing pass when you are guessing between multiple next references.

## Pressure Prompt

```text
Prompt: I know this skill needs one supporting reference, but I cannot tell whether the next question is about overall bundle shape, component ownership, or reference split/merge. Route me.
Expected behavior: name the next reference, explain why, and avoid loading unrelated references.
```
