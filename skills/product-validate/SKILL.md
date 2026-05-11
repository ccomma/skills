---
name: product-validate
description: "Use when an existing product plan needs rigorous challenge against docs, terminology, code, and decision boundaries before execution or replanning."
---

# Product Validate

## Overview

Stress-test an existing product plan against the project's owned artifacts before implementation or replanning continues.

Core pattern: **Load -> Challenge -> Reconcile -> Write Back -> Hand Off**.

This skill preserves the sharp questioning style of a grilling session, but grounds it in a product document stack such as `DESIGN.md`, roadmap, PRD, technical design, test plan, ADRs, and current handoff docs.

## Artifact Contract

This skill owns validation output: questions, contradictions, recommendations, validation notes, and targeted repairs to the artifact layer that already owns the decision.

This skill must not:

- create or replace the initial product plan from scratch
- change `docs/context/CURRENT_HANDOFF.md` directly
- declare or switch the current phase
- silently rewrite roadmap sequencing as if a new direction were already accepted
- turn a speculative branch raised during validation into accepted execution state without downstream planning reconciliation

## Response Language

Mirror the user's working language for visible labels, questions, recommendations, and summaries. Keep exact technical tokens such as `PRD`, `ADR`, `JTBD`, `MVP`, `DESIGN.md`, or `CURRENT_HANDOFF.md` verbatim when translation would reduce precision.

## When To Use

Use when the user:

- already has a plan, design, PRD, technical design, test plan, or roadmap and wants it challenged before execution
- wants to stress-test a current or revised phase against existing docs, code, or prior decisions
- suspects terminology drift, hidden contradictions, missing boundaries, weak scenarios, or unrecorded trade-offs
- wants a product-plan stack to be sharpened without skipping directly into implementation

Do not use when:

- the product direction is still fundamentally fuzzy and needs discovery
- the project lacks a real plan and needs durable docs created or repaired first
- the user wants implementation planning, coding, debugging, verification, or code review
- the user only wants a glossary-only workflow built around `CONTEXT.md` and `docs/adr/` without the broader product document stack

## Neighboring Workflow Routing

This skill sits after planning and before implementation in a product engineering chain:

```text
Fuzzy product intent
    -> Product exploration
    -> Product-context documentation and planning
    -> Product validation and grilling (this skill)
    -> Implementation
```

Route away by capability category, not by private local skill names:

- Fuzzy direction, unclear users, or open-ended option discovery -> product exploration workflow
- Creating or repairing durable planning layers such as `DESIGN.md`, roadmap, PRD, technical design, test plan, or phase handoff -> documentation and planning workflow
- Narrowing one immediate execution slice before editing code -> execution-contract workflow
- Code, tests, refactors, debugging, verification, or review -> engineering workflow
- Deciding whether this skill should split, merge, or overlap with another skill -> skill-boundary workflow

## Core Behavior

- Ask pointed questions one at a time unless batching is clearly lower-friction.
- Provide a recommended answer or default hypothesis with each major question.
- Explore the codebase instead of asking the user for facts that are already inspectable.
- Distinguish fact, assumption, contradiction, open decision, and recommended repair.
- Write changes into the artifact that owns the decision instead of creating parallel truth.
- Stop once the plan is coherent enough to hand off to execution or replanning.

Load `references/validation-lenses.md` when choosing what to challenge. Load `references/terminology-governance.md` when language or domain-model precision is part of the risk. Load `references/writeback-rules.md` when deciding where resolved conclusions should be recorded. Load `references/adr-format.md` when a durable decision may deserve an ADR.

## Workflow

### 1. Load The Smallest Useful Context

Read in this order unless the user directs otherwise:

1. `docs/context/CURRENT_HANDOFF.md`
2. current phase `HANDOFF.md`
3. the plan artifact under discussion, such as PRD, technical design, test plan, roadmap, or `DESIGN.md`
4. relevant ADRs
5. code and tests only when needed to confirm or falsify a claim

Do not bulk-load all history by default.

### 2. Choose Validation Mode

Pick the narrowest mode that matches the user's need:

- `full plan grill`: challenge the plan end-to-end before execution
- `midstream replan grill`: challenge a changed direction before planning state is updated
- `terminology and domain pass`: focus on language, concepts, and boundary meanings
- `code consistency pass`: compare the docs against existing implementation
- `decision capture pass`: decide whether unresolved trade-offs need ADRs or doc tightening

### 3. Challenge The Plan

1. Ask one focused question at a time unless the user is explicitly speed-optimizing.
2. For each question, provide:
   - why the question matters
   - your recommended answer or default hypothesis
   - what artifact would need to change if the answer lands differently
3. If the answer can be checked in docs or code, inspect first.
4. Use concrete scenarios and edge cases to force precision.
5. Call out contradictions immediately when terminology, requirements, technical design, or code disagree.

### 4. Write Back To Owning Artifacts

After a decision is resolved, update the owning artifact coherently. Do not duplicate the same rationale everywhere.

Do not update `CURRENT_HANDOFF.md` from this workflow. If the grilling outcome implies a real plan change, hand the result back to the planning workflow so it can reconcile durable docs first and then decide whether execution state should move.

### 5. Hand Off

Stop when one of these is true:

- the plan is coherent enough to execute
- the plan needs replanning before execution
- the remaining questions are low-value and can be parked explicitly

Conclude with:

- validated decisions
- contradictions found
- open questions
- recommended doc repairs
- recommended next workflow

## Rules

1. Challenge the current plan, not the user's intelligence.
2. Ask the next most leverageful question, not every imaginable question.
3. Provide a recommendation with the question whenever useful.
4. Prefer inspectable evidence over user recollection.
5. Tighten terminology when it affects meaning, not as a ritual.
6. Preserve artifact ownership; repair the source of truth instead of making side notes.
7. Do not mutate execution-state artifacts from a validation workflow.
8. Do not smuggle exploration or replanning decisions directly into accepted phase state.
9. Use the user's language for visible structure and questioning.
10. Stop once the plan is genuinely ready for execution or clearly needs replanning.

## Pressure Tests

Load `references/pressure-tests.md` before calling this skill mature.
