# Roadmap Format

Load this when creating or repairing the project's roadmap, such as `docs/roadmap/PROJECT_DEVELOPMENT_PLAN.md`.
It answers what phase strategy, sequencing, exits, and prerequisites the roadmap must express across the planning stack.
It does not replace PRD, technical design, implementation plan, or the current execution state.

## Purpose

The roadmap defines phase strategy: sequence, scope progression, exit conditions, and dependencies between phases.

It is not an implementation task board and not a second technical design.

## Required Structure

```text
Roadmap purpose and reading rule
Phase-by-phase plan:
  - phase name
  - goal
  - inputs
  - outputs
  - acceptance criteria
  - exit conditions
  - prerequisites for the next phase
```

## Required Quality Bar

- Each phase should answer what this phase is for and what changes when it finishes.
- The sequence should show dependency and evolution, not only ambition.
- Current and future phases should remain distinguishable.
- A reader should be able to tell whether a new request belongs to the current phase, a future phase, or a new phase.

## Anti-Patterns

Avoid:

- turning the roadmap into a task checklist
- storing detailed code-implementation slicing here
- leaving phase exits vague enough that completion is not judgeable
- mixing durable design rationale into every phase block
