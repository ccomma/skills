# Skill Architect Bundle Design

Load this when deciding what overall support-layer component combination should survive after the kernel and build brief are already frozen.

If the real question is whether references should exist, merge, split, or sharpen, load `reference-design.md`.

If the real question is still "what is this skill's kernel" or "what should the build brief say", go back to `kernel-extraction.md`, `build-brief-protocol.md`, or `kernel-build-brief.md`.

## Routing Position

- common upstream:
  - `kernel-extraction.md`
  - `build-brief-protocol.md`
  - `kernel-build-brief.md`
  - `design-expansion.md`
- if the real question is owner component, jump to `component-paths.md`

## Distinction

Use this file for bundle-wide component alignment after the build brief already exists.

Do not use this file to discover the kernel, render the build brief, decide downstream initialization, or choose one component owner in isolation.

Use `component-paths.md` to decide where one piece of guidance belongs.

Use this file to decide what overall combination of components the skill should keep across repeated burdens.

If you are only placing one rule, one checklist, one template description, or one example, you are probably in `component-paths.md`, not here.

## Design Questions

- Which components directly teach, protect, or verify the kernel?
- Which files are part of the public bundle?
- Which files are always loaded, conditionally loaded, used, or executed?
- How will the skill stay internally consistent after renames or upgrades?
- Which references need a direct path from `SKILL.md`?

## Bundle Shapes

Use the lightest overall combination that protects the real failure mode:

- `SKILL.md only`
  - for narrow skills with short stable rules
- `SKILL.md + references/`
  - for optional depth, examples, policies, or variants
- `SKILL.md + scripts/`
  - for deterministic repeated work
- `SKILL.md + format file`
  - for one repeated artifact shape whose structure must stay stable
- `SKILL.md + assets/`
  - for reusable templates, starters, or media resources
- `bundle metadata`
  - when the environment needs a human-facing entry surface

Do not add a component just because similar skills often have one. Add it only when it removes a clear burden from the main entry surface, protects a real bundle contract, or makes the kernel more teachable, stable, or verifiable.

## Design Patterns

### 1. Design One-Hop Reachability

Every important reference, script, or asset should have a clear load or use condition from `SKILL.md`.

### 2. Keep Entry Surfaces Aligned

Frontmatter, title, agent metadata, and any reference descriptions should all describe the same skill and the same trigger boundary.

### 3. Keep The Core Thin And Sharp

If a skill depends on a small number of strong behavioral instructions, keep those instructions near the top of `SKILL.md` and move artifact schemas, long examples, and detailed writeback rules into one-hop references.

Good signs for a companion reference or format file:

- the content describes the shape of a repeated artifact such as a decision record, domain-language entry, handoff, or report
- the detail is important, but not needed on every invocation
- keeping it out of the main file makes the kernel sharper rather than merely shorter
- the main skill is starting to feel explanatory instead of directive

### 4. Use Companion Format Files Deliberately

Artifact-specific format files work well when a skill repeatedly creates or updates one artifact shape. They help the main skill stay short while keeping the artifact contract precise.

Do not create companion files just to fragment the bundle. Add them when they preserve a stronger core instruction surface.

### 5. Treat Bundle Drift As A Design Failure

If a design makes it easy for names, modes, or entrypoints to drift apart, simplify it or add deterministic checks.

## Necessity Check

Before keeping a component in the bundle, ask:

- what exact kernel burden this component removes from the entry surface
- what recurring burden does this component remove from the main entry surface
- why is that burden recurring rather than local to one rule
- why would repeated `component-paths.md` decisions not already be enough
- what token, maintenance, read, or drift cost this component adds
- why that cost is still worth paying

If removing the component would only reduce explanation comfort, cut it.

## Pressure Prompts

```text
Prompt: Design a mature skill with references, scripts, and agent metadata that other runtimes can install.
Expected design: clear bundle structure, aligned entry surfaces, and explicit use conditions for references.
```
