# Skill Architect Kernel Build Brief

Load this when the kernel is already explicit, the protocol is frozen, and you need the build brief instance before you widen into bundle design, file creation, or generic scaffolding.

This file has one job: turn the kernel into the smallest build brief instance that a downstream initializer can follow without redefining the skill.

Do not use this file to discover the kernel. If the kernel sentence, trigger boundary, first move, strongest thing, or wrong-scope sentence is still fuzzy, go back to `kernel-extraction.md`.

## Required Output

Produce one brief with exactly these fields:

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

These fields are the default explicit deliverable of `skill-architect`.

## Field Rules

### 1. Kernel Lines Stay Sharp

Reuse the five kernel lines from `kernel-extraction.md`. Do not expand them into paragraphs unless one short clarification is necessary.

### 2. Minimal Shape Names The Smallest Top-Level Form

Name only the lightest top-level form that still teaches and protects the kernel.

Examples:

- `SKILL.md only`
- `SKILL.md + one reference`
- `SKILL.md + one reference + one smoke helper script`

Do not list components just because they are common in mature bundles.

### 3. Component Decisions Must Defend Themselves

For each surviving component, name:

- what the component is
- what burden it removes
- whether it protects kernel clarity, kernel stability, or kernel verification

If the answer is only "it explains things more comfortably", cut it from the brief.

### 4. Do-Not-Add Protects Against Overbuilding

Name the common components a downstream initializer might add by habit but should not add yet.

Good examples:

- `Do not add a reference just to restate the main path.`
- `Do not add scripts unless one repeated check is genuinely deterministic and fragile.`
- `Do not add starter files beyond the minimal shape already named.`

### 5. Validation Starter Must Stay Small

Give only the smallest proving set:

- deterministic bundle checks
- one or two narrow smoke prompts

Do not turn this into a full maturity suite unless the request is explicitly about robustness.

Keep the shape the same, but make the smoke ladder recoverable inside it:

- the default narrow live smoke
- the stop rule when that first narrow smoke passes clearly
- the escalation rule for when broader smoke is actually warranted

A `Validation starter` with only empty headings is still too weak for downstream handoff. A starter that keeps the headings but still hides the smallest smoke ladder is also too weak. Keep it light, but not blank.

### 6. Initializer Handoff Must Be Operational

State what a downstream initializer should initialize and what it should not invent.

The handoff should make these boundaries recoverable:

- what folder/file surface to create
- what bundle parts are in scope now
- which decisions are already frozen
- which decisions must not be re-opened by the initializer

An `Initializer handoff` with only empty headings is not enough. Even the lightest brief should still name one concrete initialize action and one concrete do-not-invent rule.

## Build Brief Failure Modes

- the brief repeats the kernel but never names the minimal shape
- the brief names components but not what they protect
- the brief acts like a generic starter-pack checklist
- the brief omits `do-not-add`, so a downstream initializer can overbuild by habit
- the brief tells the initializer to "finish the design" instead of handing off a frozen enough build surface
- the brief silently assumes one named creator, runtime, or directory layout
- the brief silently lets the creator redefine the kernel or strongest thing

## Canonical Examples

These are canonical brief examples for humans. The protocol still lives in `build-brief-protocol.md`. Repo-local machine fixtures live beside `scripts/check-build-brief.py`.

### Valid: `SKILL.md only`

```text
Kernel sentence:
This skill exists to stabilize complex live workflows before execution drifts.
Trigger boundary:
It should trigger when multi-step work has blockers, branching risk, or costly recovery.
First move:
Its first move is to map goal, known inputs, blockers, and the next checkpoint.
Strongest thing:
It is strongest when it forces an explicit checkpoint before risky work continues.
Not-this-skill-if:
If the task is already simple and deterministic, this is not the right skill.
Minimal shape:
SKILL.md only
Component decisions:
- SKILL.md hot path: owns the checkpoint loop. It protects kernel clarity.
- Recovery rule block in SKILL.md: owns retry, ask, reroute, or defer decisions. It protects kernel stability.
Do-not-add:
- Do not add references just to restate the main path.
- Do not add scripts unless one repeated verification step becomes deterministic and fragile.
Validation starter:
- Deterministic checks:
  - run the bundle check for the skill before installation or handoff
- Smoke prompts:
  - start with one narrow smoke prompt that checks the checkpoint loop and refusal boundary on first read
  - if that first smoke passes clearly, stop there instead of widening the suite
  - escalate only when trigger boundary, authority, cadence, broader routing, or multi-turn behavior changed
Initializer handoff:
- Initialize:
  - create `SKILL.md`
- Do not invent:
  - do not add references
  - do not add scripts
```

### Valid: `SKILL.md + one reference`

```text
Kernel sentence:
This skill exists to route fuzzy requests to the right workflow without long intake.
Trigger boundary:
It should trigger when the request is still fuzzy but the next owner decision is the main need.
First move:
Its first move is to classify the request by owned workflow object.
Strongest thing:
It is strongest when it resolves the owner fast and avoids over-interviewing.
Not-this-skill-if:
If the task already has a clear owner and only needs execution, this is not the right skill.
Minimal shape:
SKILL.md + one reference
Component decisions:
- SKILL.md routing loop: owns the first-turn owner judgment. It protects kernel clarity.
- One reference: holds edge-case routing examples so the hot path stays short. It protects kernel verification.
Do-not-add:
- Do not add scripts for subjective routing judgment.
- Do not add extra references for neighboring workflows that the main reference already covers.
Validation starter:
- Deterministic checks:
  - run the bundle check and confirm the one-reference shape still matches the brief
- Smoke prompts:
  - start with one narrow smoke prompt that checks the first-turn owner judgment before opening the reference
  - if that first smoke passes clearly, stop there instead of widening the suite
  - escalate only when trigger boundary, authority, cadence, broader routing, or multi-turn behavior changed
Initializer handoff:
- Initialize:
  - create `SKILL.md`
  - create one reference for edge-case routing examples
- Do not invent:
  - do not add scripts
  - do not add extra references beyond the one edge-case routing reference
```

### Valid: `SKILL.md + one script`

```text
Kernel sentence:
This skill exists to verify build brief instances against the repo-local protocol helper before handoff.
Trigger boundary:
It should trigger when the brief is already written and needs deterministic contract checking.
First move:
Its first move is to parse the brief fields in protocol order.
Strongest thing:
It is strongest when it catches missing fields and shape conflicts before downstream consumption.
Not-this-skill-if:
If the brief still needs kernel design judgment, this is not the right skill.
Minimal shape:
SKILL.md + one script
Component decisions:
- SKILL.md usage rule: explains when to run the validator. It protects kernel clarity.
- One script: checks required fields, order, and conflict signals. It protects kernel verification.
Do-not-add:
- Do not add references if the validator behavior fits in the main file.
- Do not add extra scripts that reinterpret the protocol semantically.
Validation starter:
- Deterministic checks:
  - run the bundle check and confirm the one-script shape still matches the brief
- Smoke prompts:
  - start with one narrow smoke prompt that checks the validator trigger and refusal boundary on first read
  - if that first smoke passes clearly, stop there instead of widening the suite
  - escalate only when trigger boundary, authority, cadence, broader routing, or multi-turn behavior changed
Initializer handoff:
- Initialize:
  - create `SKILL.md`
  - create one script for deterministic brief checking
- Do not invent:
  - do not add references
  - do not add extra scripts that reinterpret the protocol
```

### Incomplete: Missing Core And Structure Fields

```text
Kernel sentence:
This skill exists to stabilize complex live workflows before execution drifts.
Trigger boundary:
It should trigger when multi-step work has blockers, branching risk, or costly recovery.
First move:
Its first move is to map goal, known inputs, blockers, and the next checkpoint.
Minimal shape:
SKILL.md only
Component decisions:
- SKILL.md hot path: owns the checkpoint loop. It protects kernel clarity.
Validation starter:
- Deterministic checks:
- Smoke prompts:
Initializer handoff:
- Initialize:
- Do not invent:
```

Why this is incomplete: it is missing `Strongest thing`, `Not-this-skill-if`, and `Do-not-add`, so a downstream initializer still would not know the strongest boundary or the deny-list.

### Protocol-Valid But Not Consumption-Ready

```text
Kernel sentence:
This skill exists to route fuzzy requests to the right workflow without long intake.
Trigger boundary:
It should trigger when the request is still fuzzy but the next owner decision is the main need.
First move:
Its first move is to classify the request by owned workflow object.
Strongest thing:
It is strongest when it resolves the owner fast and avoids over-interviewing.
Not-this-skill-if:
If the task already has a clear owner and only needs execution, this is not the right skill.
Minimal shape:
SKILL.md + one reference
Component decisions:
- SKILL.md routing loop: owns the first-turn owner judgment. It protects kernel clarity.
- One reference: holds edge-case routing examples so the hot path stays short. It protects kernel verification.
Do-not-add:
- Do not add scripts for subjective routing judgment.
- Do not add extra references for neighboring workflows that the main reference already covers.
Validation starter:
- Deterministic checks:
- Smoke prompts:
Initializer handoff:
- Initialize:
- Do not invent:
```

Why this is not ready: the protocol structure is present, but both `Validation starter` and `Initializer handoff` are still empty shells, so a downstream initializer still lacks the minimum operational handoff.

### Protocol-Valid But Not Consumption-Ready: Weak Smoke Ladder

```text
Kernel sentence:
This skill exists to route fuzzy requests to the right workflow without long intake.
Trigger boundary:
It should trigger when the request is still fuzzy but the next owner decision is the main need.
First move:
Its first move is to classify the request by owned workflow object.
Strongest thing:
It is strongest when it resolves the owner fast and avoids over-interviewing.
Not-this-skill-if:
If the task already has a clear owner and only needs execution, this is not the right skill.
Minimal shape:
SKILL.md + one reference
Component decisions:
- SKILL.md routing loop: owns the first-turn owner judgment. It protects kernel clarity.
- One reference: holds edge-case routing examples so the hot path stays short. It protects kernel verification.
Do-not-add:
- Do not add scripts for subjective routing judgment.
- Do not add extra references for neighboring workflows that the main reference already covers.
Validation starter:
- Deterministic checks:
  - run the bundle check and confirm the one-reference shape still matches the brief
- Smoke prompts:
  - confirm the first-turn owner judgment is clear before opening the reference
Initializer handoff:
- Initialize:
  - create `SKILL.md`
  - create one reference file for edge-case routing examples
- Do not invent:
  - do not add scripts
  - do not add extra references beyond the one edge-case routing reference
```

Why this is not ready: the brief is still protocol-valid, but the smoke guidance never makes the default narrow smoke, stop rule, or escalation rule recoverable.

### Invalid: Shape Conflict

```text
Kernel sentence:
This skill exists to stabilize complex live workflows before execution drifts.
Trigger boundary:
It should trigger when multi-step work has blockers, branching risk, or costly recovery.
First move:
Its first move is to map goal, known inputs, blockers, and the next checkpoint.
Strongest thing:
It is strongest when it forces an explicit checkpoint before risky work continues.
Not-this-skill-if:
If the task is already simple and deterministic, this is not the right skill.
Minimal shape:
SKILL.md only
Component decisions:
- One reference: holds long case examples. It protects kernel verification.
- One script: checks checkpoint coverage. It protects kernel verification.
Do-not-add:
- Do not add assets.
- Do not add extra templates.
Validation starter:
- Deterministic checks:
- Smoke prompts:
Initializer handoff:
- Initialize:
- Do not invent:
```

Why this is invalid: `Minimal shape` wins. `Component decisions` cannot silently widen it.

### Invalid Or Manual-Review-Needed: Weak `Do-not-add`

```text
Kernel sentence:
This skill exists to stabilize complex live workflows before execution drifts.
Trigger boundary:
It should trigger when multi-step work has blockers, branching risk, or costly recovery.
First move:
Its first move is to map goal, known inputs, blockers, and the next checkpoint.
Strongest thing:
It is strongest when it forces an explicit checkpoint before risky work continues.
Not-this-skill-if:
If the task is already simple and deterministic, this is not the right skill.
Minimal shape:
SKILL.md only
Component decisions:
- SKILL.md hot path: owns the checkpoint loop. It protects kernel clarity.
Do-not-add:
- none
Validation starter:
- Deterministic checks:
- Smoke prompts:
Initializer handoff:
- Initialize:
- Do not invent:
```

Why this fails: `Do-not-add` is a hard deny-list. Placeholder wording such as `none`, `TBD`, or `try not to` is not a real protection layer.

## Next Hop

- if the brief is complete, hand initialization to a downstream initializer and stop pretending `skill-architect` is the scaffolder
- if one brief field still needs real design judgment, load `design-expansion.md` only to complete that field
- if the next question is how one downstream mode should consume the same brief, load `initializer-adapters.md`
- if the next question is already narrower than expansion, jump straight to the relevant owner reference

## Pressure Prompts

```text
Prompt: Use $skill-architect. 创建一个 skill，但我只想先把最小可建形态定清楚。
Expected behavior: produce the build brief, keep the shape minimal, and avoid drifting into generic scaffolding.
```

```text
Prompt: The kernel is clear, but I still do not know what a downstream initializer should initialize and what it should not invent.
Expected behavior: complete the initializer handoff fields before widening into extra structure.
```
