---
name: skill-referee
description: Use when installed or available skills may overlap, conflict, trigger too broadly, duplicate responsibilities, use incompatible conventions, or need clearer routing after a skill is added, updated, or questioned.
---

# Skill Referee

Referee skill boundaries across any domain with controlled questions and minimal context. Collect scope, depth, and strategy before deep-reading skill bodies.

Use this when the main question is how multiple skills should divide responsibility. If the boundary is already clear and the remaining task is to lock one skill's kernel, produce its build brief protocol instance, and then redesign its internal shape, split, merge, or file layout, hand off to a skill-architecture workflow — the workflow that freezes one skill's core and build surface before downstream initialization once the multi-skill boundary picture is already clear.

If the real uncertainty is not between multiple skills but between artifact-level drift, one workflow skill, and a higher governance layer, route to a governance-escalation workflow instead of widening this skill.

## Core Rules

- Use the user's latest language for all prose, option text, headings, table headers, field labels, and summaries. Keep only skill names, paths, commands, frontmatter keys, option letters, and issue type labels exact.
- Option codes are internal handles. When reporting choices back, translate them into the user's language, e.g. say “focused depth + combined strategy” in the user's language rather than “Depth B + Strategy F”.
- Treat `skill-referee`, `$skill-referee`, and this skill's own path as invocation names, not review targets.
- Count only target skill names other than `skill-referee` when deciding whether the user specified targets.
- Metadata first: inspect skill names, descriptions, paths, inputs, outputs, touched assets, and visible exclusions before reading bodies.
- Do not deep-read skill bodies until scope, review depth, and strategy are confirmed.
- If the user names 2+ target skills, scope is confirmed; do not ask which skills to compare.
- If the user names 1 target skill, use it as the anchor, inventory available skill metadata, find the 3-8 most likely overlaps, then ask the user to confirm scope.
- If the user names no target skills, ask a fixed entry-mode question first.
- Use fixed option meanings for entry mode, smart scope, depth, and strategy, but render the option wording in the user's language. See `references/interaction.md` only when menus or report structure are needed.

## Skill Discovery

Discover skills from the narrowest reliable source first:

1. Skills explicitly named or linked by the user.
2. Skill metadata already available in the current session.
3. User-provided skill roots or workspace-local skill directories.
4. Common local skill roots only when needed and accessible.
5. Additional skill systems only when the user mentions them or metadata suggests relevant overlap.

Do not assume any one agent runtime, directory layout, domain, or skill ecosystem is always present.

## Universal Boundary Signals

Look for overlap in domain-neutral responsibilities:

- user intent handled: planning, creation, transformation, analysis, critique, validation, publishing, maintenance
- lifecycle stage: intake, discovery, planning, execution, review, repair, handoff, closeout
- inputs and outputs: files, prompts, records, media, data, tasks, decisions, reports, artifacts
- assets touched: documents, images, videos, code, datasets, configs, notes, trackers, external tools
- authority level: suggest, draft, edit, execute, install, delete, approve, persist, publish
- quality responsibility: correctness, style, safety, format, usability, compliance, performance, evidence
- persistence: temporary output, project files, personal settings, shared knowledge, decision records

Use field-specific terms only when the inspected skills themselves introduce them.

## Workflow

### 1. Determine Entry Mode

Ignore this skill's own invocation name and path, then count target skills:

- `2+ target skills named`: proceed to settings collection.
- `1 target skill named`: run anchor discovery.
- `0 target skills named`: ask the entry-mode menu from `references/interaction.md`, then stop.

### 2. Anchor Discovery

For one target skill:

1. Read that skill's metadata.
2. Inventory available skill metadata from the discovery sources above.
3. Recommend 3-8 likely comparison candidates based on names, descriptions, shared inputs/outputs, touched assets, verbs, lifecycle stage, authority level, quality responsibility, and conventions.
4. Ask the anchor-scope menu from `references/interaction.md`, then stop.

### 3. Smart Selection

For unspecified checks when the user chooses smart selection:

1. Inventory available skill metadata.
2. Classify by trigger domain and lifecycle role.
3. Present 3-6 fixed scope options with one recommended.
4. Ask the smart-scope menu from `references/interaction.md`, then stop.

### 4. Collect Settings

Once scope is known, ask for review depth and strategy using fixed option meanings. Recommend defaults from metadata:

- default depth: `focused`
- shared assets/files/conventions: `convention + routing`
- broad triggers or same verbs: `trigger + routing`
- lifecycle adjacency: `sequence + routing`
- same inputs/outputs or quality responsibility: `routing`; add `merge-split` only if duplication is likely
- duplicate names or stale copies: `trigger + merge-split`

You may ask depth and strategy in the same message. Stop after asking unless the user already specified both.

### 5. Review

After scope, depth, and strategy are confirmed:

- Read only selected skill bodies or relevant sections.
- Prefer search for boundary terms such as `description`, usage sections, `Do not use`, `Workflow`, `Process`, `input`, `output`, `asset`, `create`, `edit`, `review`, `validate`, `publish`, `persist`, `delete`, and shared artifact names found during metadata triage.
- Classify findings as: `hard conflict`, `trigger overlap`, `artifact convention mismatch`, `responsibility blur`, `sequence dependency`, `duplicate/stale copy`, or `benign adjacency`.
- Prefer routing rules and small trigger edits before recommending merges or rewrites.

## Depth Rules

- `quick`: metadata only; no body reads unless needed to resolve ambiguity.
- `focused`: default; read bodies only for confirmed likely-conflict group.
- `deep`: read selected bodies more fully and inspect references if they define boundaries.
- `full`: exhaustive and high token; use only when selected.

## Output

Use the report structure in `references/interaction.md`. If no actionable conflict exists, say so clearly and still provide routing guidance for adjacent skills.
