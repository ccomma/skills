# Skill Architect Reference Routing

Load this when you know `skill-architect` is the right workflow but you are not yet sure which reference should be next.

This is a fallback routing layer, not a second content outline and not a substitute for kernel extraction.

Use it only after the grouped `support-routing` list in `SKILL.md` still leaves the next hop unclear.

## Routing Order

Use this order instead of guessing:

1. If the request is underspecified, load `design-intake.md`.
2. Then return to `kernel-extraction.md` and make the kernel explicit.
3. If the kernel is already explicit but the design is still non-trivial, load `design-expansion.md`.
4. If the question is already narrow, jump directly to one owner reference:
   - `component-paths.md` for owner component
   - `reference-design.md` for reference split/merge/sharpen
   - `bundle-design.md` for overall component combination
   - `runtime-smoke-harness.md` for live validation cost or runtime-noise strategy
5. Only then load narrower topical references for the dimensions that were explicitly marked for depth.

## Important Rule

Do not force a design-expansion pass when the narrower question is already obvious.

Do not let routing take over the job of defining the skill's core. If the strongest thing is still unclear, route back to `kernel-extraction.md`.

Do force a routing pass when you are guessing between multiple next references.

## Pressure Prompt

```text
Prompt: I know this skill needs one supporting reference, but I cannot tell whether the next question is about overall bundle shape, component ownership, or reference split/merge. Route me.
Expected behavior: name the next reference, explain why, and avoid loading unrelated references.
```
