# Technical Design Format

Load this when creating or repairing a phase technical design.
It answers how accepted product requirements should be translated into a phase-specific architecture and delivery contract.
It does not replace product strategy, implementation sequencing, or the current execution state.

## Purpose

The technical design translates accepted product requirements into an architecture and delivery contract for implementation.

It is not the product strategy file and not the execution slicing file.

Phase technical designs own phase-specific architecture, integration structure, and implementation-facing tradeoffs.

If a technical choice becomes a durable cross-phase foundation decision rather than a phase-local design choice, extract it into an ADR and let later phase technical designs reference that ADR instead of duplicating the rationale everywhere.

## Required Structure

```text
Design goal and scope
Relevant requirements mapping
Architecture or module changes
Interfaces and data contracts
State, storage, or lifecycle considerations
Failure modes and recovery behavior
Observability, security, or operational constraints
Testing impact
Tradeoffs and rejected alternatives
```

## Required Quality Bar

- It should make implementation boundaries clearer, not merely restate the PRD.
- It should explain why the chosen structure is acceptable relative to alternatives.
- It should surface important failure, operational, and integration concerns early enough to shape implementation.
- Another engineer should be able to implement from it without inventing the architecture from scratch.

## Anti-Patterns

Avoid:

- copying product positioning or roadmap narrative
- collapsing into a class-by-class inventory with no system view
- omitting failure and observability concerns for externally meaningful changes
- mixing ordered task slicing into the design itself
