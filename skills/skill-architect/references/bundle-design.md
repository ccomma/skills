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

### 3. Treat Bundle Drift As A Design Failure

If a design makes it easy for names, modes, or entrypoints to drift apart, simplify it or add deterministic checks.

## Pressure Prompts

```text
Prompt: Design a mature skill with references, scripts, and agent metadata that other runtimes can install.
Expected design: clear bundle structure, aligned entry surfaces, and explicit use conditions for support files.
```
