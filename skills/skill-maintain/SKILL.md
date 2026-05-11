---
name: skill-maintain
description: Use when auditing or repairing one existing skill, especially for portability issues, bundle drift, weak boundaries, bloated structure, or token/context cost. Do not use this for multi-skill boundary disputes or for deciding whether a skill should be created, split, or merged.
---

# Skill Maintain

Audit and repair one existing skill without blurring its role. Use this when a skill already exists and needs an internal fix.

## Boundaries

Use this for one existing skill at a time.

Route away when:

- the main question is whether a skill should exist, be created, split, or merged from scratch -> skill-design workflow
- the main problem is overlap, conflict, stale duplication, or routing ambiguity between multiple skills -> skill-boundary workflow
- the request is general prompt compression, code optimization, runtime performance, or arbitrary chat summarization

## Repair Modes

Choose the narrowest mode that matches the problem:

- `portability + language`: runtime terms, mixed language, local paths, abstraction leaks
- `structure + routing`: bloated `SKILL.md`, misplaced content, weak routing
- `output contracts`: unstable report shape, labels, fields, or artifact checks
- `interaction intensity`: too many questions, too few checkpoints, bad batching, weak recovery
- `bundle consistency`: drift across `SKILL.md`, frontmatter, references, scripts, metadata, or public bundle surfaces
- `safety + authority`: overreach, missing confirmations, weak permission boundaries
- `token optimization`: heavy default load, repeated narration, weak progressive disclosure

Load only the references needed for the active mode:

- [language-and-portability.md](references/language-and-portability.md) for portability or language problems
- [repair-patterns.md](references/repair-patterns.md) for structure, routing, or general repair planning
- [output-contracts.md](references/output-contracts.md) for unstable sections, fields, templates, or artifact quality expectations
- [interaction-intensity.md](references/interaction-intensity.md) for questioning depth, pacing, batching, or recovery behavior
- [bundle-consistency.md](references/bundle-consistency.md) for cross-file drift
- [safety-and-authority.md](references/safety-and-authority.md) for overreach or confirmation problems
- [token-optimization.md](references/token-optimization.md) when token/context cost is the primary failure mode

## Core Rules

- Repair the smallest surface that fixes the problem.
- When the user asks to audit, review, inspect, or check a specific skill, default to a proactive maintenance audit across all major maintenance dimensions before narrowing the patch.
- Keep guidance publishable, environment-neutral, and aligned with the user's language.
- Prefer capability categories and workflow contracts over hardcoded runtime terms, local paths, or downstream skill names.
- When a skill is one step in a broader workflow, check whether it clearly defines what artifact it owns, what state it must not mutate, and what downstream capability should consume its output.
- Prefer deterministic scripts for repeated bundle checks, metadata extraction, link validation, and compact reporting when those steps do not require judgment.
- When a script exists for a deterministic check, use it instead of redoing the same inspection through prose alone.
- Treat every edit as a behavior change until validated against a capability baseline.

## Core Principle

Repair quality first, then trim weight. A smaller skill is not a better skill if it loses trigger accuracy, safety, evidence requirements, persistence rules, or practical usefulness.

## Workflow

### 1. Confirm The Target And Failure Mode

If the target skill is not explicit, ask which skill to inspect.

If the user explicitly asks to audit, review, inspect, or check a specific skill, do not wait for a bug list. Treat that as authorization to run a full maintenance breadth scan, surface the real issues you find, and repair the ones that are safe or clearly required.

If the request is broad and not an explicit audit/review request, narrow it to one repair mode first.

If the real issue is between multiple skills, route to a skill-boundary workflow — the workflow that compares multiple skills and clarifies which one should own which situation — instead of continuing here.

### 2. Run A Maintenance Breadth-And-Depth Pass

Start with a maintenance breadth-and-depth pass before locking the repair scope.

Load [repair-breadth-and-depth.md](references/repair-breadth-and-depth.md) to scan the major maintenance dimensions and choose repair depth.

For explicit audit/review requests, this breadth pass is mandatory even if the user only mentioned one visible symptom. The workflow should proactively discover adjacent drift in structure, routing, output contract, bundle consistency, safety, and token cost rather than waiting for the user to enumerate them.

### 3. Inspect The Skill Skeleton

Read metadata, file layout, `SKILL.md`, and only the references needed for the problem. Note neighboring capability categories before proposing changes.

Load the matching repair-mode references when doing more than a quick wording fix.

If the reported problem is deterministic and bundle-wide, prefer a matching local script before manual inspection.

When the skill was newly renamed, newly published, or just generated by another skill workflow, treat YAML validity, agent metadata alignment, old-name residue, and public index updates as first-class inspection targets rather than optional cleanup.

### 4. Establish A Capability Baseline

Before editing, write a short baseline for:

- valid trigger cases and wrong-scope cases
- safety, confirmation, evidence, and persistence rules
- output quality plus user-facing language and interaction style
- reachable references, scripts, and assets
- explicit upstream/downstream workflow contracts
- execution-state artifacts this skill must not mutate

If the user supplied a failure report, transcript, diff, or complaint, use it as a regression fixture. Otherwise create realistic before/after scenarios from the skill's stated purpose.

### 5. Diagnose And Plan

Classify findings using the same maintenance dimensions from the breadth scan.

Make repair depth explicit for each important dimension: `no issue`, `light wording fix`, `section rewrite`, `reference repair`, `script-assisted repair`, `bundle-wide patch`, or `defer explicitly`.

If token economy is the primary failure mode, use the stronger token-optimization workflow from [token-optimization.md](references/token-optimization.md) instead of treating token trimming as a minor side check.

Show a concise repair plan before editing unless the user explicitly asked for direct implementation.

For explicit audit/review requests, the repair plan should separate:

- issues explicitly reported by the user
- issues proactively discovered by the maintenance audit

Do not ignore proactively discovered issues just because the user did not name them first. Fix the safe, clearly justified ones in the same pass, and call out any higher-risk findings before changing them.

Classify each planned change as `safe`, `moderate`, or `risky`.

Load [regression-tests.md](references/regression-tests.md) before proposing or implementing anything beyond a trivial wording-only change.

### 6. Patch And Validate

Edit the smallest necessary files. Load [pressure-tests.md](references/pressure-tests.md) before calling a reusable skill mature.

Validate that:

- the capability baseline still passes and the reported failure mode is fixed
- frontmatter, metadata, support files, and public bundle surfaces stay aligned
- breadth coverage and repair depth are explicit
- routing, workflow boundaries, language, output checks, and interaction pacing still match the intended contract
- the default load is smaller or more focused when token cost was part of the problem
- authority levels, confirmation gates, execution-state boundaries, and safety/evidence/persistence rules still hold
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
