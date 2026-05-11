# Skill Maintain Interaction Intensity

Load this when the target skill asks too much, asks too little, batches the wrong things, or fails to expand again after oversimplifying.

## What To Check

- whether the skill asks more questions than the risk or ambiguity justifies
- whether it skips checkpoints that the task actually needs
- whether compact mode or batching starts too early or too late
- whether the skill can expand again when disagreement, safety, persistence, or boundary-sensitive decisions appear

## Repair Patterns

### 1. Match Pressure To Risk

Reduce questioning when the work is narrow and safe. Add structure when ambiguity or consequence is high.

### 2. Separate Shape From Intensity

Keep in mind that `guided` versus `constrained` is not the same as question volume. A guided skill can still be too chatty; a constrained skill can still batch well.

### 3. Restore Recovery Behavior

If the skill was simplified with compact mode or batching, make sure it knows when to expand again.

## Regression Prompts

```text
Prompt: This skill now asks ten questions before doing obvious work, but it also skips clarification when the request is actually risky. Repair the interaction intensity.
Pass if: questioning becomes lighter for easy paths and stronger for risky branches.
```
