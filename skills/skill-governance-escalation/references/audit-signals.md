# Governance Audit Signals

Use this when `skill-governance-escalation` needs a stable findings vocabulary for auto-audit work before any escalation judgment.

## Purpose

This file defines shared governance-audit signal names and what they mean. It does not decide ownership, routing, or fix layer by itself.

These signals are meant to be:

- mechanically discoverable when possible
- judgment-assisted when needed
- reusable across local review and escalation workflows

## Canonical Signals

### `headings-only template`

A project-visible template or format file has section headings but little or no guidance about what each section should contain.

This often points to:

- weak template self-descriptiveness
- fragile artifact quality across models or maintainers

### `mixed-language headings or labels`

One visible artifact mixes user-facing languages in a way that does not reflect an intentional language strategy.

This often points to:

- language-strategy drift
- public/internal language boundary blur

### `local-context leakage`

The artifact presents local paths, private workflow names, machine-specific assumptions, or non-owned references as if they were public rules.

This often points to:

- portability leakage
- ownership leakage

### `portability or ownership hint`

The artifact may still be publishable overall, but some wording hints that it depends on a runtime, repo, or neighbor it does not truly own.

This often points to:

- abstraction leak
- weak publishability

### `helper-layer misplacement candidate`

A helper artifact, auxiliary note, or cross-phase reference may be acting like source of truth for a core layer without being promoted, downgraded, or referenced correctly.

This often points to:

- ownership drift
- helper/core layer confusion

### `thin-but-correct core artifact candidate`

A core artifact keeps the right boundary but lacks enough judgment, tradeoff density, or explanation to carry its actual role.

This often points to:

- shallow durable guidance
- correct structure with weak decision content

## Usage Notes

- A signal is not yet an escalation judgment.
- Multiple signals may describe one finding.
- Not every canonical signal must be detected by script.
- If a signal cannot be detected reliably by a deterministic script, it should still remain part of the shared vocabulary for human or workflow judgment.
