# Skill Trim Optimization Patterns

Load this when diagnosing a skill's token cost or proposing structural changes.

## Cost Model

Separate default cost from conditional cost:

- **Default cost**: metadata plus `SKILL.md` body loaded when the skill triggers.
- **Conditional cost**: references, scripts, assets, and extra exploration loaded only when justified.
- **Conversation cost**: repeated verbose interaction during long workflows.
- **Coordination cost**: duplicate or overlapping skills triggering together.

Optimize in that order. A smaller `SKILL.md` with an uncontrolled long conversation can still be expensive.

## Capability Preservation

Token optimization can degrade a skill when it removes context that looked verbose but actually carried judgment. Before changing a skill, identify which capability the text protects:

- trigger accuracy
- safety or confirmation gates
- evidence requirements
- persistence or documentation behavior
- output format and artifact quality
- domain terminology
- user-facing language, labels, tone, and interaction style
- portability across repositories, users, and skill bundles
- tool ordering or fragile procedural steps
- neighboring-skill routing
- recovery behavior when inputs are missing or contradictory

Prefer moving important guidance behind lazy-load references over deleting it. Prefer compact templates over vague instructions. Prefer adaptive verbosity over making all responses terse.

Treat these changes as higher risk:

- narrowing or broadening the frontmatter description
- removing examples that disambiguate behavior
- changing one-question-at-a-time workflows to batch mode
- adding compact templates that hard-code a different language or label style
- adding routing guidance that names private or environment-specific skills instead of generic capability categories
- moving mandatory safety or verification rules into optional references
- deleting references, scripts, or assets
- merging skill responsibilities

For each higher-risk change, add a regression scenario that proves the original capability still works.

## High-Value Patterns

### 1. Progressive Disclosure

Keep in `SKILL.md`:

- trigger boundary
- non-goals and neighboring skills
- core rules
- workflow skeleton
- conditions for loading references/scripts/assets
- output shape

Move to `references/`:

- long examples
- fixed menus
- detailed checklists
- framework variants
- pressure tests
- troubleshooting catalogs
- report templates

### 2. Adaptive Verbosity

Long-running interactive skills should define when to switch modes:

- start detailed when ambiguity or risk is high
- switch to compact questions after repeated agreement
- offer batch mode after several accepted decisions
- expand again when the user disagrees, asks for explanation, or the decision affects safety, persistence, ADRs, or domain language

Example:

```text
After 5 accepted answers, switch to compact mode unless the next decision is risky or disputed. After 10 accepted answers, offer batches of 3-5 questions.
```

### 3. Batch Interaction

Use batches when decisions are independent and low-risk. Keep one-question-at-a-time when answers are sequential, risky, or likely to change the next branch.

Good batch item:

```text
Q12. Pack versioning? <Recommend / 推荐>: integer version + content hash. <Record / 记录位置>: handoff if accepted.
```

### 4. Persistence Before Compression

If compressing a long design workflow, persist accepted decisions before shortening the conversation. Use the repo's existing artifact: `CONTEXT.md`, ADR, issue, PRD, design note, handoff, or TODO.

Do not rely on the chat transcript as the only memory for important decisions.

### 5. Reference Routing

Each reference should have a load condition:

```text
Load `references/security.md` only for security-sensitive skills or permission changes.
```

Avoid vague instructions like "read references as needed" when there are many references.

### 6. Script Extraction

Use scripts when repeated prose would cause fragile or expensive work:

- counting lines/tokens
- extracting frontmatter
- validating skill layout
- generating reports
- checking broken links
- comparing skill metadata

Scripts should produce compact summaries, not giant dumps.

### 7. Trigger Tightening

Skill descriptions should say when the skill should load, not describe the full workflow. Watch for triggers that match ordinary tasks too broadly.

Prefer:

```yaml
description: Use when auditing or reducing the token/context cost of an existing skill...
```

Avoid:

```yaml
description: Helps with skills, prompts, context, design, code, workflows, and optimization...
```

### 8. Neighbor Routing

When a skill overlaps with another skill, add routing rules:

- "Use this for..."
- "Use the neighboring capability/workflow for..."
- "Do not use this for..."

Prefer routing edits before merging skills. Keep routing public and portable: name responsibility categories by default, not private skill names. Concrete skill names are acceptable only when they are part of the same public skill bundle, the target skill's documented dependencies, or explicitly supplied by the user.

### 9. Output Budget

Set default output expectations:

- concise diagnosis first
- detailed evidence only on request
- changed files after implementation
- residual risks instead of full transcript

### 10. Decision-Preserving Deletion

Never remove:

- safety constraints
- confirmation gates
- verification steps
- domain persistence rules
- user-language requirements
- environment-neutral routing requirements
- explicit non-goals

Trim or move:

- repeated explanation
- redundant examples
- verbose menus
- implementation history
- generic advice the base model already knows

## Optimization Plan Template

```text
Target:
Main cost drivers:
Capability baseline:
Recommended changes:
- Safe:
- Moderate:
- Risky:
Expected token impact:
Decision-quality risks:
Regression tests:
```
