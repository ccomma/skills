# Governance Layer Model

Use this when deciding where a recurring quality problem really belongs, including cases where the real upstream cause may sit outside the current skill stack.

## Layers

### 1. Artifact Instance

One concrete project artifact is wrong, drifted, thin, stale, or misplaced.

Examples:

- one `AGENTS.md` contains non-owned workflow guidance
- one template is too empty
- one `DESIGN.md` is structurally correct but too shallow

Default action:

- repair the artifact locally
- do not escalate unless the same pattern clearly recurs across projects

### 2. Reusable Workflow Or Skill Layer

One reusable workflow or skill keeps generating or encouraging the same kind of drift.

Examples:

- a planning skill repeatedly produces headings-only project templates
- a maintenance skill repeatedly misses language-strategy drift
- a workflow routes output into the wrong owning layer
- a reusable skill keeps producing the same user-facing mismatch or behavioral confusion

Default action:

- repair that reusable workflow or skill
- keep the fix at that reusable layer unless the same failure spans multiple workflows

### 3. Multi-Skill Boundary

The main problem is not one skill's internals but unclear ownership between skills.

Examples:

- two skills both claim the same request
- one skill starts absorbing another skill's lifecycle stage
- a routing handoff keeps bouncing because boundaries are blurry

Default action:

- use a skill-boundary workflow
- do not treat this as one-skill maintenance

### 4. Meta-Skill Or Governance Layer

The recurring problem suggests that the workflows used to design or maintain skills are missing a general governance rule.

Examples:

- multiple reusable skills leak concrete local context into public outputs
- multiple skills lack an explicit language strategy
- multiple skills keep adding unnecessary standard layers

Default action:

- repair the relevant governance skill or meta-skill
- only escalate when the rule can be stated abstractly and reused safely

### 5. Runtime, Agent, Or Model Constraint

The local artifact may still need patching, but the durable upstream cause is not owned by the current project or skill stack.

Examples:

- the same prompt or skill text behaves differently because of runtime registry freshness
- the agent fails to load an installed skill because the session cache is stale
- user-visible output drift appears to come from model behavior rather than the owning skill contract

Default action:

- record the local workaround only if it is still necessary
- do not mutate several skills to compensate for a runtime or platform constraint without evidence
- separate "what we can patch locally" from "what platform/runtime fact we must acknowledge"

## Escalation Rule

Always prefer the lowest layer that can permanently prevent recurrence.

Escalate only when:

- the issue is recurring rather than isolated
- the higher-layer fix can be expressed as a portable rule
- the higher-layer fix will reduce future cleanup burden
- the higher-layer fix will not bloat a more general workflow with one narrow symptom

If the durable cause is outside the current skill stack, stop escalating upward inside the skill hierarchy and record that explicitly.
