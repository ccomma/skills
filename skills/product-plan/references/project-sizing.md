# Project Sizing

Load this when deciding how much document weight a project should receive, especially whether it should stay light or grow into a phase-package-centered planning stack. It only answers structure weight; it does not replace the parent skill's routing or workflow.
It answers when a project should stay light versus when it deserves a fuller phase-package-centered planning stack.
It does not replace artifact ownership, execution-state handling, or the parent skill's routing.

## Principle

Document weight should follow project weight. Do not give every repo the same planning stack by reflex, and do not assume every project needs a full phase package.

## Default Tiers

### 1. Prototype Or One-Off

Typical signs:

- short-lived experiment
- one main task or narrow feature probe
- little expectation of future multi-session handoff

Default stack:

- `README.md` or equivalent short project note
- short handoff if continuation is likely

Usually avoid:

- full roadmap
- full phase package
- templates
- docs governance layers

### 2. Small Continuing Project

Typical signs:

- likely to continue across sessions
- one maintainer or one agent runtime most of the time
- not yet a broad multi-phase product

Default stack:

- entrypoint file
- `CURRENT_HANDOFF.md`
- light roadmap or phase note
- selective PRD / technical / testing only when the work merits them
- no full phase package by default unless the work is becoming repeated, stateful, or handoff-heavy

### 3. Serious Multi-Phase Product

Typical signs:

- multiple phases
- repeated implementation cycles
- planning and execution need durable separation
- future session resumption matters

Default stack:

- full layered stack centered on the active or next phase package
- `docs/README.md`
- `docs/process/DEVELOPMENT_FLOW.md`
- phase package
- PRD / technical / testing
- templates once repeated shapes clearly exist

### 4. Large Multi-Writer Or Multi-Agent Project

Typical signs:

- multiple runtimes, maintainers, or skills may write docs
- directory ownership drift is already a risk
- helper directories and historical evidence matter

Default stack:

- everything from the serious tier
- stronger docs governance
- stronger template discipline
- more explicit helper-layer rules
- clearer source-of-truth boundaries around the phase package and current execution state

## Adjustment Rule

If a project is between tiers, choose the lighter structure first unless lack of structure is already causing drift, rework, or unsafe resumption.
