# Skill Maintain Bundle Consistency

Load this when the problem may come from mismatches across the main skill surface, references, format files, scripts, assets, or agent metadata rather than from one paragraph of prose.

If the real problem is that references are too vague, duplicated, or badly split, load `reference-quality.md`.

## Routing Position

- common upstream:
  - `reference-routing.md`
  - `repair-expansion.md`
- if the real question is owner component, jump to `component-paths.md`
- if the real question is only repair shape after ownership is known, jump to `repair-patterns.md`

## Distinction

Use `component-paths.md` to route one drift to one owner component.

Use this file when the real issue is that several components drifted together or the bundle contract itself has become inconsistent.

## What To Check

- `agents/openai.yaml` still describes the current skill behavior and name
- every referenced file actually exists
- heavy guidance moved out of `SKILL.md` is still reachable through an explicit load condition
- references do not contradict the main workflow or each other
- scripts, assets, and templates still match the workflow that invokes them
- renamed skills, files, or modes are updated consistently across the bundle
- obsolete references or orphaned files are not silently lingering

## Deterministic First

Use [scripts/check-skill-bundle.sh](../scripts/check-skill-bundle.sh) for the repeatable checks before doing manual reasoning. The script is the preferred path for:

- required file presence
- frontmatter name mismatch
- `agents/openai.yaml` display or prompt mismatch
- broken local markdown links
- orphaned references
- script files that are never mentioned
- forbidden old-name residue during a rename

Use manual review after the script when the problem is about meaning, clarity, or whether a file should exist at all.

## Necessity Check

Before keeping a non-core bundle component, ask:

- what exact burden or contract it protects
- whether that burden is recurring across the bundle rather than local to one rule
- whether the same value would survive with one fewer component

## Repair Patterns

### 1. Reconcile The Entry Surface

Check whether the frontmatter description, title, and agent metadata all describe the same skill. If the skill was renamed or repurposed, update all entrypoints together.

### 2. Preserve One-Hop Reachability

If a rule, checklist, or example lives in `references/`, `SKILL.md` should point to it with a clear load condition. Do not leave important files discoverable only by directory browsing.

### 3. Remove Orphans Carefully

When a file no longer belongs to the bundle:

- confirm no remaining reference points to it
- check whether its behavior was replaced elsewhere
- delete or rename it only after the replacement path is clear

### 4. Align References With Real Behavior

If `agents/openai.yaml`, scripts, templates, or assets still describe old modes, old names, or old outputs, update them as part of the same repair.

### 5. Prefer Compact Machine Summaries

When extracting bundle facts, prefer a deterministic script that emits a short summary over pasting raw grep dumps into the main workflow. The script should surface errors and warnings, not full-file noise.

## Script Usage

```bash
./scripts/check-skill-bundle.sh ./skills/skill-maintain --expected-name skill-maintain
```

## Regression Prompts

```text
Prompt: This skill was renamed, but its agent metadata and one reference still use the old name. Repair the bundle.
Pass if: all user-facing and reference entrypoints agree on the current name and behavior.
```

```text
Prompt: This skill moved examples into references, but the main file no longer tells me when to load them. Repair it.
Pass if: each important reference is reachable from `SKILL.md` through a clear load condition.
```
