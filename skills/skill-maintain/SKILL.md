---
name: skill-maintain
description: Use when one existing skill has drift and needs repair without redefining its role or kernel.
---

# Skill Maintain

Repair drift in one existing skill without redefining its role or kernel.

<main-path>

1. Establish the role/kernel baseline:
   - what role and trigger boundary the skill should keep
   - what its kernel sentence is
   - what it should do first
   - what its strongest thing is
   - what `not-this-skill-if...` boundary it depends on
   - what the dominant path is
   - what references, format files, scripts, assets, or metadata it depends on
   - what public boundary or bundle contract it must preserve

2. Audit for the drift that hurts first-read usability most:
   - state the drift in a way that can close back into the default `maintenance verdict`, not just into an isolated wording patch
   - the first 20-30 lines do not tell the model what to do
   - trigger is blurry or repeated
   - the kernel is still implicit even though the structure looks complete
   - first move or dominant path is hard to find
   - the strongest thing is hard to state even after reading the file
   - the `not-this-skill-if...` boundary is missing, vague, or buried
   - the skill looks structurally complete but never made its build brief protocol or initializer handoff explicit
   - the dominant path appears too late
   - the skill depends on a literal heading name instead of making the dominant path obvious
   - wrong-scope guidance names example domains instead of the real workflow object boundary
   - sections collide, restate each other, or bury behavior under explanation
   - sibling bullets inside one step repeat the same decision instead of sharpening it
   - multiple bullets restate one governing decision with slight condition changes instead of collapsing into one sharper rule
   - a cross-cutting invariant block restates local path steps instead of guarding global invariants
   - a supposedly generic rule still depends on one named runtime, brand, or machine-specific example
   - a durable principle has no path step, hard invariant, deterministic check, pressure test, or smoke test backing it
   - a component does not make its job obvious enough for its layer
   - two components answer the same question and should merge or split more sharply
   - a component survives only as a plausible topic bucket, not as a uniquely necessary bundle part
   - bundle drift exists across the main file, references, format files, scripts, assets, or metadata
   - token cost comes from low-value narration instead of real invariants

3. Choose the narrowest repair depth:
   - wording fix
   - section rewrite
   - reference repair
   - script-layer repair
   - bundle-wide patch
   - explicit defer
   - make the chosen repair depth and any required handoff judgment explicit enough to land cleanly in the final `maintenance verdict`
   - if the patch would span too many modes, would introduce a new owner layer, or would redefine the skill's role or kernel rather than repair drift around it, stop and ask whether this is really redesign rather than maintenance

4. Rewrite the hot path first:
   - restore the kernel before polishing structure:
     - if the kernel sentence, strongest thing, or wrong-scope boundary is weak, repair those in `SKILL.md` before expanding references
   - keep the main path easy to find
   - collapse repeated guidance before polishing prose:
     - if deleting text leaves trigger, first move, strongest thing, boundary, and output unchanged, cut it
     - if top-level sections or sibling bullets are teaching the same judgment, merge them
     - if an invariant only repeats a local path step, move that judgment back into the path block
   - keep non-core material only when it earns clarity:
     - if a component needs browsing or guesswork before its job is clear, rewrite, move, merge, or cut it
     - move heavy detail away from the main file only when the main file becomes sharper because of it
     - keep any non-core component only when it removes a clear burden from the main entry surface, protects a real bundle contract, or protects kernel clarity, stability, or verification
   - interrogate each surviving component one by one:
     - if this component vanished, what exact failure would return
     - if it merged with its nearest neighbor, what exact confusion or collision would return
     - if a weaker model encountered it first, could it still recover cleanly
     - what cost does this component add in tokens, reads, maintenance, or drift risk
   - cut text that does not change behavior or protect a boundary
   - keep support layers subordinate:
     - if the repair touches protocol wording, helper behavior, or runtime smoke, keep each layer on its existing job instead of letting one layer absorb another
     - do not "solve drift" by promoting a helper, check script, or fallback file into a new source of truth
     - do not create a new script, reference, or validation entrypoint when the existing owner can carry the repair cleanly

5. Validate the repaired skill:
   - kernel sentence is now explicit
   - first move is now clear
   - trigger is sharp
   - strongest behavior is easy to find
   - the wrong-scope boundary is explicit enough to route away
   - top-level sections no longer collide in responsibility
   - sections no longer duplicate each other
   - each surviving component can name its burden, nearest merge collision, and cost
   - bundle components still align
   - the skill is lighter only where it was safe to lighten
   - any remaining strong principle still names its enforcement path
   - support layers still have clean ownership:
     - protocol owners still define protocol
     - helper scripts still act like helpers
     - smoke harnesses still act like smoke harnesses
   - validate from cheapest proof upward:
     - deterministic bundle checks pass
     - if the repair touched an existing validator, proof helper, or private shared script core, keep using the existing validation chain instead of inventing a new validation entrypoint
     - if the smoke harness or runner changed, run its deterministic self-check before broader live smoke
     - then run the smallest live smoke that still touches the repaired behavior, usually `references/minimal-smoke-prompts.md`
     - escalate to `references/pressure-tests.md` or `references/regression-tests.md` only when the repair touched trigger boundary, authority, cadence, broader capability preservation, or the narrow smoke stays ambiguous
   - keep narrow smoke lean:
     - feed changed snippets or tiny context extracts first when they are enough; do not default to full-file reads
     - disable unrelated rules, memory, plugins, or other ambient context when the runtime allows it
     - keep the live prompt tiny and limited to one repair judgment unless the changed dimension is still ambiguous
   - close out with the default `maintenance verdict` unless the task explicitly asks for a different artifact:
     - drift diagnosis
     - repair depth
     - maintenance vs redesign judgment
     - handoff judgment
     - proof
     - residual risk or confidence
   - close the loop:
     - if live smoke exposes one in-scope issue, repair it and rerun the narrowest proving smoke
     - stop when the smallest sufficient smoke is clean; otherwise defer or escalate explicitly
     - if no suitable runtime is available, hand back exact manual regression prompts and mark live behavior as unverified

</main-path>

<scope>

Use this for one existing skill at a time.

Do not use this when the main task is designing a different skill, routing across multiple skills, or executing the underlying workflow itself rather than repairing this skill.

If the real task is changing the target skill's role, redefining its kernel, or turning a repair into a redesign, route to a skill-architecture workflow.

If the real task is deciding whether multiple skills should split, merge, or reroute, route to a skill-boundary workflow.

If the repair reveals that the original skill never had a real build brief protocol or initializer handoff, classify that first as kernel/architecture drift and decide explicitly whether it still fits maintenance or needs architecture handoff.

If the audit suggests a reusable upstream cause after the local repair locus is clear, hand off to a governance-escalation workflow instead of widening this skill into a multi-layer review.

</scope>

<invariants>

- Treat the skill as a behavior bundle, not just a text file.
- Repair drift without redefining the role or kernel. If redefinition is needed, hand off instead of stretching maintenance.
- A structurally complete skill is still drifted if its kernel is not explicit.
- Do not justify structure by citing another skill alone; justify it with the target skill's real job or failure mode.
- Describe scope by the workflow object being repaired, not by a list of example domains.
- Audit is a method for locating drift, not this skill's core identity.
- If a repair crosses too many modes, treat that as redesign pressure and say so explicitly.
- If a repair would create a new owner layer, new validation entrypoint, or new helper role just to make the current fix feel cleaner, treat that as redesign pressure and say so explicitly.
- Prefer fixing the teaching failure over preserving familiar prose.
- Collapse sibling bullets when they are really restating one governing repair decision with minor condition changes.
- Apply the same collapse rule to references and other bundle components, not only to `SKILL.md`.
- Collapse toward a clearer system, not just shorter prose: related repair judgments should compose into stable routes, layers, or rules instead of staying as scattered local fixes.
- Collapse checklist-style capability toggles into one operational rule when they are only different ways of achieving the same runtime mode or system behavior.
- Treat bundle components as first-class teaching surfaces or deterministic helpers, not storage bins.
- Keep existing owner layers distinct: protocol owners define protocol, helper scripts support owned behavior, and smoke harnesses prove runtime behavior. Maintenance must not blur those jobs.
- A surviving non-core component should defend itself with a real job, a real burden it removes, a real reason it should not merge, and a cost worth paying.
- When real smoke tests are skipped, say whether the blocker was runtime availability, side-effect risk, or token budget.
- If a durable principle has no enforcement path, either add one compactly or cut the principle.
- Treat every repair as a behavior change until verified.
- A skill write is not complete until deterministic checks and at least one real smoke test both ran, or runtime unavailability was stated explicitly.
- If a smoke runner changed, its deterministic self-check must pass before the broader smoke result counts.
- A skill write is not complete while live smoke still shows an in-scope issue that has not yet been repaired, rerun, deferred with reason, or escalated out of this workflow.
- Keep generic governance text abstract: brand names, local runtime names, and machine-specific examples belong in adapter detail only, not in the governing rule itself.
- Prefer snippet-first smoke context when a changed excerpt can prove the repaired behavior; do not spend live tokens on full-file reads unless the narrower context is insufficient.
- Prefer the existing validation chain over new entrypoints: if current bundle checks, validators, helper scripts, or smoke self-checks already cover the repair, extend their usage discipline before introducing another named check.

</invariants>

<support-routing>
For early audit:
- load `references/repair-expansion.md` at the start of any non-trivial audit

For repair ownership:
- load `references/component-paths.md` when deciding whether the fix belongs in `SKILL.md`, a reference, a format file, a script, an asset, or bundle metadata
- load `references/reference-quality.md` when references themselves may be too vague, duplicated, or badly split
- load `references/bundle-consistency.md` and `scripts/check-skill-bundle.sh` when references, format files, scripts, assets, or metadata may have drifted together
- load `references/repair-patterns.md` when deciding whether to cut, merge, relocate, or deepen the patch

For narrower repair depth:
- load `references/interaction-intensity.md`
- load `references/language-and-portability.md`
- load `references/safety-and-authority.md`
- load `references/token-optimization.md`
- load `references/format-file-quality.md`
- load `references/regression-tests.md`
only when the failure is clearly about that dimension

For closeout:
- load `references/output-contracts.md` as the default closeout contract owner
- load `references/runtime-smoke-harness.md` when the question is how to run the cheapest useful live smoke or how to reduce runtime noise
- load `references/minimal-smoke-prompts.md` as the cheapest live proof owner
- load `references/pressure-tests.md` and `references/regression-tests.md` as stronger proof owners before calling the repair mature

If these groups still leave the next repair reference unclear, load `references/reference-routing.md` as the fallback router.

</support-routing>
