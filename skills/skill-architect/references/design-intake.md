# Skill Architect Design Intake

Load this when the user's skill request is underspecified or when designing a new mature skill.

Render questions in the user's language. Keep option ids stable.

## Quick Intake

Ask these together when the request is mostly clear:

1. What should this skill help with?
2. What usually goes wrong without this skill?
3. Should it act directly, ask questions first, or choose based on context?
4. Should output be flexible, structured, or template-based?
5. Are there neighboring skills it must avoid overlapping with?
6. Which dimension most needs depth: authority, output contract, interaction, bundle structure, scripts, or token cost?

## Full Intake

Use for broad, risky, reusable, or previously failed skills.

### A. Skill Job

- What user request should trigger this skill?
- What output should it produce?
- What is explicitly out of scope?

### B. Failure Modes

- What mistakes should this skill prevent?
- Does the task often suffer from vague scope, wrong defaults, excessive token use, unsafe actions, inconsistent format, or skill overlap?
- Does it need a stable output contract or artifact shape?
- Does it need deterministic checks or transformations that should become scripts?

### C. Interaction Strength

Offer fixed options:

- `A. simple` — no questions; use when the task is narrow and safe.
- `B. guided` — flexible sequence; use when expert judgment matters.
- `C. constrained` — fixed options and stop points; use when choices are ambiguous, risky, or often mishandled.
- `D. deterministic` — scripts/tools; use when repeated work must be exact.
- `E. asset-backed` — templates/assets; use when output shape matters.
- `F. recommend for me` — infer from failure modes and output needs.

### D. Structure Needs

Ask only the relevant questions:

- Are there long menus, examples, variants, or policies? If yes, use `references/`.
- Is there repeated fragile parsing, validation, conversion, or generation? If yes, consider `scripts/`.
- Are reusable templates, media, boilerplate, or visual resources needed? If yes, use `assets/`.
- Does the skill need UI metadata for a skill list? If yes, use `agents/openai.yaml` when supported.

### E. Authority And Output

Ask only if relevant:

- What is the highest authority this skill should hold?
- Which actions require confirmation or stop points?
- Does the skill need a fixed report, fields, or artifact structure?
- What must be validated before the output counts as complete?

### F. Neighbor Boundaries

Ask:

- Which existing skills are adjacent?
- What should this skill own?
- What should it explicitly hand off to another skill?

### G. Breadth And Depth

Ask when the skill is broad, reusable, or being upgraded:

- Which dimensions are most likely to fail if left too light?
- Which dimensions need only a short rule in `SKILL.md`?
- Which deserve their own `reference`?
- Which deterministic steps should become scripts?
- Which dimensions can be deferred explicitly for now?

## Intake Shortcuts

Skip intake when the user already provides:

- skill name
- trigger conditions
- expected output
- boundaries
- desired file layout
- interaction model

Do not force fixed options when they add more work than they save.
