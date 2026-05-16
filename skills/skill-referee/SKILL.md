---
name: skill-referee
description: Use when 2 or more skills may own the same request and you need a metadata-first owner ruling plus handoff rule before deeper redesign or repair.
---

# Skill Referee

Settle ambiguous skill ownership with a metadata-first ruling.

This skill exists to decide which skill should own a situation when 2 or more skills look like plausible owners. Its default explicit output is a ruling: `Situation`, `Primary Owner`, `Do Not Use`, `Handoff Rule`, `Why`, and `Residual Uncertainty`.

Use this when the main question is not "what is wrong inside one skill" but "which skill should own this request, and how should the neighboring skills stay out or hand off cleanly."

If the boundary is already clear and the remaining task is to lock one skill's kernel, build brief, or internal structure, hand off to `skill-architect`.

If the real task is repairing drift in one existing skill without redefining its role or kernel, hand off to `skill-maintain`.

If the local issue is already clear but the evidence points to a reusable upstream governance cause, hand off to `skill-governance-escalation`.

## Core Rules

- Use the user's latest language for all prose, headings, labels, summaries, and explanations. Keep only skill names, paths, commands, frontmatter keys, option letters, and issue type labels exact.
- Treat `skill-referee`, `$skill-referee`, and this skill's own path as invocation names, not review targets.
- Count only target skill names other than `skill-referee` when deciding whether the user specified targets.
- Start with owner arbitration, not broad audit:
  - first ask whether 2 or more skills could plausibly own the same situation
  - if not, hand off instead of forcing a referee workflow
- Build the first owner map from metadata before deeper reading:
  - `description`
  - usage-expansion or trigger-contract wording
  - visible exclusions such as `Do not use`
  - inputs, outputs, touched assets, and authority level
- Do not deep-read full skill bodies until the metadata pass still leaves the ruling ambiguous.
- If the user names 2 or more target skills, start the owner map directly; do not begin with a menu.
- If the user names 1 target skill, use it as the anchor, find the most plausible competing owners from metadata, then rule or narrow the comparison.
- Load `references/interaction.md` only as a fallback shell:
  - the user explicitly asks for audit, batch compare, or full inventory
  - current context is too thin for a direct ruling
  - explicit cost, scope, or depth selection would materially reduce ambiguity

## Skill Discovery

Discover skills from the narrowest reliable source first:

1. Skills explicitly named or linked by the user.
2. Skill metadata already available in the current session.
3. User-provided skill roots or workspace-local skill directories.
4. Common local skill roots only when needed and accessible.
5. Additional skill systems only when the user mentions them or metadata suggests a real owner collision.

Do not assume any one agent runtime, directory layout, domain, or skill ecosystem is always present.

## Universal Boundary Signals

Look for ambiguous ownership in domain-neutral responsibilities:

- user intent handled: planning, creation, transformation, analysis, critique, validation, publishing, maintenance
- lifecycle stage: intake, discovery, planning, execution, review, repair, handoff, closeout
- inputs and outputs: files, prompts, records, media, data, tasks, decisions, reports, artifacts
- assets touched: documents, images, videos, code, datasets, configs, notes, trackers, external tools
- authority level: suggest, draft, edit, execute, install, delete, approve, persist, publish
- quality responsibility: correctness, style, safety, format, usability, compliance, performance, evidence
- persistence: temporary output, project files, personal settings, shared knowledge, decision records

Use field-specific terms only when the inspected skills themselves introduce them.

## Workflow

### 1. Confirm that this is an ownership problem

- If multiple skills may own the same request or artifact boundary, stay here.
- If one skill's role is already chosen and the remaining work is internal redesign, hand off to `skill-architect`.
- If the issue is single-skill drift, hand off to `skill-maintain`.
- If the reusable-cause question is more important than the local owner question, hand off to `skill-governance-escalation`.

### 2. Build the owner map from metadata first

For each plausible owner:

1. Read the shortest public trigger contract first.
2. Read visible exclusions and wrong-scope guidance.
3. Compare inputs, outputs, touched assets, lifecycle stage, and authority level.
4. Mark whether the skill looks like:
   - primary owner
   - conditional owner
   - adjacent but not owner
   - wrong owner

If the ruling is already clear, stop here and issue it.

### 3. Deepen only when the ruling is still ambiguous

- Read only the smallest body sections needed to resolve the owner collision.
- Prefer boundary-bearing sections such as `Workflow`, `Do not use`, `Process`, output contract wording, and shared artifact names found during metadata triage.
- Use issue types only as support for the ruling:
  - `hard conflict`
  - `trigger overlap`
  - `artifact convention mismatch`
  - `responsibility blur`
  - `sequence dependency`
  - `duplicate/stale copy`
  - `benign adjacency`
- Prefer owner rulings, handoff rules, and small trigger edits before merge or rewrite recommendations.

### 4. Use the fallback shell only when it earns its cost

Load `references/interaction.md` only when:

- the user explicitly wants audit, batch comparison, or a full inventory
- there are too many plausible owners to narrow honestly from the current context
- an explicit depth, scope, or cost choice is needed before the ruling can be trusted

When the question is how to prove the changed ruling behavior with the cheapest useful live smoke, load `references/runtime-smoke-harness.md` first.

For narrow validation of ruling behavior after deterministic bundle checks, load `references/minimal-smoke-prompts.md`.

## Output

Default to a short ruling in the user's language:

```text
Situation
- <the ambiguous ownership situation>

Primary Owner
- <skill>

Do Not Use
- <skills that should not own this case>

Handoff Rule
- <when to stay, when to hand off>

Why
- <short evidence from metadata or boundary text>

Residual Uncertainty
- <what remains unclear, if anything>
```

If no actionable conflict exists, say so clearly and still explain the clean adjacency or handoff rule.
