# Skill Architect Output Contracts

Load this when the skill's value depends on stable output shape, fields, labels, sections, or artifact quality.

## Design Questions

- Does the skill need a predictable report, checklist, table, patch summary, or artifact layout?
- Which parts of the output must stay stable across runs?
- Should the contract live in `SKILL.md`, `references/`, assets, or a script-generated summary?
- Does the contract need placeholders that adapt to the user's language at runtime?

## Design Patterns

### 1. Put The Contract Where The Weight Belongs

- Keep short always-needed output rules in `SKILL.md`
- Put detailed templates or variants in `references/`
- Use `assets/` when a real file or template is more stable than prose

### 2. Contract First, Wording Second

Stabilize:

- required sections
- required fields
- ordering
- must-have evidence
- artifact acceptance checks

Then decide how much wording flexibility the skill should allow.

When the output is user-facing, keep the semantic contract stable while allowing visible labels to follow the user's session language. Preserve exact technical tokens only when translation would reduce precision.

### 3. Design For Validation

If output consistency matters, make the contract easy to validate:

- named sections
- stable labels or placeholders
- explicit completion checks

## Pressure Prompts

```text
Prompt: Design a skill that always produces a concise audit report with fixed headings and evidence notes.
Expected design: explicit output contract, with stable sections and a validation path.
```

```text
Prompt: Design a reusable skill whose report must stay structurally stable in Chinese and English sessions.
Expected design: stable sections with localized visible labels, rather than an English-only scaffold.
```
