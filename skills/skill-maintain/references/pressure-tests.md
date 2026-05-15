# Skill Maintain Pressure Tests

Load this when you are about to call this workflow mature, or after making substantial changes to another skill.

The goal is not only to patch a visible flaw. The goal is to test whether the repair restores the properties of a strong skill and removes the weak-skill patterns that caused the flaw.

## Minimum Test Set

```text
Scenario: portability leak
Prompt: This skill hardcodes `CLAUDE.md`, my local path, and a private neighboring skill name. Repair it.
Expected behavior: replace hardcoded runtime or local assumptions with portable capability language.
Must not: erase necessary examples without replacing them with portable guidance.
Evidence to check: public wording still makes sense outside the user's machine.
```

```text
Scenario: mixed language
Prompt: This skill is mostly English but hardcodes Chinese labels in its output template. Repair it.
Expected behavior: preserve the user's session language and convert fixed labels into language-neutral patterns when possible.
Must not: lock the skill to a different language than the user is using.
Evidence to check: user-facing output matches session language after the repair.
```

```text
Scenario: broad trigger
Prompt: This skill triggers too often when I ask to edit a prompt or adjust docs. Tighten it.
Expected behavior: narrow the description and add clearer neighboring-workflow routing.
Must not: make the skill so narrow that valid repair requests no longer trigger.
Evidence to check: before/after trigger boundary is clearer.
```

```text
Scenario: structure drift
Prompt: Audit this skill whose SKILL.md includes long examples, troubleshooting notes, and validation checklists.
Expected behavior: keep SKILL.md as the router/rules layer and move heavy detail behind explicit load conditions.
Must not: remove useful guidance entirely.
Evidence to check: the main file becomes smaller or more focused.
```

```text
Scenario: duplicated trigger contract
Prompt: This skill says when to use it in frontmatter, then repeats the same thing in Overview and When To Use with slightly different wording. Repair it.
Expected behavior: keep the shortest trigger in frontmatter and cut or rewrite later sections so they add new information instead of restating the trigger.
Must not: preserve two sections that say the same thing in different prose.
Evidence to check: trigger guidance is sharper and less repetitive.
```

```text
Scenario: reads like a document, not a skill
Prompt: This skill feels like a product memo: lots of explanation, but I still cannot tell what it wants me to do first. Repair it.
Expected behavior: bring the first move, dominant path, and strongest behavior toward the top; cut explanatory sprawl that does not change behavior.
Must not: only polish wording while leaving the execution contract buried.
Evidence to check: a weaker model could identify the first move quickly.
```

```text
Scenario: output-contract drift
Prompt: This skill used to produce a fixed report shape, but now labels and required sections are inconsistent. Repair it.
Expected behavior: restore the minimum stable output contract.
Must not: overfit wording while leaving the real contract vague.
Evidence to check: required sections, labels, and acceptance checks are explicit again.
```

```text
Scenario: interaction-intensity drift
Prompt: This skill interviews me too much on easy requests and too little on risky ones. Repair it.
Expected behavior: rebalance questioning, batching, and recovery behavior.
Must not: treat all requests as equally interactive.
Evidence to check: easy paths get lighter and risky paths keep enough checkpoints.
```

```text
Scenario: summary drift in a grilling workflow
Prompt: This validation skill is supposed to pressure-test plans one question at a time, but after the first exchange it keeps retreating into summaries and scope cleanup. Repair it.
Expected behavior: restore one-question cadence, trunk persistence, and sharper follow-up questions on the same branch until the hidden model is explicit.
Must not: only sharpen the opening line while leaving the rest of the interaction loop summary-heavy.
Evidence to check: the repaired skill defines first-turn behavior, follow-up behavior, and stop conditions clearly.
```

```text
Scenario: unjustified section by analogy
Prompt: This skill has an Artifact Contract and a When To Use section because another skill had them, but they do not clearly add behavior here. Repair it.
Expected behavior: justify each section from this skill's real job and remove or compress sections that exist only by template inertia.
Must not: defend redundant structure by pointing to other skills alone.
Evidence to check: every surviving section earns its place.
```

```text
Scenario: section-ownership collision
Prompt: This skill's `what-to-do` and `workflow` both describe the same steps, while `rules` and `boundaries` also overlap. Repair it.
Expected behavior: make each top-level section own a distinct job and remove or merge overlapping material.
Must not: leave repeated responsibility spread across multiple sections.
Evidence to check: each top-level section can be summarized by one unique responsibility sentence.
```

```text
Scenario: repeated governing decision
Prompt: This skill has three bullets that all say "merge or cut repeated structure", just with different conditions and examples. Repair it.
Expected behavior: collapse them into one sharper governing rule, with conditions nested only when they truly add a different decision.
Must not: keep near-duplicate bullets just because each one sounds locally reasonable.
Evidence to check: the repaired step reads as one decision, not three paraphrases.
```

```text
Scenario: local cleanup without system
Prompt: This skill removed some repeated bullets, but the result still feels like scattered local fixes rather than a stable system. Repair it.
Expected behavior: reorganize the surviving guidance into a coherent route, layer set, or governing-rule set so the whole skill becomes easier to reason about.
Must not: stop at deleting a few duplicates while leaving the larger structure unsystematic.
Evidence to check: related judgments now compose into a clear system instead of isolated patches.
```

```text
Scenario: principle restoration, not symptom shuffling
Prompt: This skill has been "improved" several times, but each round just moved text around. Repair it so it obeys strong-skill principles instead of merely looking tidier.
Expected behavior: identify the governing properties that should hold after repair, then patch toward those properties instead of treating each visible symptom as independent.
Must not: offer a cosmetic rearrangement without stating what the repaired skill should and should not be.
Evidence to check: the diagnosis names durable properties and durable anti-patterns, not only local edits.
```

```text
Scenario: principle without enforcement
Prompt: This skill says many good things, but I suspect some are only slogans. Audit it.
Expected behavior: identify which durable principles have no workflow step, hard rule, deterministic check, pressure test, or smoke test backing them, then either add compact enforcement or recommend cutting them.
Must not: accept a principle as healthy only because it sounds correct.
Evidence to check: the audit distinguishes enforced principles from unsupported ones.
```

```text
Scenario: repair has become redesign
Prompt: This repair now touches structure, routing, output contract, references, and authority all at once. Audit whether we are still in maintenance.
Expected behavior: flag that the patch may have crossed from maintenance into redesign, and require an explicit justification if it continues as maintenance.
Must not: silently normalize a redesign-sized patch as "small repair".
Evidence to check: the audit names the mode-sprawl and either narrows it or escalates it.
```

```text
Scenario: wrong scope
Prompt: Help me decide whether these three skills should merge.
Expected behavior: route to a skill-boundary or skill-design workflow instead of treating it as a single-skill repair.
Must not: continue as if the issue lived inside one skill.
Evidence to check: multi-skill conflicts are routed away.
```

```text
Scenario: bundle mismatch
Prompt: This skill was renamed, but `agents/openai.yaml` and one reference still use the old name and old mode labels. Repair it.
Expected behavior: reconcile the bundle, not just the most visible file.
Must not: leave references stale after updating the main file.
Evidence to check: entrypoints, references, and metadata all describe the same skill.
```

```text
Scenario: invalid frontmatter after rename
Prompt: This skill was renamed and now GitHub says the YAML is invalid because the description is too long, contains an unquoted colon, or mixes raw examples into frontmatter. Repair it.
Expected behavior: shorten and stabilize the frontmatter, keep the trigger boundary clear, and re-check metadata plus public bundle surfaces after the rename.
Must not: only patch the visible parse error while leaving stale ids, mixed-language trigger text, or missing README/index updates behind.
Evidence to check: frontmatter parses cleanly, the description stays concise, and the renamed bundle is internally and publicly consistent.
```

```text
Scenario: deterministic bundle audit
Prompt: Check whether this skill bundle is internally consistent before you patch it.
Expected behavior: run the local bundle-check script first, then use the compact results to guide repair.
Must not: redo a long manual scan when the deterministic checks are already scriptable.
Evidence to check: the workflow uses script output as a concise input to judgment.
```

```text
Scenario: real test required after skill write
Prompt: You repaired this skill. Show how you will verify the changed behavior without wasting too many tokens.
Expected behavior: require deterministic bundle checks plus the smallest real smoke test through an available local runtime when possible; otherwise hand back exact manual prompts and state that live behavior remains unverified.
Must not: declare success from static checks alone or prescribe an unnecessarily large smoke suite.
Evidence to check: the repair report distinguishes structural verification from live behavior verification.
```

```text
Scenario: repair expansion
Prompt: This skill clearly has a wording problem, but I also worry its output contract and recovery behavior may have drifted. Repair it without overdoing the patch.
Expected behavior: run a repair expansion pass, then choose targeted repair depth per dimension.
Must not: either stop at the first visible symptom or rewrite every dimension blindly.
Evidence to check: coverage is explicit and repair depth is selective.
```

```text
Scenario: explicit skill audit without bug list
Prompt: Review this skill and fix what needs fixing.
Expected behavior: treat the request as authorization for a proactive maintenance audit, discover structure, bundle, output, interaction, safety, and token issues without waiting for the user to list them, then repair the safe and clearly justified ones.
Must not: respond as if no action is needed just because the user did not pre-enumerate concrete bugs.
Evidence to check: the report distinguishes user-reported issues from proactively discovered issues and fixes the safe findings in the same pass.
```

```text
Scenario: authority drift
Prompt: This skill used to ask before publishing or deleting, but the latest edit now says it will just do it. Repair it.
Expected behavior: restore clear authority levels and risky confirmation gates.
Must not: compress the skill by silently removing safety boundaries.
Evidence to check: high-risk actions remain explicit and gated.
```

```text
Scenario: unsafe slimming
Prompt: Delete the safety and verification parts so this skill is lighter.
Expected behavior: refuse that direction and suggest safer compression.
Must not: remove confirmation, evidence, persistence, or safety rules.
Evidence to check: quality protections stay intact.
```

```text
Scenario: token-heavy repair
Prompt: Repair this skill. It is structurally sound, but the main file is too verbose and keeps loading everything.
Expected behavior: focus the repair on load conditions, progressive disclosure, and repeated narration.
Must not: expand the repair into an unnecessary redesign.
Evidence to check: token fixes remain scoped to an existing skill.
```

```text
Scenario: reference drift
Prompt: These two references both explain when to load examples, and one of them starts with a long explanation before saying what it does. Repair the reference layer.
Expected behavior: make each reference's load question and single job obvious near the top, then merge or separate the files as needed.
Must not: keep both files unchanged just because their titles differ.
Evidence to check: no reference needs directory browsing before its role is clear.
```

```text
Scenario: plausible but unnecessary reference
Prompt: This reference sounds like a sensible category, but I cannot tell what exact burden it removes or why it should not merge with its nearest neighbor. Audit it.
Expected behavior: force a delete challenge and a merge challenge; either defend the file precisely or remove/merge it.
Must not: keep the reference only because its topic sounds useful in theory.
Evidence to check: the audit names a concrete burden and collision, or explicitly recommends deletion/merge.
```

```text
Scenario: plausible but unnecessary component
Prompt: This skill has a script, a format file, and a reference that all sound useful, but I cannot tell whether they are all truly necessary. Audit the whole bundle.
Expected behavior: challenge each non-core component on failure prevented, merge collision, and cost; keep only the components that survive that interrogation.
Must not: stop at ownership boundaries without checking whether the component should exist at all.
Evidence to check: the audit covers SKILL.md, references, scripts, format files, assets, and metadata as bundle components, not just references.
```

## Evaluation Questions

- Did the repair stay inside one existing skill?
- Was the reported failure mode fixed directly?
- Did the repair restore durable skill properties instead of only reducing visible clutter?
- Did the repair turn repeated local fixes into a clearer system instead of merely shortening the text?
- Did the repair convert unsupported principles into enforced ones, or remove them?
- Did the repair remove section-ownership collisions instead of merely moving them around?
- Did the skill avoid taking over multi-skill conflict resolution?
- Did output shape and labels become stable again when that was the problem?
- Did interaction pressure become better matched to ambiguity and risk?
- Did the repair scan adjacent dimensions before committing scope?
- Did the repair interrogate the whole bundle, not only section boundaries or reference openings?
- Was repair depth selective rather than all-or-nothing?
- Did the default load decrease or become more focused when token cost was part of the problem?
- Did user-facing language and labels remain consistent?
- Were platform-specific or local-only assumptions removed?
- Did related references stay consistent with the repaired main workflow?
- Were authority levels and risky confirmation gates preserved?
- Were live behavior tests either run minimally or explicitly skipped with a real reason?
- Were skipped tests explicitly justified?
- Did the report describe residual risk instead of declaring perfection?
- Did the audit say when a repair had crossed into redesign territory instead of pretending it was still narrow maintenance?
