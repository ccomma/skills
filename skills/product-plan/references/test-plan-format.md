# Test Plan Format

Load this when creating or repairing a phase test plan.
It answers how one phase should be validated, which risks matter most, and what execution flows must later run.
It does not replace acceptance evidence, implementation sequencing, or the parent skill's routing.

## Purpose

The test plan defines how the phase will be validated and where the major regression or risk boundaries are.

It is not the final evidence record and not a generic testing manifesto.

## Required Structure

```text
Validation goal and scope
Key risks
Test strategy by level
Critical scenarios and edge cases
Fixtures, data, or environment needs
Commands or execution flows
Acceptance mapping
Known gaps or deferred coverage
```

## Required Quality Bar

- It should reflect the real risk profile of the phase, not a generic checklist.
- It should connect validation work back to PRD and technical-design commitments.
- Commands or execution flows should be concrete enough to run later.
- Known gaps should remain visible instead of being silently dropped.

## Anti-Patterns

Avoid:

- replacing risk-based testing with a shallow level taxonomy
- writing only "unit / integration / e2e" without real scenarios
- turning the test plan into acceptance evidence before anything has run
- hiding deferred coverage because the phase is time-constrained
