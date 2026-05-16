# Skill Maintain Regression Tests

Load this when proposing or implementing non-trivial changes to another skill. Use it to prove the repaired skill still does its job after the fix.

## Required Test Plan

For every repair, define this before patching:

```text
Target skill:
Primary failure mode:
Capability baseline:
- Must still trigger for:
- Must still refuse or route away for:
- Must still distinguish maintenance from redesign:
- Must still hand off reusable upstream causes explicitly:
- Must preserve safety/confirmation/evidence/persistence:
- Must preserve output/artifact quality:
- Must preserve user-facing language, labels, tone, and interaction style:
- Must keep these references/scripts/assets reachable:

Regression scenarios:
1. Happy path:
2. Wrong-scope path:
3. Safety or confirmation path:
4. Evidence or persistence path:
5. Reported failure path:
6. Neighboring-workflow path:
7. Language/style preservation path:
8. Verdict-shape path:
9. Redesign-handoff path:
10. Governance-handoff path:

Validation method:
- Run:
- Simulate:
- Inspect:
- Not runnable because:

Maintenance breadth scan:
- Trigger boundary:
- Portability and language:
- Abstraction:
- Structure and routing:
- Output contract:
- Interaction intensity:
- Bundle consistency:
- Safety and authority:
- Script opportunities:
- Token economy:
- Validation:

Repair depth:
- Light wording fix:
- Section rewrite:
- Reference repair:
- Script-assisted repair:
- Bundle-wide patch:
- Defer explicitly:
```

## Minimum Scenarios

### Happy Path

Use a prompt that clearly should trigger the target skill and exercise its core workflow.

Pass if the repaired skill still produces the expected kind of plan, action, artifact, or answer with no missing mandatory step, including a complete maintenance verdict when that is the default output.

### Wrong Scope

Use a prompt that is adjacent but should be routed away.

Pass if the repaired skill does not overtake a neighboring workflow.

### Safety Or Confirmation

Use a prompt that tries to skip approval, safety, verification, or user confirmation.

Pass if the repaired skill preserves the original guardrail and offers a safer lower-cost alternative when relevant.

### Evidence Or Persistence

Use a prompt where the skill should inspect artifacts, cite evidence, write durable notes, or preserve decisions.

Pass if the repaired skill keeps that behavior reachable and mandatory when the original skill required it.

### Reported Failure Path

Re-run the exact complaint or a faithful simulation of it: hardcoded runtime wording, mixed language, abstraction leak, bloated structure, output-contract drift, interaction-intensity drift, bundle mismatch, authority drift, or token-heavy flow.

Pass if the specific failure mode is fixed without creating a new routing or quality regression.

### Neighboring-Workflow Path

Use prompts that could trigger nearby workflows such as skill design or skill boundary review.

Pass if routing boundaries are explicit and the repaired skill neither disappears from valid cases nor triggers on invalid ones.

### Verdict-Shape Path

Use a prompt that should stay inside maintenance and require the default verdict.

Pass if the repaired skill produces stable sections for drift diagnosis, repair depth, maintenance judgment, handoff, proof, and residual risk without drifting into protocol or governance-report shape.

### Redesign-Handoff Path

Use a prompt where fixing the issue would redefine the skill's role or kernel.

Pass if the repaired skill routes to `skill-architect` instead of pretending the work is still ordinary maintenance.

### Governance-Handoff Path

Use a prompt where the local repair is clear but the same pattern plausibly reflects a reusable upstream cause.

Pass if the repaired skill keeps the local maintenance path explicit and then points to `skill-governance-escalation`.

### Bundle-Integrity Path

Use a prompt where the issue spans more than one file in the same skill bundle: stale agent metadata, orphaned reference, broken load condition, or renamed mode not propagated everywhere.

Pass if the repaired skill updates the connected files consistently rather than patching only one visible line.

### Language And Style Preservation

Use a prompt in the user's working language and style, especially if the repair touches labels, templates, or compact formats.

Pass if the repaired skill preserves that language and style in user-facing output.

## Optional Stronger Validation

Use these when the change is moderate or risky:

- compare before/after frontmatter descriptions against positive and negative trigger prompts
- ask an independent agent to run the regression scenarios without revealing the expected fix
- run scripts or linters for skill layout, links, YAML, or generated metadata
- check that moved content is linked from `SKILL.md` with a clear load condition
- re-run one real transcript or failure case that motivated the repair
- check that the default verdict still localizes visible labels while preserving technical tokens

## Minimal Live Smoke

For narrow component or reference repairs, load `minimal-smoke-prompts.md` first and use one or two prompts before escalating to the larger suite.

## Completion Gate

A repair is complete only when:

- each baseline capability has at least one passing scenario
- the reported failure mode has a passing scenario
- the default maintenance verdict has at least one passing scenario
- redesign handoff has at least one passing scenario
- governance handoff has at least one passing scenario
- breadth coverage was explicit rather than assumed
- repair depth was intentional rather than accidental
- any skipped test has a concrete reason
- no mandatory rule was silently deleted
- user-facing language and interaction style did not regress
- verdict structure stayed stable across the tested language mode
- the final report states residual risk and confidence
