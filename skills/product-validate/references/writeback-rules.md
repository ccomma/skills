# Writeback Rules

When a validation conclusion lands, record it in the artifact that owns the decision.

Do not wait until the entire grilling session is over if several important conclusions are already stable. Write back in tight, coherent batches while the exact reasoning and wording are still fresh.

## Owning Artifact Map

- durable product framing, cross-phase vocabulary, long-lived constraints -> `DESIGN.md`
- phase goals, ordering, exits, and prerequisites -> roadmap
- user-visible behavior, actors, scope, acceptance intent -> PRD
- architecture boundaries, component responsibilities, data contracts, integration behavior -> technical design
- test strategy, key scenarios, acceptance coverage -> test plan
- durable, surprising, hard-to-reverse trade-offs -> ADR

## Execution-State Rule

`docs/context/CURRENT_HANDOFF.md` is not an output surface for this workflow. If validation reveals a real plan change:

1. patch the owning durable docs first
2. hand the result back to the planning workflow
3. let planning decide whether execution-state docs should change

## Anti-Patterns

Avoid these:

- waiting so long to write back that the session summary has to reconstruct half-settled decisions from memory
- recording product rationale in `CURRENT_HANDOFF.md`
- inventing a new glossary file when `DESIGN.md` or the PRD already owns the vocabulary
- duplicating the same decision across roadmap, PRD, technical design, and acceptance docs
- capturing speculative alternatives as if they were accepted direction
