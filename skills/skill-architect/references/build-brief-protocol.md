# Skill Architect Build Brief Protocol

Load this when the kernel is already explicit and you need to lock the build brief as a stable protocol before any downstream initializer consumes it.

This file defines the protocol. It is not one specific adapter, one specific creator, or one specific runtime.

## Protocol Version

Current protocol version: `v1`

For now, the version lives in this protocol reference. Do not force every brief instance to repeat a version header unless the protocol later grows multiple live versions or machine-validated consumers.

## Required Fields

Every `v1` build brief must contain these field labels in this order:

```text
Kernel sentence:
Trigger boundary:
First move:
Strongest thing:
Not-this-skill-if:
Minimal shape:
Component decisions:
- ...
Do-not-add:
- ...
Validation starter:
- Deterministic checks:
- Smoke prompts:
Initializer handoff:
- Initialize:
- Do not invent:
```

Keep the field labels in English. Keep the explanations, examples, and notes in the user's language when helpful.

## Sufficiency Layers

Keep these layers distinct:

- `protocol-valid`
  - the brief satisfies protocol `v1` field, order, and basic substructure requirements
- `consumption-ready`
  - the brief gives a downstream initializer enough non-empty `Validation starter` and `Initializer handoff` detail to continue without reopening the kernel
- `repo-local executable`
  - the brief is not only ready in general, but also deterministic enough for the repo-local proof helper to execute

`protocol-valid` does not automatically mean `consumption-ready`.

`repo-local executable` is not a protocol-layer property. It belongs to adapter/helper execution.

## Freeze Levels

### 1. Core Freeze

These fields define the skill's kernel and may not be re-authored by a downstream initializer:

- `Kernel sentence`
- `Trigger boundary`
- `First move`
- `Strongest thing`
- `Not-this-skill-if`

Downstream consumers may restate them lightly for implementation clarity, but they must not change the owned job, trigger scope, opening move, strongest behavior, or wrong-scope boundary.

### 2. Structure Freeze

These fields define the build surface and may not be broadened by a downstream initializer:

- `Minimal shape`
- `Component decisions`
- `Do-not-add`

`Minimal shape` is the outer boundary.

`Component decisions` may only refine what exists inside that boundary.

`Do-not-add` is a hard deny-list, not a suggestion.

### 3. Execution Mapping

These fields may be mapped into concrete actions by different downstream flows, but their intent may not be overturned:

- `Validation starter`
- `Initializer handoff`

This is where adapters translate the brief into native creator prompts, manual bootstrap steps, or repo-local creation steps.

## Conflict Rules

- `Minimal shape` overrides `Component decisions`.
- If `Minimal shape` and `Component decisions` conflict, the brief is invalid and must return to `skill-architect`.
- If any core field is missing, the brief is incomplete and must return to `skill-architect`.
- If two core fields conflict semantically, the brief is invalid and must return to `skill-architect`.
- If an environment parameter is missing, such as target location or bootstrap mode, the downstream initializer may ask one narrow implementation question or use the adapter default.
- A downstream initializer may fill implementation parameters, but it may not invent missing kernel content.

## What The Protocol Does Not Own

These are not protocol-core fields:

- absolute filesystem paths
- one agent's private directory layout
- one runtime's metadata quirks
- one creator's default scaffolding habits

If these matter, mention them only as adapter inputs or abstract handoff targets such as:

- `repo-local`
- `user skill dir`
- `native creator target`

## Consumption Rule

Any consumer must do one of three things:

1. consume the brief faithfully
2. reject it explicitly as incomplete or conflicting
3. escalate it as an upstream integration candidate if repeated failures suggest the protocol is sound but one consumer class cannot reliably follow it

Do not silently reinterpret the brief.

Before a consumer attempts real initialization, it should check not only whether the brief is `protocol-valid`, but also whether it is `consumption-ready` enough for that downstream mode.

## Retrofit Rule

The main protocol story is pre-create handoff.

If an existing draft still lacks a stable kernel, it may be retrofitted into a build brief first and then re-shaped.

If the role is already stable and the problem is only drift, route to `skill-maintain` instead of pretending every old draft needs protocolization.

## Pressure Prompts

```text
Prompt: This build brief is missing `Strongest thing` and `Do-not-add`. Can the initializer continue?
Expected behavior: reject consumption and send it back to skill-architect instead of inventing the missing kernel.
```

```text
Prompt: `Minimal shape` says `SKILL.md only`, but `Component decisions` names a reference and a script. What now?
Expected behavior: mark the brief invalid and route back for repair.
```

```text
Prompt: Every field is present, but `Validation starter` and `Initializer handoff` still contain only empty headings. Is the brief ready?
Expected behavior: keep protocol validity separate from readiness and say the brief is not yet consumption-ready.
```
