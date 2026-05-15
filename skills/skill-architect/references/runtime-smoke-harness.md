# Skill Architect Runtime Smoke Harness

Load this when the design question is not "what should the skill do", but "how do I prove the changed behavior with the cheapest useful live test".

## What A Harness Is

A runtime smoke harness is a thin, repeatable test wrapper around an available agent runtime.

It is not the runtime itself. It is the minimal contract for running one live behavior check without dragging in unnecessary ambient context.

A harness fixes one tiny test:

- runtime layer
- prompt
- pass condition
- ambient context to disable
- stop / rerun / escalate rule

## Runtime Classes

Do not optimize for one brand name first. Optimize for the runtime class you actually have.

### 1. Direct Smoke

Use this when a tiny prompt against the changed skill artifact is enough to prove the changed behavior.

Examples:

- a local model wrapper
- a narrow API harness
- a tiny agent test runner that can load just the target skill

This is usually the cheapest useful live test.

If this bundle ships a direct smoke pack generator, use it to prepare the tiny prompt plus pass criteria instead of inventing the pack from scratch.

If downstream automation needs machine-readable input, prefer a direct pack format that can emit structured output such as JSON instead of forcing everything through prose parsing.

### 2. Lean Agent-CLI Smoke

Use this when you need real agent behavior from an installed runtime, but the change is still narrow.

The runtime should be launched in its leanest mode:

- ephemeral if available
- ignore unrelated user config if available
- ignore unrelated rules if available
- disable plugins, apps, browser layers, memories, or other ambient context if available
- if possible, run against an isolated smoke home that contains only system skills plus the target skill
- keep reasoning effort low when that does not weaken the test

This is the right layer when direct smoke would miss a real runtime behavior, but a full session would be wasteful.

### 3. Full Runtime Smoke

Use this only when the change touched:

- trigger boundary
- authority or risky actions
- interaction cadence
- broader routing
- multi-turn behavior

If a lean smoke already proves the changed behavior, do not escalate.

## Adapter Rule

Treat Codex as one adapter, not the definition of the harness.

If the user uses a different agent, do not invent Codex-only requirements. Reuse the same harness contract and map it onto the runtime class that agent actually exposes.

Examples of adapter questions:

- Can this runtime run ephemerally?
- Can it ignore user config or local rules?
- Can it disable plugins, apps, memories, or other ambient layers?
- Can it keep the prompt/output narrow?

If yes, build a lean adapter.

If not, drop to the next simpler class:

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
- escalate only when the lower layer cannot prove behavior or exposes a broader risk

## Codex Example

Codex is only one current adapter. A lean Codex smoke can use flags such as:

- `--ephemeral`
- `--ignore-user-config`
- `--ignore-rules`
- `--disable plugins`
- `--disable apps`
- `--disable browser_use`
- `--disable computer_use`
- `--disable memories`

For stronger isolation, launch Codex against a temporary `HOME/CODEX_HOME` that contains only the target skill plus system skills. This removes injected local bundles such as `superpowers` from the model-visible skill list.

Use Codex-specific flags only when Codex is the runtime being tested.

If this bundle ships `scripts/run-runtime-smoke.sh`, use it instead of hand-assembling the command every time.

If this bundle ships `scripts/check-runtime-smoke.sh`, run it after editing the runner so the harness itself is proven before broader live smoke.
