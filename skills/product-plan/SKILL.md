---
name: product-plan
description: "Use when a product direction is clear enough to become a durable planning stack centered on a phase package, with aligned source-of-truth layers and execution-state handoff."
---

# Product Plan

## Overview

Turn a planning-ready product direction into a durable planning stack centered on the current or next phase package.

Default first move: inspect the existing planning layers and current execution state, then decide whether the work is a cold start, a midstream replan, or a repair pass.

This skill owns the planning workflow that connects upstream direction to executable phase work. It keeps the current or next phase package aligned with `DESIGN.md`, roadmap, `CURRENT_HANDOFF.md`, and the phase-level source-of-truth artifacts so a future teammate or agent can continue without reconstructing the plan from scratch.

Use this for serious, multi-phase work. For a prototype or one-off task, keep it light: a README and short handoff are enough.

This skill prepares durable planning artifacts. It does not replace product exploration, plan validation, implementation planning, code work, debugging, verification, or review.

The goal is not document completeness for its own sake. The goal is to keep planning-ready direction, phase execution state, and durable source-of-truth layers in the right places so the delivery path stays understandable across sessions, runtimes, and future maintainers.

## Artifact Contract

The core owned object is the current or next phase package:

- `HANDOFF.md`
- `IMPLEMENTATION_PLAN.md`
- `ACCEPTANCE.md`

Alongside that core object, this skill maintains the source-of-truth relationship between:

- `DESIGN.md` for durable product judgment
- roadmap for sequencing and exits
- `CURRENT_HANDOFF.md` for current execution state
- phase PRD, technical design, and test plan for requirements, architecture contract, and testing strategy

`Product Brief` is upstream planning input. It may shape roadmap or phase-doc changes, but it does not directly become current execution state.

## When To Use

Use when the user asks to:

- turn a planning-ready product direction into durable planning artifacts for serious product or product-like engineering work
- create or repair the planning layers around the current or next phase package, including `DESIGN.md`, roadmap, handoffs, PRDs, technical designs, test plans, implementation plans, and acceptance evidence
- align source-of-truth ownership between durable planning artifacts and current execution state
- diagnose document responsibilities, loading flow, or ownership drift before authorizing planning-layer repair

Do not use when the direction is still fuzzy and needs a `Product Brief`, when an existing plan needs to be challenged against docs or code before execution, or when the work is code execution, refactoring, debugging, verification, code review, feature brainstorming, direct plan grilling, or implementation planning. Hand off to the appropriate exploration, validation, or engineering workflow instead.

## Upstream Inputs

This workflow may start from a `Product Brief`, an already accepted product direction, or an existing project that needs replanning. Accept upstream input by capability, not by one specific skill name.

## Core Pattern

This workflow is phase-package-centered even when the surrounding stack is broader. The planning modes below are branch cases inside that workflow, not separate product identities:

- `cold start`: set up the initial durable document stack before implementation begins
- `midstream replan`: incorporate a new direction, extension, or pivot into the existing document stack without silently promoting it into current execution state
- `review mode`: inspect document responsibilities, loading flow, and ownership quality without defaulting to full rewrites

Project sizing matters before document creation. A prototype, a small continuing repo, a serious multi-phase product, and a large multi-writer project should not receive the same document weight by default.

Default loading order for an existing project:

1. Runtime entrypoint file such as `AGENTS.md`, `CLAUDE.md`, or an equivalent cold-start file.
2. `docs/context/CURRENT_HANDOFF.md` for current phase, branch, next work, avoid list, and verification commands.
3. Current phase `docs/phases/<phase>/HANDOFF.md`.
4. Current task code and tests.
5. `README.md` only when repo-level orientation or public-facing project guidance is needed.
6. Load PRD, technical design, test plan, roadmap, or `DESIGN.md` only when the shorter context cannot answer the question.

Formal supporting layers for serious multi-phase projects:

- `docs/README.md` for shared-namespace ownership and auxiliary-directory policy
- `docs/process/DEVELOPMENT_FLOW.md` for the mandatory phase execution workflow and context-loading protocol
- `docs/templates/` for project-visible reusable document skeletons once the project is large enough to justify them

Default document order for a new project:

1. `DESIGN.md`
2. `docs/roadmap/PROJECT_DEVELOPMENT_PLAN.md`
3. Cold-start entrypoint file. It must point first to `docs/context/CURRENT_HANDOFF.md` and also reference the project's phase execution flow.
4. `docs/README.md` when the project has or is likely to gain a non-trivial `docs/` tree
5. `docs/process/DEVELOPMENT_FLOW.md`
6. `docs/context/CURRENT_HANDOFF.md`
7. `docs/phases/phase-01-<slug>/HANDOFF.md`
8. First phase PRD, technical design, and test plan
9. `docs/phases/phase-01-<slug>/IMPLEMENTATION_PLAN.md` only after the PRD, technical design, and test plan exist
10. `docs/phases/phase-01-<slug>/ACCEPTANCE.md`
11. `docs/templates/` when the project is serious enough that repeated phase artifacts should not drift in structure

Default update order for a midstream replan:

1. Read `CURRENT_HANDOFF.md`, the current phase handoff, roadmap, and affected PRD / technical design first.
2. Treat the new direction as planning input, not current execution state.
3. Update durable layers before `IMPLEMENTATION_PLAN.md`.
4. Update `CURRENT_HANDOFF.md` only after the planning layers agree on the accepted direction.

If the cold-start entrypoint file exists but only says "read CURRENT_HANDOFF.md" without referencing the phase execution workflow, repair it.

`IMPLEMENTATION_PLAN.md` is an execution-slicing document. It should translate accepted requirements, design, and test strategy into an ordered implementation path. It is not a second technical design.

When multiple runtime entrypoint files exist, treat them as an entrypoint family: they should be semantically aligned, but they do not need identical wording. Each one must independently support safe cold start for its runtime.

## Document Ownership

Keep each layer narrow around the phase package rather than treating every planning document as an equal first-class identity:

- entrypoint file: minimum cold-start loading order, mandatory phase workflow reference, and smallest must-know runtime rules
- `DESIGN.md`: durable product judgment, not daily execution detail
- `docs/README.md`: shared `docs/` namespace ownership, source-of-truth rules, and auxiliary-directory policy
- `docs/process/DEVELOPMENT_FLOW.md`: phase execution workflow, context-loading protocol, and document progression rules
- roadmap: phase sequence, goals, exits, and prerequisites
- `CURRENT_HANDOFF.md`: minimum current context, branch, next work, and verification commands for current execution state
- phase package: `HANDOFF.md`, `IMPLEMENTATION_PLAN.md`, and `ACCEPTANCE.md` for one phase; this is the center of current executable planning state
- PRD / technical design / test plan: requirements, architecture contract, and testing strategy
- ADR: sparse, durable, cross-phase decisions, especially hard-to-reverse technical foundation or stack choices once they stabilize
- `README.md`: public entrypoint, reading paths, and quickstart
- `docs/templates/`: project-visible reusable skeletons that reinforce stable structure, not live project status or proof

Reference loading guide:

- Structure and layering:
  - Load [references/layered-docs.md](references/layered-docs.md) for detailed structure, naming, and phase-end shapes.
  - Load [references/entrypoint-family.md](references/entrypoint-family.md) when multiple runtime entrypoints exist or when entrypoint responsibilities are blurred.
  - Load [references/auxiliary-docs-policy.md](references/auxiliary-docs-policy.md) when the repo has helper directories or helper files outside the core planning stack.
  - Load [references/docs-namespace-readme.md](references/docs-namespace-readme.md) when creating or repairing `docs/README.md`.
  - Load [references/development-flow-format.md](references/development-flow-format.md) when creating or repairing `docs/process/DEVELOPMENT_FLOW.md`.

- Core document formats:
  - Load [references/readme-format.md](references/readme-format.md) when creating or repairing `README.md`.
  - Load [references/design-format.md](references/design-format.md) when creating or repairing `DESIGN.md`.
  - Load [references/roadmap-format.md](references/roadmap-format.md) when creating or repairing the roadmap.
  - Load [references/prd-format.md](references/prd-format.md) when creating or repairing a phase PRD.
  - Load [references/technical-design-format.md](references/technical-design-format.md) when creating or repairing a phase technical design.
  - Load [references/test-plan-format.md](references/test-plan-format.md) when creating or repairing a phase test plan.
  - Load [references/implementation-plan-format.md](references/implementation-plan-format.md) when creating or repairing a phase `IMPLEMENTATION_PLAN.md`.
  - Load [references/handoff-format.md](references/handoff-format.md) when creating or repairing handoff artifacts.
  - Load [references/acceptance-format.md](references/acceptance-format.md) when creating or repairing acceptance artifacts.

- Cross-cutting quality and governance:
  - Load [references/language-strategy.md](references/language-strategy.md) when internal working docs, public entry docs, templates, or visible labels may need different language treatment.
  - Load [references/consistency-constraints.md](references/consistency-constraints.md) when cross-project structure drift is a key concern.
  - Load [references/quality-bars.md](references/quality-bars.md) when document quality, depth, or cross-project consistency is a key concern.

## Workflow

Execute the 5 steps below in order. Do not skip straight to document creation because the user named one file to update.

### 1. Classify

Confirm this is product-context work. If the user is asking for code execution, refactoring, debugging, verification, or review, hand off to the more specific skill.

Before applying the full stack, classify:

1. project size and expected lifespan
2. whether this is cold start, midstream replan, or review mode
3. whether the existing document system is low quality, mixed quality, or already high quality
4. whether the project needs an explicit language strategy for internal working docs versus public entry docs

Do not assume every project needs the heavy serious-project stack. Use [references/project-sizing.md](references/project-sizing.md) before deciding default document weight. Use [references/existing-quality-assessment.md](references/existing-quality-assessment.md) before deciding whether to rewrite broadly or repair locally.

### 2. Inspect Minimal Context

Read the current handoff first. Do not load all historical docs by default. If there is no handoff, create one early so the project has a future entrypoint.

Before creating or modifying any file, produce a visible inventory:

1. List all existing top-level docs and `docs/` subdirectories
2. Map each artifact to its document layer (DESIGN.md, PRD, Technical Design, ADR, Phase package, etc.)
3. Identify gaps: which required layers are missing? Which phases lack packages? Is `docs/README.md` missing? Is `docs/process/DEVELOPMENT_FLOW.md` missing? Are reusable templates absent even though the project clearly has repeated phase artifacts?
4. Identify quality posture: which existing layers are already strong enough to preserve? Which ones are weak, mixed, or drifted? Which helper directories are harmless versus structurally misleading?
5. Make the gap analysis visible before proceeding to Repair. Stop there only in `review mode` or before `heavy` / clearly high-risk repair. In `light` and `medium` repair paths, continue into repair after presenting the analysis unless the user asked to stop at review.

This prevents duplicate docs and missing layers.

Consume transient discovery artifacts when `docs/discovery/` exists:

1. Read them and extract: the core direction, key design decisions, boundaries, and parked ideas
2. Incorporate relevant insights into the roadmap and phase planning
3. After consumption, update the status line to indicate "consumed" with the date, or delete the file. Use the same language as the original status line.

Do not treat discovery artifacts as execution-state docs, and do not leave them as long-term handoff dependencies after consumption.

Verify that the cold-start chain is complete: entrypoint file -> `CURRENT_HANDOFF.md` -> development flow.

If the project has more than one runtime entrypoint file, verify the entrypoint family: each entrypoint should independently route to `CURRENT_HANDOFF.md`, the phase execution workflow, and the project's must-know runtime rules.

### 3. Repair Or Create Layers

Move content to the layer that owns it. Prefer coherent rewrites over scattered addenda.

Choose repair depth deliberately:

- `light`: fix ownership drift, loading drift, or missing governance with minimal rewrites
- `medium`: rewrite one or two layers that are structurally wrong
- `heavy`: reshape the full stack only when the existing system is low quality, contradictory, or still effectively missing

Do not punish an already strong project by rewriting good documents just to enforce textual uniformity. Preserve high-quality material and repair only the parts that violate ownership, loading safety, or delivery support.

For the common path, create or repair layers in this order:

1. `DESIGN.md`
2. roadmap
3. runtime entrypoint file
4. `docs/README.md` when the repo's `docs/` tree is non-trivial or includes auxiliary directories
5. `docs/process/DEVELOPMENT_FLOW.md`
6. `docs/context/CURRENT_HANDOFF.md`
7. current phase `HANDOFF.md`
8. current phase PRD
9. current phase technical design
10. current phase test plan
11. current phase `IMPLEMENTATION_PLAN.md`
12. `docs/templates/` when the project is large enough that stable repeated document shapes should be project-visible assets rather than implicit skill memory

Treat `handoff-format.md`, `acceptance-format.md`, the `docs/README.md` reference, and the development-flow reference as first-class companion formats when shaping those artifacts.

Do not create `IMPLEMENTATION_PLAN.md` before the PRD, technical design, and test plan exist.

When touching `DESIGN.md`, apply [references/design-format.md](references/design-format.md) plus [references/design-growth-policy.md](references/design-growth-policy.md). Only durable product judgment, stable design tradeoffs, and long-lived boundaries belong there.

When a hard-to-reverse technical stack or foundation choice becomes a durable cross-phase decision, capture it in an ADR and let later phase technical designs reference it. Keep phase-specific architecture and implementation tradeoffs in the phase technical design instead of pushing them into `DESIGN.md`.

When touching the roadmap, phase PRD, technical design, test plan, or implementation plan, apply the corresponding companion format reference instead of improvising a fresh structure.

When creating or refreshing project templates, apply [references/template-lifecycle.md](references/template-lifecycle.md). Templates are not one-time scaffolds; they are long-lived structure-control assets.

When templates, handoffs, or visible labels are part of the work, apply [references/language-strategy.md](references/language-strategy.md) before finalizing wording.

### 4. Preserve Evidence

At phase closeout:

- Merge to main and push both main plus the phase branch.
- Update `docs/context/CURRENT_HANDOFF.md` for the next session
- Update current phase `ACCEPTANCE.md` for commands, results, final artifacts, commits, risks
- Update `README.md` incrementally; at project completion, rewrite it holistically as the definitive entrypoint.

Phase branches are part of the evidence trail. Do not leave them local-only unless the user explicitly chooses to skip pushing.

If a historical phase predates this structure, create a compact phase package with evidence from commits, tests, and known artifacts.

### 5. Hand Off To Validation Or Execution

After the context architecture is clean, decide whether the plan should be challenged before execution. If terminology is still fuzzy, the owning docs disagree, the current phase boundary is uncertain, the technical design needs pressure-testing, or the code may contradict the docs, hand off first to a design validation workflow that grills the plan against the existing artifacts without mutating execution-state docs. If the plan is already coherent enough, hand off to the appropriate implementation workflow.

Ensure `CURRENT_HANDOFF.md`'s load order references the project's phase execution workflow so the agent knows what concrete steps to follow (create branch -> implement -> refactor -> test -> closeout -> merge). Do not turn this skill into a substitute for design validation, implementation planning, TDD, debugging, verification, or review.

`CURRENT_HANDOFF.md` is an execution-state artifact, not a discovery scratchpad. Update it only after the accepted planning layers are internally consistent.

In review mode, stop after diagnosing boundary and quality issues unless the user asked for direct repair. Use [references/review-mode.md](references/review-mode.md) to keep review output focused on responsibilities, ownership drift, and minimum corrective moves.

## Branch Cases

### Midstream Replan

Use this branch only when a new direction appears after work has already started.

- Completed phases are evidence records by default; do not silently rewrite them.
- The current phase may be updated only while its scope is still materially fluid.
- Future phases remain editable.
- If a current-phase change would break the current phase goal, prefer opening a new phase instead of mutating the existing one beyond recognition.

### Shared Namespace Rules

`docs/` is a shared namespace, not this skill's private workspace.

Before creating or editing documents:

1. Inventory existing top-level docs and `docs/` subdirectories.
2. Classify each artifact by purpose, not by which skill created it.
3. Preserve the owner of any existing artifact when its purpose is clear.
4. Reference instead of copy.
5. Create a new artifact only when no existing artifact already owns that responsibility.

Ownership means responsibility for the source of truth, not exclusive permission to read.

Prefer predictable subdirectories only when they match the project's existing layout. Handoffs may link to owned artifacts but should not paste their full content. Acceptance docs may cite commands, results, commits, and risks but should not become product rationale or architecture design.

Auxiliary directories are allowed. Treat them as helper layers unless they clearly own source material for the current task. They do not enter the default load chain just because they sit under `docs/`.

This branch matters most in existing projects, shared doc trees, or multi-writer environments. It is not the focus of the usual single-project happy path.

## Quality Checks

- Project size and document weight match each other.
- High-quality existing layers were preserved when possible; low-quality or contradictory layers were actually repaired.
- A cold-start entrypoint file exists, points first to `CURRENT_HANDOFF.md`, and references the phase execution workflow.
- If multiple runtime entrypoint files exist, each one independently supports safe cold start and they are semantically aligned.
- `docs/README.md` exists when the `docs/` tree is non-trivial or has helper directories with ambiguous ownership.
- `docs/process/DEVELOPMENT_FLOW.md` exists and is treated as a formal layer, not an ad hoc note.
- Every completed phase has `HANDOFF.md`, `IMPLEMENTATION_PLAN.md`, and `ACCEPTANCE.md`.
- Phase branches follow a predictable `phase-XX-<slug>` naming pattern and the active one is recorded in `CURRENT_HANDOFF.md`.
- Completed phase branches are pushed to remote (not local-only).
- Acceptance files contain real commands, results, artifacts, commits, and risks.
- Handoffs are short and operational.
- `README.md` matches the current project state and becomes the definitive entrypoint at project completion.
- Long documents are referenced, not duplicated, by handoffs.
- Shared directories have documented ownership rules before multiple skills or tools write into them.
- Repeated document shapes become project-visible templates once the project is large enough that structure drift would otherwise become likely.
- Project-visible templates are self-describing enough that a human or weaker model can fill them without guessing.
- Same-class documents across projects answer the same class of questions in roughly the same order, unless a project-specific reason is stronger.
- Obsolete process notes are rewritten away rather than appended.
- Discovery artifacts do not overwrite current phase state unless they have been consumed and reconciled into the planning layers.
- `DESIGN.md` stores durable design judgment rather than execution-state convenience notes.
- Internal working docs, templates, and visible labels follow an explicit language strategy instead of drifting between languages by accident.
- The document system improves delivery quality instead of merely looking complete.

For templates and naming examples, read [references/layered-docs.md](references/layered-docs.md) only when needed.
