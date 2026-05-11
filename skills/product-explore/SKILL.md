---
name: product-explore
description: Use when a product or feature idea is still fuzzy and the user needs discovery before documentation or planning: clarify the real problem, target users, value, scope, assumptions, and success signals; then diverge and converge into a product brief. Trigger on vague product intent such as "I want to build X but I'm not sure why/how", "what should this product be", "help me explore this requirement", or "我想做 X 但不确定真实需求". Do not trigger for code implementation, code review, architecture refactoring, an already committed PRD/spec, or ordinary advice that is not about product discovery.
---

# Product Explore

## Overview

Turn vague product intent into a concrete Product Brief through a structured discovery conversation. This skill covers the fuzzy front end before documentation, phase planning, technical design, or implementation: figuring out what problem is worth solving, for whom, why now, and what direction is worth carrying forward.

Core pattern: **Diagnose -> Diverge -> Converge -> Handoff**.

This skill is a conversation facilitator. It clarifies and expands thinking, then stops at a Product Brief. It does not create PRDs, phase plans, technical designs, implementation tasks, roadmaps, code, or design validation reports.

## Artifact Contract

The only durable output this skill owns is a discovery artifact such as a `Product Brief` or extension brief.

This artifact is an input to a downstream documentation/planning workflow, not a replacement for roadmap, phase docs, technical design, implementation planning, or current execution state.

This skill must not:

- change `docs/context/CURRENT_HANDOFF.md`
- declare or switch the current phase
- rewrite roadmap, PRD, technical design, or implementation-plan artifacts directly
- treat a newly discovered direction as already accepted into the active project plan

## Response Language

Mirror the user's working language for visible labels, questions, templates, and status lines. Keep exact technical terms such as `Product Brief`, `JTBD`, `PRD`, `MVP`, or file paths when translating them would reduce precision.

If this skill runs in Chinese, use Chinese section labels in the final brief unless the user asks for English. Do not hardcode English output scaffolding in a Chinese session.

## When To Use

Use when the user:

- has a product, feature, workflow, or service idea but the real problem, user, value, or scope is unclear
- asks to explore, discover, brainstorm, or evaluate what should be built before committing to a direction
- presents a solution-shaped idea such as "recommendation system", "AI assistant", "dashboard", or "automation" and needs help reframing it into a product problem
- wants options and trade-offs before writing PRD, roadmap, technical design, or implementation plan

Do not use when:

- the user already has a committed PRD, detailed spec, or clear execution plan and wants to document or execute it
- the user wants code review, refactoring, debugging, API design, architecture advice, or implementation
- the user wants to validate an existing design against domain docs, code, ADRs, or a glossary
- the request is generic ideation, writing, naming, or career/product advice without a concrete product or feature opportunity

## Neighboring Workflow Routing

This skill is the first step in a product engineering chain:

```text
Fuzzy product intent
    -> Product discovery (this skill)
    -> Product-context documentation and planning
    -> Design/domain validation
    -> Implementation
```

Route away by capability category, not by private local skill names:

- Durable product docs, roadmap, PRD, technical design, phase handoff -> documentation and planning workflow, meaning the workflow that turns product direction into durable project documents and phased plans
- Stress-test a known plan against domain language, code, ADRs, or existing docs -> design validation workflow, meaning the workflow that challenges a proposed design against domain truth and recorded decisions
- Current-turn implementation boundary or task scoping -> execution-contract workflow, meaning the workflow that narrows one immediate action before coding or edits begin
- Code, tests, refactors, debugging, or review -> engineering workflow, meaning the workflow that changes or verifies implementation
- Deciding whether this skill should split, merge, or overlap with another skill -> skill-boundary workflow, meaning the workflow that compares multiple skills and clarifies which one should own which situation

## Capability Baseline

The skill must preserve these behaviors:

- discover the underlying product problem before accepting the user's proposed solution
- ask concrete hypothesis-driven questions instead of broad blank-page questions
- diverge before converging unless the user explicitly asks for a lean answer
- separate evidence-backed facts from assumptions and guesses
- keep non-selected ideas in "parked for later" instead of deleting them
- produce a Product Brief that downstream documentation/planning workflows can consume once
- stop after the brief unless the user explicitly asks to continue into another workflow
- keep discovery output separate from current phase state until a downstream planning workflow consumes it

## Protocol

### Phase 1: Diagnose

Understand what the user actually wants, not just what they said. Users often present a solution before naming the problem.

1. Restate the user's original intent in their language. Quote or closely paraphrase only enough to anchor the session.
2. Identify the smallest set of critical ambiguities:
   - Goal: what problem is being solved, for whom, and what happens if nothing changes?
   - Users: primary users, secondary beneficiaries, buyers, operators, and anti-users
   - Scope: included behavior, explicit non-goals, and boundary with adjacent workflows
   - Context: existing product, system, market, team, workflow, or data reality
   - Constraints: time, budget, team, technical constraints, compliance, integrations, risk tolerance
   - Success: what observable behavior, metric, or decision would prove this direction is worth pursuing?
3. Ask hypothesis-driven questions with 2-4 concrete options. Prefer "Which of these is closest?" over "What do you think?"
4. Cap diagnosis at 4-6 rounds for ordinary ambiguity and 6-8 rounds for high-risk or deeply unclear product bets. Stop earlier when the user accepts a framing, asks to skip ahead, or further questioning has diminishing returns.

If the user cannot answer, propose a default hypothesis and label it as an assumption to validate later.

### Phase 2: Diverge

Expand the possibility space before narrowing. Challenge hidden assumptions and look for what the user is not yet considering.

1. Pick 2-3 lenses from `references/lenses.md`; do not apply all lenses mechanically.
2. When the idea involves market risk, user research, monetization, or strategic commitment, load `references/discovery-methods.md` and pick only the relevant method adapters.
3. Summarize the expanded possibility space:
   - new user segments or jobs
   - alternative problem framings
   - solution options with different risk profiles
   - key assumptions and failure modes
   - valuable but parked ideas

### Phase 3: Converge

Turn the expanded possibility space into binding choices.

1. Present key trade-offs in the user's language. Use a compact table only when comparison helps.
2. Ask the user to make major decisions. If the runtime provides a structured question tool, use it for mutually exclusive choices; otherwise use numbered options.
3. If the user says "you decide", choose a recommendation, explain the trade-off, and mark unresolved assumptions.
4. Do not invent evidence. When a metric, target, or market claim is not backed by data supplied in the session, label it as an assumption, placeholder target, or validation question.

### Phase 4: Product Brief

Produce a Product Brief in the user's working language. The labels below are a contract, not mandatory English text; localize them when appropriate.

```markdown
## Product Brief: [Working title]

> Status: [awaiting downstream consumption, in the user's language]
> Evidence level: [facts supplied / assumptions / unknowns]

### Problem Statement
[Who has what problem, why it matters now, and what happens if nothing changes.]

### Target Users
- Primary: [direct user and core job]
- Secondary: [indirect beneficiary, buyer, operator, or stakeholder]
- Anti-users: [who this is explicitly not for]

### Core Value Proposition
[Outcome language: users can X without Y. Avoid "we built Z" as the main value.]

### Key Design Decisions
1. [Decision] - Why: [accepted trade-off and evidence/assumption]
2. [Decision] - Why: [accepted trade-off and evidence/assumption]
3. [Decision] - Why: [accepted trade-off and evidence/assumption]

### Boundaries
- In scope: [specific included behavior]
- Out of scope for now: [explicit non-goals]
- Parked for later: [valuable ideas from divergence that do not fit now]

### Success Signals
- Behavior signal: [observable user behavior]
- Quantitative signal: [metric or placeholder target; mark assumption if unvalidated]
- Qualitative signal: [feedback, confidence threshold, or stakeholder confirmation]

### Constraints And Assumptions
- Constraint: [hard limit]
- Assumption: [bet that needs validation]

### Validation Questions
[Questions that need research, data, or prototype feedback; not implementation tasks.]

### Recommended Next Workflow
[documentation/planning, validation, research, prototype, or stop]
```

### Phase 5: Handoff And Persistence

1. Summarize what was decided and what was deliberately deferred.
2. Stop at the Product Brief unless the user explicitly asks to continue into a downstream workflow.
3. Present the brief inline by default.
4. Save the brief only when one of these is true:
   - the user asks to save it
   - the current project already has a documented discovery or docs workflow
   - a downstream documentation/planning workflow is about to consume it
5. Before writing into a repository, respect local artifact ownership rules. If no discovery location exists, ask where to save instead of inventing a permanent structure.
6. If saved, prefer `docs/discovery/PRODUCT_BRIEF.md` only when that fits the project's existing docs layout. Include a status line in the user's language that marks it as transient and awaiting downstream consumption.
7. When the project already has an active `CURRENT_HANDOFF.md`, treat the brief as a candidate input to replanning. Do not edit current-phase, next-work, branch, or execution-state fields from within this skill.
8. If the user is exploring a mid-project expansion or pivot, label the artifact as a discovery input for replanning rather than as the new current phase.

## Interaction Pacing

- Ordinary fuzzy idea: ask 2-4 focused questions, apply 2 lenses, then converge.
- High-risk product bet: ask up to 6-8 diagnostic rounds, apply 3 lenses, and explicitly list assumptions.
- Overspecified idea with exploration intent: skip most diagnosis, apply 1-2 blind-spot lenses, then produce a lightweight brief.
- Impatient user: apply 1 high-signal lens and produce a lean brief with caveats.
- Repeated acceptance: batch low-risk convergence decisions instead of asking one by one.
- Disagreement, contradiction, safety risk, or evidence gap: slow down and ask the next single critical question.

## Rules

1. Hypotheses, not blank-page questions.
2. Problem before solution; outcome before feature list.
3. Diverge before converging unless the user asks for the lean path.
4. Use evidence labels: fact, assumption, unknown, validation question.
5. Preserve intent; refine and expand the user's vision without redirecting it into your preferred product.
6. Park ideas instead of killing them.
7. Keep output language aligned with the user.
8. Treat saved Product Briefs as transient handoff artifacts, not permanent product memory.
9. Do not continue into PRD, roadmap, technical design, or implementation unless the user explicitly asks for the next workflow.
10. The next step should be described by capability category such as documentation/planning workflow, not by assuming one specific downstream skill implementation.

## References

- Load `references/lenses.md` during Phase 2 when choosing divergence lenses.
- Load `references/discovery-methods.md` when the product risk calls for user research, JTBD, opportunity mapping, assumption testing, prioritization, or market framing.
- Load `references/example-flow.md` only when you need a concrete end-to-end sample.

## Pressure Tests

Before calling this skill mature, verify:

| # | Scenario | Expected behavior |
|---|----------|-------------------|
| 1 | "我想做一个智能推荐系统但不确定怎么做" | Trigger -> diagnose users/problem -> apply lenses -> converge -> Chinese Product Brief |
| 2 | "帮我做个东西" | Trigger only enough to ask concrete hypotheses about domain, user, and goal before proceeding |
| 3 | User supplies users, scope, constraints, and success criteria but asks to explore options | Skip most diagnosis -> apply blind-spot lenses -> lightweight convergence |
| 4 | "帮我重构这个 Java 类的包结构" | Do not trigger; route to engineering/refactoring workflow |
| 5 | User has a clear PRD and asks "拷打一下这个方案" | Do not take over; route to design/domain validation workflow |
| 6 | User says "直接给我建议" mid-diagnosis | Lean path: one lens, recommendation, explicit caveats |
| 7 | Chinese session | Final labels and status are Chinese; technical terms remain precise |
| 8 | No docs directory or no user save request | Present inline; do not create files without a persistence reason |
| 9 | Success metrics are unknown | Mark targets as assumptions or validation questions; do not invent evidence |
| 10 | Mid-project ideation with an active handoff | Produce a discovery artifact for replanning; do not modify current phase state |
