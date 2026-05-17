# Auxiliary Docs Policy

Load this when a repository contains `docs/` directories or files that are outside the core planning stack but still provide useful supporting context.
It answers how helper layers should be classified relative to the core planning stack and default load chain.
It does not replace the phase-package-centered workflow, source-of-truth ownership, or current execution state rules.

## Principle

Auxiliary directories are allowed. They are not a sign that the document system is broken.

The rule is not "only the standard layers may exist." The rule is "only the owning layers should drive the default planning and execution flow."

## Default Treatment

When you encounter a `docs/` subdirectory outside the core stack:

1. Classify its purpose.
2. Decide whether it owns source material for the current task.
3. If not, downgrade it to a helper layer.
4. Keep it out of the default load chain.
5. Read it only when the task explicitly needs it.

## Core Stack Vs Helper Layers

Core stack normally includes:

- `docs/README.md`
- `docs/context/`
- `docs/process/`
- `docs/roadmap/`
- `docs/phases/`
- `docs/prd/`
- `docs/technical/`
- `docs/testing/`
- `docs/adr/`

Common helper-layer categories include:

- presentation, onboarding, or communication materials
- API contract or integration reference docs
- agent-facing repository guidance that is not the core product source of truth
- architecture notes or long-lived implementation references that span phases
- reports, inventories, or generated analysis artifacts
- consumed discovery archives that should remain available but no longer drive execution state

## Read Rule

Do not load helper layers by default just because they exist under `docs/`.

Read them only when:

- the user's task is explicitly about that helper domain
- the owning planning layers point to them as necessary reference
- the current task's source of truth genuinely lives there

## Ownership Rule

Helper directories may contain useful supporting material, but they should not silently become the source of truth for:

- current execution state
- durable product judgment
- phase requirements
- technical architecture contracts
- test strategy

If a helper directory is repeatedly being used as a hidden source of truth, move the owning content back into the proper layer.

Cross-phase technical strategy docs are helper layers by default. They may inform phase design, but they do not automatically become the canonical owner of any one phase's technical contract.

## README Guidance

Use a directory `README.md` when the helper directory's purpose is not self-evident or is easy to confuse with core planning layers.

Do not create a `README.md` for every directory by reflex. Add one when it reduces ambiguity, not when it merely repeats the directory name.
