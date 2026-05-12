# Skill Referee Interaction Reference

Load this file only when fixed option meanings, menu structure, or report structure are needed.

## Language Rule

Render every menu, explanation, warning, heading, table header, report label, and choice summary in the user's latest language. Preserve only option letters, skill names, paths, commands, frontmatter keys, and issue type labels exactly. The English labels below define stable semantics, not required display language.

Do not echo raw internal phrases such as `Depth B + Strategy F` in the final report. Convert selections into localized meaning, for example: `focused depth + combined strategy` translated into the user's language. Option letters may be shown in parentheses only when useful: `<localized meaning> (B)`.

## Entry Mode Options

Use when the user did not name target skills.

- `A. Anchor skill` — recommended when the user just installed or changed one skill. Ask for one skill; then find likely conflicts around it.
- `B. Direct compare` — most precise. Ask for 2+ skill names or paths; then compare them directly.
- `C. Smart selection` — recommended when the user is unsure what to inspect. Inventory metadata, classify skills, then recommend scopes.
- `D. Full audit` — caution, high token. Audit all available skills, possibly in batches.
- `E. Custom concern` — ask the user to describe the concern, then map it to a scope.

After presenting these options, stop and wait.

## Anchor Scope Options

Use after one anchor skill is provided and metadata candidates are found.

Show the anchor and candidate list with short reasons, then offer:

- `A. Recommended scope` — recommended, low cost. Compare the anchor with the strongest likely overlaps.
- `B. Expanded adjacent scope` — medium cost. Include nearby lifecycle, shared asset, or convention skills.
- `C. Duplicate/stale-copy check` — low cost. Check same-name or multi-location copies only.
- `D. All candidates` — caution, higher cost. Compare every candidate found in this round.
- `E. Custom list` — user supplies exact skill names or paths.

After presenting these options, stop and wait.

## Smart Scope Options

Use after the user chooses smart selection.

Classify metadata into 3-6 domain or lifecycle scopes. Mark one as recommended. Typical scopes may include writing/content, visual/media creation, data/spreadsheets, documents/files, research/analysis, project/planning work, automation/tool use, task/request workflow, external tool integrations, duplicate installs, or other discovered clusters.

Offer:

- `A-C. Scope options` — each with skill names, recommendation status, and cost/risk note.
- `D. Full audit` — caution, high token.
- `E. Custom list` — user supplies exact skill names or paths.

After presenting these options, stop and wait.

## Depth Options

Use once scope is known.

- `A. quick` — metadata only; fastest rough conflict scan.
- `B. focused` — recommended default; deep-read only likely-conflict skills in scope.
- `C. deep` — read selected bodies more fully and inspect references when they define boundaries.
- `D. full` — caution, high token; exhaustive review of selected scope.

## Strategy Options

Recommend one strategy or combination before asking. Then offer:

- `A. routing` — default recommendation; decide which situation should use which skill and which to avoid.
- `B. trigger` — inspect frontmatter trigger contracts, usage-expansion sections, and adjacent workflow wording for overly broad or simultaneous triggering.
- `C. convention` — inspect shared assets, files, directories, workspace conventions, task sources, decision records, or agent instruction files.
- `D. sequence` — inspect lifecycle ordering, such as intake -> plan -> create -> review -> validate -> publish.
- `E. merge-split` — decide whether skills should merge, split, rename, or be rewritten.
- `F. combined` — use the recommended strategy combination, such as routing + convention.
- `G. full` — caution, high token; run all strategy lenses.

After presenting depth and strategy options, stop and wait unless the user already chose both.

## Report Structure

Render headings, field labels, table headers, and choice summaries in the user's language, preserving only issue type labels and exact skill/path names. The structure below is semantic; translate labels such as `Scope Reviewed`, `Verdict`, `Findings`, `Routing Table`, `Use`, `Avoid`, and `Suggested Edits`.

```text
Scope Reviewed
- metadata inventory: <count>
- full bodies read: <count>
- selected scope: <skills>
- depth: <depth>
- strategy: <strategy>

Verdict
- <no conflict / manageable overlap / edits recommended / rewrite recommended>

Findings
1. <group>
   Type: <issue type>
   Risk: <low/medium/high>
   Evidence: <short evidence>
   Recommendation: <action>

Routing Table
| Situation | Use | Avoid |

Suggested Edits
- <path>: <concise edit>

Risks
- <remaining uncertainty or token/runtime risk>
```

## Issue Types

- `hard conflict`: same situation requires incompatible actions
- `trigger overlap`: multiple skills can fire; routing can fix it
- `artifact convention mismatch`: shared files/dirs/assets have incompatible rules
- `responsibility blur`: one skill owns work another should own
- `sequence dependency`: skills are valid but need ordering
- `duplicate/stale copy`: same skill exists in multiple paths with divergent behavior
- `benign adjacency`: related, no action needed
