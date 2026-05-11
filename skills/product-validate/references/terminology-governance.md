# Terminology Governance

Tighten language only when it changes product or engineering meaning.

## What To Challenge

- one term used with multiple meanings across `DESIGN.md`, PRD, technical design, or acceptance language
- different terms used for the same concept
- actor names, states, or lifecycle steps vague enough to mislead implementation
- phase boundaries that depend on an undefined noun

## How To Challenge

For each weak term:

1. name the ambiguity directly
2. propose the canonical term
3. name the avoided aliases when they create real confusion
4. give one concrete scenario that shows why the distinction matters

## Where To Write Back

- cross-phase product vocabulary -> `DESIGN.md`
- requirement-local terms, actors, or acceptance language -> PRD
- architecture concepts, data shapes, or component vocabulary -> technical design

Prefer tightening the owning artifact over inventing a glossary doc. If the project already has `CONTEXT.md` or another vocabulary artifact, use it instead of duplicating terminology elsewhere.
