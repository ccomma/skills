# Skill Maintain Repair Patterns

Load this when the repair shape is not obvious after the repair expansion pass.

Use it as the pattern library for deciding whether to cut, merge, move, or limit the patch.

If the problem is specifically that references are too vague, duplicated, or badly split, load `reference-quality.md`.

## Failure Modes

For each finding, decide whether it is:

- a **single-skill finding** that should stay inside `skill-maintain`
- an **escalation candidate** that may deserve a later governance pass

Do not assume every escalation candidate requires immediate recursion. Local repair may still be enough for the current task.

Check the reported issue before widening scope:

- **Portability leak**: vendor-specific filenames, private paths, personal workflow names, or local tool assumptions appear as if they were universal rules.
- **Language inconsistency**: templates, labels, or examples hardcode a human language that should instead follow the user's session language.
- **Abstraction leak**: neighboring responsibilities are described through concrete private skill names instead of capability categories.
- **Ownership leak**: the artifact implies ownership over local context, external workflows, or helper layers it does not actually own.
- **Structure drift**: `SKILL.md` carries content that belongs in `references/`, scripts, or assets; or references have no clear load condition.
- **Workflow-clarity drift**: the dominant happy path is hard to see, branch cases appear too early, a usage-expansion section absorbs goals instead of trigger guidance, or entrypoint roles are blurred together.
- **Reference-routing drift**: references are linked inconsistently, load conditions are hard to spot, or the wording in generic references is more concrete than the skill's public abstraction level should allow.
- **Output-contract drift**: required sections, labels, fields, evidence expectations, or artifact checks are no longer stable.
- **Interaction-intensity drift**: the skill asks too much, too little, batches poorly, or fails to expand again when risk rises.
- **Bundle mismatch**: `SKILL.md`, references, scripts, assets, or agent metadata no longer describe the same behavior.
- **Authority drift**: the skill overreaches, weakens confirmation gates, or blurs analysis versus execution.
- **Token drift**: the default load is too large, too repetitive, or too eager for the value it protects.
- **Diluted core**: the skill's strongest behavioral instructions are buried under explanation, while artifact schemas or detailed examples crowd the main entry surface.
- **Missed format opportunity**: a repeated artifact shape is embedded inline in `SKILL.md` or a generic reference, but the bundle would be clearer and more stable with a companion format file.
- **Thin-but-correct core**: a core artifact keeps the right boundary but lacks enough judgment or depth to carry its real role.
- **Helper-layer misplacement**: a helper artifact quietly becomes source of truth for a core layer without being promoted or referenced correctly.

Start with a repair expansion pass before deciding that only one of these dimensions matters.

Typical escalation candidates include:

- repeated findings that keep showing up across skills or repos
- findings whose durable fix appears to belong in a higher governance rule
- findings where local repair is clear but reusable prevention still feels unresolved

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

If the skill feels more like a handbook than a tool, extract repeated artifact shapes into companion reference files and keep the core behavioral instructions near the top.

Also check the inverse problem: if a repeated artifact shape appears often enough to drift, but has not yet been split into a companion format file, call that out explicitly instead of waiting for the user to ask for templates.

For every surviving non-core component, force these challenges:

- delete challenge: what exact failure returns if this component disappears
- merge challenge: what exact collision returns if it merges with its nearest neighbor
- cost challenge: what maintenance, token, read, or drift cost does it add, and why is that cost worth paying

### 2a. Recover Workflow Clarity

For workflow skills:

- keep the dominant happy path early and easy to scan
- move rare branch cases, governance rules, and repair paths behind the main path
- keep usage-expansion sections limited to trigger situations, wrong-scope boundaries, and neighboring routes
- move quality goals, token goals, resumability goals, and branch-case policy into rules, workflow, or references
- separate public orientation, runtime entrypoint, current execution state, and durable long-form context when the skill touches multiple loading layers

If the skill feels like a governance handbook before it feels like a route through work, treat that as a real repair target.

### 3. Replace Concrete Neighbor Names

Prefer capability categories such as:

- skill design workflow
- skill boundary workflow
- documentation and planning workflow
- code review workflow

Only keep a concrete skill name when it is part of the target skill's public bundle or explicitly supplied by the user.

### 4. Normalize User-Facing Language

If the skill defines labels, headers, or compact templates, express them as patterns or placeholders unless the target skill intentionally fixes one language for a public artifact. The runtime should speak in the user's session language.

If the skill emits both public-entry artifacts and internal working artifacts, keep the language strategy explicit rather than letting mixed examples decide it implicitly.

### 4a. Preserve Trigger-Contract Layering

Keep these layers distinct:

- frontmatter description for the shortest trigger contract
- usage sections for expanded trigger situations and wrong-scope boundaries
- workflow sections for process, quality goals, and branch-case policy

If one layer starts swallowing the job of another, repair the layering instead of just trimming words.

### 4b. Repair Reference Routing And Abstraction

When a skill points to references:

- use a consistent link style for the same kind of reference
- keep important references one hop from `SKILL.md`
- describe generic references through artifact categories, not through overly specific local examples
- keep concrete filenames or domain-specific examples only when they materially clarify the public contract

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

### 11. Recover A Sharp Core Surface

When a skill used to feel decisive and now feels mushy:

- move artifact templates into dedicated format references
- move detailed writeback rules into references with explicit load conditions
- keep the strongest "what to do" instructions early and compact
- preserve the hard behavioral edges while trimming explanation

### 12. Surface Missed Format Opportunities

When auditing a skill, ask:

- Does this workflow repeatedly emit one high-value artifact shape?
- Is that shape currently described inline instead of through a dedicated format file?
- Would a weaker model benefit from a stable mini-template?
- Would extracting the format make the core `SKILL.md` sharper without creating bureaucracy?

If yes, recommend a companion format file as a first-class repair option.

### 13. Make Repair Depth Explicit

For every important dimension, decide whether it needs:

- no work
- light wording repair
- section rewrite
- reference repair
- script-assisted repair
- bundle-wide patch
- explicit deferral

This prevents both narrow repairs and over-repairs.

### 14. Interrogate The Whole Bundle

Do not stop at boundary ownership alone. Ask about each component:

- what behavior it protects
- what ambiguity it removes
- what deterministic work it isolates
- what artifact contract it stabilizes
- what cost it adds

If the component cannot justify its existence beyond "it seems like a useful category", cut, merge, or downgrade it.

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
