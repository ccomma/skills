---
name: skill-architect
description: Use when designing, upgrading, splitting, merging, productizing, or deciding whether to create a skill, especially when the work needs the right authority boundary, output contract, interaction model, references, scripts, assets, validation, token efficiency, frontmatter discipline, or clearer boundaries beyond a basic scaffold.
---

# Skill Architect

Design mature, token-efficient skills. This complements basic skill creators: use it to decide whether a skill should exist, whether it should be split or merged, and how to choose authority boundaries, output contracts, interaction strength, references, scripts, assets, bundle structure, validation, and adaptive token behavior before writing or rewriting a skill.

## Boundaries

Use this for skill architecture and quality. Do not replace basic skill creation docs, installation mechanics, or generic frontmatter rules unless the current design needs them.

Use this when the main question is how one skill should be shaped: whether it should exist, how it should be structured, or whether it should be split or merged after the boundary problem is already understood.

If the real uncertainty is between multiple skills, such as overlap, trigger conflict, duplicate responsibility, or unclear routing, use a skill-boundary workflow first — the workflow that compares multiple skills and clarifies who should own which situation. Come back to this workflow after the conflict is clarified and the remaining task is structural design for one skill.

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

Start with a breadth-and-depth pass before locking the structure.

Decide:

- primary job and trigger boundary
- authority and safety boundary
- output contract and artifact expectations
- neighboring skills and non-goals
- whether neighboring responsibilities can be described as portable capability categories instead of private skill names
- interaction profile
- interaction intensity, pacing, and stop points
- file layout
- bundle consistency across `SKILL.md`, references, scripts, assets, and agent metadata
- frontmatter contract for `name` and `description`
- what stays in `SKILL.md`
- whether repeated artifact shapes deserve companion format files
- what moves to `references/`, `scripts/`, or `assets/`
- whether deterministic checks or transformations should be extracted into scripts
- validation method
- pressure-test scenarios
- token-cost failure modes and adaptive verbosity or batching triggers

Load [breadth-and-depth.md](references/breadth-and-depth.md) first to scan coverage and choose which dimensions stay implicit, move into `SKILL.md`, get their own `reference`, require a `script`, or justify an `asset`. Then load `references/architecture-patterns.md` when choosing structure or tradeoffs. Load [authority-and-safety.md](references/authority-and-safety.md) when the skill may act, persist, publish, delete, install, or cross a permission boundary. Load [output-contracts.md](references/output-contracts.md) when output shape, fields, or artifacts matter. Load [interaction-intensity.md](references/interaction-intensity.md) when deciding questioning depth, pacing, batching, or stop points. Load [bundle-design.md](references/bundle-design.md) when planning references, scripts, assets, and agent metadata as one bundle. Load [format-file-design.md](references/format-file-design.md) when deciding whether a repeated artifact deserves a companion format file or when artifact quality depends on a stable mini-template. Load [script-design.md](references/script-design.md) when deterministic work may justify scripts. Load `references/examples.md` when examples would clarify the structure. Load `references/pressure-tests.md` before calling a reusable skill mature.

### 3. Write Or Propose

If the user asks for design only, output a concise architecture spec. If they ask to implement, write the skill files after the design is clear.

### 4. Validate And Report

Before calling the skill mature, check:

- trigger description says when to use, not the whole workflow
- frontmatter is valid YAML and the description is concise, single-purpose, and free of fragile inline examples or mixed-language clutter unless explicitly required
- authority level is explicit and risky actions have the right confirmation design
- output contract is clear when consistency matters
- breadth coverage is explicit: major dimensions were considered, not only the most obvious ones
- depth choices are explicit: each important dimension was intentionally left light, deepened into a `reference`, extracted into a `script`, turned into an `asset`, or deferred
- `SKILL.md` is the router/rules layer, not a dumping ground
- the strongest behavioral instructions stay easy to find near the top of `SKILL.md`
- references are conditional and lazy-loaded
- companion format files are used when they keep the core skill shorter while preserving artifact precision
- companion format files have explicit creation thresholds, quality bars, and wrong-scope guidance
- scripts/assets are justified by repeatability, fragility, or output shape
- scripts have narrow inputs, predictable outputs, and compact summaries
- interaction strength matches ambiguity, risk, and token cost
- interaction intensity matches ambiguity, user effort, and safety
- neighboring skills have routing boundaries
- bundle files stay aligned: `SKILL.md`, references, scripts, assets, and agent metadata describe the same skill
- renamed or newly added skills update public bundle surfaces that enumerate skills, such as `README.md` or other maintained indexes, when those surfaces exist
- routing guidance is publishable and does not depend on private skill names, local paths, or a user's personal workflow names unless they are explicitly part of the public bundle being designed
- skill content uses platform-generic terminology (e.g., "cold-start entrypoint file" not "CLAUDE.md"), with vendor-specific names only as illustrative examples
- the skill can fail gracefully when inputs are missing
- pressure tests cover underspecified, overspecified, wrong-scope, and neighboring-skill scenarios
- a concise design report explains design rationale, testing, residual risks, and token cost

## Output

Use the user's session language for visible report labels and section headers. Keep exact technical tokens such as skill names, file paths, profile ids, or mode labels verbatim when translation would reduce precision.

For design-only work:

```text
[Localized label for skill name]:
[Localized label for purpose]:
[Localized label for trigger description]:
[Localized label for non-goals / neighboring skills]:
[Localized label for recommended profile]:
[Localized label for file layout]:
[Localized label for interaction model]:
[Localized label for references / scripts / assets]:
[Localized label for validation plan]:
[Localized label for pressure tests]:
[Localized label for risks]:
```

For implementation work, create or update files directly and include a concise design report. Load `references/design-report.md` when writing the report.
