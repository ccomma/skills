Kernel sentence:
This skill exists to stabilize complex live workflows before execution drifts.
Trigger boundary:
It should trigger when multi-step work has blockers, branching risk, or costly recovery.
First move:
Its first move is to map goal, known inputs, blockers, and the next checkpoint.
Strongest thing:
It is strongest when it forces an explicit checkpoint before risky work continues.
Not-this-skill-if:
If the task is already simple and deterministic, this is not the right skill.
Minimal shape:
SKILL.md only
Component decisions:
- SKILL.md hot path: owns the checkpoint loop. It protects kernel clarity.
- Recovery rule block in SKILL.md: owns retry, ask, reroute, or defer decisions. It protects kernel stability.
Do-not-add:
- Do not add references just to restate the main path.
- Do not add scripts unless one repeated verification step becomes deterministic and fragile.
Validation starter:
- Deterministic checks:
  - run the bundle check for the skill before installation or handoff
- Smoke prompts:
  - start with one narrow smoke prompt that checks the checkpoint loop and refusal boundary on first read
  - if that first smoke passes clearly, stop there instead of widening the suite
  - escalate only when trigger boundary, authority, cadence, broader routing, or multi-turn behavior changed
Initializer handoff:
- Initialize:
  - create `SKILL.md`
- Do not invent:
  - do not add references
  - do not add scripts
