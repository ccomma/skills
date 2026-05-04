# Skill Trim Regression Tests

Load this before proposing or implementing non-trivial changes to another skill. Use it to prove that token savings did not make the optimized skill worse at its job.

## Required Test Plan

For every target skill optimization, define this before patching:

```text
Target skill:
Optimization goal:
Capability baseline:
- Must still trigger for:
- Must still refuse or route away for:
- Must preserve safety/confirmation/evidence/persistence:
- Must preserve output/artifact quality:
- Must preserve user-facing language, labels, tone, and interaction style:
- Must keep these references/scripts/assets reachable:

Regression scenarios:
1. Happy path:
2. Wrong-scope path:
3. Safety or confirmation path:
4. Evidence or persistence path:
5. Token-heavy path:
6. Neighboring-skill conflict path:
7. Language/style preservation path:

Validation method:
- Run:
- Simulate:
- Inspect:
- Not runnable because:
```

## Minimum Scenarios

### Happy Path

Use a prompt that clearly should trigger the skill and exercise its core workflow.

Pass if the optimized skill still produces the expected kind of plan, action, artifact, or answer with no missing mandatory step.

### Wrong Scope

Use a prompt that is adjacent but should be routed to another skill or handled normally.

Pass if the optimized skill does not overtake the neighboring skill's job.

### Safety Or Confirmation

Use a prompt that asks for faster work by skipping approval, safety, verification, or user confirmation.

Pass if the optimized skill preserves the original guardrail and offers a safer lower-cost alternative.

### Evidence Or Persistence

Use a prompt where the skill should inspect code/docs, cite artifacts, write durable notes, or preserve decisions.

Pass if the optimized skill keeps the evidence or persistence behavior reachable and mandatory when the original skill required it.

### Token-Heavy Path

Use a prompt that creates the cost problem being optimized: long examples, repeated questions, large references, broad trigger, or verbose output.

Pass if the optimized skill reduces cost through progressive disclosure, compact mode, batching, scripts, or routing while preserving judgment. If the optimization adds a compact or batch trigger, the test must prove the trigger actually fires in the intended scenario, not merely that the rule exists.

### Neighboring-Skill Conflict

Use prompts that could trigger nearby skills.

Pass if routing boundaries are explicit and the optimized skill neither disappears from valid cases nor triggers on invalid ones.

### Language And Style Preservation

Use a prompt in the user's working language and style, especially if the optimized skill adds templates, labels, or compact formats.

Pass if the optimized skill preserves that language and style in user-facing output. For example, a Chinese grilling session should not suddenly switch labels such as `推荐` and `记录位置` to `Recommended` and `Record`.

## Optional Stronger Validation

Use these when the change is moderate or risky:

- Compare before/after frontmatter descriptions against five positive and five negative trigger prompts.
- Ask an independent agent to run the regression scenarios without revealing the expected fix.
- Run scripts or linters for skill layout, links, YAML, or generated metadata.
- Check that moved content is linked from `SKILL.md` with a clear load condition.
- Re-run one real transcript or failure case that motivated the optimization.
- Re-run the exact complaint that exposed the regression when the user reports one.

## Completion Gate

An optimization is complete only when:

- each baseline capability has at least one passing scenario
- any skipped test has a concrete reason
- token savings and quality risks are both reported
- no mandatory rule was silently deleted
- user-facing language and interaction style did not regress
- the final report says whether confidence is high, medium, or low
