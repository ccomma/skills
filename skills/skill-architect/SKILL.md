---
name: skill-architect
description: "Use when one skill's boundary is already clear and you need to lock its kernel, turn it into an initializer-neutral build brief protocol, and only then decide the lightest structure, validation starter, and downstream handoff."
---

# Skill Architect

Lock one skill's kernel and turn it into an initializer-neutral build brief before structural design.

Use this when the boundary is already clear and the remaining question is: what does this skill exist to do, when should it trigger, what should it do first, what is it strongest at, what is the wrong-scope boundary, and what is the lightest build brief any downstream initializer should follow.

Do not use this as the generic skill-creation workflow.

Do not use this to repair one existing skill whose role should stay stable.

<main-path>

1. Lock the kernel first:
   - produce these five outputs before structural design:
     - `kernel sentence`
     - `trigger boundary`
     - `first move`
     - `strongest thing`
     - `not-this-skill-if...`
   - if the request is too fuzzy to fill those five lines honestly, load `references/design-intake.md` only long enough to gather the missing inputs, then return to `references/kernel-extraction.md`
   - do not start from sections, references, scripts, or bundle shape while the kernel is still implicit

2. Produce the build brief before bundle discussion:
   - once the kernel is explicit, load `references/build-brief-protocol.md` and lock the protocol contract
   - then load `references/kernel-build-brief.md` and render the build brief
   - the build brief is the default explicit output of this workflow
   - include:
     - the five kernel lines
     - `minimal shape`
     - `component decisions`
     - `do-not-add`
     - `validation starter`
     - `initializer handoff`
   - if any brief field still needs real design judgment, use `references/design-expansion.md` only to complete the brief, not to skip it

3. Deepen only after the build brief exists:
   - use `references/design-expansion.md` only after the kernel is stable enough to teach back clearly and the build brief still has unresolved engineering choices
   - expansion may deepen dimensions, but it does not get to discover the kernel for you
   - if expansion reveals that the strongest thing is still unclear, stop and return to `references/kernel-extraction.md`
   - if the user asks for folder creation, starter files, or generic scaffolding, still finish the build brief first and mark initialization as downstream initializer work

4. Choose the lightest top-level shape:
   - start with the fewest sections that still teach the behavior
   - keep the shortest trigger in frontmatter
   - near the top of `SKILL.md`, default to one hot-path block that carries the strongest instruction and dominant path
   - a literal step-by-step section is optional; an obvious dominant path is not
   - keep the kernel visible on first read:
     - the kernel sentence, trigger boundary, first move, strongest thing, and wrong-scope sentence should all stay easy to recover from the entry surface
   - add an extra top-level section only when that hot path cannot carry one of these jobs cleanly:
     - ordered path
     - wrong-scope or ownership boundary
     - hard invariant
     - conditional support routing

5. Cut what does not earn its place:
   - collapse repeated decisions instead of listing them three ways:
     - if two sections or sibling bullets are teaching the same judgment, merge them
     - if a section can disappear without blurring trigger, first move, strongest thing, boundary, or output, cut it
   - keep each surviving layer on one job:
     - trigger guidance should not repeat unless the later layer adds new routing value
     - a reference should name one hot-path burden it removes and one load question it answers near the top
     - scripts are for deterministic repeated work; assets are for output shapes that truly depend on them
   - challenge every component against the kernel:
     - if this component vanished, would the loss be kernel clarity, kernel stability, kernel verification, or only explanation comfort
     - if the loss is only explanation comfort, default to cutting the component instead of adding it

6. Pressure-test the first read:
   - does it read like a skill or like a memo
   - can the design state the kernel sentence, strongest thing, wrong-scope sentence, and minimal shape without falling back to structural prose
   - does the build brief tell a downstream initializer what to initialize and what not to invent
   - does the brief stay valid without depending on one named creator, runtime, or directory layout
   - can a weaker model tell what to do from the first screen
   - is the dominant path visible early
   - is any core behavior buried by explanation
   - do any two sections own the same job
   - does each durable principle have an enforcement path
   - does any supposedly generic rule still depend on one named runtime, brand, or machine-specific example
   - is any top-level section present only because it is common in other skills
   - interrogate each surviving component one by one:
     - if this component vanished, what exact behavior, artifact quality, or safety would fail
     - if it merged with its nearest neighbor, what exact confusion or collision would return
     - if a weaker model opened it first by mistake, could it redirect cleanly
     - what cost does this component add in tokens, reads, maintenance, or drift risk

7. Write and validate:
   - keep public wording portable and publishable
   - name any local or runtime-specific term that still needs a portable replacement
   - if no downstream initializer is being edited in this phase, state that the build brief is the handoff contract for the next initializer layer rather than pretending initialization is complete
   - validate from cheapest proof upward:
     - run deterministic bundle checks first
     - if the smoke harness or runner changed, run its deterministic self-check before broader live smoke
     - then run the smallest live smoke that still touches the changed behavior, usually `references/minimal-smoke-prompts.md`
     - escalate to `references/pressure-tests.md` only when the change touched trigger boundary, authority, cadence, or broader routing, or when the narrow smoke stays ambiguous
   - keep narrow smoke lean:
     - feed changed snippets or tiny context extracts first when they are enough; do not default to full-file reads
     - disable unrelated rules, memory, plugins, or other ambient context when the runtime allows it
     - keep the prompt tiny and tied to one judgment unless the changed dimension is still ambiguous
   - close the loop:
     - if live smoke exposes one in-scope issue, repair it and rerun the narrowest proving smoke
     - stop when the smallest sufficient smoke is clean; otherwise defer or escalate explicitly
     - if no suitable runtime is available, provide exact manual regression prompts and mark live behavior unverified
     - record what was tested and what was intentionally skipped because it would be redundant or too token-expensive

</main-path>

<scope>

Use this when the main question is how one skill should be shaped or reshaped after its boundary is already clear and its kernel still needs to be locked.

Do not use this when the main task is executing the underlying workflow itself rather than designing the skill for it.

Do not use this as the generic skill initialization or bundle scaffolding workflow.

If the real problem is overlap between multiple skills, route to a skill-boundary workflow first.

If the real problem is repairing one existing skill without changing its core role, route to a skill-maintenance workflow.

</scope>

<invariants>

- A skill is a behavior surface first and a document second.
- A skill design is not ready for structural expansion until its kernel is explicit.
- Do not start by copying a familiar section template.
- Do not start from section names, references, scripts, or bundle shape before the kernel is explicit.
- The minimum architecture output is not "a draft bundle". It is a teachable kernel: kernel sentence, trigger boundary, first move, strongest thing, and wrong-scope sentence.
- The default explicit deliverable is not "starter files". It is a build brief protocol instance: kernel, minimal shape, component decisions, do-not-add rules, validation starter, and initializer handoff.
- The build brief protocol is `v1` until a later protocol reference explicitly changes it.
- Optimize for clear section jobs and a visible dominant path, not heading conventions.
- Collapse sibling bullets when they are really expressing one governing decision with different conditions or examples.
- Apply the same collapse rule to references and other bundle components, not only to `SKILL.md`.
- Collapse toward a clearer system, not just shorter prose: related judgments should compose into stable routes, layers, or rules instead of staying as scattered local fixes.
- Collapse checklist-style capability toggles into one operational rule when they are only different ways of achieving the same runtime mode or system behavior.
- Describe scope by the workflow object being designed, not by a list of example domains.
- Every reference should have one clear load question and one primary job.
- Every surviving component must be able to say whether it protects kernel clarity, kernel stability, kernel verification, or nothing important enough to keep.
- Every surviving component should be able to defend itself against a delete challenge, a merge challenge, and a cost challenge.
- Every durable principle must close through at least one enforcement path: explicit path step, hard invariant, deterministic check, pressure test, or smoke test. If it closes through none, cut it or operationalize it.
- A skill write is not complete until deterministic checks and at least one real smoke test both ran, or runtime unavailability was stated explicitly.
- If a smoke runner changed, its deterministic self-check must pass before the broader smoke result counts.
- A skill write is not complete while live smoke still shows an in-scope issue that has not yet been repaired, rerun, deferred with reason, or escalated out of this workflow.
- If a skill's power depends on cadence, first-turn pressure, or stop conditions, make that explicit.
- Keep platform-specific names out unless they are necessary examples.
- Keep generic governance text abstract: brand names, local runtime names, and machine-specific examples belong in adapter detail only, not in the governing rule itself.
- Prefer snippet-first smoke context when a changed excerpt can prove the behavior; do not spend live tokens on full-file reads unless the narrower context is insufficient.
- A slimmer skill is better only if it stays equally teachable.
- Do not let a downstream initializer redefine the kernel, add default bundle parts, or invent validation obligations that the build brief did not earn.
- Keep the protocol stable and semi-structured: stable English field labels, stable ordering, and no hidden dependence on one agent's private defaults.

</invariants>

<support-routing>
For kernel-first design:
- load `references/kernel-extraction.md` first when the skill kernel is not yet explicit
- load `references/design-intake.md` only when the request is too underspecified to complete kernel extraction honestly
- load `references/build-brief-protocol.md` immediately after the kernel is explicit so the protocol contract is frozen before any adapter-specific wording appears
- load `references/kernel-build-brief.md` right after that so the build brief exists before broader structure work
- load `references/design-expansion.md` only after the kernel is explicit and the build brief still needs multidimensional expansion before the structure is frozen
- load `references/initializer-adapters.md` when the next question is how a native creator, manual bootstrap flow, or repo-local initializer should safely consume the same brief

For structure decisions:
- load `references/component-paths.md` when deciding where one piece of guidance belongs
- load `references/reference-design.md` when deciding whether references should exist, merge, split, or sharpen
- load `references/bundle-design.md` when deciding what overall component combination the skill should keep

For narrower depth:
- load `references/authority-and-safety.md` for risky authority boundaries
- load `references/output-contracts.md` for stable report or artifact shape
- load `references/interaction-intensity.md` for pacing and cadence
- load `references/format-file-design.md` for repeated artifact shape
- load `references/script-design.md` for deterministic repeated work

For closeout:
- load `references/runtime-smoke-harness.md` when the question is how to run the cheapest useful live smoke or how to reduce runtime noise
- load `references/design-report.md` when reporting a non-trivial architecture recommendation
- load `references/minimal-smoke-prompts.md` for cheap narrow live checks
- load `references/pressure-tests.md` before calling the design mature

If these groups still leave the next reference unclear, load `references/reference-routing.md` as the fallback router.

</support-routing>
