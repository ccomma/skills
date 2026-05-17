# DESIGN Format

Load this when creating or repairing `DESIGN.md`.
It answers what durable product and architecture judgment belongs in `DESIGN.md` and what quality bar that artifact should meet.
It does not replace roadmap, phase package, current execution state, or docs governance layers.

## Purpose

`DESIGN.md` stores durable product and architecture judgment. It explains why the project exists, what long-lived boundaries matter, and which major tradeoffs were chosen.

It is not a roadmap, not a handoff, and not a docs-governance file.

It may record durable architecture principles and stable solution-shape judgments, but it should not become the default home for phase-local technical design or routine stack-choice churn.

## Required Structure

```text
Problem and product definition
Target users or operating context
Pain and value proposition
North star or success framing
Differentiation or strategic choice
Non-goals
Core design principles
Major architecture or solution tradeoffs
Stable boundaries and risk principles
```

## Required Quality Bar

- It should contain real judgment, not just aspiration.
- It should answer why the project takes this shape instead of obvious alternatives.
- It should remain useful after the current phase ends.
- It should feel worth reading in depth because it stores durable thinking, not execution convenience.

## Anti-Patterns

Avoid:

- storing current phase status, next work, or branch policy
- storing document loading order or shared-directory governance
- copying roadmap phase sequencing into design memory
- using `DESIGN.md` as a dumping ground for all important information
