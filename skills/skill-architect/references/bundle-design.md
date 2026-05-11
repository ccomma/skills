# Skill Architect Bundle Design

Load this when deciding how `SKILL.md`, references, scripts, assets, and agent metadata should work as one published bundle.

## Design Questions

- Which files are part of the public bundle?
- Which files are always loaded, conditionally loaded, used, or executed?
- How will the skill stay internally consistent after renames or upgrades?
- Which support files need a direct path from `SKILL.md`?

## Design Patterns

### 1. Design One-Hop Reachability

Every important reference, script, or asset should have a clear load or use condition from `SKILL.md`.

### 2. Keep Entry Surfaces Aligned

Frontmatter, title, agent metadata, and any support-file descriptions should all describe the same skill and the same trigger boundary.

### 3. Keep The Core Thin And Sharp

If a skill depends on a small number of strong behavioral instructions, keep those instructions near the top of `SKILL.md` and move artifact schemas, long examples, and detailed writeback rules into one-hop references.

Good signs for a companion reference or format file:

- the content describes the shape of a repeated artifact such as an ADR, glossary entry, handoff, or report
- the detail is important, but not needed on every invocation
- the main skill is starting to feel explanatory instead of directive

### 4. Use Companion Format Files Deliberately

Format files such as `ADR-FORMAT.md` or `CONTEXT-FORMAT.md` work well when a skill repeatedly creates or updates one artifact shape. They help the main skill stay short while keeping the artifact contract precise.

Do not create companion files just to fragment the bundle. Add them when they preserve a stronger core instruction surface.

### 5. Treat Bundle Drift As A Design Failure

If a design makes it easy for names, modes, or entrypoints to drift apart, simplify it or add deterministic checks.

## Pressure Prompts

```text
Prompt: Design a mature skill with references, scripts, and agent metadata that other runtimes can install.
Expected design: clear bundle structure, aligned entry surfaces, and explicit use conditions for support files.
```
