# Project Sizing

Use this before deciding how much document structure a project should receive.

## Principle

Document weight should follow project weight. Do not give every repo the same planning stack by reflex.

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

### 3. Serious Multi-Phase Product

Typical signs:

- multiple phases
- repeated implementation cycles
- planning and execution need durable separation
- future session resumption matters

Default stack:

- full layered stack
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

## Adjustment Rule

If a project is between tiers, choose the lighter structure first unless lack of structure is already causing drift, rework, or unsafe resumption.
