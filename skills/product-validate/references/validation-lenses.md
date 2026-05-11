# Validation Lenses

Choose only the lenses needed for the current plan. Do not run every lens mechanically.

## 1. Terminology And Domain Model

- Are the key nouns stable across `DESIGN.md`, PRD, technical design, and acceptance language?
- Does one word carry multiple meanings in different docs?
- Are actors, resources, states, or lifecycle steps named consistently enough that implementation will not drift?

Use this lens when language ambiguity could change product scope, API shape, data contracts, or acceptance criteria.

## 2. Problem And User Consistency

- Does the proposed design still solve the problem stated in the PRD or `DESIGN.md`?
- Do the target users in different artifacts still match?
- Has the technical approach quietly optimized for a different user or operator than the product plan intended?

## 3. Scope And Boundary Clarity

- What is explicitly in scope for the current phase?
- What is deferred, parked, or intentionally unsupported?
- Where could implementation teams interpret the boundary differently?

Use concrete counterexamples to expose hidden scope creep.

## 4. Scenario And Edge-Case Coverage

- What common scenario is missing from the plan?
- What unhappy path would force a different requirement or interface?
- What operational or data state transition is underspecified?

Prefer scenarios that would break implementation or acceptance if left vague.

## 5. Roadmap And Phase Fit

- Does this requirement belong in the current phase at all?
- Does it assume prerequisites that are only planned for a later phase?
- Would accepting this decision silently reorder the roadmap?

This lens is especially important during midstream replanning.

## 6. Technical Feasibility And Architecture Alignment

- Does the technical design actually satisfy the product requirement?
- Are there hidden non-functional constraints such as latency, operability, data ownership, or integration boundaries?
- Does the design assume infrastructure or contracts that the project does not have yet?

## 7. Code-Versus-Docs Consistency

- Do the docs describe behavior the code does not implement?
- Does the code reveal constraints, defaults, or state transitions missing from the docs?
- Is there legacy behavior that the new plan would contradict?

Inspect the code before asking a question the repo can already answer.

## 8. Decision Durability

- Is this a one-phase implementation detail or a durable cross-phase decision?
- Would a future reader ask "why did they choose this?"
- Were there meaningful alternatives with real trade-offs?

If yes, consider an ADR or durable note in `DESIGN.md`.
