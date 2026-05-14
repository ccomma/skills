---
name: product-validate
description: "Use when an existing product plan or roadmap slice needs rigorous challenge against docs, terminology, code, and decision boundaries before execution or replanning."
---

# Product Validate

## Overview

Stress-test an existing product plan against the project's owned artifacts before implementation or replanning continues.

Core pattern: **Load -> Challenge -> Reconcile -> Write Back -> Hand Off**.

This skill preserves the sharp questioning style of a grilling session, but grounds it in a product document stack such as `DESIGN.md`, roadmap, PRD, technical design, test plan, ADRs, and current handoff docs.

Default posture: validate the current phase or the current replanning slice first. Broader project-level validation is valid when the future direction is already documented in durable artifacts such as `DESIGN.md`, roadmap entries, ADRs, or written phase plans.

Default challenge posture: treat the current plan as a hypothesis to falsify, not a draft to bless. Keep grilling until the main contradictions, ownership ambiguities, dependency questions, and scenario gaps are either resolved or explicitly parked.

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
- wants to challenge a documented future phase, roadmap slice, or long-horizon direction that already exists in durable artifacts
- suspects terminology drift, hidden contradictions, missing boundaries, weak scenarios, or unrecorded trade-offs
- wants a product-plan stack to be sharpened without skipping directly into implementation

Do not use when:

- the product direction is still fundamentally fuzzy and needs discovery
- the user wants to challenge speculative future details that are not yet written into durable planning artifacts
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
- Increase questioning depth when the plan still has unresolved structural ambiguity. Do not stop at the first coherent-sounding answer.
- Provide a recommended answer or default hypothesis with each major question.
- Explore the codebase instead of asking the user for facts that are already inspectable.
- Walk the decision tree branch-by-branch. Resolve upstream dependency questions before debating downstream leaf details.
- Call out domain-language conflicts immediately when the plan, docs, or code use the same term with different meanings, and propose a sharper canonical term when needed.
- Distinguish fact, assumption, contradiction, open decision, and recommended repair.
- Stress-test the plan with concrete scenarios, edge cases, and unhappy paths that force boundary precision.
- Challenge ownership boundaries, not just local correctness. Ask whether a proposed platform layer is duplicating lifecycle, approval, or state-machine responsibility that already belongs to another system of record.
- Prefer falsification questions over comfort questions. Ask what would break this plan, what existing artifact contradicts it, and what scenario would force a different boundary.
- Keep an explicit mental queue of unresolved high-leverage questions. Do not collapse into summary mode while foundational questions remain open.
- Write back resolved conclusions in tight batches while the reasoning is still fresh. Do not let a long session accumulate dozens of implicit decisions that never make it back into the owning artifacts.
- Offer ADR capture sparingly. A conclusion deserves ADR treatment only when it is hard to reverse, surprising without context, and the result of a real trade-off.
- Write changes into the artifact that owns the decision instead of creating parallel truth.
- Stop once the plan is coherent enough to hand off to execution or replanning.

## Validation Scope Boundary

This skill supports two legitimate scopes:

- `phase-level validation`
  - Default mode.
  - Challenge the current phase package before implementation or midstream replanning continues.
  - Primary artifacts usually include `CURRENT_HANDOFF.md`, current phase `HANDOFF.md`, PRD, technical design, test plan, and implementation plan.

- `project-level validation`
  - Higher-bar mode.
  - Challenge long-horizon product direction, roadmap sequencing, durable architecture intent, or future phase fit.
  - Only use this when the future direction already exists in owned artifacts such as `DESIGN.md`, roadmap, ADRs, or written future phase plans.

Do not pretend to validate all future implementation details if those details are not yet planned. If the future remains fuzzy, route back to exploration or planning instead of stretching validation into speculation.

Load `references/validation-lenses.md` when choosing what to challenge. Load `references/terminology-governance.md` when language or domain-model precision is part of the risk. Load `references/writeback-rules.md` when deciding where resolved conclusions should be recorded. Load `references/adr-format.md` when a durable decision may deserve an ADR.

## Workflow

### 1. Load The Smallest Useful Context

Read in this order unless the user directs otherwise:

1. the execution-state artifact that matches the validation scope:
   - for `phase-level validation`: `docs/context/CURRENT_HANDOFF.md`, then current phase `HANDOFF.md`
   - for `project-level validation`: the roadmap or `DESIGN.md` section under challenge, then only the current handoff if needed for contradiction checking
2. the plan artifact under discussion, such as PRD, technical design, test plan, roadmap, or `DESIGN.md`
3. relevant ADRs
4. code and tests only when needed to confirm or falsify a claim

Do not bulk-load all history by default.

### 2. Choose Validation Mode

Pick the narrowest mode that matches the user's need:

- `phase package grill`: challenge the current phase package before execution
- `project direction grill`: challenge documented long-horizon direction, roadmap sequencing, or future phase fit
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
4. Map the decision tree and ask dependency-order questions before leaf-detail questions. If decision B depends on decision A, resolve A first.
5. Use concrete scenarios and edge cases to force precision.
6. Call out contradictions immediately when terminology, requirements, technical design, or code disagree.
7. When the plan introduces a new platform-side workflow, approval step, lifecycle, or state machine, ask whether that behavior should instead be reused from an existing downstream system, operational process, or owned domain service.
8. Keep grilling until the major open questions are exhausted, the remaining uncertainty is explicitly low-value, or the evidence shows the plan must return to replanning. Do not stop merely because the latest answer sounds plausible.
9. As important decisions crystallize, write them back to the owning artifacts before too many later questions pile on top of them. Use ADRs only when the decision meets the explicit durability threshold.

### 4. Write Back To Owning Artifacts

After a decision is resolved, update the owning artifact coherently. Do not duplicate the same rationale everywhere.

Do not update `CURRENT_HANDOFF.md` from this workflow. If the grilling outcome implies a real plan change, hand the result back to the planning workflow so it can reconcile durable docs first and then decide whether execution state should move.

### 5. Hand Off

Stop when one of these is true:

- the plan is coherent enough to execute
- the plan needs replanning before execution
- the remaining questions are low-value and can be parked explicitly

Do not treat "the current explanation sounds self-consistent" as a sufficient stop condition. The plan is only ready to hand off when the most important contradiction, dependency, ownership, and scenario-pressure questions have all been resolved or explicitly parked with rationale.

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
6. Distinguish platform governance from business-domain ownership. Reuse an existing downstream lifecycle when the plan does not need a second one.
7. A plan that still survives only because no one has pushed its strongest counterexamples is not yet validated.
8. Preserve artifact ownership; repair the source of truth instead of making side notes.
9. Do not mutate execution-state artifacts from a validation workflow.
10. Do not smuggle exploration or replanning decisions directly into accepted phase state.
11. Use the user's language for visible structure and questioning.
12. Default to phase-level validation unless the user is clearly challenging documented project-level direction.
13. Project-level validation may challenge future phases and roadmap choices, but must not hallucinate missing future implementation detail.
14. Stop once the plan is genuinely ready for execution or clearly needs replanning.

## Pressure Tests

Load `references/pressure-tests.md` before calling this skill mature.
