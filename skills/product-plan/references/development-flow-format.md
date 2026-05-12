# Development Flow Format

Use this when creating or repairing `docs/process/DEVELOPMENT_FLOW.md`.

## Purpose

`docs/process/DEVELOPMENT_FLOW.md` is the formal phase execution workflow for a serious project. It explains how planning turns into implementation and how phase evidence is preserved.

It is not a current-status file and not a project vision document.

## Required Structure

```text
Purpose of this workflow
Document responsibility boundary summary
Context loading protocol
Standard phase progression
Phase-end update rules
Branch and phase-package rules
Optional naming or template rules
```

## Minimum Content

It should explicitly define:

- the required planning-to-execution sequence
- what gets loaded first in a new implementation session
- when PRD, technical design, test plan, implementation plan, and acceptance evidence are expected
- what must be updated at phase closeout
- how branch naming and phase package naming stay aligned

## Quality Bar

- It should be strong enough that a weak entrypoint file can point to it and still preserve discipline.
- It should clarify why phase docs are separate rather than repeating the same rule in every phase package.
- It should prevent design docs, roadmaps, and handoffs from absorbing each other's roles.

## Anti-Patterns

Avoid:

- writing current phase status here
- repeating full product positioning
- reducing it to a one-line sequence without update rules
- letting it become a second roadmap
