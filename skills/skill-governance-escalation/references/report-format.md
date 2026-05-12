# Governance Report Format

Use this when writing the final report for a governance-escalation pass.

## Report Shape

```text
[Localized label for observed issue]:
[Localized label for evidence]:
[Localized label for layer classification]:
[Localized label for abstract failure mode]:
[Localized label for escalation judgment]:
[Localized label for immediate local fix locus]:
[Localized label for durable upstream fix locus]:
[Localized label for recommended next workflow]:
[Localized label for layers not to change]:
[Localized label for rationale]:
```

## Writing Guidance

- Keep the report compact and decision-oriented.
- Name one primary layer even if secondary context exists.
- If escalation is not justified, say so clearly.
- If both a local patch and an upstream repair are warranted, name both and keep their scopes distinct.
- If implementation should be deferred to another workflow, make the handoff explicit.
