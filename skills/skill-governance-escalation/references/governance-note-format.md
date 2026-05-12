# Governance Note Format

Use this when a `provisional candidate` or `promote now` result should be captured as durable governance memory.

## When To Emit A Note

Emit a governance note when:

- the upstream status is `provisional candidate`
- the upstream status is `promote now`

Do not emit a governance note when the status is `local-only`.

## Note Shape

```md
## <short candidate title>

- Observed issue:
- Evidence summary:
- Abstract failure mode:
- Upstream status:
- Immediate local fix locus:
- Durable upstream fix locus:
- Promotion trigger:
- Recommended next workflow:
- Last reviewed:
- Resolution status:
```

## Writing Guidance

- Keep the title short and reusable, not file-name-specific.
- The evidence summary should be compact and concrete.
- The abstract failure mode should stay capability-level and portable.
- `Promotion trigger` may be `already met` when the status is `promote now`.
- `Resolution status` may be `open`, `promoted`, `resolved locally`, or another short lifecycle label.
