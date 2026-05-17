---
name: product-explore
description: "Use when a product direction is still fuzzy or prematurely solution-shaped and needs reframing into a problem-shaped Product Brief before planning."
---

# Product Explore

## Overview

Turn fuzzy or prematurely solution-shaped product intent into a problem-shaped `Product Brief` that downstream planning can actually use.

Default first move: restate the raw idea in the user's language, strip solution or technology framing when needed, and isolate the smallest unresolved ambiguity around problem, user, value, or boundary.

This is the fuzzy front end before planning or implementation. Its internal workflow is **Diagnose -> Diverge -> Converge -> Handoff**, but that workflow serves the core job; it is not the identity of the skill.

This skill recovers the real product problem, expands the option space only after that recovery starts, then stops at a `Product Brief`. It does not create PRDs, phase plans, technical designs, implementation tasks, roadmaps, code, or design validation reports.

## Artifact Contract

The only durable output this skill owns is an exploration artifact such as a `Product Brief`. It feeds downstream planning, but does not replace roadmap, phase docs, technical design, implementation planning, or current execution state.

This skill must not:

- change `docs/context/CURRENT_HANDOFF.md`
- declare or switch the current phase
- rewrite roadmap, PRD, technical design, or implementation-plan artifacts directly
- treat a newly explored direction as already accepted into the active project plan

## Response Language

Mirror the user's working language for visible labels, questions, templates, and status lines. Keep exact technical terms such as `Product Brief`, `JTBD`, `PRD`, or `MVP` only when translation would reduce precision.

## When To Use

Use when the user:

- names a solution too early, such as "AI assistant", "recommendation system", "dashboard", or "automation", and needs help recovering the real product problem underneath it
- has a product, feature, workflow, or service direction but the real problem, user, value, or scope is still unclear
- needs to clarify which problem, user, boundary, or success signal should anchor planning before expanding or selecting solutions
- wants options and trade-offs before writing PRD, roadmap, technical design, or implementation plan

Do not use when:

- the direction is already clear enough to become durable planning artifacts such as PRD, roadmap, technical design, or implementation plan
- the user already has a committed PRD, detailed spec, or clear execution plan and wants to document or execute it
- the user wants to challenge an existing design or plan against domain docs, code, ADRs, or a glossary
- the user wants code review, refactoring, debugging, API design, architecture advice, or implementation
- the request is generic ideation, writing, naming, or career/product advice without a concrete product or feature opportunity

## Neighboring Workflow Routing

This skill is the first step in a product engineering chain:

```text
Fuzzy product intent
    -> Product exploration (this skill)
    -> Product-context documentation and planning
    -> Design/domain validation
    -> Implementation
```

Route away by capability category, not by private local skill names:

- Direction is already stable enough for durable product docs, roadmap, PRD, technical design, or phase handoff -> documentation and planning workflow
- Stress-test a known plan against domain language, code, ADRs, or existing docs -> design validation workflow
- Current-turn implementation boundary or task scoping -> execution-contract workflow
- Code, tests, refactors, debugging, or review -> engineering workflow
- Deciding whether this skill should split, merge, or overlap with another skill -> skill-boundary workflow

## Capability Baseline

The skill must still:

- recover the underlying product problem before accepting the proposed solution framing
- restate the idea without solution or technology framing when that framing is hiding the real product need
- ask concrete hypothesis-driven questions instead of blank-page questions
- use the default Step 2 lens stack first, and escalate to conditional lenses or adapters only when a specific residual risk remains
- diverge before converging unless the user explicitly asks for a lean answer
- separate facts, assumptions, unknowns, and validation questions
- keep parked ideas instead of deleting them
- stop at a Product Brief unless the user explicitly asks to continue
- route generic naming or unconstrained ideation away instead of absorbing it as product exploration

## Workflow

Use these workflow steps after reclaiming the product problem. The steps teach how the skill works; they do not replace the core boundary above.

### Step 1: Reframe And Diagnose

1. Restate the user's original intent in their language. Quote or closely paraphrase only enough to anchor the session.
2. If the user named a solution, tool, or technology too early, restate it in problem language before expanding options.
3. Identify the smallest set of critical ambiguities across problem, users, scope, context, constraints, and success.
4. Ask hypothesis-driven questions with 2-4 concrete options. Prefer "Which of these is closest?" over "What do you think?"
5. Cap diagnosis at 4-6 rounds for ordinary ambiguity and 6-8 rounds for high-risk or deeply unclear product bets. Stop earlier when the user accepts a framing, asks to skip ahead, or further questioning has diminishing returns.

If the user cannot answer, propose a default hypothesis and label it as an assumption to validate later.

### Step 2: Diverge

1. Start with the default lens stack from `references/lenses.md`: `First-Principles Decomposition`, `Technology-Neutral Reframing`, and `Failure Mode Exploration`. Use 1-3 of these before reaching for anything else.
2. Load additional conditional lenses only when a specific unresolved risk remains, such as segmentation, adoption, quantitative worth, or constraint shaping.
3. Load `references/discovery-methods.md` only after Step 1 and the default lens stack still leave the main product risk unresolved. Pick the smallest adapter that closes that risk.
4. Summarize the expanded possibility space: alternative framings, user segments, solution options, assumptions, failure modes, and parked ideas.

### Step 3: Converge

1. Present key trade-offs in the user's language. Use a compact table only when comparison helps.
2. Ask the user to make major decisions. If the runtime provides a structured question tool, use it for mutually exclusive choices; otherwise use numbered options.
3. If the user says "you decide", choose a recommendation, explain the trade-off, and mark unresolved assumptions.
4. Do not invent evidence. When a metric, target, or market claim is not backed by data supplied in the session, label it as an assumption, placeholder target, or validation question.

### Step 4: Product Brief

Load `references/product-brief-format.md` before drafting the `Product Brief`. Produce the brief in the user's working language and keep it as a compact downstream handoff artifact, not a pseudo-PRD.

### Step 5: Handoff And Persistence

1. Summarize what was decided and what was deliberately deferred.
2. Stop at the `Product Brief` unless the user explicitly asks to continue.
3. Present the brief inline by default.
4. Save the brief only when one of these is true:
   - the user asks to save it
   - the current project already has a documented discovery or docs workflow
   - a downstream documentation/planning workflow is about to consume it
5. Before writing into a repository, respect local artifact ownership rules. If no discovery location exists, ask where to save instead of inventing one.
6. If saved, prefer `docs/discovery/PRODUCT_BRIEF.md` only when it fits the existing docs layout, and mark it as awaiting downstream consumption.
7. Treat the brief as replanning input, not current execution state.

## Interaction Pacing

- Ordinary fuzzy idea: 2-4 focused questions, 2 lenses, then converge.
- High-risk bet: up to 6-8 diagnostic rounds, 3 lenses, explicit assumptions.
- Overspecified or impatient user: skip most diagnosis, use 1-2 high-signal lenses, produce a lean brief with caveats.
- Disagreement, contradiction, or evidence gap: slow down and ask the next critical question.

## Rules

1. Hypotheses, not blank-page questions.
2. Recover the problem before accepting the solution; outcome before feature list.
3. Diverge before converging unless the user asks for the lean path.
4. Use evidence labels: fact, assumption, unknown, validation question.
5. Preserve intent; refine and expand the user's vision without redirecting it into your preferred product.
6. Park ideas instead of killing them.
7. Keep output language aligned with the user.
8. Treat saved Product Briefs as transient handoff artifacts, not permanent product memory.
9. Do not continue into PRD, roadmap, technical design, or implementation unless the user explicitly asks for the next workflow.
10. Name the next step by capability category, not by assuming one specific downstream skill implementation.

## References

- Load `references/lenses.md` during Step 2 when choosing divergence lenses.
- Load `references/discovery-methods.md` only when Step 1 plus the default lenses still leave the main product risk unresolved.
- Load `references/product-brief-format.md` during Step 4 when drafting the final `Product Brief`.
- Load `references/example-flow.md` only when you need a concrete end-to-end sample.

## Pressure Tests

Before calling this skill mature, verify at least these cases:

- underspecified idea -> diagnose and converge without blank-page interviewing
- overspecified idea -> skip redundant intake, label gaps as assumptions, and produce a lighter brief instead of forcing a full discovery pass
- planning-ready direction -> first response hands off quickly instead of reopening broad exploration
- existing plan under challenge -> first response routes to design validation instead of rebuilding the brief
- generic naming or unconstrained ideation -> first response routes away instead of pretending it is product exploration
- wrong engineering scope -> route to engineering instead of absorbing implementation work
- impatient user -> use the lean path with explicit caveats instead of insisting on more intake rounds
- active handoff -> produce replanning input, not execution-state edits
