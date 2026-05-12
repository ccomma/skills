# Implementation Plan Format

Use this when creating or repairing a phase `IMPLEMENTATION_PLAN.md`.

## Purpose

`IMPLEMENTATION_PLAN.md` turns accepted requirements, technical design, and test strategy into an ordered execution path.

It is not a second technical design and not the final acceptance record.

## Required Structure

```text
Execution objective
Preconditions
Ordered work slices
Validation checkpoints
Coordination or sequencing notes
Done criteria for this execution pass
```

## Required Quality Bar

- It should assume the architecture is already decided elsewhere.
- Ordered slices should reduce execution risk and coordination ambiguity.
- Validation checkpoints should connect each slice back to real verification.
- Another engineer should be able to resume execution from this file without redesigning the phase.

## Anti-Patterns

Avoid:

- restating architectural rationale already captured in technical design
- collapsing all work into one undifferentiated checklist
- omitting verification until the very end
- using implementation plan as a replacement for handoff or acceptance
