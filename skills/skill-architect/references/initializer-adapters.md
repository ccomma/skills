# Skill Architect Initializer Adapters

Load this when the build brief already exists and the next question is how one class of downstream initializer should safely consume it.

This file defines adapter classes. It does not patch external creators or hardcode one runtime as the protocol itself.

## What An Adapter Does

The protocol defines the brief.

The adapter defines how one downstream consumption mode should follow that same brief without:

- redefining the kernel
- widening the bundle by habit
- inventing forbidden components
- depending on private runtime defaults

## Adapter Classes

### 1. Native Creator Adapter

Use this when the environment already has a creator workflow.

Consumption method:

- pass the build brief as structured prompt context
- explicitly mark core and structure fields as frozen
- tell the creator to initialize only what `Minimal shape` and `Component decisions` permit
- repeat `Do-not-add` as a hard deny-list

You may cite a system `skill-creator` as an example of this class, but only as an adapter example, not as the protocol definition itself.

### 2. Manual Bootstrap Adapter

Use this when there is no native creator workflow.

Default actions:

1. read the build brief
2. create only the file surface allowed by `Minimal shape`
3. implement only the components named in `Component decisions`
4. skip everything forbidden by `Do-not-add`
5. run the `Validation starter`

If the brief is missing kernel fields, stop and return it to `skill-architect`.

### 3. Repo-Local Adapter

Use this when the work happens directly inside the current skills repo or another known repo-local skill tree.

Default actions:

- map the brief onto the repo's existing skill layout conventions
- keep the bundle minimal
- use repo-local deterministic checks such as bundle validators only as adapter-local execution detail
- keep those repo conventions out of the protocol definition itself

## Adapter Rules

- Adapters are consumption mappings, not upstream patches.
- Adapters may ask at most one narrow implementation question when a non-protocol environment parameter is missing.
- Adapters must reject missing or conflicting core protocol fields instead of inventing them.
- Adapters may map `Initializer handoff` into concrete steps, but they may not broaden `Minimal shape` or weaken `Do-not-add`.

## Prompt Wrapper Pattern

When a native creator workflow is used through prompting, the adapter should wrap the brief with these rules:

```text
Treat the build brief as frozen protocol input.
Do not redefine the kernel.
Do not widen the bundle beyond Minimal shape and Component decisions.
Treat Do-not-add as a hard deny-list.
Only ask about missing environment parameters, not missing kernel decisions.
```

The exact prompt wording can vary by runtime. The control rule must stay the same.

## Governance Boundary

If repeated evidence shows that one adapter class cannot reliably consume a sound brief, classify that as an `upstream integration candidate` or other governance candidate instead of silently forking the protocol.

## Pressure Prompts

```text
Prompt: We have a complete build brief, but this environment has no creator workflow. What adapter should we use?
Expected behavior: choose manual bootstrap and keep the same protocol fields intact.
```

```text
Prompt: This native creator keeps adding references that `Do-not-add` forbids. What is the right response?
Expected behavior: classify the issue as adapter or upstream integration failure, not as a reason to weaken the protocol.
```
