# Skill Architect Format File Design

Load this when deciding whether a skill should create companion format files such as `ADR-FORMAT.md`, `CONTEXT-FORMAT.md`, report templates, handoff formats, or other artifact-shape guides.

## When A Format File Is Worth Creating

Create a companion format file only when all of these are true:

1. the skill repeatedly creates or updates the same artifact shape
2. artifact quality materially affects workflow quality
3. the details are important, but not needed on every invocation of the main skill
4. the artifact can be judged against stable quality criteria

If any of the four is missing, keep the guidance in `SKILL.md` or a normal reference instead.

## What A High-Quality Format File Must Contain

Every format file should make these points easy to answer:

- what artifact this file governs
- the smallest good structure or template
- what is required
- what is optional
- what should usually be omitted
- when the artifact should be created
- when it should not be created
- where the resolved content should live in the owning document stack

The goal is not a comprehensive form. The goal is the smallest artifact shape that still protects quality.

## Quality Bar

Use this checklist before calling a format file mature:

- **Minimal completeness**: enough structure to prevent weak output, without turning into bureaucracy
- **Decision usefulness**: preserves the part a future reader actually needs
- **Anti-ritual guidance**: says when *not* to create or expand the artifact
- **Owning-layer fit**: matches the document layer that should actually hold the content
- **Weak-model resilience**: a weaker model following the file should still produce something decent
- **Portable wording**: no local repo assumptions unless the public bundle truly depends on them

## Anti-Patterns

Watch for these failures:

- giant section-heavy templates with low information value
- a template without creation thresholds
- format rules that duplicate the main `SKILL.md` instead of specializing an artifact
- a format file that encourages parallel truth instead of updating the owning artifact
- examples that are more detailed than the rule and accidentally become the real contract

## Pressure Tests

Before shipping a format file, test at least:

- a strong minimal artifact -> stays short and still passes
- a weak artifact -> the format file would push it toward better structure
- an overbuilt artifact -> the format file would trim it down
- a wrong-scope case -> the file says not to use this artifact at all
- a weak-model simulation -> the instructions still produce a decent first draft

## Design Output Pattern

When the answer is "yes, create a format file", the design should also say:

- which skill loads it and under what condition
- which artifact it governs
- which rules stay in `SKILL.md`
- which detail moves into the format file
- how the format file will be pressure-tested
