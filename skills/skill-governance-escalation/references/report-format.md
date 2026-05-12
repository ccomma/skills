# Governance Report Format

Use this when writing the final report for a governance-escalation pass.

## Report Shape

```text
[Localized label for observed issue]:
[Localized label for evidence]:
[Localized label for findings]:
[Localized label for layer classification]:
[Localized label for upstream status]:
[Localized label for abstract failure mode]:
[Localized label for escalation judgment]:
[Localized label for immediate local fix locus]:
[Localized label for durable upstream fix locus]:
[Localized label for promotion trigger]:
[Localized label for governance note action]:
[Localized label for recommended next workflow]:
[Localized label for layers not to change]:
[Localized label for rationale]:
```

## Writing Guidance

- Keep the report compact and decision-oriented.
- Put findings before escalation judgment so local-only issues do not disappear.
- State the upstream status before naming durable repair ownership.
- Name one primary layer even if secondary context exists.
- If escalation is not justified, say so clearly.
- If both a local patch and an upstream repair are warranted, name both and keep their scopes distinct.
- If the status is `provisional candidate`, include the trigger that would justify promotion later.
- If the status is `local-only`, the governance note action should explicitly say that no durable note should be written.
- If implementation should be deferred to another workflow, make the handoff explicit.
