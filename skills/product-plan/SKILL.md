---
name: product-plan
description: "Use when starting or continuing serious product work that needs durable planning context, phase handoffs, PRDs, technical designs, test plans, and acceptance evidence."
---

# Product Plan

## Overview

Build and maintain a product project's context architecture. Core pattern: short handoff first, long docs on demand, clear artifact ownership, phase evidence preserved at closeout.

Use this for serious, multi-phase work. For a prototype or one-off task, keep it light: a README and short handoff are enough.

This skill prepares product context. It does not replace implementation planning, code work, debugging, verification, or review.

## When To Use

Use when the user asks to:

- start a serious product or product-like engineering project
- create or repair `DESIGN.md`, roadmap, phase PRDs, technical designs, test plans, handoffs, acceptance docs, or ADRs
- define or repair ownership rules for shared project documents and directories
- reduce token cost while preserving project quality
- prepare a project so future sessions can resume with minimal prompting
- close a phase and preserve evidence for the next phase

Do not use for code execution, refactoring, debugging, verification, code review, feature brainstorming, or implementation planning. Hand off to the appropriate engineering or discovery workflow instead.

## Upstream Inputs

This workflow may start from a `Product Brief`, a direct product direction, or an existing project that needs replanning. Accept upstream input by capability, not by one specific skill name.

## Core Pattern

Planning modes:

- `cold start`: set up the initial durable document stack before implementation begins
- `midstream replan`: incorporate a new direction, extension, or pivot into the existing document stack without silently promoting it into current execution state

Default loading order for an existing project:

1. `README.md` for public project orientation.
2. `docs/context/CURRENT_HANDOFF.md` for current phase, branch, next work, avoid list, and verification commands.
3. Current phase `docs/phases/<phase>/HANDOFF.md`.
4. Current task code and tests.
5. Load PRD, technical design, test plan, roadmap, or `DESIGN.md` only when the shorter context cannot answer the question.

Default document order for a new project:

1. `DESIGN.md`
2. `docs/roadmap/PROJECT_DEVELOPMENT_PLAN.md`
3. Cold-start entrypoint file. It must point first to `docs/context/CURRENT_HANDOFF.md` and also reference the project's phase execution flow.
4. `docs/context/CURRENT_HANDOFF.md`
5. `docs/phases/phase-01-<slug>/HANDOFF.md`
6. First phase PRD, technical design, and test plan
7. `docs/phases/phase-01-<slug>/IMPLEMENTATION_PLAN.md` only after the PRD, technical design, and test plan exist
8. `docs/phases/phase-01-<slug>/ACCEPTANCE.md`

Default update order for a midstream replan:

1. Read `CURRENT_HANDOFF.md`, the current phase handoff, roadmap, and affected PRD / technical design first.
2. Treat the new direction as planning input, not current execution state.
3. Update durable layers before `IMPLEMENTATION_PLAN.md`.
4. Update `CURRENT_HANDOFF.md` only after the planning layers agree on the accepted direction.

If the cold-start entrypoint file exists but only says "read CURRENT_HANDOFF.md" without referencing the phase execution workflow, repair it.

## Document Ownership

Keep each layer narrow:

- `DESIGN.md`: durable product judgment, not daily execution detail
- roadmap: phase sequence, goals, exits, and prerequisites
- `CURRENT_HANDOFF.md`: minimum current context, branch, next work, and verification commands
- phase package: `HANDOFF.md`, `IMPLEMENTATION_PLAN.md`, and `ACCEPTANCE.md` for one phase
- PRD / technical design / test plan: requirements, architecture contract, and testing strategy
- ADR: sparse, durable, cross-phase decisions
- `README.md`: public entrypoint, reading paths, and quickstart

For detailed structure, naming, and phase-end shapes, load [references/layered-docs.md](references/layered-docs.md).

## Shared Namespace Rules

`docs/` is a shared namespace, not this skill's private workspace.

Before creating or editing documents:

1. Inventory existing top-level docs and `docs/` subdirectories.
2. Classify each artifact by purpose, not by which skill created it.
3. Preserve the owner of any existing artifact when its purpose is clear.
4. Reference instead of copy.
5. Create a new artifact only when no existing artifact already owns that responsibility.

Ownership means responsibility for the source of truth, not exclusive permission to read.

Prefer predictable subdirectories only when they match the project's existing layout. Handoffs may link to owned artifacts but should not paste their full content. Acceptance docs may cite commands, results, commits, and risks but should not become product rationale or architecture design.

## Workflow

Execute the 5 steps below in order. Do not skip straight to document creation because the user named one file to update.

### 1. Classify

Confirm this is product-context work. If the user is asking for code execution, refactoring, debugging, verification, or review, hand off to the more specific skill.

Before applying the full stack, ask whether this is multi-phase work expected to live across many sessions and possibly different agents. If not, keep it light.

### 2. Inspect Minimal Context

Read the current handoff first. Do not load all historical docs by default. If there is no handoff, create one early so the project has a future entrypoint.

Before creating or modifying any file, produce a visible inventory:

1. List all existing top-level docs and `docs/` subdirectories
2. Map each artifact to its document layer (DESIGN.md, PRD, Technical Design, ADR, Phase package, etc.)
3. Identify gaps: which required layers are missing? Which phases lack packages?
4. Present the gap analysis to the user before proceeding to Repair

This prevents duplicate docs and missing layers.

Consume transient discovery artifacts when `docs/discovery/` exists:

1. Read them and extract: the core direction, key design decisions, boundaries, and parked ideas
2. Incorporate relevant insights into the roadmap and phase planning
3. After consumption, update the status line to indicate "consumed" with the date, or delete the file. Use the same language as the original status line.

Do not treat discovery artifacts as execution-state docs, and do not leave them as long-term handoff dependencies after consumption.

Verify that the cold-start chain is complete: entrypoint file -> `CURRENT_HANDOFF.md` -> development flow.

### 3. Repair Or Create Layers

Move content to the layer that owns it. Prefer coherent rewrites over scattered addenda.

Per phase, create or repair layers in this order:

1. PRD
2. Technical Design
3. Test Plan
4. `IMPLEMENTATION_PLAN.md`

Do not create `IMPLEMENTATION_PLAN.md` before the PRD and technical design exist.

### 4. Preserve Evidence

At phase closeout:

- Merge to main and push both main plus the phase branch.
- Update `docs/context/CURRENT_HANDOFF.md` for the next session
- Update current phase `ACCEPTANCE.md` for commands, results, final artifacts, commits, risks
- Update `README.md` incrementally; at project completion, rewrite it holistically as the definitive entrypoint.

Phase branches are part of the evidence trail. Do not leave them local-only unless the user explicitly chooses to skip pushing.

If a historical phase predates this structure, create a compact phase package with evidence from commits, tests, and known artifacts.

### 5. Hand Off To Execution

After the context architecture is clean, hand off to the appropriate implementation workflow. Ensure `CURRENT_HANDOFF.md`'s load order references the project's phase execution workflow so the agent knows what concrete steps to follow (create branch → implement → refactor → test → closeout → merge). Do not turn this skill into a substitute for implementation planning, TDD, debugging, verification, or review.

`CURRENT_HANDOFF.md` is an execution-state artifact, not a discovery scratchpad. Update it only after the accepted planning layers are internally consistent.

## Quality Checks

- A cold-start entrypoint file exists, points first to `CURRENT_HANDOFF.md`, and references the phase execution workflow.
- Every completed phase has `HANDOFF.md`, `IMPLEMENTATION_PLAN.md`, and `ACCEPTANCE.md`.
- Completed phase branches are pushed to remote (not local-only).
- Acceptance files contain real commands, results, artifacts, commits, and risks.
- Handoffs are short and operational.
- `README.md` matches the current project state and becomes the definitive entrypoint at project completion.
- Long documents are referenced, not duplicated, by handoffs.
- Shared directories have documented ownership rules before multiple skills or tools write into them.
- Obsolete process notes are rewritten away rather than appended.
- Discovery artifacts do not overwrite current phase state unless they have been consumed and reconciled into the planning layers.

For templates and naming examples, read `references/layered-docs.md` only when needed.
