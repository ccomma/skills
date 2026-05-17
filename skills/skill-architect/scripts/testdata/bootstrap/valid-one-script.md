Kernel sentence:
This skill exists to verify build brief instances against the repo-local protocol helper before handoff.
Trigger boundary:
It should trigger when the brief is already written and needs deterministic contract checking.
First move:
Its first move is to parse the brief fields in protocol order.
Strongest thing:
It is strongest when it catches missing fields and shape conflicts before downstream consumption.
Not-this-skill-if:
If the brief still needs kernel design judgment, this is not the right skill.
Minimal shape:
SKILL.md + one script
Component decisions:
- SKILL.md usage rule: explains when to run the validator. It protects kernel clarity.
- One script: checks required fields, order, and conflict signals. It protects kernel verification.
Do-not-add:
- Do not add references if the validator behavior fits in the main file.
- Do not add extra scripts that reinterpret the protocol semantically.
Validation starter:
- Deterministic checks:
  - run the bundle check and confirm the one-script shape still matches the brief
- Smoke prompts:
  - start with one narrow smoke prompt that checks the validator trigger and refusal boundary on first read
  - if that first smoke passes clearly, stop there instead of widening the suite
  - escalate only when trigger boundary, authority, cadence, broader routing, or multi-turn behavior changed
Initializer handoff:
- Initialize:
  - create `SKILL.md`
  - create `scripts/check-brief-surface.sh`
- Do not invent:
  - do not add references
  - do not add extra scripts that reinterpret the protocol
