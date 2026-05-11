# Skill Architect Interaction Intensity

Load this when deciding how many questions a skill should ask, how much it should batch, and where it should stop.

## Design Questions

- How much ambiguity is normal for this skill?
- Which decisions are low risk and batchable?
- Which decisions must pause for confirmation?
- When should the skill stay quiet and proceed versus ask the user?
- How should the skill adapt after repeated agreement?

## Design Patterns

### 1. Match Intensity To Risk

- low ambiguity + low risk: fewer questions
- high ambiguity + high consequence: more structured checkpoints
- repeated accepted decisions: compact mode or batching

### 2. Separate Interaction Profile From Intensity

`guided` versus `constrained` chooses shape. Interaction intensity chooses how much pressure the skill puts on the user within that shape.

### 3. Give The Skill A Recovery Path

If a compact or batched flow is wrong, the skill should know when to expand again: disagreement, safety, persistence, or boundary-sensitive decisions.

## Pressure Prompts

```text
Prompt: Design a reusable skill that usually gets underspecified requests, but users hate long intake.
Expected design: moderate questioning, strong stop points, and adaptive compactness after initial clarification.
```
