# Skill Architect Breadth And Depth

Load this at the start of non-trivial skill design or major skill upgrades.

## Purpose

Use a breadth-and-depth pass to prevent two common failures:

- **narrow design**: the skill looks structurally tidy but ignores important dimensions such as authority, output contract, or bundle drift
- **undirected complexity**: the skill adds references, scripts, or assets without a clear reason

This pass is for design and upgrade work. Use a maintenance workflow instead when the main task is fixing drift or regressions inside an existing skill.

## Breadth Scan

Scan these dimensions before freezing the architecture:

- trigger boundary
- main-path clarity and branch-case load
- neighboring-skill routing
- authority and safety
- output contract and artifact quality
- interaction profile
- interaction intensity and pacing
- portability and language behavior
- bundle structure and internal consistency
- deterministic script opportunities
- assets or templates
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

## Depth Decision

Choose the lightest depth that still protects behavior:

- **implicit**: safe only when the dimension is genuinely irrelevant
- **light in `SKILL.md`**: use for always-needed boundaries, trigger rules, or short stable constraints
- **`reference`**: use for optional detail, variants, menus, checklists, or heavy explanation
- **`script`**: use for deterministic checks, parsing, validation, or repeated fragile work
- **`asset`**: use when output shape is best carried by a real template or resource

Do not deepen a dimension just because it exists. Deepen only when it protects against a real failure mode.

## Upgrade Use

For an existing skill being upgraded:

1. Run the same breadth scan.
2. Mark which dimensions are already strong, weak, or missing.
3. Upgrade only the dimensions that materially improve the skill's maturity.

If the main work is repairing drift, stale files, or broken behavior, hand off to a maintenance workflow instead of treating the task as architecture-first.

## Coverage Table Template

Render in the user's language when reporting.

```text
Breadth scan:
- Trigger boundary:
- Main-path clarity:
- Neighbor routing:
- Authority and safety:
- Output contract:
- Interaction profile:
- Interaction intensity:
- Portability and language:
- Bundle structure:
- Script opportunities:
- Assets/templates:
- Token cost:
- Validation:

Depth choices:
- Keep light in SKILL.md:
- Deepen in references:
- Extract into scripts:
- Use assets/templates:
- Defer explicitly:
```

## Pressure Prompts

```text
Prompt: Design a reusable skill for high-risk workflow setup, but keep it lightweight.
Expected behavior: scan the full dimension set, then deepen only authority, output contract, validation, and script opportunities instead of inflating every category.
```

```text
Prompt: Upgrade this existing skill so it feels more mature.
Expected behavior: run a breadth scan, identify weak dimensions, and propose targeted upgrades rather than a full rewrite.
```

```text
Prompt: Design a reusable workflow skill for long-lived project planning. The workflow has one common path and several rare branch cases.
Expected behavior: keep the dominant happy path early and easy to scan, move branch cases behind it, keep usage-expansion sections limited to trigger and wrong-scope guidance, and separate entrypoint roles instead of collapsing README, runtime entrypoint, and execution-state docs into one layer.
```
