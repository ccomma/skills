# Consistency Constraints

Load this when the user wants different projects, different models, or different runtimes to produce documents that feel structurally aligned rather than ad hoc.
It answers how comparable document families should stay consistent across projects without collapsing into identical prose.
It does not replace artifact ownership, project sizing, or the phase-package-centered decision path in the parent skill.

## Principle

Cross-project consistency does not require identical prose. It requires the same class of document to answer the same class of questions in a predictable place.

## Core Constraints

### Responsibilities Stay Stable

- `README.md` owns project entry and navigation.
- `DESIGN.md` owns durable product and architecture judgment.
- Roadmap owns phase strategy.
- PRD owns phase requirements.
- Technical design owns implementation architecture contract.
- Test plan owns validation strategy.
- Implementation plan owns execution slicing.
- Handoff owns resumable operational context.
- Acceptance owns evidence.

### Section Order Should Mostly Converge

For the same class of document across projects:

- keep the highest-level purpose near the top
- move scope and boundaries before details
- move evidence or verification after design or planning content
- avoid project-specific section order churn unless it buys real clarity

### Naming Should Be Predictable

- prefer stable filenames for stable layers
- prefer phase identifiers that align across branch, handoff, and phase package
- avoid inventing a new file class when an existing layer already owns the responsibility

### Quality Should Be Comparable

- a good `DESIGN.md` in one repo should feel recognizably like a good `DESIGN.md` in another
- a roadmap should not become a task list in one repo and a strategy document in another
- companion formats should be used to reduce model-to-model drift

## Allowed Variation

Variation is acceptable when:

- the project is much smaller or larger than the default tier
- a runtime entrypoint needs runtime-specific warnings
- the domain needs one additional section to clarify an unusual boundary

Do not treat these allowances as permission to collapse ownership boundaries.

## Anti-Patterns

Avoid:

- structurally identical headings with empty, generic content
- purely cosmetic uniformity that ignores project maturity
- letting one repo's local accident become the global standard
- moving a concept to a different layer just because one model improvised it there
