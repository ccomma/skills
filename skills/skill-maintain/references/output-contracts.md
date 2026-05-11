# Skill Maintain Output Contracts

Load this when the target skill has drifting sections, unstable labels, missing required fields, or weak artifact acceptance rules.

## What To Check

- required report sections or fields are actually stated
- labels and headings are consistent across `SKILL.md`, references, and examples
- output ordering or required evidence has not drifted
- templates or artifact rules are explicit enough to validate
- the contract still adapts to the user's session language when appropriate

## Repair Patterns

### 1. Restore The Minimum Stable Contract

Repair the smallest set of rules needed to make output predictable again:

- must-have sections
- must-have fields
- required evidence
- completion or acceptance checks

When the artifact is user-facing, make the contract language-aware:

- keep the section set stable, but let visible labels follow the user's session language
- keep exact technical tokens verbatim when translation would reduce precision
- avoid hardcoding English scaffold text unless the artifact itself is intentionally English

### 2. Put Heavy Contract Detail In The Right Place

- short always-needed rules stay in `SKILL.md`
- heavier examples or variants move to `references/`
- real templates or starter files belong in `assets/` when prose is too fragile

### 3. Keep The Contract Validatable

Prefer stable headings, labels, and completion checks over vague prose such as "give a nice summary."

## Regression Prompts

```text
Prompt: This skill used to produce a fixed audit report, but now the sections and labels drift from run to run. Repair the output contract.
Pass if: required sections and labels become explicit again without over-specifying irrelevant wording.
```
