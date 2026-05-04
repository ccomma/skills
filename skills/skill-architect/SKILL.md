---
name: skill-architect
description: Use when designing, upgrading, splitting, merging, productizing, or deciding whether to create a skill, especially when the work needs the right interaction model, progressive disclosure, references, scripts, assets, validation, token efficiency, or clearer boundaries beyond a basic scaffold.
---

# Skill Architect

Design mature, token-efficient skills. This complements basic skill creators: use it to decide whether a skill should exist, whether it should be split or merged, and how to choose structure, interaction strength, references, scripts, assets, boundaries, validation, and adaptive token behavior before writing or rewriting a skill.

## Boundaries

Use this for skill architecture and quality. Do not replace basic skill creation docs, installation mechanics, or generic frontmatter rules unless the current design needs them.

Do not use for normal code implementation, code review, debugging, product roadmap work, or executing the skill being designed.

Use a retrospective token-audit workflow when the primary request is to audit or reduce the token/context cost of an existing skill. Keep token efficiency in mind while designing new skills, but do not make this design workflow absorb every existing-skill optimization task.

## Core Principle

Use the lightest structure that reliably works. Strong interaction, references, scripts, and assets are tools, not defaults.

**Platform neutrality**: Skills are published artifacts usable across agent runtimes. Skill content must use platform-generic language. Refer to concepts by their function (e.g., "cold-start entrypoint file", "agent runtime", "session context loader"), not by vendor-specific filenames (e.g., `CLAUDE.md`, `AGENTS.md`). Vendor-specific names may appear only as illustrative examples with qualifiers ("e.g.,", "varies by platform").

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
- whether neighboring responsibilities can be described as portable capability categories instead of private skill names
- interaction profile
- file layout
- what stays in `SKILL.md`
- what moves to `references/`, `scripts/`, or `assets/`
- validation method
- pressure-test scenarios
- token-cost failure modes and adaptive verbosity or batching triggers

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
- routing guidance is publishable and does not depend on private skill names, local paths, or a user's personal workflow names unless they are explicitly part of the public bundle being designed
- skill content uses platform-generic terminology (e.g., "cold-start entrypoint file" not "CLAUDE.md"), with vendor-specific names only as illustrative examples
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
