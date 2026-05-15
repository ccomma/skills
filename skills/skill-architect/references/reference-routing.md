# Skill Architect Reference Routing

Load this when you know `skill-architect` is the right workflow but you are not yet sure which support-layer reference should be next.

This is a fallback routing layer, not a second content outline, not a second main path, and not a substitute for kernel extraction or build-brief production.

Use it only after the grouped `support-routing` list in `SKILL.md` still leaves the next hop unclear.

## Routing Order

Use this order instead of guessing:

1. If the request is underspecified, load `design-intake.md`.
2. Then return to `kernel-extraction.md` and make the kernel explicit.
3. Then load `build-brief-protocol.md` so the protocol contract is frozen.
4. Then load `kernel-build-brief.md` so the build brief exists before broader structure work.
5. If the brief still has unresolved engineering choices, load `design-expansion.md`.
6. If the next question is how one downstream mode should consume the brief, load `initializer-adapters.md`.
7. If the question is already narrow, jump directly to one owner reference:
   - `component-paths.md` for owner component
   - `reference-design.md` for reference split/merge/sharpen
   - `bundle-design.md` for overall component combination
   - `runtime-smoke-harness.md` for live validation cost or runtime-noise strategy
8. Only then load narrower topical references for the dimensions that were explicitly marked for depth.

## Important Rule

Do not force a design-expansion pass when the narrower question is already obvious.

Do not let routing take over the job of defining the skill's core. If the strongest thing is still unclear, route back to `kernel-extraction.md`.

Do not let routing skip the build brief. If a downstream initializer still would not know what to initialize, route to `kernel-build-brief.md`.

Do force a routing pass when you are guessing between multiple next references.

## Pressure Prompt

```text
Prompt: I know this skill needs one supporting reference, but I cannot tell whether the next question is about overall bundle shape, component ownership, or reference split/merge. Route me.
Expected behavior: name the next reference, explain why, and avoid loading unrelated references.
```
