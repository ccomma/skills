# Acceptance Format

Load this when `product-plan` creates or repairs a phase `ACCEPTANCE.md`.
It answers what a phase acceptance record must contain and how evidence should be recorded at phase closeout.
It does not replace the phase package, current execution state, or the parent skill's routing.

## When To Use

Use this at phase closeout or when reconstructing historical phase evidence from commits, tests, and known artifacts.

Do not use this as a planning doc. It is evidence of completion and residual risk, not a place to redefine the phase.

## Required Structure

```text
Exit criteria checklist:
Commands run:
Actual results:
Final artifacts:
Commit / branch evidence:
Remaining risks:
```

## Required Quality Bar

- `Exit criteria checklist` maps to real phase goals or acceptance conditions.
- `Commands run` are exact commands or clearly named verification flows.
- `Actual results` report what happened, not what was expected.
- `Final artifacts` name the docs, code paths, reports, or deliverables that matter.
- `Commit / branch evidence` is included when available.
- `Remaining risks` stays honest; it does not disappear just to make the phase look done.

## Optional Additions

Add only when useful:

- follow-up issues or deferred cleanup
- links to generated reports
- rollout caveats

## Anti-Patterns

Avoid:

- claiming phase completion without evidence
- copying the implementation plan into acceptance
- rewriting product rationale here
- hiding known risk because tests passed
