# Skill Architect Architecture Patterns

Load this when choosing structure, interaction strength, or file layout.

## Design Rule

Use the weakest structure that prevents the real failure mode.

| Profile | Use When | Avoid When |
| --- | --- | --- |
| `simple` | task is narrow, safe, obvious | user choices change outcome significantly |
| `guided` | judgment matters but flow can vary | repeated failures come from skipped decisions |
| `constrained` | choices are ambiguous, risky, expensive, or often confused | task is tiny or user already specified enough |
| `deterministic` | repeated work needs exact parsing, validation, conversion, or filesystem actions | prose is enough and variation is useful |
| `asset-backed` | output should follow reusable templates, media, or boilerplate | no reusable output resources exist |

Strong constraints are useful when they prevent bad defaults, wasted context, accidental broad scope, irreversible actions, or repeated mistakes. They are harmful when they slow down simple work or block creative exploration.

## File Layout Decision

### `SKILL.md only`

Use for narrow skills with short stable rules.

Keep:

- trigger boundary
- 3-7 hard rules
- tiny decision tree
- output expectation

### `SKILL.md + references/`

Use when the skill has optional or bulky knowledge:

- fixed option menus
- long examples
- style guides
- domain rules
- policy details
- variants by framework, format, platform, or audience
- output templates that are read, not copied

Reference files should be one hop from `SKILL.md` and loaded by condition.

### `SKILL.md + scripts/`

Use when deterministic work matters:

- inventory
- parsing
- validation
- conversion
- formatting
- generation
- repeated filesystem edits

Prefer scripts when prose would cause repeated fragile rewrites.

### `SKILL.md + assets/`

Use when output needs reusable resources:

- document templates
- slide templates
- image/media resources
- starter projects
- boilerplate copied into outputs

Assets are used, not read into context by default.

### `agents/openai.yaml`

Use when the environment supports human-facing skill metadata. Keep it aligned with `SKILL.md`.

## Frontmatter Description

Description should answer: when should this skill load?

Good pattern:

```yaml
description: Use when <trigger situation or failure mode>, especially <specific boundary>, or when <neighboring confusion>
```

Avoid:

- full workflow summaries
- implementation details
- exact output promises
- first-person phrasing
- broad descriptions that trigger on nearly every task

## Interaction Design

Good fixed options:

- stable ids or letters
- recommended default
- cost/risk notes
- stop and wait after asking
- option wording rendered in user language
- stable meaning even when translated

Avoid fixed options when:

- the user already answered the choice
- the task is tiny
- open-ended creativity is the point
- the menu is longer than the work

## Neighbor Boundaries

Write routing rules rather than vague exclusions:

```text
Use this skill for <owned situation>.
Use <other skill> for <neighbor situation>.
Do not use this skill for <non-goal>.
```

Consider using a skill-boundary/referee skill after designing a skill that touches existing workflows.

## Maturity Checklist

- One primary job.
- Specific trigger description.
- Clear non-goals.
- Lightest adequate interaction model.
- `SKILL.md` stays concise.
- References/scripts/assets have clear load/use conditions.
- Output format exists when consistency matters.
- Missing information has a fallback path.
- Neighboring skills have routing boundaries.
- Token-heavy content is lazy-loaded.
