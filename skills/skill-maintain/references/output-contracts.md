# Skill Maintain Output Contracts

Load this when the target skill has drifting sections, unstable labels, missing required fields, or weak artifact acceptance rules.

For `skill-maintain`, the default output contract is a `maintenance verdict`.

That verdict is a localized maintenance report for one existing skill. It is not:

- a build-brief protocol instance
- a governance-escalation report
- a repo-wide shared governance artifact
- a new format file or asset by default

## What To Check

- the verdict sections or fields are actually stated
- labels and headings are consistent across `SKILL.md`, references, and examples
- output ordering or required evidence has not drifted
- the contract can explain why the issue is still maintenance rather than redesign
- handoff conditions are explicit when the repair should route away
- templates or artifact rules are explicit enough to validate
- the contract still adapts to the user's session language when appropriate

## Repair Patterns

### 1. Restore The Minimum Stable Contract

Repair the smallest set of rules needed to make the default verdict predictable again:

- drift diagnosis
- repair depth
- maintenance vs redesign judgment
- handoff judgment when needed
- proof or acceptance evidence
- residual risk or confidence

When the artifact is user-facing, make the contract language-aware:

- keep the section semantics and ordering stable, but let visible labels follow the user's session language
- keep exact technical tokens verbatim when translation would reduce precision
- avoid hardcoding English scaffold text unless the artifact itself is intentionally English

### 2. Put Heavy Contract Detail In The Right Place

- short always-needed verdict rules stay in `SKILL.md`
- heavier verdict examples or variants move to `references/`
- do not introduce a new `assets/` template unless prose can no longer carry the contract cleanly

### 3. Keep The Contract Validatable

Prefer stable section semantics, handoff rules, and completion checks over vague prose such as "give a nice summary."

## Skill-Maintain Default Verdict

Unless the task explicitly asks for a different artifact, `skill-maintain` should default to a `maintenance verdict` with stable sections for:

- drift diagnosis
- repair depth
- maintenance vs redesign judgment
- handoff judgment
- proof
- residual risk and confidence

The visible labels may follow the user's language.

The verdict should stay compact and decision-oriented. It should not expand into a protocol instance or a multi-layer governance report.

## Regression Prompts

```text
Prompt: This skill used to produce a maintenance verdict, but now the sections drift, the redesign judgment disappears, and the labels vary from run to run. Repair the output contract.
Pass if: the verdict regains stable sections for drift, repair depth, maintenance judgment, handoff, proof, and residual risk without turning into an English-only protocol or a governance report.
```
