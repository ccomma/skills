# Skill Maintain Repair Patterns

Load this when auditing or repairing a skill beyond a trivial wording fix.

## Failure Modes

Check the reported issue before widening scope:

- **Portability leak**: vendor-specific filenames, private paths, personal workflow names, or local tool assumptions appear as if they were universal rules.
- **Language inconsistency**: templates, labels, or examples hardcode a human language that should instead follow the user's session language.
- **Abstraction leak**: neighboring responsibilities are described through concrete private skill names instead of capability categories.
- **Structure drift**: `SKILL.md` carries content that belongs in `references/`, scripts, or assets; or references have no clear load condition.
- **Output-contract drift**: required sections, labels, fields, evidence expectations, or artifact checks are no longer stable.
- **Interaction-intensity drift**: the skill asks too much, too little, batches poorly, or fails to expand again when risk rises.
- **Bundle mismatch**: `SKILL.md`, references, scripts, assets, or agent metadata no longer describe the same behavior.
- **Authority drift**: the skill overreaches, weakens confirmation gates, or blurs analysis versus execution.
- **Token drift**: the default load is too large, too repetitive, or too eager for the value it protects.

Start with a maintenance breadth-and-depth pass before deciding that only one of these dimensions matters.

## Capability Preservation

Before changing a skill, identify which capability the current text protects:

- trigger accuracy
- wrong-scope routing
- safety and confirmation gates
- evidence or persistence behavior
- output or artifact quality
- user-facing language, labels, tone, and interaction style
- portability across runtimes and repositories
- tool ordering or fragile procedural steps
- recovery behavior when inputs are missing or contradictory

Prefer moving important guidance behind explicit load conditions over deleting it.

## High-Value Repairs

### 1. Tighten Trigger Language

Descriptions should say when the skill should load, not summarize the entire workflow. If the description starts matching ordinary code work or generic editing, narrow it.

### 2. Restore Router Discipline

Keep in `SKILL.md`:

- trigger boundary
- non-goals and neighboring workflows
- core rules
- workflow skeleton
- explicit load conditions for references, scripts, or assets
- output shape

Move to `references/`:

- long checklists
- fixed menus
- detailed examples
- troubleshooting catalogs
- pressure tests
- validation templates

### 3. Replace Concrete Neighbor Names

Prefer capability categories such as:

- skill design workflow
- skill boundary workflow
- documentation and planning workflow
- code review workflow

Only keep a concrete skill name when it is part of the target skill's public bundle or explicitly supplied by the user.

### 4. Normalize User-Facing Language

If the skill defines labels, headers, or compact templates, express them as patterns or placeholders unless the target skill intentionally fixes one language for a public artifact. The runtime should speak in the user's session language.

### 5. Trim Without Losing Judgment

When token cost is part of the problem:

- shorten repeated narration
- move heavy detail to conditional references
- add compact mode only when the decision path is low risk
- keep disputed, safety-sensitive, or persistence-sensitive paths detailed

### 6. Restore Output Contracts

When a skill's report shape, required fields, or artifact checks drift, repair the minimum stable contract before changing prose style.

### 7. Rebalance Interaction Pressure

If a skill became too chatty or too shallow, repair questioning volume, batching, and recovery behavior without changing the whole interaction profile unless necessary.

### 8. Keep The Bundle In Sync

When a skill is renamed, repurposed, or structurally reorganized, check the whole bundle together:

- frontmatter and title
- agent metadata
- references
- scripts or assets
- load conditions back from `SKILL.md`

### 9. Preserve Authority Boundaries

If the skill can edit, execute, install, delete, publish, or persist, keep those authority levels explicit. Repairs should not silently remove risky confirmation gates or make execution sound like analysis.

### 10. Extract Deterministic Checks

When part of the repair is repetitive, mechanical, and stable, prefer a local script over natural-language inspection. Good candidates:

- metadata extraction
- link and file-existence checks
- stale-name residue scans
- bundle consistency summaries

Keep script output compact so the workflow consumes a summary, not a raw dump.

### 11. Make Repair Depth Explicit

For every important dimension, decide whether it needs:

- no work
- light wording repair
- section rewrite
- reference repair
- script-assisted repair
- bundle-wide patch
- explicit deferral

This prevents both narrow repairs and over-repairs.

## High-Risk Changes

Treat these as risky and add explicit regression scenarios:

- broadening or narrowing the frontmatter description
- removing examples that disambiguate behavior
- moving mandatory safety or verification rules into optional references
- replacing a concrete example with a vague generic rule
- changing a one-question flow into batch mode
- weakening the output contract while simplifying wording
- flattening interaction checkpoints so risky branches lose needed pauses
- leaving renamed or moved files inconsistent across the bundle
- weakening confirmation gates or execution labels while simplifying wording
- deepening every dimension because one dimension failed
- removing routing guidance for neighboring workflows
- splitting or merging skills

## Repair Plan Template

```text
Target:
Primary failure mode:
Capability baseline:
Recommended changes:
- Safe:
- Moderate:
- Risky:
Decision-quality risks:
Regression tests:
```
