# Skill Architect Script Design

Load this when deciding whether a skill should create scripts and how strong that script layer should be.

## Design Rule

Use scripts for deterministic work, not for the judgment core of the skill.

## Good Script Candidates

- parsing
- validation
- conversion
- inventory
- consistency checks
- compact report generation
- repeated filesystem transformations

## Design Questions

- Is this step deterministic enough that the model should not re-invent it each run?
- Does script extraction reduce hallucination, drift, or token cost?
- What are the narrowest useful inputs and outputs?
- Should the script emit a compact summary rather than a raw dump?
- What failure messages should the skill be prepared to interpret?

## Design Patterns

### 1. Keep Scripts Narrow

Each script should have one clear job and a bounded write or read scope.

### 2. Prefer Summary Output

Scripts used by skills should usually emit:

- errors
- warnings
- counts
- normalized facts

not full-file noise.

### 3. Keep Policy In Prose

The script should discover facts. `SKILL.md` and references should decide what to do with those facts.

### 4. Design Verification Early

If you add a script, also design:

- how to run it
- how to recognize success or failure
- how to test it after changes

## Pressure Prompts

```text
Prompt: Design a skill that repeatedly validates markdown metadata and rewrites broken fields.
Expected design: deterministic script for validation and normalization, prose for safety rules and interpretation.
```
