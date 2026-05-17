# Layered Product Context Docs

Load this when the main question is how to organize or load planning layers around a current or next phase package. It explains the working model behind `product-plan`; it does not replace the parent skill's routing, artifact contract, or validation boundary.

## Principle

Use progressive disclosure around the phase package and current execution state:

- Always load: runtime entrypoint file, then `docs/context/CURRENT_HANDOFF.md`.
- Always create for serious projects: a formal phase execution workflow in `docs/process/DEVELOPMENT_FLOW.md`.
- Usually load: current phase `HANDOFF.md` and relevant code/tests.
- Sometimes load: `README.md` for repo/public orientation, plus current phase PRD, technical design, test plan, or implementation plan.
- Rarely load: full `DESIGN.md`, full roadmap, historical phase docs, ADRs.

This reference is about product-context documents. It is not a code refactoring guide, implementation-plan format for code execution, TDD workflow, debugging method, verification workflow, or code review guide.

Discovery artifacts are upstream inputs, not execution-state documents. A `Product Brief` may inform roadmap or phase-doc changes, but it does not directly replace `CURRENT_HANDOFF.md`, phase handoffs, PRDs, technical designs, or implementation plans.

Treat the phase package as the center of current executable planning state. PRD, technical design, and test plan are its surrounding planning truth, not a separate competing execution-state stack.

## Standard Structure

Use this structure to keep source-of-truth layers legible around the phase package, not to force every project into the heaviest possible stack.

```text
README.md
DESIGN.md
<entrypoint>.md
docs/README.md
docs/process/DEVELOPMENT_FLOW.md
docs/context/CURRENT_HANDOFF.md
docs/roadmap/PROJECT_DEVELOPMENT_PLAN.md
docs/phases/phase-XX-<slug>/HANDOFF.md
docs/phases/phase-XX-<slug>/IMPLEMENTATION_PLAN.md
docs/phases/phase-XX-<slug>/ACCEPTANCE.md
docs/prd/PHASE_X_<NAME>_PRD.md
docs/technical/PHASE_X_<NAME>_TECHNICAL_DESIGN.md
docs/testing/PHASE_X_<NAME>_TEST_PLAN.md
docs/adr/ADR-0001-<decision>.md
docs/templates/
```

## From Zero To First Implementation

1. Create `DESIGN.md` with product definition, target users, pain, north star, differentiation, non-goals, architecture principles, risk principles, and durable design judgments.
2. Create roadmap with phase goals, core capabilities, inputs, outputs, acceptance criteria, exit conditions, and next-phase prerequisites.
3. Create the cold-start entrypoint file (name varies by platform — `CLAUDE.md`, `AGENTS.md`, `SOUL.md`, etc.) as the first thing the runtime reads. It must reference:
   - `docs/context/CURRENT_HANDOFF.md` as the first-read document
   - The development flow document that defines the mandatory phase sequence (PRD → tech design → test plan → implementation → closeout)
   - Key project constraints
4. Create `docs/README.md` once the `docs/` tree is non-trivial or likely to gain helper directories.
5. Create `docs/process/DEVELOPMENT_FLOW.md` as a formal layer, not an ad hoc note.
6. Create `docs/context/CURRENT_HANDOFF.md` as the default future-session entrypoint.
7. Create the first phase `HANDOFF.md`.
8. Create or switch to the phase branch before implementation starts. Use the same phase identifier across branch and docs, for example `phase-01-core-search`.
9. Create the first phase PRD, technical design, and test plan when the phase is ready for implementation. These are the planning truth layers that support the phase package.
10. Create `IMPLEMENTATION_PLAN.md` only after the phase PRD, technical design, and test plan exist. This file owns execution slicing and task order; it should not restate architectural rationale that already belongs in the technical design.
11. Create `ACCEPTANCE.md` so the phase package closes with evidence rather than recollection.
12. Create `docs/templates/` once repeated project-visible artifact shapes should stop drifting by memory alone.
13. Hand off to validation or execution skills.

If the cold-start entrypoint file exists but only says "read CURRENT_HANDOFF.md" without referencing the development flow, repair it before proceeding. A minimal entrypoint file without process enforcement is the most common cause of documentation rot across phases.

## Midstream Replan

Use this branch when a new upstream input is being considered against an existing phase package and current execution state.

When a new discovery artifact appears after work has already started:

1. Read `CURRENT_HANDOFF.md`, roadmap, relevant phase handoff, PRD, and technical design first.
2. Treat the discovery artifact as candidate input, not as accepted current state.
3. Rewrite the owning layers coherently: `DESIGN.md` if durable judgment changes, roadmap if sequencing changes, and affected phase PRD / technical design / test plan before implementation-plan updates.
4. Decide whether the idea belongs to the current phase, a future phase, or a new phase.
5. Update `CURRENT_HANDOFF.md` only after the planning layers agree.

Do not let a discovery artifact silently rename the current phase or overwrite execution state.

Default judgment rules:

- Completed phases are evidence records and should not be silently rewritten.
- The current phase can be updated only while its scope is still materially fluid.
- Future phases can be replanned normally.
- If a current-phase change would break the current phase goal, prefer creating a new phase instead.

## Minimal Handoff Shape

Load `handoff-format.md` when drafting or repairing a handoff. A handoff should stay operational and compact.

Keep handoffs operational. They are not second design docs.

## Phase Acceptance Shape

Load `acceptance-format.md` when drafting or repairing acceptance evidence.

Do not claim phase completion without evidence.

## Phase-End Checklist

Before ending a phase:

- Run relevant verification commands.
- Update phase `ACCEPTANCE.md` with evidence.
- Update phase `HANDOFF.md` with final state and next handoff.
- Update `docs/context/CURRENT_HANDOFF.md` for the next phase or task.
- Before starting the next phase, create or switch to a new phase branch and record it in both handoffs. Reuse the same `phase-XX-<slug>` identifier in docs and git branch naming.
- Update `README.md` incrementally to reflect the new phase: add new commands, update project status, refresh quickstart if needed.
- Update roadmap only if scope, exit status, or next prerequisites changed.
- Update `DESIGN.md` only if durable product judgment changed.
- Remove stale next-work items that are already completed.
- Keep `docs/README.md` aligned if directory ownership or helper layers changed.
- When all phases complete, rewrite `README.md` holistically as the definitive project entrypoint — overview, document map, reading paths for different readers, architecture summary, quickstart — all matching the final state.

## Common Failure Modes

- Loading all long docs every session.
- Handoff becomes a design essay.
- Roadmap becomes a task tracker.
- PRD contains module internals.
- Technical design repeats product positioning.
- Tests pass but acceptance evidence is not recorded.
- Historical phases lack phase packages, forcing future agents to reread commits or long docs.
- The project has helper directories under `docs/` but no formal `docs/README.md` explains their role.
- `DEVELOPMENT_FLOW.md` exists informally in one project and not another, so phase execution discipline drifts across repos.
