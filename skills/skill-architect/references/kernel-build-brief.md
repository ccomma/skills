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

### 6. Initializer Handoff Must Be Operational

State what a downstream initializer should initialize and what it should not invent.

The handoff should make these boundaries recoverable:

- what folder/file surface to create
- what bundle parts are in scope now
- which decisions are already frozen
- which decisions must not be re-opened by the initializer

## Build Brief Failure Modes

- the brief repeats the kernel but never names the minimal shape
- the brief names components but not what they protect
- the brief acts like a generic starter-pack checklist
- the brief omits `do-not-add`, so a downstream initializer can overbuild by habit
- the brief tells the initializer to "finish the design" instead of handing off a frozen enough build surface
- the brief silently assumes one named creator, runtime, or directory layout
- the brief silently lets the creator redefine the kernel or strongest thing

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
