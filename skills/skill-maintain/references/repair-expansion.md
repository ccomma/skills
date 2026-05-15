# Skill Maintain Repair Expansion

Load this when one existing skill clearly has drift, but you still need to expand the repair across the important product dimensions before freezing the patch.

If you are not yet sure whether repair expansion is the next right move, load `reference-routing.md` first.

If the visible drift is already clearly narrower than repair expansion, jump directly to that narrower reference instead.

## Repair Expansion

Repair expansion means: scan the important repair dimensions before freezing the patch so you avoid two failures:

- **narrow repair**: fixing the first visible symptom while adjacent drift survives
- **undirected repair depth**: rewriting too many dimensions when only one needed real correction

This is an expansion pass for repair work, not the owner of every downstream repair question.

When the user explicitly asks to review, inspect, audit, or check a named skill, assume they want this expansion pass by default even if they did not provide a bug list.

Scan these dimensions before freezing the repair plan:

- request and trigger fit
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

If more than two adjacent dimensions look suspicious, the repair should not stop at the first reported symptom.

After the expansion pass, pick one next owner:

- `component-paths.md` when owner component is still unclear
- `reference-quality.md` when the issue is really reference-layer quality
- `bundle-consistency.md` when the issue is really bundle alignment
- `repair-patterns.md` when repair shape is still unclear

## Repair Depth Decision

Depth means: decide how much repair weight each suspicious dimension deserves.

It does not mean "touch more files". A repair can be deep because one dimension needs serious correction, and a multi-file patch can still be shallow if it is only reconciling one owner dimension.

Choose the lightest repair depth that actually removes the problem:

- **`no issue`**: the dimension is healthy enough to leave alone
- **`light wording fix`**: small clarifications, labels, or routing phrasing
- **`section rewrite`**: a focused rewrite inside `SKILL.md`
- **`reference repair`**: deeper correction in one or more reference files
- **`script-assisted repair`**: deterministic checks or summaries should help the repair
- **`bundle-wide patch`**: multiple linked files must change together
- **`defer explicitly`**: real issue acknowledged but intentionally left for later

Do not deepen a repair just because the dimension exists. Deepen only when drift, failure, or fragility makes it necessary to restore the skill's intended behavior.

## Repair Expansion Table Template

Render in the user's language when reporting.

```text
Repair expansion:
- Request and trigger fit:
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
```

## Pressure Prompts

```text
Prompt: Repair this skill. The obvious bug is a bad label, but I suspect the output contract and reference bundle also drifted.
Expected behavior: scan adjacent dimensions, then choose targeted deeper repairs where needed instead of stopping at the first wording fix.
```

```text
Prompt: Fix this skill, but keep the patch as small as possible.
Expected behavior: run the expansion pass, confirm which dimensions have no issue, and keep repair depth intentionally narrow.
```
