---
name: skill-governance-escalation
description: Use when a concrete issue should trigger an auto-audit first and then an upward-check for reusable causes if needed, so you can separate immediate local repair from any durable upstream fix and persist reusable governance candidates when warranted.
---

# Skill Governance Escalation

Audit governance-relevant AI changes and diagnose cross-layer causes without over-generalizing. Use this when a concrete issue may need both a local patch and a reusable upstream check, or when you need to prove that no such escalation is warranted.

## Boundaries

Use this when a concrete problem may have more than one plausible repair layer and you want to determine:

- what findings the current change actually produces
- what should be patched locally right now
- whether an upstream reusable fix is also warranted
- which layer should own that durable fix

This workflow may inspect:

- concrete project artifacts such as docs, templates, reports, or entrypoints
- one reusable workflow or skill that appears to be causing repeated problems
- a meta-skill when the same governance failure keeps recurring
- a multi-skill boundary when the issue is actually a routing or ownership conflict
- a runtime, agent, or model constraint when the issue may not be fixable inside the current skill stack

Do not use this when:

- the fix location is already clear and only one existing skill needs repair -> use a skill-maintenance workflow
- the main issue is overlap or conflict between multiple skills -> use a skill-boundary workflow
- the main task is designing a new skill or reshaping one skill whose boundary is already understood -> use a skill-design workflow
- the main task is directly repairing project documents after the owning workflow is already known -> use the owning project/document workflow

## Core Rules

- Start from the concrete issue, not from a desired abstraction.
- When this workflow is invoked, default to an auto-audit first. Do not wait for the user to pre-diagnose findings.
- This workflow is explicitly invoked. It does not imply silent background hooks or automatic execution after every change.
- Abstract only as far as the evidence supports.
- Prefer the lowest layer that can permanently fix the problem.
- Distinguish one-off project drift from repeatable workflow failure.
- Treat routing, ownership, and publishability as governance signals, not as isolated wording bugs.
- Distinguish "local patch now" from "durable upstream repair later" when both are needed.
- Allow the answer to be "the upstream cause is outside the current skill stack" when the evidence points to runtime, agent, or model behavior.
- When the issue is text-heavy and deterministic signal extraction is useful, run `scripts/scan-governance-signals.py` first to gather candidate evidence. Do not let the script replace judgment.
- Keep findings separate from escalation judgments. A local-only finding is still a useful output.
- Classify the post-audit governance status explicitly as `local-only`, `provisional candidate`, or `promote now`.
- Persist only reusable governance candidates. Do not create durable note noise for local-only findings.
- Default to a governance report, not to direct multi-layer rewrites.
- Hand off to downstream workflows once the fix locus is clear.

## Workflow

### 1. Confirm The Trigger

Use this workflow when a concrete issue should trigger an auto-audit and then, only if needed, an upstream-check. This is especially useful if the issue recurs, feels misowned, may reflect a reusable governance gap, or may be getting blamed on the wrong layer.

Examples:

- a project-document problem may actually come from an upstream planning workflow
- a concrete skill symptom may actually come from a higher design or maintenance contract
- repeated drift across multiple repos may reflect a missing governance rule
- a user-visible behavior problem may actually come from runtime, agent, or model behavior rather than the current skill text

### 2. Run The Auto-Audit

Start with the concrete evidence:

- what artifact or behavior looks wrong
- where it appears
- what the user expected instead
- whether the same problem has appeared before
- whether a local fix is still needed even if an upstream cause exists

Load [references/audit-signals.md](references/audit-signals.md) before naming findings.

If the issue lives in skills, templates, docs, or other text artifacts, use `scripts/scan-governance-signals.py` to collect candidate signals such as headings-only templates, mixed-language headings, or local-context leakage before classifying the layer. Prefer scanning the most relevant current files first; use `--exclude` patterns when historical directories would only add noise.

Produce a compact findings list first. Each finding should be marked as one of:

- `local-only finding`
- `upstream-check candidate`
- `runtime/platform candidate`

Do not escalate anything yet.

### 3. Judge The Upstream Status

Before escalating, decide the overall governance status for the issue:

- `local-only`
- `provisional candidate`
- `promote now`

Use [references/escalation-tests.md](references/escalation-tests.md) before deciding that an issue should move beyond local repair.

Use `local-only` when:

- the current evidence supports only a local fix
- recurrence is unproven or too weakly abstracted
- no durable higher-layer rule is justified yet

Use `provisional candidate` when:

- the evidence already suggests a reusable failure mode
- the local fix still matters now
- the higher-layer fix should be remembered and revisited even if it is not promoted immediately

Use `promote now` when:

- the current evidence is already sufficient to justify an upstream repair
- the durable rule can be stated abstractly and portably
- delaying promotion would mostly create repeated cleanup work

Load [references/persistence-policy.md](references/persistence-policy.md) before deciding whether a governance note should be emitted or written.

### 4. Escalate If Needed

Only escalate findings that look reusable, misowned, or suspiciously higher-layer. Leave pure local findings at the local layer.

Load [references/layer-model.md](references/layer-model.md) before classifying the layer.

For each escalated finding, decide whether the durable fix primarily belongs to:

- artifact instance
- reusable workflow or skill
- multi-skill boundary
- meta-skill or governance skill
- runtime, agent, or model constraint outside the current skill stack

Use [references/routing-matrix.md](references/routing-matrix.md) when the likely next workflow is not obvious.

### 5. Abstract The Failure Mode

For each escalated finding, turn the concrete symptoms into the narrowest reusable failure mode that still explains the evidence.

Load [references/abstraction-rules.md](references/abstraction-rules.md) before naming the failure mode.

Good outputs at this step look like:

- ownership drift
- portability leakage
- language-strategy drift
- template self-descriptiveness failure
- thin-but-correct core artifact
- helper-layer misplacement

Bad outputs at this step look like:

- a restatement of one filename
- a rule tailored to one private setup
- a sweeping meta-rule based on one accident

### 6. Decide The Final Split Between Local Repair And Upstream Repair

Ask:

- is this local-only, or is it likely to recur?
- would fixing the lower layer only create repeated cleanup work?
- does the higher-layer change stay abstract and portable?
- would escalation bloat a more general workflow with a narrow symptom?
- is the higher-layer cause still inside the skill stack, or has the analysis crossed into runtime/platform behavior?

### 7. Produce The Governance Report

Load [references/output-contract.md](references/output-contract.md), [references/report-format.md](references/report-format.md), and [references/governance-note-format.md](references/governance-note-format.md).

The report must state:

- the observed issue
- layer classification
- the findings list
- upstream status
- abstract failure mode
- whether escalation is justified
- the immediate local fix locus, if one is justified
- the durable upstream fix locus, if one is justified
- promotion trigger when the issue is a `provisional candidate`
- governance note action
- the recommended downstream workflow
- which higher layers should not be changed, and why

In review-only work, emit a governance note block for `provisional candidate` and `promote now` so the result can be persisted later even when the current pass does not write files.

In implementation or repair work, write or update the governance candidate ledger only when the issue is `provisional candidate` or `promote now`.

### 8. Hand Off

Once the fix locus is clear:

- route to a skill-maintenance workflow for one existing skill
- route to a skill-design workflow when one skill's structure must change
- route to a skill-boundary workflow for multi-skill ownership conflict
- route to the owning project/document workflow when the problem is local to one project
- stop inside this workflow and record the constraint explicitly when the durable cause is outside the current skill stack

## Output

Use the user's session language for visible report labels and section headers. Keep exact technical tokens such as skill names, file paths, and layer ids verbatim when translation would reduce precision.

For review-only work:

```text
[Localized label for observed issue]:
[Localized label for evidence]:
[Localized label for findings]:
[Localized label for layer classification]:
[Localized label for upstream status]:
[Localized label for abstract failure mode]:
[Localized label for escalation judgment]:
[Localized label for immediate local fix locus]:
[Localized label for durable upstream fix locus]:
[Localized label for promotion trigger]:
[Localized label for governance note action]:
[Localized label for recommended next workflow]:
[Localized label for layers not to change]:
[Localized label for rationale]:
```

When the user explicitly asks for implementation after the report, hand off to the owning workflow instead of silently turning this skill into a catch-all repair workflow. If the analysis shows both a local patch and an upstream repair are warranted, make that dual path explicit instead of collapsing them into one vague "fix layer".
