# Skill Architect Design Report

Load this when finishing a new or substantially upgraded skill.

The report should be concise enough to include in the final response or a short handoff note. It should explain the design without becoming a second SKILL.md.

## Purpose

The report helps future users understand:

- why the skill was designed this way
- which structure choices were made
- how the skill should be tested
- whether token cost is healthy
- what risks remain

## Recommended Length

Aim for 150-300 words for small skills and 300-600 words for mature reusable skills. Avoid long transcripts or copied skill text.

## Report Template

Render labels in the user's language.

```text
Skill:
Design goal:
Architecture:
- Profile:
- Files:
- Why this structure:
Interaction model:
Validation / pressure tests:
Token cost:
- Default load:
- Conditional references/scripts/assets:
- Cost risk:
Residual risks:
Recommended next test:
```

## Token Cost Guidance

Estimate token cost qualitatively unless exact token tooling is available.

Use:

- `low`: short `SKILL.md`, references rarely loaded, no large examples
- `medium`: several references or menus loaded in common use
- `high`: long default body, many always-loaded rules, large examples, or broad full-audit behavior

Always separate default load from worst-case load.

Good phrasing:

```text
Default token cost is low because only SKILL.md loads. Worst-case cost is medium when intake, architecture patterns, and pressure tests are all loaded during skill creation.
```

## What Not To Include

- full file contents
- long command output
- generic praise
- exhaustive design history
- unrelated implementation details
