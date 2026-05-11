# Skill Maintain Language And Portability

Load this when the target skill has hardcoded runtime terms, mixed human languages, local paths, private workflow names, or non-portable examples.

## What To Check

- vendor-specific filenames presented as universal rules
- local filesystem paths or personal workflow names treated as public requirements
- concrete neighboring skill names where capability categories would be clearer
- mixed-language labels, headers, or templates
- examples that assume one runtime, one repository, or one user's setup

## Repair Patterns

### 1. Replace Concrete Runtime Assumptions

Prefer generic concepts such as:

- cold-start entrypoint file
- agent runtime
- session context loader
- skill boundary workflow
- skill design workflow

Use vendor-specific names only as clearly labeled examples.

### 2. Normalize User-Facing Language

When a skill defines labels, headers, or compact templates:

- keep output in the user's session language
- use placeholders or pattern descriptions when the artifact should adapt at runtime
- avoid mixing languages inside one template unless the artifact intentionally requires it

### 3. Remove Private Context From Public Guidance

Replace:

- local paths
- private repo aliases
- personal workflow nicknames
- environment-specific neighboring skill references

with portable capability descriptions unless the user explicitly supplied the concrete term.

## Regression Prompts

```text
Prompt: This skill hardcodes `CLAUDE.md`, my local path, and Chinese labels in an otherwise English workflow. Repair it.
Pass if: runtime wording becomes illustrative, labels become session-language aware, and the skill still stays specific enough to use.
```

```text
Prompt: This skill routes to two private neighboring skills by name. Make it publishable.
Pass if: routing uses capability categories without losing practical clarity.
```

```text
Prompt: This skill tells other skills to follow the user's language, but its own output template is hardcoded in English. Repair it.
Pass if: the output contract keeps stable sections while making visible labels session-language aware.
```
