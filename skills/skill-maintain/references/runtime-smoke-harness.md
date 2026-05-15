# Skill Maintain Runtime Smoke Harness

Load this when the repair question is not "what should we patch", but "how do we prove the repaired behavior with the cheapest useful live test".

The user should not need to choose these runtime layers explicitly. They are internal testing modes for the workflow to choose automatically.

## What A Harness Is

A runtime smoke harness is a thin, repeatable test wrapper around an available agent runtime.

It is not the runtime itself. It is the minimal contract for one live repair check without dragging in unnecessary ambient context.

A harness fixes one tiny repair test:

- runtime layer
- prompt
- pass condition
- ambient context to disable
- stop / rerun / escalate rule

When the repaired behavior can be judged from one changed excerpt or tiny context extract, pass that narrower context first instead of forcing the runtime to recover the same context by reading whole files.

## Runtime Classes

Do not hardcode one agent brand into the repair policy. Choose the lightest runtime class that can still prove the repaired behavior.

### 1. Direct Smoke

Use this when a tiny prompt against the repaired skill artifact is enough to prove the changed behavior.

Examples:

- a local model wrapper
- a narrow API harness
- a tiny agent test runner that can load just the target skill

This is usually the cheapest useful live check.

If this bundle ships a direct smoke pack generator, use it to prepare the tiny prompt plus pass criteria instead of inventing the pack from scratch.

If downstream automation needs machine-readable input, prefer a direct pack format that can emit structured output such as JSON instead of forcing everything through prose parsing.

### 2. Lean Agent-CLI Smoke

Use this when direct smoke is not enough, but a full live session would be wasteful.

In practice, this means:

- the workflow still needs real behavior from an installed agent runtime
- but the repaired surface is narrow enough that one tiny live check should be enough

This is an internal workflow choice, not something the user should have to decide manually.

Launch the runtime in its leanest trustworthy mode: isolate it from unrelated ambient context, keep only the target skill plus system skills in view when possible, and keep reasoning effort low unless that would weaken the test.

### 3. Full Runtime Smoke

Use this only when the repair touched:

- trigger boundary
- authority or risky actions
- interaction cadence
- broader capability preservation
- multi-turn behavior

If a lean smoke already proves the repaired behavior, do not escalate.

## Adapter Rule

Treat any concrete runtime as one adapter, not the definition of the harness.

Do not let the generic harness contract hardcode one brand, one local installation, or one machine-specific runtime. Keep the same contract and map it onto the runtime class the active environment actually exposes.

Adapter questions:

- Can this runtime be made lean enough: ephemeral, isolated from unrelated config/rules/plugins/memory, and narrow in prompt/output?

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
- escalate only when the lower layer cannot prove the repaired behavior or exposes a broader risk

The workflow should choose this ladder automatically. Only surface these layer names to the user when explaining verification strategy or debugging the harness itself.

## Adapter-Specific Detail

Keep concrete flags, environment variables, and isolation tricks inside the adapter implementation or its adapter-local test note, not in the generic harness contract.

Adapter-local test notes are non-normative for the generic harness contract.

If an adapter can launch in a lean isolated mode, prefer that mode there rather than teaching brand-specific toggles in this reference.

If an adapter can accept explicit changed snippets or tiny context extracts, prefer that over prompting it to rediscover the same context from full-file reads.

If this bundle ships `scripts/run-runtime-smoke.sh`, use it instead of hand-assembling the command every time.

If this bundle ships `scripts/check-runtime-smoke.sh`, run it after editing the runner so the harness itself is proven before broader live smoke.
