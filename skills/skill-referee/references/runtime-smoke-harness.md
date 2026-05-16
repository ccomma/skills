# Skill Referee Runtime Smoke Harness

Load this when the question is not "what is the owner ruling", but "how do I prove the changed ruling behavior with the cheapest useful live test".

The user should not need to choose these runtime layers explicitly. They are internal testing modes for this workflow to choose automatically.

## What A Harness Is

A runtime smoke harness is a thin, repeatable wrapper around one available agent runtime.

It is not the runtime itself. It is the minimal contract for one live owner-ruling check without dragging in unrelated ambient context.

A harness fixes one tiny test:

- runtime layer
- prompt
- pass condition
- ambient context to disable
- stop / rerun / escalate rule

When the changed behavior can be judged from one changed excerpt or tiny context extract, pass that narrower context first instead of forcing the runtime to rediscover the same context by reading whole files.

## Runtime Classes

Do not hardcode one agent brand into the ruling policy. Choose the lightest runtime class that can still prove the changed ruling behavior.

### 1. Direct Smoke

Use this when a tiny prompt against the changed skill artifact is enough to prove the behavior.

Examples:

- a local model wrapper
- a narrow API harness
- a tiny agent test runner that can load only the target skill

This is usually the cheapest useful live check.

If a direct smoke pack can carry the prompt, pass criteria, and tiny context cleanly, prefer that over a heavier live session.

### 2. Lean Agent-CLI Smoke

Use this when direct smoke is not enough, but a full live session would be wasteful.

In practice, this means:

- the workflow still needs real behavior from an installed agent runtime
- but the changed surface is narrow enough that one tiny live check should be enough

Launch the runtime in its leanest trustworthy mode: isolate it from unrelated ambient context, keep only the target skill plus unavoidable system context in view when possible, and keep reasoning effort low unless that would weaken the test.

### 3. Full Runtime Smoke

Use this only when the change touched:

- trigger boundary
- authority or risky actions
- interaction cadence
- broader routing
- multi-turn behavior

If a lean smoke already proves the changed behavior, do not escalate.

## Adapter Rule

Treat any concrete runtime as one adapter, not the definition of the harness.

Do not let the generic harness contract hardcode one brand, one local installation, or one machine-specific runtime. Keep the same contract and map it onto the runtime class the active environment actually exposes.

Adapter questions:

- Can this runtime be made lean enough: ephemeral, isolated from unrelated config, rules, plugins, memory, and narrow in prompt and output?

If yes, build a lean adapter.

If not, fall back to:

- direct smoke
- manual operator prompt with explicit pass/fail criteria

## Execution Rule

Climb only as far as needed:

1. deterministic checks
2. direct smoke
3. lean agent-CLI smoke
4. full runtime smoke

At each layer:

- stop if the tiny smoke passes clearly
- repair and rerun the same narrow layer if it exposes one in-scope issue
- escalate only when the lower layer cannot prove the changed ruling behavior or exposes a broader risk

The workflow should choose this ladder automatically. Only surface these layer names to the user when explaining verification strategy or debugging the harness itself.

## Referee-Specific Guidance

- Default to one prompt, not the whole `minimal-smoke-prompts.md` file.
- Prefer prompt 1 when the change is about entry behavior or ruling shape.
- Prefer prompt 2 only when the change is about fallback-shell entry.
- Prefer prompts 3-6 only when the change is about handoff boundaries.
- Do not run all six prompts unless the ruling surface itself changed broadly enough that one prompt cannot prove the edited behavior.
- If the changed behavior can be shown from one short excerpt in `SKILL.md`, `agents/openai.yaml`, or `references/interaction.md`, feed that excerpt first instead of the full file.
- If deterministic checks are clean and the first narrow live smoke passes clearly, stop.
