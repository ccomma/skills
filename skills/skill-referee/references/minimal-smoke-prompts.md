# Skill Referee Minimal Smoke Prompts

Load this when validating a narrow `skill-referee` change and you need the cheapest useful live regression.

This is the default live test layer for narrow skill writes.

Use one or two prompts, not a broad audit sweep.

## When This Is Enough

Use this file when the change is mainly about:

- metadata-first owner ruling behavior
- public ruling shape
- fallback-shell entry conditions
- handoff to adjacent governance skills
- narrow bundle drift across the public skill surface

If trigger boundary, authority, or multi-turn interaction changes beyond this narrow ruling surface, stop and use a broader validation layer instead of stretching this file.

If the real question is which runtime layer to use or how to keep the live smoke lean, load `runtime-smoke-harness.md` first.

## Minimal Prompt Set

```text
Prompt 1: Use $skill-referee. Three skills all look plausible for the same request. Decide the owner.
Pass if: the answer starts with a ruling, names `Primary Owner`, names at least one `Do Not Use`, and gives a compact `Handoff Rule` before opening any audit menu.
```

```text
Prompt 2: Use $skill-referee. I want a full audit of nearby skills because I do not trust the current routing.
Pass if: the answer explicitly enters the fallback interaction shell or equivalent explicit audit path instead of pretending a direct ruling is already enough.
```

```text
Prompt 3: Use $skill-referee. The owner is already clear; I just need to redesign that skill's kernel and structure.
Pass if: the answer hands off to `skill-architect` instead of keeping the work inside referee analysis.
```

```text
Prompt 4: Use $skill-referee. The problem is one existing skill drifting away from its intended role, but there is no real owner collision.
Pass if: the answer hands off to `skill-maintain` instead of forcing a multi-skill ruling.
```

```text
Prompt 5: Use $skill-referee. The local owner question is mostly clear, but the recurring problem may reflect a reusable upstream governance cause.
Pass if: the answer keeps the local owner judgment explicit and then hands off to `skill-governance-escalation` for the reusable-cause question.
```

```text
Prompt 6: Use $skill-referee. Two skills touch the same area, but one clearly owns planning and the other clearly owns repair. Do they actually conflict?
Pass if: the answer says there is no actionable owner conflict, explains the benign adjacency, and still gives a clean handoff rule.
```

## Run Rule

- Deterministic bundle checks happen first; live smoke only proves the changed behavior.
- This file is a narrow live layer, not a default full proof sweep.
- Start with one prompt only.
- Prefer changed snippets or tiny context extracts before reasoning over a full file.
- Prefer the leanest runtime mode available.
- Disable unrelated rules, memory, plugins, or other ambient context when the runtime allows it.
- Keep the prompt short and single-purpose.
- Ask for one ruling and a brief answer, not a broad review.
- Prefer prompts 1 and 2 when the change is about entry behavior or fallback-shell behavior.
- Prefer prompts 3-5 when the change is about handoff boundaries.
- Prefer prompt 6 when the question is whether a perceived conflict is actually just adjacency.
- If the first live smoke passes clearly, stop.
- If the first live smoke exposes one in-scope issue, repair it and rerun only the narrowest prompt that covers that issue.
- If multiple prompts fail because the ruling surface itself is still unstable, stop and escalate to a broader validation pass instead of inflating this file.
