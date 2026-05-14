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

For project-level validation, use this lens to challenge documented future phases or roadmap sequencing. Do not use it to invent detail for future work that has not yet been planned.

## 6. Technical Feasibility And Architecture Alignment

- Does the technical design actually satisfy the product requirement?
- Are there hidden non-functional constraints such as latency, operability, data ownership, or integration boundaries?
- Does the design assume infrastructure or contracts that the project does not have yet?

When the design adds a new platform-side step, service, or control loop, ask:

- Is this capability truly owned here, or is it already owned by a downstream business system or operational workflow?
- Is the plan creating a second lifecycle, approval chain, or state machine where reuse would be cleaner?
- Does the platform need governance, visibility, or traceability only, or does it truly need to own a new business process?

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

## 9. Decision Tree And Dependency Order

- Which unresolved decisions are foundational, and which are downstream consequences?
- Is the discussion getting stuck on leaf details before the trunk decisions are actually settled?
- What question, if answered now, would collapse the most uncertainty across the rest of the plan?

Use this lens to preserve the strongest part of a real grilling session: walk the design tree in dependency order instead of collecting disconnected comments.

## 10. System Ownership And Lifecycle Reuse

- Is the plan introducing a platform-owned workflow that duplicates an existing workflow in another system of record?
- Is the proposed validation or approval step governing an agent action, or replacing an already-owned business approval chain?
- Are we adding a second copy of a lifecycle because the boundary is unclear, or because the platform truly needs a different owned state model?

Use this lens when a platform, orchestration, governance, or control layer is being added around existing downstream systems.

## 11. Falsification And Counterexample Search

- What is the strongest concrete scenario that would break this plan if one hidden assumption is wrong?
- Which existing artifact, code path, operator workflow, or state transition most strongly contradicts the current explanation?
- If the current proposal is wrong, where would implementation fail first: ownership, API contract, lifecycle semantics, acceptance, or operability?
- Has the plan only been explained, or has it actually survived adversarial examples?

Use this lens when a plan starts sounding coherent too early. The goal is not to add random skepticism, but to force the plan to survive the strongest realistic counterexample before it is treated as validated.
