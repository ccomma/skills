# Handoff Format

Use this when `product-plan` creates or repairs a phase `HANDOFF.md` or `docs/context/CURRENT_HANDOFF.md`.

## When To Use

Use this for operational handoff artifacts that future sessions should load first.

Do not use this as a second design document. Long product rationale belongs in `DESIGN.md`, PRD, roadmap, or technical design.

## Required Structure

```text
Load order:
Current phase:
Phase goal:
Branch and commit policy:
In scope:
Out of scope:
Key artifacts:
Owned files / files to avoid:
Verification commands:
Next work:
Context budget rule:
```

## Required Quality Bar

- `Load order` points to the minimum documents needed to resume safely.
- `Current phase` and `Phase goal` are operational, not aspirational.
- `Branch and commit policy` includes the active phase branch when one exists.
- `In scope` and `Out of scope` are explicit enough to prevent drift.
- `Verification commands` are real commands, not placeholders.
- `Next work` is concrete enough that another agent can continue without re-planning the whole project.

## Optional Additions

Add only when useful:

- avoid list for sensitive files
- noteworthy risks blocking the next step
- explicit resume caveats when the project is mid-replan

## Anti-Patterns

Avoid:

- repeating full design rationale
- pasting large sections from PRD or technical design
- using handoff as the source of truth for product decisions
- leaving stale next-work items after the work is already done
