---
name: product-plan
description: Use when starting or continuing a serious product project that needs durable context architecture: design memory, roadmap, phase handoffs, PRDs, technical designs, test plans, acceptance evidence, artifact ownership rules, or token-efficient context loading.
---

# Product Plan

## Overview

Build and maintain a product project's context architecture. Core pattern: short handoff first, long documents on demand, clear artifact ownership, phase evidence preserved at closeout.

This skill is designed for serious, multi-phase engineering projects. For a prototype, single-session task, or simple tool, this is overkill — a README and a short handoff are enough. Do not apply the full document stack to projects that don't need it.

This skill prepares the product-context substrate. It does not design implementation tasks, refactor code, run TDD, debug failures, verify code, or perform code review.

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

This workflow may start from:

- a discovery artifact such as a `Product Brief`
- a user-supplied product direction without a discovery artifact
- an existing project that needs midstream replanning

Do not assume the upstream discovery step was performed by one specific skill. Accept the artifact or intent by capability, not by concrete skill name.

## Core Pattern

Planning modes:

- `cold start`: set up the initial durable document stack before implementation begins
- `midstream replan`: incorporate a new direction, extension, or pivot into the existing document stack without silently promoting it into current execution state

Default loading order for an existing project:

1. `README.md` for public project orientation.
2. `docs/context/CURRENT_HANDOFF.md` for current phase, branch, next work, avoid list, and verification commands.
3. Current phase `docs/phases/<phase>/HANDOFF.md`.
4. Current task code and tests.
5. Phase PRD, technical design, test plan, roadmap, or `DESIGN.md` only when the shorter context cannot answer the question.

Default creation order for a new project:

1. `DESIGN.md`
2. `docs/roadmap/PROJECT_DEVELOPMENT_PLAN.md`
3. Cold-start entrypoint file: the file the runtime reads first on session start (name varies by platform — `CLAUDE.md`, `AGENTS.md`, `SOUL.md`, etc.). Must reference:
   - `docs/context/CURRENT_HANDOFF.md` as the first-read document
   - The project's development flow / phase execution process document (e.g., `docs/process/DEVELOPMENT_FLOW.md`) so every agent session knows the mandatory sequence: PRD → tech design → test plan → code → closeout
   - Key project constraints (language, dependencies, storage, invariants)
   - Available skills and when to invoke them
4. `docs/context/CURRENT_HANDOFF.md`
5. `docs/phases/phase-01-<slug>/HANDOFF.md`
6. Phase PRD, technical design, and test plan for the first implementation slice
7. `docs/phases/phase-01-<slug>/IMPLEMENTATION_PLAN.md` only after the phase PRD, technical design, and test plan exist
8. `docs/phases/phase-01-<slug>/ACCEPTANCE.md`

Default update order for a midstream replan:

1. Read `docs/context/CURRENT_HANDOFF.md`, current phase handoff, relevant PRD, technical design, and roadmap.
2. Ingest the new discovery artifact or clarified direction as a planning input, not as current phase state.
3. Update `DESIGN.md` only if durable product judgment changes.
4. Update roadmap if phase sequence, scope, exit criteria, or prerequisites change.
5. Update the affected phase PRD, technical design, and test plan before touching `IMPLEMENTATION_PLAN.md`.
6. Decide whether the change belongs to the current phase, a future phase, or a new phase.
7. Update `CURRENT_HANDOFF.md` only after the planning layers agree on the accepted direction and current execution state.

If the cold-start entrypoint file already exists but is missing the development flow reference, repair it. An entrypoint that only says "read CURRENT_HANDOFF.md" without referencing the phase execution workflow is incomplete — agents will skip the mandatory PRD → tech design → test plan steps before coding.

## Document Boundaries

| Layer | Owns | Must Not Own | Update When |
| --- | --- | --- | --- |
| `DESIGN.md` | Durable product judgment, target users, principles, non-goals, strategic boundaries | sprint tasks, daily status, line-level implementation | product identity or principles change |
| `CONTEXT.md` / `CONTEXT-MAP.md` | Domain language, glossary, relationships, ambiguous terms, context map | product positioning, phase status, task tracking | domain vocabulary or concept relationships change |
| Roadmap | Phase sequence, goals, acceptance criteria, exit conditions, prerequisites | detailed PRDs, module internals, task tracking | phase sequence, exit criteria, or prerequisites change |
| `CURRENT_HANDOFF.md` | Minimum current context, branch, next work, avoid list, verification commands | design history, product essay, full implementation detail | phase, branch, next work, or verification commands change |
| Phase `HANDOFF.md` | Phase entry capsule, scope, artifacts, validation summary, next handoff | full PRD, full technical design, broad roadmap | new phase started or phase context changed |
| Phase `IMPLEMENTATION_PLAN.md` | Milestones, task status, smallest verifiable slices | product positioning, architecture rationale, proof claims | task status changed |
| Phase `ACCEPTANCE.md` | Acceptance checklist, commands, results, final artifacts, residual risks | aspirations, future plans, unverified claims | verification completed or phase closed |
| PRD | Why, users, problem, goals, non-goals, flows, success criteria | module internals, storage details, task status | product requirements changed |
| Technical Design | Architecture contract, models, interfaces, storage, failure modes, security | product positioning, daily progress | module, interface, storage, or security contract changed |
| Test Plan | Fixture strategy, unit/integration/acceptance scope, regression risks, commands | acceptance evidence after the fact | testing strategy or fixture scope changed |
| ADR | Durable cross-phase decisions and alternatives | temporary notes, routine implementation choices | durable cross-phase decision made (sparse: only hard-to-reverse, surprising, real-tradeoff decisions) |
| `README.md` | Project entrypoint, reading paths for newcomers, document map, architecture overview, quickstart | detailed spec, daily status, task tracking | every phase completion (incremental) and at project completion (holistic rewrite) |

When an existing repository uses different names, preserve the local convention and map it to these responsibilities in the nearest README or handoff.

## Shared Namespace Rules

`docs/` is a shared namespace, not this skill's private workspace.

Before creating or editing documents:

1. **Inventory** existing top-level docs and `docs/` subdirectories.
2. **Classify** each artifact by purpose, not by which skill created it.
3. **Preserve** the owner of any existing artifact when its purpose is clear.
4. **Reference** instead of copy: add missing references or indexes rather than duplicating owned content into another layer.
5. **Create** a new artifact only when no existing artifact already owns that responsibility.

Ownership means responsibility for the source of truth, not exclusive permission to read.

Prefer predictable subdirectories (`docs/context/`, `docs/phases/`, `docs/prd/`, `docs/technical/`, `docs/testing/`, `docs/adr/`, `docs/templates/`, `docs/process/`) only when they match the project's existing layout. Handoffs may link to other owned artifacts but should not paste their full content. Acceptance documents may cite commands, results, commits, and risks but should not become product rationale or architecture design.

## Workflow

**Mandatory sequence**: The 5 steps below must be executed in order. Each step produces visible output before the next begins. Do NOT skip ahead to Create without completing Inspect.

**Narrow args guard**: When invoked with specific document-update arguments (e.g., "update ADR-NNN, update roadmap, create tech design"), do NOT treat them as a mechanical checklist. Run the full workflow first — Inspect the current docs state, identify ALL gaps, then address the requested updates AND any missing layers. Specific args do not authorize skipping the audit.

### 1. Classify

Confirm this is product-context work. If the user is asking for code execution, refactoring, debugging, verification, or review, use the more specific skill instead.

Before applying the full document stack, determine project weight with one question: **"Is this a multi-phase product you expect to maintain across many sessions and possibly with different agents?"** If yes, apply the full stack. If the user describes it as a prototype, one-off script, or single-session task, keep it light: a short handoff and README are enough. Do not guess — ask the user.

### 2. Inspect Minimal Context

Read the current handoff first. Do not load all historical docs by default. If there is no handoff, create one early so the project has a future entrypoint.

**Before creating or modifying any file**, produce a visible inventory:

1. List all existing top-level docs and `docs/` subdirectories
2. Map each artifact to its document layer (DESIGN.md, PRD, Technical Design, ADR, Phase package, etc.)
3. Identify gaps: which required layers are missing? Which phases lack packages?
4. Present the gap analysis to the user before proceeding to Repair

This inventory is mandatory — it prevents the agent from creating documents that duplicate existing content or skipping layers that should exist.

**Consume transient discovery artifacts**: Check `docs/discovery/` for any Product Briefs with a status indicating "awaiting consumption" (the exact phrasing will be in the user's working language). If found:

1. Read them and extract: the core direction, key design decisions, boundaries, and parked ideas
2. Incorporate relevant insights into the roadmap and phase planning
3. After consumption, update the status line to indicate "consumed" with the date, or delete the file. Use the same language as the original status line.

Discovery artifacts are transient — they exist to be consumed once, not to be re-read by future sessions. Do not reference them from `CURRENT_HANDOFF.md` or phase handoffs after consumption.

When consuming a discovery artifact for midstream replanning, do not treat its proposed scope, title, or imagined next phase as already accepted current state. First reconcile it with the roadmap and affected phase docs; only then update handoff state.

Verify that a cold-start chain exists: the runtime entrypoint file must point to exactly one initial document, and that document must reference the standard phase execution workflow. If the chain is broken, repair it before proceeding.

### 3. Repair Or Create Layers

Move content to the layer that owns it. Prefer concise rewrites over appending patches that preserve obsolete thinking. The resulting docs should read as if the current architecture was intentional from the beginning.

If the user wants to add a feature or change direction mid-project, prefer coherent rewrites of the owning layers over scattered addendum notes, unless preserving historical divergence is itself important to the project.

**Layer creation order**: For each phase, create layers in this sequence:

1. PRD — Why, users, problem, goals, non-goals (owns product rationale)
2. Technical Design — Architecture contract, interfaces, storage, failure modes. **Naming**: `docs/technical/phase-0X-<slug>.md`. Must reference its phase in the opening header. Created during phase start, never during initial scaffolding.
3. Test Plan — Fixture strategy, test scope, regression risks
4. Implementation Plan — Milestones, tasks, slices (ONLY after 1-3 exist)

Never create an IMPLEMENTATION_PLAN.md for a phase that doesn't have at minimum a PRD and Technical Design. If a phase has an IMPLEMENTATION_PLAN.md but no PRD, flag it and offer to create the PRD first.

### 4. Preserve Evidence

At phase closeout:

- Merge to main and push both branches:
  ```bash
  git checkout main
  git merge phase<NN> --no-edit
  git push origin main
  git push origin phase<NN>
  ```
- Update `docs/context/CURRENT_HANDOFF.md` for the next session
- Update current phase `ACCEPTANCE.md` for commands, results, final artifacts, commits, risks
- Update `README.md` incrementally: add new phase commands, update quickstart if needed, reflect current project status. At project completion (all phases done), rewrite `README.md` holistically as the definitive project entrypoint — update overview, document map, reading paths, architecture summary, and quickstart to match the final state.

Phase branches must be pushed to remote after merge — they are part of the phase evidence trail. Do not leave phase branches local-only unless the user explicitly chooses to skip pushing.

If a historical phase predates this structure, create a compact phase package with evidence from commits, tests, and known artifacts.

### 5. Hand Off To Execution

After the context architecture is clean, hand off to the appropriate implementation workflow. Ensure `CURRENT_HANDOFF.md`'s load order references the project's phase execution workflow so the agent knows what concrete steps to follow (create branch → implement → refactor → test → closeout → merge). Do not turn this skill into a substitute for implementation planning, TDD, debugging, verification, or review.

`CURRENT_HANDOFF.md` is an execution-state artifact, not a discovery scratchpad. Update it only after the accepted planning layers are internally consistent.

## Quality Checks

- A cold-start entrypoint file exists and directs the agent to exactly one initial document (`CURRENT_HANDOFF.md`). The entrypoint file itself references the standard phase execution workflow (e.g., `docs/process/DEVELOPMENT_FLOW.md`) so agents know the mandatory PRD → tech design → test plan → code → closeout sequence before touching any code. The entrypoint filename varies by runtime (e.g., `CLAUDE.md`, `AGENTS.md`, `SOUL.md`).
- Every completed phase has `HANDOFF.md`, `IMPLEMENTATION_PLAN.md`, and `ACCEPTANCE.md`.
- Completed phase branches are pushed to remote (not local-only).
- Acceptance files contain real commands, results, artifacts, commits, and risks.
- Handoffs are short and operational.
- `README.md` is current for the project state — not describing an earlier phase as the present. After all phases complete, `README.md` has been holistically rewritten as a definitive entrypoint with document map, reading paths, architecture overview, and quickstart.
- Long documents are referenced, not duplicated, by handoffs.
- Shared directories have documented ownership rules before multiple skills or tools write into them.
- Obsolete process notes are rewritten away rather than appended as amendments.
- Technical design files use `phase-0X-<slug>.md` naming and reference their phase in the opening header. Cross-phase system-level docs (no phase prefix) declare their cross-phase scope in a header note.
- Discovery artifacts do not overwrite current phase state unless they have been consumed and reconciled into the planning layers.

For templates and naming examples, read `references/layered-docs.md` only when needed.
