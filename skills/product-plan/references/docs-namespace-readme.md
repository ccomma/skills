# Docs Namespace README

Use this when creating or repairing `docs/README.md`.

## Purpose

`docs/README.md` is the governance file for the shared documentation namespace. It explains ownership and prevents long-term layer drift.

It is not a project overview, not a phase handoff, and not a second design document.

## When It Is Needed

Create or repair `docs/README.md` when:

- the project has a non-trivial `docs/` tree
- multiple skills, agents, or workflows may write into `docs/`
- auxiliary directories exist under `docs/`
- source-of-truth boundaries are already drifting

## Required Structure

```text
Shared namespace statement
Source of truth table:
  - artifact or directory
  - owns
  - must not own
Write rule
Helper-layer rule
Historical-record rule (optional when relevant)
```

## Quality Bar

- It should make ownership decisions easier, not harder.
- It should distinguish core planning layers from helper layers.
- It should stop duplication by redirecting writers to the owning layer.
- It should stay short enough to scan before editing.

## Anti-Patterns

Avoid:

- repeating the full project architecture
- repeating all phase status
- turning `docs/README.md` into a public project introduction
- pretending helper directories are forbidden
