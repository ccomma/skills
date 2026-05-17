Kernel sentence:
This skill exists to route fuzzy requests to the right workflow without long intake.
Trigger boundary:
It should trigger when the request is still fuzzy but the next owner decision is the main need.
First move:
Its first move is to classify the request by owned workflow object.
Strongest thing:
It is strongest when it resolves the owner fast and avoids over-interviewing.
Not-this-skill-if:
If the task already has a clear owner and only needs execution, this is not the right skill.
Minimal shape:
SKILL.md + one reference
Component decisions:
- SKILL.md routing loop: owns the first-turn owner judgment. It protects kernel clarity.
- One reference: holds edge-case routing examples so the hot path stays short. It protects kernel verification.
Do-not-add:
- Do not add scripts for subjective routing judgment.
- Do not add extra references for neighboring workflows that the main reference already covers.
Validation starter:
- Deterministic checks:
  - run the bundle check and confirm the one-reference shape still matches the brief
- Smoke prompts:
  - start with one narrow smoke prompt that checks the first-turn owner judgment before opening the reference
  - if that first smoke passes clearly, stop there instead of widening the suite
  - escalate only when trigger boundary, authority, cadence, broader routing, or multi-turn behavior changed
Initializer handoff:
- Initialize:
  - create `SKILL.md`
  - create one reference file for edge-case routing examples
- Do not invent:
  - do not add scripts
  - do not add extra references beyond the one edge-case routing reference
