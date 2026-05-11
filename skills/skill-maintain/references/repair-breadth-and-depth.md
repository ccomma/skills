# Skill Maintain Repair Breadth And Depth

Load this at the start of non-trivial repair or correction work on an existing skill.

## Purpose

Use a maintenance breadth-and-depth pass to prevent two common failures:

- **narrow repair**: the workflow fixes the first visible symptom but misses adjacent drift such as labels, bundle metadata, or interaction behavior
- **over-repair**: the workflow rewrites half the skill when the real issue only needed a small targeted patch

This pass is for repair and correction work. Use an architecture workflow instead when the main task is to redesign or mature a skill rather than repair drift or failure.

When the user explicitly asks to review, inspect, audit, or check a named skill, assume they want this breadth scan by default even if they did not provide a bug list. The scan should actively look for drift and not wait for the user to point at every issue first.

## Maintenance Breadth Scan

Scan these dimensions before freezing the repair plan:

- trigger boundary and wrong-scope routing
- workflow clarity: dominant happy path, branch-case load, and entrypoint-role separation
- trigger-contract layering and reference-routing clarity
- portability and language behavior
- abstraction level
- structure and routing clarity
- output contract and artifact quality
- format-file opportunity and format-file quality
- interaction intensity and recovery behavior
- bundle consistency across files
- safety and authority boundaries
- deterministic script opportunities
- token economy
- validation and regression coverage

For each dimension, record one of:

- `no issue`
- `light wording fix`
- `section rewrite`
- `reference repair`
- `script-assisted repair`
- `bundle-wide patch`
- `defer explicitly`

If more than two adjacent dimensions look suspicious, the repair should not stop at the first reported symptom.

## Repair Depth Decision

Choose the lightest repair depth that actually removes the problem:

- **`no issue`**: the dimension is healthy enough to leave alone
- **`light wording fix`**: small clarifications, labels, or routing phrasing
- **`section rewrite`**: a focused rewrite inside `SKILL.md`
- **`reference repair`**: deeper correction in one or more reference files
- **`script-assisted repair`**: deterministic checks or summaries should help the repair
- **`bundle-wide patch`**: multiple linked files must change together
- **`defer explicitly`**: real issue acknowledged but intentionally left for later

Do not deepen a repair just because the dimension exists. Deepen only when drift, failure, or fragility makes it necessary.

## Coverage Table Template

Render in the user's language when reporting.

```text
Maintenance breadth scan:
- Trigger boundary:
- Workflow clarity:
- Trigger layering and reference routing:
- Portability and language:
- Abstraction:
- Structure and routing:
- Output contract:
- Format-file opportunity and quality:
- Interaction intensity:
- Bundle consistency:
- Safety and authority:
- Script opportunities:
- Token economy:
- Validation:

Repair depth:
- Light wording fix:
- Section rewrite:
- Reference repair:
- Script-assisted repair:
- Bundle-wide patch:
- Defer explicitly:
```

## Pressure Prompts

```text
Prompt: Repair this skill. The obvious bug is a bad label, but I suspect the output contract and reference bundle also drifted.
Expected behavior: scan adjacent dimensions, then choose targeted deeper repairs where needed instead of stopping at the first wording fix.
```

```text
Prompt: Fix this skill, but keep the patch as small as possible.
Expected behavior: run the breadth scan, confirm which dimensions have no issue, and keep repair depth intentionally narrow.
```
