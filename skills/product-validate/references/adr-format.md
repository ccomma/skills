# ADR Format

Use this only when a decision is durable, surprising, and the result of a real trade-off.

ADRs should stay small. A single short paragraph is often enough.

## Template

```md
# {Decision title}

{1-3 sentences: what the decision is, why it was made, and what alternative pressure mattered.}
```

## Optional Sections

Only include these when they add real value:

- `Status`
- `Considered Options`
- `Consequences`

## Product-Plan Fit

Typical ADR-worthy cases in this workflow:

- durable cross-phase architecture choices
- ownership boundaries between systems or components
- surprising constraints not obvious from code
- deliberate deviations from the apparent default
- replan decisions that future readers would otherwise reopen blindly

If the conclusion is phase-local and easy to reverse, record it in the PRD or technical design instead of creating an ADR.
