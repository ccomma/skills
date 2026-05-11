---
name: skill-maintain
description: Use when auditing or repairing a single existing skill that already should exist, especially for hardcoded references, mixed language, abstraction leaks, platform-specific wording, bundle mismatches, weak authority boundaries, bloated structure, or token/context cost. Do not use this for multi-skill boundary disputes or for deciding whether a skill should be created, split, or merged.
---

# Skill Maintain

Audit and repair one existing skill without blurring its role. Use this when a skill already exists and needs an internal fix or improvement, such as missing rules, misleading wording, routing ambiguity, portability issues, language inconsistency, output-contract drift, interaction-intensity drift, structural drift, weak authority boundaries, bundle mismatch, or token economy.

## Boundaries

Use this for one existing skill at a time.

Use a skill-design workflow — a workflow for deciding whether one skill should exist and how it should be created, split, merged, or fundamentally reshaped — when the main question is whether a skill should exist, be created from scratch, or be split or merged.

Use a skill-boundary workflow — a workflow for comparing multiple skills and deciding their overlap, conflict, sequencing, or routing boundaries — when the main problem is overlap, conflict, stale duplication, or routing ambiguity between multiple skills.

Do not use this for general prompt compression, code optimization, runtime performance, or summarizing arbitrary chat history.

## Repair Modes

Choose the narrowest mode that matches the reported problem:

- `portability + language`: hardcoded runtime terms, mixed language, local paths, non-portable labels, abstraction leaks
- `structure + routing`: bloated `SKILL.md`, misplaced content, weak load conditions, unclear neighboring-workflow routing
- `output contracts`: unstable report shape, drifting labels, missing required fields, weak artifact acceptance rules
- `interaction intensity`: too many questions, too few checkpoints, bad batching, or poor expansion/recovery behavior
- `bundle consistency`: mismatches between `SKILL.md`, references, scripts, assets, or agent metadata
- `safety + authority`: overreaching execution, missing confirmations, weak permission boundaries, or action level drift
- `token optimization`: default load too heavy, repeated narration, missing progressive disclosure, missing compact or batch behavior

Load only the references needed for the active mode:

- Load [language-and-portability.md](references/language-and-portability.md) for portability or language problems.
- Load [repair-patterns.md](references/repair-patterns.md) for structure, routing, or general repair planning.
- Load [output-contracts.md](references/output-contracts.md) for unstable sections, fields, templates, or artifact quality expectations.
- Load [interaction-intensity.md](references/interaction-intensity.md) for questioning depth, pacing, batching, or recovery behavior.
- Load [bundle-consistency.md](references/bundle-consistency.md) for mismatches across the skill bundle.
- Load [safety-and-authority.md](references/safety-and-authority.md) for overreach, confirmation, or authority-boundary problems.
- Load [token-optimization.md](references/token-optimization.md) when token/context cost is the primary failure mode.

## Core Rules

- Repair the smallest surface that fixes the problem.
- Keep guidance publishable and environment-neutral.
- Describe neighboring responsibilities by capability category unless a concrete dependency is part of the target skill's public bundle or explicitly supplied by the user.
- Replace hardcoded vendor-specific runtime terms unless they are clearly illustrative examples.
- Keep user-facing language, tone, labels, and output patterns consistent with the user's session language.
- Prefer workflow contracts based on artifact roles and capability categories over hardcoded downstream skill names.
- When a skill is one step in a broader workflow, check whether it clearly defines what artifact it owns, what state it must not mutate, and what downstream capability should consume its output.
- Prefer deterministic scripts for repeated bundle checks, metadata extraction, link validation, and compact reporting when those steps do not require judgment.
- When a script exists for a deterministic check, use it instead of redoing the same inspection through prose alone.
- Treat every edit as a behavior change until validated against a capability baseline.

## Core Principle

Repair quality first, then trim weight. A smaller skill is not a better skill if it loses trigger accuracy, safety, evidence requirements, persistence rules, or practical usefulness.

## Workflow

### 1. Confirm The Target And Failure Mode

If the target skill is not explicit, ask which skill to inspect.

If the request is broad, narrow it to one primary failure mode first:

- hardcoded references or non-portable wording
- mixed-language or wrong-language output patterns
- abstraction leaks or project-specific assumptions
- hidden workflow coupling to one private neighboring skill
- bloated structure or misplaced content
- unstable output shape, labels, fields, or artifact rules
- too much or too little interaction pressure
- bundle mismatch across files, references, scripts, or metadata
- unsafe authority, missing confirmation, or action-level drift
- token/context cost

If the real issue is between multiple skills, route to a skill-boundary workflow — the workflow that compares multiple skills and clarifies which one should own which situation — instead of continuing here.

### 2. Run A Maintenance Breadth-And-Depth Pass

Start with a maintenance breadth-and-depth pass before locking the repair scope.

Load [repair-breadth-and-depth.md](references/repair-breadth-and-depth.md) to scan major maintenance dimensions and decide which ones need no work, light wording repair, section rewrite, reference repair, script-assisted repair, bundle-wide patch, or explicit deferral.

### 3. Inspect The Skill Skeleton

Read metadata, file layout, `SKILL.md`, and only the references needed for the reported problem. Note neighboring capability categories before proposing changes.

Load the matching repair-mode references when doing more than a quick wording fix.

If the reported problem is deterministic and bundle-wide, prefer a matching local script before manual inspection.

### 4. Establish A Capability Baseline

Before editing, write a short baseline for what must keep working:

- valid trigger cases that must still load the skill
- wrong-scope cases that must still route away
- safety, confirmation, evidence, and persistence rules that must remain intact
- core output or artifact quality the user relies on
- user-facing language, labels, tone, and interaction style that must not regress
- references, scripts, or assets that must remain reachable through explicit load conditions
- upstream and downstream workflow contracts that must remain explicit
- execution-state artifacts this skill must not mutate

If the user supplied a failure report, transcript, diff, or complaint, use it as a regression fixture. Otherwise create realistic before/after scenarios from the skill's stated purpose.

### 5. Diagnose And Plan

Classify findings into one or more of these buckets:

- portability
- language consistency
- abstraction level
- structure and routing
- output contracts
- interaction intensity
- bundle consistency
- safety and authority
- token economy

Make the repair depth explicit for each important dimension:

- `no issue`
- `light wording fix`
- `section rewrite`
- `reference repair`
- `script-assisted repair`
- `bundle-wide patch`
- `defer explicitly`

If token economy is the primary failure mode, use the stronger token-optimization workflow from [token-optimization.md](references/token-optimization.md) instead of treating token trimming as a minor side check.

Show a concise repair plan before editing unless the user explicitly asked for direct implementation.

Classify each planned change:

- `safe`: wording, examples, routing phrasing, load conditions, label cleanup
- `moderate`: moving content across files, tightening triggers, simplifying interaction flow
- `risky`: changing core responsibilities, splitting or merging skills, removing behavior-protecting rules

Load [regression-tests.md](references/regression-tests.md) before proposing or implementing anything beyond a trivial wording-only change.

### 6. Patch And Validate

Edit the smallest necessary files. Load [pressure-tests.md](references/pressure-tests.md) before calling a reusable skill mature.

Validate that:

- the capability baseline still passes
- the reported failure mode is fixed
- breadth coverage is explicit: major maintenance dimensions were considered, not only the first visible symptom
- repair depth is explicit: each important dimension was intentionally left alone, lightly repaired, deeply repaired, script-assisted, bundle-patched, or deferred
- neighboring-skill routing is clearer, not broader
- upstream/downstream workflow boundaries are clearer, not more tightly coupled to one concrete neighboring skill
- user-facing language and labels still match the session language
- runtime terminology is platform-generic except for clearly labeled examples
- output sections, labels, and artifact checks still match the intended contract
- interaction pacing and batching are better matched to the task
- related support files remain consistent with the repaired workflow
- the default load is smaller or more focused when token cost was part of the problem
- authority levels and risky confirmation gates still match the intended behavior
- the skill does not silently change execution-state artifacts that belong to a downstream planning or execution workflow
- no safety, confirmation, evidence, or persistence rule was removed
- all planned regression tests were run, simulated, or explicitly marked not runnable with a reason

Do not call a repair complete based on one dimension alone. Report residual quality risk if any baseline behavior could not be verified.

## Output

Use the user's session language for visible section labels in reports. Keep technical tokens such as file names, exact mode labels, or skill ids verbatim when translation would reduce precision.

For review-only work:

```text
[Localized label for target skill]:
[Localized label for primary failure mode]:
[Localized label for diagnosis]:
- [Localized portability label]:
- [Localized language label]:
- [Localized abstraction label]:
- [Localized structure label]:
- [Localized output label]:
- [Localized interaction label]:
- [Localized bundle label]:
- [Localized safety label]:
- [Localized token label]:
[Localized breadth coverage label]:
[Localized repair depth label]:
[Localized recommended changes label]:
[Localized risk label]:
[Localized validation label]:
```

For implementation work, report changed files, why each change was made, the capability baseline, tests run, and any residual quality risk.
