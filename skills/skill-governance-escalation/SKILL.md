---
name: skill-governance-escalation
description: Use when a concrete issue should trigger an upward-check for reusable causes before or alongside local repair, and you need to decide whether the durable fix belongs in a project artifact, one reusable skill, a multi-skill boundary, a higher governance layer, or outside the skill stack entirely.
---

# Skill Governance Escalation

Diagnose governance problems across layers without over-generalizing. Use this when a concrete issue may need to be fixed above the place where it first appears, or when a local problem should trigger an upstream-check for reusable causes as well.

## Boundaries

Use this when a concrete problem may have more than one plausible repair layer and you want to determine:

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
- Do not wait for the user to pre-diagnose the higher layer before doing the upward-check.
- Abstract only as far as the evidence supports.
- Prefer the lowest layer that can permanently fix the problem.
- Distinguish one-off project drift from repeatable workflow failure.
- Treat routing, ownership, and publishability as governance signals, not as isolated wording bugs.
- Distinguish "local patch now" from "durable upstream repair later" when both are needed.
- Allow the answer to be "the upstream cause is outside the current skill stack" when the evidence points to runtime, agent, or model behavior.
- Default to a governance report, not to direct multi-layer rewrites.
- Hand off to downstream workflows once the fix locus is clear.

## Workflow

### 1. Confirm The Trigger

Use this workflow when a concrete issue should trigger an upstream-check, especially if it recurs, feels misowned, may reflect a reusable governance gap, or may be getting blamed on the wrong layer.

Examples:

- a project-document problem may actually come from `product-plan`
- a concrete skill symptom may actually come from a higher design or maintenance contract
- repeated drift across multiple repos may reflect a missing governance rule
- a user-visible behavior problem may actually come from runtime, agent, or model behavior rather than the current skill text

### 2. Map The Observed Issue

Start with the concrete evidence:

- what artifact or behavior looks wrong
- where it appears
- what the user expected instead
- whether the same problem has appeared before
- whether a local fix is still needed even if an upstream cause exists

Load [references/layer-model.md](references/layer-model.md) before classifying the layer.

### 3. Classify The Owning Layer

Decide whether the issue primarily belongs to:

- artifact instance
- reusable workflow or skill
- multi-skill boundary
- meta-skill or governance skill
- runtime, agent, or model constraint outside the current skill stack

Use [references/routing-matrix.md](references/routing-matrix.md) when the likely next workflow is not obvious.

### 4. Abstract The Failure Mode

Turn concrete symptoms into the narrowest reusable failure mode that still explains the evidence.

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

### 5. Decide Whether To Escalate

Ask:

- is this local-only, or is it likely to recur?
- would fixing the lower layer only create repeated cleanup work?
- does the higher-layer change stay abstract and portable?
- would escalation bloat a more general workflow with a narrow symptom?
- is the higher-layer cause still inside the skill stack, or has the analysis crossed into runtime/platform behavior?

Use [references/escalation-tests.md](references/escalation-tests.md) before concluding that a meta-layer change is justified.

### 6. Produce The Governance Report

Load [references/output-contract.md](references/output-contract.md) and [references/report-format.md](references/report-format.md).

The report must state:

- the observed issue
- layer classification
- abstract failure mode
- whether escalation is justified
- the immediate local fix locus, if one is justified
- the durable upstream fix locus, if one is justified
- the recommended downstream workflow
- which higher layers should not be changed, and why

### 7. Hand Off

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
[Localized label for layer classification]:
[Localized label for abstract failure mode]:
[Localized label for escalation judgment]:
[Localized label for immediate local fix locus]:
[Localized label for durable upstream fix locus]:
[Localized label for recommended next workflow]:
[Localized label for layers not to change]:
[Localized label for rationale]:
```

When the user explicitly asks for implementation after the report, hand off to the owning workflow instead of silently turning this skill into a catch-all repair workflow. If the analysis shows both a local patch and an upstream repair are warranted, make that dual path explicit instead of collapsing them into one vague "fix layer".
