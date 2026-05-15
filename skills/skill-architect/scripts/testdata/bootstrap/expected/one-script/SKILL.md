---
name: one-script
description: "This skill exists to verify build brief instances against the repo-local protocol helper before handoff."
---

# One Script

Repo-local consumption proof generated from a validated build brief.

## Frozen Kernel

- Kernel sentence: This skill exists to verify build brief instances against the repo-local protocol helper before handoff.
- Trigger boundary: It should trigger when the brief is already written and needs deterministic contract checking.
- First move: Its first move is to parse the brief fields in protocol order.
- Strongest thing: It is strongest when it catches missing fields and shape conflicts before downstream consumption.
- Not-this-skill-if: If the brief still needs kernel design judgment, this is not the right skill.
