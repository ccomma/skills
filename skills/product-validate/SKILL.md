---
name: product-validate
description: "Use when an existing phase package, product plan, or documented roadmap direction needs rigorous challenge against owned docs, code, terminology, and decision boundaries before execution or replanning."
---

# Product Validate

Challenge an existing product plan against the project's owned artifacts before implementation or replanning continues.

<what-to-do>

Treat the current plan as a hypothesis to falsify, not a draft to bless.

Default to the current phase or current replanning slice. Move up to project-level direction only when that future direction already exists in durable artifacts such as a design doc, roadmap, ADRs, or written future phase plans.

Start with the strongest unresolved trunk question, not a summary. Make the first move a real question whenever the repo does not already answer it.

Walk the decision tree branch-by-branch. Resolve upstream dependency questions before leaf-detail questions. For each major question, provide your recommended answer.

Ask one question at a time and wait for the user's answer before moving on, unless the repo itself can answer the question or the user is clearly speed-optimizing after the trunk model is already stable.

Stress-test the plan with pointed scenarios, counterfactuals, unhappy paths, terminology conflicts, and ownership challenges. Default to questions that force hidden models into the open: who owns the state, what freezes now versus later, what changes mid-flight, what proves this phase is ready to start, and whether a new platform-side workflow is duplicating responsibility that already belongs to a downstream system of record.

Keep pressing the same trunk question until it is actually resolved. Do not retreat into scope tidying, broad recaps, or cross-branch summaries while the real ownership, permission, freezing, recovery, or versioning model is still fuzzy.

Write resolved conclusions back to the artifact that owns the decision in small batches. Stop when the plan is ready to execute or clearly needs replanning.

</what-to-do>

<boundaries>

Use this only when there is already a real plan to challenge: a phase package, PRD, technical design, test plan, roadmap slice, design doc, or equivalent durable planning artifact.

Do not use this for fuzzy discovery, first-time planning, implementation planning, coding, debugging, verification, or code review.

If the job is only glossary or domain-language pressure against a context doc and ADRs, use a narrower domain-grilling workflow instead of this broader product-validation workflow.

Do not create or replace the plan from scratch. Do not update current execution-state handoff artifacts directly. Do not silently turn a speculative validation branch into accepted execution state.

</boundaries>

<workflow>

1. Load the smallest useful context:
   - default phase-level: the current execution-state handoff, the current phase handoff, then the plan artifact under challenge
   - project-level: the roadmap or design-doc section under challenge, then the current handoff only if contradiction checking needs it
   - read ADRs, code, and tests only when needed to confirm or falsify a claim

2. Find the first trunk question before giving any verdict:
   - pick the unresolved question that collapses the most uncertainty or exposes the most dangerous hidden assumption
   - prefer a counterfactual, scenario, timing-boundary, permission-boundary, version-boundary, or ownership-boundary question over a descriptive recap
   - if the repo already answers that question, inspect and move to the next unresolved trunk question

3. Ask the next highest-leverage question:
   - phrase it as a real challenge, not a soft recap
   - why it matters
   - your recommended answer
   - what artifact would need to change if the answer lands differently

4. After each answer or new repo evidence:
   - test whether the trunk question is actually resolved or only verbally soothed
   - if it is still fuzzy, ask the next sharper follow-up on the same branch before moving sideways
   - prefer follow-ups about ownership, permissions, freezing, recovery, replay, versioning, and activation timing when those semantics are still loose

5. Keep grilling until the main contradiction, dependency, ownership, and scenario questions are resolved or explicitly parked.

6. Write back to the owning artifact:
   - update the PRD, technical design, test plan, roadmap, design doc, or other source-of-truth artifact where the decision belongs
   - do not duplicate the same rationale everywhere
   - if the result implies a real plan change, hand back to planning before execution-state docs move

7. Conclude with:
   - validated decisions
   - contradictions found
   - open questions
   - recommended doc repairs
   - recommended next workflow

</workflow>

<rules>

- Use the user's language for visible questions and summaries.
- Prefer inspectable evidence over recollection.
- Default to a hard first question before a broad summary.
- One question per turn is the default interaction mode for non-trivial validation.
- Prefer scenario-shaped and counterfactual questions when a trunk decision is still unresolved.
- Do not switch to recap mode while the trunk decision is still fuzzy.
- Tighten terminology when meaning changes.
- Reuse existing downstream lifecycles when the plan does not need a second one.
- Do not stop at the first coherent-sounding answer.
- Do not create parallel truth; repair the source of truth.

</rules>

<references>

Load `references/validation-lenses.md` when deciding what to challenge. Load `references/terminology-governance.md` when language precision is part of the risk. Load `references/writeback-rules.md` when choosing where to record resolved conclusions. Load `references/adr-format.md` when a decision may deserve an ADR. Load `references/pressure-tests.md` before calling this skill mature.

</references>
