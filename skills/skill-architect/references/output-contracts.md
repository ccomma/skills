# Skill Architect Output Contracts

Load this when the skill's value depends on stable output shape, fields, labels, sections, or artifact quality.

For `skill-architect`, the default output contract is a build brief protocol instance unless the task is explicitly asking for a closeout report instead.

## Design Questions

- Does the skill need a predictable report, checklist, table, patch summary, or artifact layout?
- Which parts of the output must stay stable across runs?
- Should the contract live in `SKILL.md`, `references/`, assets, or a script-generated summary?
- Does the contract need placeholders that adapt to the user's language at runtime?
- Is the output a pre-create handoff brief or a post-design explanation artifact?

## Design Patterns

### 1. Put The Contract Where The Weight Belongs

- Keep short always-needed output rules in `SKILL.md`
- Put detailed templates or variants in `references/`
- Use `assets/` when a real file or template is more stable than prose

For `skill-architect` specifically:

- keep the rule that a build brief is mandatory in `SKILL.md`
- keep the protocol definition in `build-brief-protocol.md`
- keep the detailed brief template and canonical examples in `kernel-build-brief.md`
- keep adapter guidance and wrapper templates in `initializer-adapters.md`
- keep `design-report.md` as closeout explanation, not pre-create handoff
- keep `scripts/check-build-brief.py` as a repo-local validator, not as the protocol owner
- keep `scripts/bootstrap-build-brief.py` as a repo-local consumption proof helper, not as a generic creator

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

For `skill-architect`, repo-local deterministic validation should run `scripts/check-build-brief.py` when a standalone brief artifact exists.

That validator now answers two different questions:

- is the brief `protocol-valid`
- is the brief `consumption-ready`

When the question is whether a validated brief can actually be consumed inside this repo, run `scripts/bootstrap-build-brief.py` as a proof helper after validation. It may refuse with `repo-local ambiguous` even when the protocol itself is valid.

## Skill-Architect Default Contract

Unless the user is explicitly asking for retrospective explanation, `skill-architect` should default to a build brief with stable field names:

- `Kernel sentence`
- `Trigger boundary`
- `First move`
- `Strongest thing`
- `Not-this-skill-if`
- `Minimal shape`
- `Component decisions`
- `Do-not-add`
- `Validation starter`
- `Initializer handoff`

The protocol version lives in `build-brief-protocol.md`, not in every brief instance by default.

The field labels stay in English; the explanatory content may follow the user's language.

The brief is the pre-create contract.

The repo-local validator checks whether one brief instance matches protocol `v1` deterministic requirements and whether it already reaches the minimum downstream handoff floor. It does not redefine protocol semantics or replace pressure tests.

The repo-local bootstrap helper checks whether one validated brief is both `protocol-valid` and `consumption-ready`, then asks the narrower question of repo-local executability. It does not replace downstream initializer design, and it does not turn `skill-architect` into a creator.

`design-report.md` is the closeout contract for explaining why a finished design was shaped this way.

## Pressure Prompts

```text
Prompt: Design a skill that always produces a concise audit report with fixed headings and evidence notes.
Expected design: explicit output contract, with stable sections and a validation path.
```

```text
Prompt: Design a reusable skill whose report must stay structurally stable in Chinese and English sessions.
Expected design: stable sections with localized visible labels, rather than an English-only scaffold.
```
