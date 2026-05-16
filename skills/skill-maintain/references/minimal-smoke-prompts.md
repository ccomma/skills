# Skill Maintain Minimal Smoke Prompts

Load this when validating a narrow repair and you need the cheapest useful live regression.

This is the default live test layer for narrow skill writes.

Use one or two prompts, not the full regression suite.

## When This Is Enough

Use this file when the repair is mainly about:

- drift diagnosis and verdict shape in one existing skill
- reference opening quality
- reference overlap
- component ownership
- small bundle drift across a few connected files

If trigger boundary, authority, or multi-turn behavior changed, go back to `regression-tests.md` and `pressure-tests.md`.

If the real question is which runtime layer or runtime adapter to use, load `runtime-smoke-harness.md` first.

## Minimal Prompt Set

```text
Prompt 1: This skill has sections and references, but I still cannot tell what the real drift is or why the answer still belongs in maintenance. Repair judgment only.
Pass if: the answer names the drift first, explains why the role/kernel stay stable, and gives a compact maintenance verdict before polishing deeper structure.
```

```text
Prompt 2: This skill's kernel is wrong and fixing it would change what the skill is for. What now?
Pass if: the answer refuses to keep the work inside maintenance and hands off to `skill-architect`.
```

```text
Prompt 3: The real issue is whether three skills should split or merge responsibilities. What now?
Pass if: the answer routes to `skill-referee` instead of acting like this is one-skill repair.
```

```text
Prompt 4: The local repair is clear, but the same drift may reflect a reusable upstream governance cause. What now?
Pass if: the answer keeps the local maintenance path explicit and then points to `skill-governance-escalation` instead of widening the verdict into a governance report.
```

```text
Prompt 5: Give the default maintenance verdict for a Chinese session where the technical tokens must stay in English.
Pass if: the verdict keeps stable sections for drift, repair depth, maintenance judgment, handoff, proof, and residual risk while localizing visible labels and preserving technical tokens.
```

```text
Prompt 6: This reference starts with a long explanation before saying when to load it. Repair judgment only.
Pass if: the answer fixes the opening first and states the load question plus single job.
```

```text
Prompt 7: These two references answer almost the same load question. Repair judgment only.
Pass if: the answer merges them or sharply separates their jobs.
```

```text
Prompt 8: The main skill is fine, but one reference, one format file, and the metadata drifted in different ways. Decide where each fix belongs.
Pass if: the answer routes each fix to one owner component instead of patching everything everywhere.
```

```text
Prompt 9: This bundle may have stale references after a narrow repair. What is the smallest verification path?
Pass if: the answer uses deterministic bundle checks first, then only the smallest live prompt needed for the changed component.
```

```text
Prompt 10: This repair would be easier if I added one more check script just for this helper boundary. Should I do that?
Pass if: the answer first checks whether the current validation chain already has a natural owner, and only accepts a new check when the repair truly cannot stay inside existing layers.
```

## Run Rule

- Deterministic checks happen first; live smoke only proves the repaired behavior.
- If `scripts/run-runtime-smoke.sh` changed, run `scripts/check-runtime-smoke.sh` before any broader live smoke.
- Start with one prompt only.
- Prefer changed snippets or tiny context extracts before asking the runtime to reason over a full file.
- Prefer the leanest runtime mode available.
- Disable unrelated rules, memory, plugins, or other ambient context when the runtime allows it.
- Keep the prompt short and single-purpose.
- Ask for one repair judgment and a brief answer, not a broad audit.
- Prefer prompt 1 when the repair is specifically about diagnosing drift and stating why the answer still belongs in maintenance.
- Prefer prompts 2-4 when routing or handoff is the real question.
- Prefer prompt 5 when the output contract itself is under question.
- For owner-only repair prompts, load `component-paths.md` first and stop once each drift has an owner component.
- Prefer prompts 6-7 for reference-only repairs.
- Add prompt 8 when multiple bundle components drifted.
- Add prompt 9 when verification scope is the real question.
- Add prompt 10 when the repair is trying to solve drift by growing a new validation or helper layer.
- Do not load deeper component-specific references unless the repair itself is under question after the owner judgment.
- If the first live smoke passes clearly, stop.
- If the first live smoke exposes one in-scope issue, repair it and rerun only the narrowest prompt that covers that issue.
- Escalate to `pressure-tests.md` or `regression-tests.md` only when the first smoke stays ambiguous or the repair touched trigger boundary, authority, cadence, or broader capability preservation.
- Stop once the changed repair dimension is covered; do not promote a narrow repair into a full redesign audit.
