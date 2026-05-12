# README Format

Use this when creating or repairing a project's root `README.md`.

## Purpose

`README.md` is the public or first-reader project entrypoint. It helps a new reader understand what the project is, how to start, and where to go next.

It is not a current-phase status board, not a second `DESIGN.md`, and not the governance file for the `docs/` namespace.

## Required Structure

```text
What this project is
Who should read what next
Quickstart or local run path
High-level architecture or module summary
Document map
Current state summary (brief only when useful)
```

## Required Quality Bar

- It should help a first reader orient quickly.
- It should give reading paths for at least repo visitors versus active maintainers.
- It should stay high-level and avoid absorbing detailed design or phase execution rules.
- It should remain accurate as the project evolves; rewrite it holistically at project completion if incremental edits have made it patchy.

## Anti-Patterns

Avoid:

- storing current-phase operational detail here
- copying long design rationale or roadmap sections
- using `README.md` as the only cold-start file for agent runtimes
- turning it into `docs/README.md`
