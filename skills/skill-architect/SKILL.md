---
name: skill-architect
description: Use when designing, upgrading, or productizing a skill that needs the right interaction model, progressive disclosure, references, scripts, assets, validation, or clearer boundaries beyond a basic scaffold.
---

# Skill Architect

Design mature, token-efficient skills. This complements basic skill creators: use it to choose structure, interaction strength, references, scripts, assets, boundaries, and validation before writing or rewriting a skill.

## Boundaries

Use this for skill architecture and quality. Do not replace basic skill creation docs, installation mechanics, or generic frontmatter rules unless the current design needs them.

Do not use for normal code implementation, code review, debugging, product roadmap work, or executing the skill being designed.

## Core Principle

Use the lightest structure that reliably works. Strong interaction, references, scripts, and assets are tools, not defaults.

Interaction profiles:

- `simple`: short instructions; no fixed questions.
- `guided`: suggested sequence; flexible user flow.
- `constrained`: fixed options, staged questions, stop points.
- `deterministic`: scripts/tools handle fragile repeated work.
- `asset-backed`: templates/assets carry output shape.

## Workflow

### 1. Choose Intake Mode

If the user already gave a clear skill goal, proceed directly. If important design information is missing, ask a concise intake from `references/design-intake.md`.

Use:

- `quick intake` for small upgrades or obvious skills
- `full intake` for new, broad, risky, or previously failed skills
- `skip intake` when the user already specified enough

### 2. Design The Skill Architecture

Decide:

- primary job and trigger boundary
- neighboring skills and non-goals
- interaction profile
- file layout
- what stays in `SKILL.md`
- what moves to `references/`, `scripts/`, or `assets/`
- validation method
- pressure-test scenarios

Load `references/architecture-patterns.md` when choosing structure or tradeoffs. Load `references/examples.md` when examples would clarify the structure. Load `references/pressure-tests.md` before calling a reusable skill mature.

### 3. Write Or Propose

If the user asks for design only, output a concise architecture spec. If they ask to implement, write the skill files after the design is clear.

### 4. Validate And Report

Before calling the skill mature, check:

- trigger description says when to use, not the whole workflow
- `SKILL.md` is the router/rules layer, not a dumping ground
- references are conditional and lazy-loaded
- scripts/assets are justified by repeatability, fragility, or output shape
- interaction strength matches ambiguity, risk, and token cost
- neighboring skills have routing boundaries
- the skill can fail gracefully when inputs are missing
- pressure tests cover underspecified, overspecified, wrong-scope, and neighboring-skill scenarios
- a concise design report explains design rationale, testing, residual risks, and token cost

## Output

For design-only work:

```text
Skill Name:
Purpose:
Trigger Description:
Non-goals / Neighboring Skills:
Recommended Profile:
File Layout:
Interaction Model:
References / Scripts / Assets:
Validation Plan:
Pressure Tests:
Risks:
```

For implementation work, create or update files directly and include a concise design report. Load `references/design-report.md` when writing the report.
