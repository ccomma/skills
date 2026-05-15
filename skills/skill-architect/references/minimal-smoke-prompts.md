# Skill Architect Minimal Smoke Prompts

Load this when validating a small design change and the question is narrow enough for the cheapest useful live regression.

This is the default live test layer for narrow skill writes.

Use one or two prompts, not the full pressure suite.

## When This Is Enough

Use this file when the change is mainly about:

- kernel extraction or kernel-first routing
- build-brief-first handoff behavior
- protocol or adapter wording
- repo-local brief validation
- repo-local consumption proof
- public positioning or explicit entry-surface wording
- component placement
- reference existence or split/merge
- bundle reachability for one component
- keeping the hot path sharp while moving detail out

If trigger boundary, authority model, or interaction cadence changed beyond the kernel-first layer, go back to `pressure-tests.md`.

If the real question is which runtime layer or runtime adapter to use, load `runtime-smoke-harness.md` first.

## Minimal Prompt Set

```text
Prompt 1: Use $skill-architect. 帮我做一个让模糊需求更容易收敛的 skill。
Pass if: the answer produces the kernel sentence, trigger boundary, first move, strongest thing, and wrong-scope sentence, then moves into a protocol-valid build brief before proposing sections, references, or scripts.
```

```text
Prompt 2: Use $skill-architect. 创建一个名为 prompt-router 的 skill；它只负责把模糊请求快速分流到正确工作流，第一步先判定 owner，不需要复杂交互。
Pass if: the answer locks the kernel quickly, then gives the minimal shape, component decisions, validation starter, and initializer handoff instead of running long intake or opening with bundle structure.
```

```text
Prompt 3: Use $skill-architect. 帮我把这个已有 skill 做成熟。
Pass if: the answer starts from one strong thing, trigger boundary, and first move, then distinguishes whether the next move is an architect retrofit brief or a maintenance repair instead of listing bundle upgrades first.
```

```text
Prompt 4: Use $skill-architect. 帮我初始化一个新的 skill folder 并补齐 starter files。
Pass if: the answer does not present generic initialization as this skill's core job and instead returns a build brief plus downstream initializer handoff.
```

```text
Prompt 5: Use $skill-architect. 后面我会交给别的 agent 去初始化，不一定有原生 creator。请先给我这份 brief。
Pass if: the answer produces a build brief that does not depend on one named creator and can still describe a safe downstream handoff.
```

```text
Prompt 6: This build brief is missing `Strongest thing` and its `Do-not-add` only says `- none`. Should a downstream initializer continue?
Pass if: the answer rejects downstream consumption and makes the validator-style failure explicit instead of patching the brief by hand.
```

```text
Prompt 7: This valid brief says `SKILL.md + one reference`, but its `Initializer handoff` only says `- create SKILL.md`. Should the repo-local proof helper execute it?
Pass if: the answer rejects execution as `repo-local ambiguous` instead of calling the brief protocol-invalid or guessing a reference filename.
```

```text
Prompt 8: This bundle repeats one report template in SKILL.md, a reference, and a format file. Decide where it really belongs.
Pass if: one owner component is named and the redundant copies are cut.
```

```text
Prompt 9: These two references both explain when to load examples. Decide whether they should merge or split more sharply.
Pass if: each surviving reference owns one clear load question.
```

```text
Prompt 10: This reference starts with background explanation, and I still do not know when to load it. Decide the design fix.
Pass if: the answer rewrites the opening toward load condition plus single job instead of polishing deep prose first.
```

```text
Prompt 11: The main hot path is sharp, but I want to move one bulky checklist out of SKILL.md. Decide whether it belongs in a reference, format file, script, or nowhere.
Pass if: the answer names the right component and protects first-read behavior.
```

```text
Prompt 12: I know skill-architect is the right workflow, but I cannot tell whether the next question is about overall shape, component placement, or reference split/merge. Decide the next reference only.
Pass if: the answer routes to one next reference instead of scanning the whole directory.
```

```text
Prompt 13: I opened `bundle-design.md` first, but now I think the real question may actually be owner component or reference split/merge. Decide whether to stay here or jump to a different reference.
Pass if: the answer names whether this file is still the right owner and, if not, gives one next hop.
```

## Run Rule

- Deterministic checks happen first; live smoke only proves the changed behavior.
- If `scripts/run-runtime-smoke.sh` changed, run `scripts/check-runtime-smoke.sh` before any broader live smoke.
- Start with one prompt only.
- Prefer changed snippets or tiny context extracts before asking the runtime to reason over a full file.
- Prefer the leanest runtime mode available.
- Disable unrelated rules, memory, plugins, or other ambient context when the runtime allows it.
- Keep the prompt short and single-purpose.
- Ask for one judgment and a brief answer, not a broad review.
- Prefer prompts 1-7 when the change is specifically about external positioning, protocol wording, validator behavior, repo-local proof behavior, initializer-neutral handoff, or kernel-first entry behavior.
- For component-placement prompts, load `component-paths.md` first and stop there if one owner component is already clear.
- Prefer prompts 8-9 for reference-only edits.
- Add prompt 10 when the opening contract changed.
- Add prompt 11 when a component moved across layers.
- Add prompt 12 when routing recall itself is under question.
- Add prompt 13 when a narrower reference may have been opened too early or by mistake.
- Do not widen into broader architecture references unless the owner component is still ambiguous after the first owner judgment.
- If the first live smoke passes clearly, stop.
- If the first live smoke exposes one in-scope issue, repair it and rerun only the narrowest prompt that covers that issue.
- Escalate to `pressure-tests.md` only when the first smoke stays ambiguous or the change touched trigger boundary, authority, cadence, or broader routing.
- Stop once the changed dimension is covered; do not inflate this into a full maturity pass.
