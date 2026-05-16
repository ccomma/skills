# Skill Referee Interaction Reference

Load this when the direct metadata-first ruling path is not enough.

This reference is a fallback interaction shell, not the default identity of the skill.

Use it only when:

- the user explicitly asks for audit, batch comparison, or full inventory
- the current context is too thin for a trustworthy owner ruling
- an explicit scope, cost, or depth choice would materially reduce ambiguity

## Language Rule

Render every menu, explanation, warning, heading, table header, report label, and choice summary in the user's latest language. Preserve only option letters, skill names, paths, commands, frontmatter keys, and issue type labels exactly. The English labels below define stable semantics, not required display language.

Do not echo raw internal phrases such as `Depth B + Strategy F` in the final ruling. Convert selections into localized meaning, for example: `focused depth + combined strategy` translated into the user's language. Option letters may be shown in parentheses only when useful: `<localized meaning> (B)`.

## Entry Mode Options

Use this menu only when the user did not provide enough owner candidates and still wants an explicit referee workflow.

- `A. Anchor skill` — recommended when one skill is already suspect and you want to find the most plausible competing owners.
- `B. Direct compare` — most precise. Compare 2 or more named skills directly.
- `C. Smart selection` — recommended when the user knows there is an owner collision but is not sure which cluster to inspect.
- `D. Full audit` — caution, high token. Inventory all available skills and look for broad owner collisions.
- `E. Custom concern` — user describes the ownership concern and you map it to a comparison scope.

After presenting these options, stop and wait.

## Anchor Scope Options

Use after one anchor skill is provided and metadata candidates are found.

Show the anchor and candidate list with short owner-collision reasons, then offer:

- `A. Recommended scope` — recommended, low cost. Compare the anchor with the strongest competing owners.
- `B. Expanded adjacent scope` — medium cost. Include nearby lifecycle or shared-asset skills that could steal ownership by accident.
- `C. Duplicate/stale-copy check` — low cost. Check same-name or multi-location copies only.
- `D. All candidates` — caution, higher cost. Compare every candidate found in this round.
- `E. Custom list` — user supplies exact skill names or paths.

After presenting these options, stop and wait.

## Smart Scope Options

Use after the user chooses smart selection.

Classify metadata into 3-6 ownership scopes. Mark one as recommended. Typical scopes may include project/planning work, repair/governance work, documents/files, research/analysis, automation/tool use, duplicate installs, or other discovered clusters.

Offer:

- `A-C. Scope options` — each with skill names, recommendation status, and owner-collision note.
- `D. Full audit` — caution, high token.
- `E. Custom list` — user supplies exact skill names or paths.

After presenting these options, stop and wait.

## Depth Options

Use once comparison scope is known.

- `A. quick` — metadata only; fastest owner ruling attempt.
- `B. focused` — recommended default; deep-read only likely competing owners.
- `C. deep` — read selected bodies more fully and inspect references when they carry real boundary semantics.
- `D. full` — caution, high token; exhaustive review of selected scope.

## Strategy Options

These are supplemental lenses for raising or lowering ruling confidence. They are not the default first move.

Recommend one strategy or combination before asking. Then offer:

- `A. routing` — default recommendation; decide which situation should use which skill and which to keep out.
- `B. trigger` — inspect trigger contracts and adjacent wording for simultaneous ownership claims.
- `C. convention` — inspect shared assets, files, directories, task sources, decision records, or agent instruction files.
- `D. sequence` — inspect lifecycle ordering such as intake -> plan -> create -> review -> validate -> publish.
- `E. merge-split` — decide whether the skills should merge, split, rename, or stay separate with clearer handoff.
- `F. combined` — use the recommended lens combination, such as routing + trigger.
- `G. full` — caution, high token; run all lenses.

After presenting depth and strategy options, stop and wait unless the user already chose both.

## Ruling Structure

Render headings, field labels, table headers, and choice summaries in the user's language, preserving only issue type labels and exact skill/path names.

```text
Situation
- <the ambiguous ownership situation>

Primary Owner
- <skill>

Do Not Use
- <skills that should not own this case>

Handoff Rule
- <when to stay, when to hand off>

Why
- <short evidence from metadata or boundary text>

Residual Uncertainty
- <what remains unclear, if anything>
```

If the user explicitly asked for audit-style output, you may add:

```text
Scope Reviewed
- metadata inventory: <count>
- full bodies read: <count>
- selected scope: <skills>
- depth: <depth>
- strategy: <strategy>

Findings
1. <group>
   Type: <issue type>
   Risk: <low/medium/high>
   Evidence: <short evidence>
   Recommendation: <action>
```

## Issue Types

- `hard conflict`: same situation requires incompatible ownership claims
- `trigger overlap`: multiple skills can fire; routing can fix it
- `artifact convention mismatch`: shared files, directories, or assets have incompatible ownership rules
- `responsibility blur`: one skill is absorbing work another should own
- `sequence dependency`: skills are valid but the ownership depends on ordering
- `duplicate/stale copy`: same skill exists in multiple paths with divergent behavior
- `benign adjacency`: related, no ownership change needed
