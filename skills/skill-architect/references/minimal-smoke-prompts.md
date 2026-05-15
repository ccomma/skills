# Skill Architect Minimal Smoke Prompts

Load this when validating a small design change and the question is narrow enough for the cheapest useful live regression.

This is the default live test layer for narrow skill writes.

Use one or two prompts, not the full pressure suite.

## When This Is Enough

Use this file when the change is mainly about:

- component placement
- reference existence or split/merge
- bundle reachability for one component
- keeping the hot path sharp while moving detail out

If trigger boundary, authority model, or interaction cadence changed, go back to `pressure-tests.md`.

If the real question is which runtime layer or runtime adapter to use, load `runtime-smoke-harness.md` first.

## Minimal Prompt Set

```text
Prompt 1: This bundle repeats one report template in SKILL.md, a reference, and a format file. Decide where it really belongs.
Pass if: one owner component is named and the redundant copies are cut.
```

```text
Prompt 2: These two references both explain when to load examples. Decide whether they should merge or split more sharply.
Pass if: each surviving reference owns one clear load question.
```

```text
Prompt 3: This reference starts with background explanation, and I still do not know when to load it. Decide the design fix.
Pass if: the answer rewrites the opening toward load condition plus single job instead of polishing deep prose first.
```

```text
Prompt 4: The main hot path is sharp, but I want to move one bulky checklist out of SKILL.md. Decide whether it belongs in a reference, format file, script, or nowhere.
Pass if: the answer names the right component and protects first-read behavior.
```

```text
Prompt 5: I know skill-architect is the right workflow, but I cannot tell whether the next question is about overall shape, component placement, or reference split/merge. Decide the next reference only.
Pass if: the answer routes to one next reference instead of scanning the whole directory.
```

```text
Prompt 6: I opened `bundle-design.md` first, but now I think the real question may actually be owner component or reference split/merge. Decide whether to stay here or jump to a different reference.
Pass if: the answer names whether this file is still the right owner and, if not, gives one next hop.
```

## Run Rule

- Deterministic checks happen first; live smoke only proves the changed behavior.
- If `scripts/run-runtime-smoke.sh` changed, run `scripts/check-runtime-smoke.sh` before any broader live smoke.
- Start with one prompt only.
- Prefer the leanest runtime mode available.
- Disable unrelated rules, memory, plugins, or other ambient context when the runtime allows it.
- Keep the prompt short and single-purpose.
- Ask for one judgment and a brief answer, not a broad review.
- For component-placement prompts, load `component-paths.md` first and stop there if one owner component is already clear.
- Prefer prompts 1-2 for reference-only edits.
- Add prompt 3 when the opening contract changed.
- Add prompt 4 when a component moved across layers.
- Add prompt 5 when routing recall itself is under question.
- Add prompt 6 when a narrower reference may have been opened too early or by mistake.
- Do not widen into broader architecture references unless the owner component is still ambiguous after the first owner judgment.
- If the first live smoke passes clearly, stop.
- If the first live smoke exposes one in-scope issue, repair it and rerun only the narrowest prompt that covers that issue.
- Escalate to `pressure-tests.md` only when the first smoke stays ambiguous or the change touched trigger boundary, authority, cadence, or broader routing.
- Stop once the changed dimension is covered; do not inflate this into a full maturity pass.
