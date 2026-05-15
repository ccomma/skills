# Skill Architect Design Expansion

Load this when one skill idea is already broadly understood, but you still need to expand it across the important product dimensions before freezing the design.

If you are not even sure whether design expansion is the next right move, load `reference-routing.md` first.

If the question is already clearly narrower than design expansion, jump directly to the narrower reference instead.

## Expansion Pass

Design expansion means: scan the important dimensions before freezing the skill shape so you avoid two failures:

- **narrow design**: the skill looks tidy but misses real product dimensions
- **undirected depth**: the skill deepens several dimensions without a real failure mode

This is an expansion pass for design and upgrade work, not the owner of every downstream design question.

Scan these dimensions before freezing the design:

- request and trigger fit
- first-read teaching model: what the skill shows first, and how much branch complexity it exposes
- neighboring-skill boundary
- authority and safety
- output contract and artifact quality
- interaction model
- interaction intensity and pacing
- portability and language behavior
- bundle and component strategy
- deterministic work opportunities
- resource or template opportunities
- default token cost and worst-case cost
- validation and pressure-test coverage

For each dimension, record one of:

- `not needed`
- `light in SKILL.md`
- `deepen in reference`
- `extract into script`
- `use asset/template`
- `defer explicitly`

If more than two important dimensions are left as "unspecified", the design is usually still under-architected.

## Depth Of Treatment

Depth means: decide how much design weight each dimension deserves.

It does not mean "more files is deeper". A dimension can be deeply designed while still staying light in `SKILL.md`, and it can also be overbuilt through unnecessary references, scripts, or assets.

Choose the lightest depth that still protects behavior:

- **implicit**: safe only when the dimension is genuinely irrelevant
- **light in `SKILL.md`**: use for always-needed boundaries, trigger rules, or short stable constraints
- **`reference`**: use when one dimension needs optional depth, variants, menus, checklists, or heavier explanation
- **`script`**: use when one dimension needs deterministic checks, parsing, validation, or repeated fragile work
- **`asset`**: use when one dimension needs a real template or resource

These are delivery mechanisms, not the definition of depth itself.

Do not deepen a dimension just because it exists. Deepen only when it protects against a real failure mode or clearly improves the skill's ability to satisfy the user's need.

## After Expansion

Once the dimensions are expanded, pick one next owner:

- `component-paths.md` for where one piece of guidance belongs
- `reference-design.md` for whether references should exist, merge, split, or sharpen
- `bundle-design.md` for what overall component combination the skill should keep
- narrower topical references only for the dimensions that truly need depth

If the next owner is still unclear, return to `reference-routing.md` instead of guessing.

## Upgrade Use

For an existing skill being upgraded:

1. Run the same expansion pass.
2. Mark which dimensions are already strong, weak, missing, or overbuilt.
3. Deepen only the dimensions that materially improve the skill's maturity or product fit.

If the main work is repairing drift, stale files, or broken behavior, hand off to a maintenance workflow instead of treating the task as architecture-first.

## Expansion Table Template

Render in the user's language when reporting.

```text
Design expansion:
- Request and trigger fit:
- First-read teaching model:
- Neighbor boundary:
- Authority and safety:
- Output contract:
- Interaction model:
- Interaction intensity and pacing:
- Portability and language:
- Bundle and component strategy:
- Deterministic work opportunities:
- Resource/template opportunities:
- Token cost:
- Validation:

Depth choices:
- Keep light in SKILL.md:
- Deepen through references:
- Deepen through scripts:
- Deepen through assets/templates:
- Defer explicitly:
```

## Pressure Prompts

```text
Prompt: Design a reusable skill for high-risk workflow setup, but keep it lightweight.
Expected behavior: expand the full dimension set, then deepen only authority, output contract, validation, and script opportunities instead of inflating every category.
```

```text
Prompt: Upgrade this existing skill so it feels more mature.
Expected behavior: run the expansion pass, identify weak dimensions, and propose targeted upgrades rather than a full rewrite.
```

```text
Prompt: Design a reusable workflow skill for long-lived project planning. The workflow has one common path and several rare branch cases.
Expected behavior: keep the dominant happy path early and easy to scan, move branch cases behind it, and deepen only the dimensions that protect the user's planning workflow instead of blindly adding structure.
```
