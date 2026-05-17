# Design Growth Policy

Load this when deciding whether something belongs in `DESIGN.md`.
It answers when durable judgment should be admitted into `DESIGN.md` instead of staying in a phase-local or execution-state artifact.
It does not replace the `DESIGN.md` format, roadmap ownership, or phase-package-centered planning flow.

## Principle

`DESIGN.md` should grow slowly. It is the durable memory of product and architecture judgment, not the easiest place to store important information.

## Good Candidates For DESIGN.md

- durable product positioning
- long-lived user and pain framing
- major design tradeoffs
- non-goals that still constrain future phases
- stable architecture boundaries
- long-lived risk principles

## Bad Candidates For DESIGN.md

- current phase status
- branch policy
- loading order
- shared-directory governance
- one-off implementation details
- execution slicing

## Admission Rule

Before adding content to `DESIGN.md`, ask:

1. Will this still matter after the current phase ends?
2. Is it a design judgment rather than an execution convenience?
3. Would a future maintainer be misled if this lived elsewhere instead?

If the answer is mostly no, keep it out of `DESIGN.md`.
