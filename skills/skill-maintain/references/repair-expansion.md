# Skill Maintain Repair Expansion

Load this when one existing skill clearly has drift, but you still need to expand the diagnosis before freezing the patch.

If you are not yet sure whether repair expansion is the next right move, load `reference-routing.md` first.

If the visible drift is already clearly narrower than repair expansion, jump directly to that narrower reference instead.

## Repair Expansion

Repair expansion means: identify the real drift first, then scan the important repair dimensions before freezing the patch so you avoid two failures:

- **narrow repair**: fixing the first visible symptom while adjacent drift survives
- **undirected repair depth**: rewriting too many dimensions when only one needed real correction

This is an expansion pass for repair work, not the owner of every downstream repair question.

When the user explicitly asks to review, inspect, audit, or check a named skill, assume they want this expansion pass by default even if they did not provide a bug list.

Before freezing the repair plan, answer these questions in order:

1. what drift is actually present
2. why this still counts as maintenance rather than redesign
3. what the smallest sufficient repair depth is
4. whether the answer should stay here or hand off

Then scan these dimensions:

- request and trigger fit
- kernel clarity: kernel sentence, strongest thing, and wrong-scope boundary
- first-read teaching model: dominant path, branch-case load, and entrypoint-role separation
- trigger-contract layering and reference-routing clarity
- portability and language behavior
- abstraction level
- structure and routing clarity
- output contract and artifact quality
- format-file opportunity and format-file quality
- interaction intensity and recovery behavior
- bundle consistency across files
- safety and authority boundaries
- deterministic script opportunities
- token economy
- validation and regression coverage

For each dimension, record one of:

- `no issue`
- `light wording fix`
- `section rewrite`
- `reference repair`
- `script-assisted repair`
- `bundle-wide patch`
- `defer explicitly`

If the kernel stays fuzzy after the scan, repair `SKILL.md` first before polishing structure around it.

If the diagnosis shows that fixing the issue would redefine the role or kernel, stop and hand off to `skill-architect` instead of pretending this is still ordinary maintenance.

If the diagnosis shows that the real problem is split/merge/reroute logic across multiple skills, hand off to `skill-referee`.

If the local repair locus is clear but the evidence points to a reusable upstream cause, keep the local maintenance path explicit and then hand off to `skill-governance-escalation`.

If more than two adjacent dimensions look suspicious, the repair should not stop at the first reported symptom.

After the expansion pass, pick one next owner:

- `component-paths.md` when owner component is still unclear
- `reference-quality.md` when the issue is really reference-layer quality
- `bundle-consistency.md` when the issue is really bundle alignment
- `repair-patterns.md` when repair shape is still unclear

## Repair Depth Decision

Depth means: decide how much repair weight each suspicious dimension deserves after the drift diagnosis and maintenance judgment are already explicit.

It does not mean "touch more files". A repair can be deep because one dimension needs serious correction, and a multi-file patch can still be shallow if it is only reconciling one owner dimension.

Choose the lightest repair depth that actually removes the problem:

- **`no issue`**: the dimension is healthy enough to leave alone
- **`light wording fix`**: small clarifications, labels, or routing phrasing
- **`section rewrite`**: a focused rewrite inside `SKILL.md`
- **`reference repair`**: deeper correction in one or more reference files
- **`script-assisted repair`**: deterministic checks or summaries should help the repair
- **`bundle-wide patch`**: multiple linked files must change together
- **`defer explicitly`**: real issue acknowledged but intentionally left for later

Do not deepen a repair just because the dimension exists. Deepen only when drift, failure, or fragility makes it necessary to restore the skill's intended behavior without redefining its role or kernel.

## Repair Expansion Table Template

Render in the user's language when reporting.

```text
Repair expansion:
- Drift diagnosis:
- Why this is still maintenance:
- Request and trigger fit:
- Kernel clarity:
- First-read teaching model:
- Trigger layering and reference routing:
- Portability and language:
- Abstraction:
- Structure and routing:
- Output contract:
- Format-file opportunity and quality:
- Interaction intensity:
- Bundle consistency:
- Safety and authority:
- Script opportunities:
- Token economy:
- Validation:

Repair depth:
- Light wording fix:
- Section rewrite:
- Reference repair:
- Script-assisted repair:
- Bundle-wide patch:
- Defer explicitly:

Handoff judgment:
- Stay in skill-maintain:
- Hand off to skill-architect:
- Hand off to skill-referee:
- Hand off to skill-governance-escalation:
```

## Pressure Prompts

```text
Prompt: Repair this skill. The obvious bug is a bad label, but I suspect the output contract and reference bundle also drifted.
Expected behavior: identify the drift, explain why it is still maintenance, then scan adjacent dimensions and choose targeted repair depth instead of stopping at the first wording fix.
```

```text
Prompt: Fix this skill, but keep the patch as small as possible.
Expected behavior: run the expansion pass, keep the drift diagnosis explicit, confirm which dimensions have no issue, and keep repair depth intentionally narrow.
```
