# Skill Maintain Minimal Smoke Prompts

Load this when validating a narrow repair and you need the cheapest useful live regression.

This is the default live test layer for narrow skill writes.

Use one or two prompts, not the full regression suite.

## When This Is Enough

Use this file when the repair is mainly about:

- reference opening quality
- reference overlap
- component ownership
- small bundle drift across a few connected files

If trigger boundary, authority, or multi-turn behavior changed, go back to `regression-tests.md` and `pressure-tests.md`.

If the real question is which runtime layer or runtime adapter to use, load `runtime-smoke-harness.md` first.

## Minimal Prompt Set

```text
Prompt 1: This reference starts with a long explanation before saying when to load it. Repair judgment only.
Pass if: the answer fixes the opening first and states the load question plus single job.
```

```text
Prompt 2: These two references answer almost the same load question. Repair judgment only.
Pass if: the answer merges them or sharply separates their jobs.
```

```text
Prompt 3: The main skill is fine, but one reference, one format file, and the metadata drifted in different ways. Decide where each fix belongs.
Pass if: the answer routes each fix to one owner component instead of patching everything everywhere.
```

```text
Prompt 4: This bundle may have stale references after a narrow repair. What is the smallest verification path?
Pass if: the answer uses deterministic bundle checks first, then only the smallest live prompt needed for the changed component.
```

```text
Prompt 5: I know skill-maintain is the right workflow, but I cannot tell whether the next repair question is about owner component, reference quality, or bundle drift. Decide the next reference only.
Pass if: the answer routes to one next repair reference instead of scanning the whole repair stack.
```

```text
Prompt 6: I opened `reference-quality.md` first, but now I think the real problem may actually be owner component or bundle drift. Decide whether to stay here or jump to a different reference.
Pass if: the answer names whether this file is still the right owner and, if not, gives one next hop.
```

```text
Prompt 7: This script, format file, and reference all sound plausible, but I cannot tell whether all three are actually worth keeping. Audit the component necessity only.
Pass if: the answer challenges each component on failure prevented, merge collision, and cost, then recommends keep/merge/cut.
```

## Run Rule

- Deterministic checks happen first; live smoke only proves the repaired behavior.
- If `scripts/run-runtime-smoke.sh` changed, run `scripts/check-runtime-smoke.sh` before any broader live smoke.
- Start with one prompt only.
- Prefer the leanest runtime mode available.
- Disable unrelated rules, memory, plugins, or other ambient context when the runtime allows it.
- Keep the prompt short and single-purpose.
- Ask for one repair judgment and a brief answer, not a broad audit.
- For owner-only repair prompts, load `component-paths.md` first and stop once each drift has an owner component.
- Prefer prompts 1-2 for reference-only repairs.
- Add prompt 3 when multiple bundle components drifted.
- Add prompt 4 when verification scope is the real question.
- Add prompt 5 when routing recall itself is under question.
- Add prompt 6 when a narrower repair reference may have been opened too early or by mistake.
- Add prompt 7 when component necessity itself is under question.
- Do not load deeper component-specific references unless the repair itself is under question after the owner judgment.
- If the first live smoke passes clearly, stop.
- If the first live smoke exposes one in-scope issue, repair it and rerun only the narrowest prompt that covers that issue.
- Escalate to `pressure-tests.md` or `regression-tests.md` only when the first smoke stays ambiguous or the repair touched trigger boundary, authority, cadence, or broader capability preservation.
- Stop once the changed repair dimension is covered; do not promote a narrow repair into a full redesign audit.
