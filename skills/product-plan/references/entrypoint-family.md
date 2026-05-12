# Entrypoint Family

Use this when a project has multiple runtime-specific cold-start entrypoint files, such as `CLAUDE.md`, `AGENTS.md`, or other runtime-specific filenames.

## Principle

An entrypoint family should be semantically aligned, not textually identical.

Each runtime-specific entrypoint must independently support safe cold start for its runtime. Do not assume one entrypoint file will always be read before another.

## Required Responsibilities

Every runtime entrypoint should independently provide:

- the minimum load order
- the first-read execution-state file
- a reference to the formal phase execution workflow
- the smallest set of must-know runtime or repo constraints
- links to longer layers when deeper context is needed

## What Entrypoints Must Not Become

Entrypoint files should not become:

- full design memory
- complete roadmap copies
- current phase long-form reports
- helper-directory indexes

## Alignment Rule

When more than one entrypoint exists:

- they should route to the same execution-state source of truth
- they should route to the same formal phase workflow
- they should not disagree on the current loading policy
- they may differ in runtime-specific warnings, constraints, or examples

## Anti-Patterns

Avoid:

- one entrypoint acting as a real entrypoint while another becomes a random note file
- textual duplication when runtime differences matter
- forcing every runtime entrypoint to contain all repo detail inline
