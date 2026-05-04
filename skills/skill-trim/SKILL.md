---
name: skill-trim
description: Use when auditing or reducing the token/context cost of an existing skill, especially when a skill is too verbose, loads too much by default, runs long interactive loops, overlaps with neighboring skills, or needs progressive disclosure and adaptive verbosity without losing decision quality.
---

# Skill Trim

Audit and improve another skill's token economy without weakening its judgment. Use this after a skill exists or when a running workflow becomes noticeably token-heavy.

## Boundaries

Use a skill-design or skill-architecture workflow for designing a new skill or deciding whether a skill should exist, split, or merge.

Use this workflow for diagnosing and patching an existing skill's context cost, interaction verbosity, lazy-loading structure, and long-flow behavior.

Do not use this for general prompt compression, code optimization, runtime performance, or summarizing arbitrary chat history.

## Portability

Keep optimization advice publishable and environment-neutral. Do not write target-skill recommendations that depend on the user's local skill names, private workflows, repository-specific aliases, or installed tool bundle. Describe neighboring responsibilities by capability category instead, such as "skill design workflow", "domain-model grilling workflow", "implementation planning workflow", or "code review workflow".

Only mention a concrete skill, tool, or path when it is the target being audited, part of the target skill's public bundle, or explicitly supplied by the user.

**Platform-neutral terminology**: Skills are shared across agent runtimes. Skill content must use generic concepts (e.g., "cold-start entrypoint file", "agent runtime", "session context loader"), not vendor-specific filenames (e.g., `CLAUDE.md`, `AGENTS.md`). Vendor-specific names may appear only as illustrative examples with a qualifier ("e.g.,", "varies by platform"). When auditing or patching a skill, flag and replace any hardcoded vendor-specific references that are not illustrative examples.

## Core Principle

Compress narration, not decisions. Preserve trigger accuracy, safety checks, evidence requirements, user confirmations, persistence behavior, and the target skill's practical task quality.

Token reduction is not successful unless the optimized skill still handles its core scenarios at least as well as before. Treat every optimization as a behavior change until tested.

## Workflow

### 1. Confirm Scope

If the target skill is not explicit, ask which skill to audit. If the user only complains about token cost during another workflow, ask whether they want a quick token-cost review before changing files.

### 2. Inspect Metadata First

Read the target skill metadata, file layout, and `SKILL.md` length before reading references. Note neighboring skills from names and descriptions.

### 3. Establish A Capability Baseline

Before proposing edits, write a short baseline for what must keep working:

- trigger cases that must still load the skill
- wrong-scope cases that must still route away
- safety, confirmation, evidence, and persistence rules that must remain intact
- core output or artifact quality the user relies on
- user-facing language, labels, tone, and interaction style that must not regress
- portability and environment-neutral routing that must not regress
- references, scripts, or assets that must remain reachable through lazy loading

If there is a real prior failure report, example prompt, transcript, diff, or user complaint, use it as a regression fixture. Otherwise create realistic before/after scenarios from the skill's stated purpose.

### 4. Diagnose Token-Cost Failure Modes

Load [optimization-patterns.md](references/optimization-patterns.md) when doing more than a quick metadata review.

Look for:

- broad trigger descriptions
- large always-loaded `SKILL.md` bodies
- examples or menus that should move to `references/`
- references that are loaded unconditionally
- repeated long-form interaction loops
- missing compact or batch modes
- missing stop points before expensive review
- duplicated responsibilities with neighboring skills
- decisions left in chat instead of persisted artifacts
- repeated prose where scripts would be more reliable

### 5. Propose Before Patching

Show a concise optimization plan before editing unless the user explicitly asked for direct implementation.

Classify each change:

- `safe`: wording, routing, lazy-load pointers, compact-mode trigger
- `moderate`: moving content to references, changing interaction flow
- `risky`: changing trigger boundary, deleting rules, merging/splitting skills

Every plan must include a regression test plan. Load [regression-tests.md](references/regression-tests.md) before proposing or implementing anything beyond a trivial wording-only change.

### 6. Patch And Validate

After approval, edit the smallest necessary files. Load [pressure-tests.md](references/pressure-tests.md) before calling a reusable skill mature.

Validate that:

- the capability baseline still passes
- default load got smaller or more focused
- worst-case path still has needed guidance
- compact or batch mode preserves decision quality
- compact or batch mode actually triggers in the scenario it was designed for
- user-facing language and labels remain consistent with the target skill's session
- neighboring skill routing remains clear
- routing guidance uses generic capability categories unless the concrete neighbor is explicitly part of the target skill's public bundle
- skill content uses platform-generic terminology; vendor-specific filenames appear only as illustrative examples with qualifiers
- no safety, confirmation, or persistence rule was removed
- all planned regression tests were run, simulated, or explicitly marked not runnable with a reason

Do not call an optimization complete if it only reduces token use. It must pass the regression plan or clearly report the remaining quality risk.

## Output

For review-only work:

```text
Target skill:
Token-cost diagnosis:
Recommended changes:
Risk:
Expected token impact:
Validation:
```

For implementation work, report changed files, why each change reduces context cost, the capability baseline, tests run, and any residual quality risk.
