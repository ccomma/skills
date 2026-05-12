# Escalation Tests

Use this before deciding that a problem should move to a higher governance layer.

## Decision Questions

Ask all of these:

1. Is the issue isolated to one artifact, or has it recurred?
2. Would a local repair be enough for the foreseeable future?
3. Can the higher-layer rule be written abstractly and portably?
4. Would the higher-layer fix materially reduce future cleanup?
5. Would the higher-layer fix distort the owning workflow by adding a narrow special case?

Escalate only when the answers support a reusable higher-layer rule.

## Pressure Scenarios

```text
Scenario:
Prompt:
Expected judgment:
Must not:
```

### 1. Local Drift Only

```text
Scenario: one project template is too thin
Prompt: 这个模板只有标题，别的项目没这个问题。
Expected judgment: keep the repair at artifact or project-workflow level unless repetition is proven.
Must not: jump straight to a meta-skill rule.
```

### 1a. Auto-Audit Finds Local Drift

```text
Scenario: one changed file has deterministic quality issues but no strong reusable pattern yet
Prompt: 先审这次改动，再判断要不要上收到更高层。
Expected judgment: produce findings first, keep local-only findings local, and escalate only what evidence supports.
Must not: treat every finding as an escalation candidate by default.
```

### 2. Repeated Workflow Failure

```text
Scenario: one workflow keeps producing the same weak artifact shape
Prompt: 两个项目都出现 headings-only project-visible template。
Expected judgment: escalate to the owning reusable skill or workflow layer.
Must not: blame the project alone.
```

### 3. Local Patch Plus Upstream Repair

```text
Scenario: one local artifact is wrong, but the pattern also points to a reusable cause
Prompt: 先把当前 skill 的输出修好，但这个问题以后应该也会反复出现。
Expected judgment: name both the immediate local fix and the durable upstream fix; do not collapse them into one vague owner.
Must not: force a false choice between local repair and upstream repair when both are justified.
```

### 3a. Auto-Audit Finds Local Issue Plus Upstream Candidate

```text
Scenario: the audit finds a local wording defect and also reveals a reusable governance pattern
Prompt: 这次改动里有一个本地问题，但我怀疑它背后还有上游原因。
Expected judgment: keep the local fix actionable, mark the upstream-check candidate explicitly, and name both loci only if the evidence supports it.
Must not: let the upstream analysis erase the local repair plan.
```

### 4. Multi-Skill Ownership Conflict

```text
Scenario: the real problem is overlap between skills
Prompt: 这类请求到底应该由 A 还是 B 处理？
Expected judgment: route to a skill-boundary workflow.
Must not: treat this as one-skill maintenance or a meta-skill rule by default.
```

### 5. Runtime Or Platform Constraint

```text
Scenario: the observed issue may come from session cache or runtime behavior
Prompt: 我明明已经把 skill 放到本地了，但当前会话就是触发不了它。
Expected judgment: classify the durable upstream cause as runtime/platform constraint unless stronger evidence points back to the skill text.
Must not: patch several skills to compensate for a registry or session-freshness problem.
```

### 6. Overfitted Meta Rule

```text
Scenario: a complaint names one private local tool
Prompt: 文档里出现了我本地才有的名字。
Expected judgment: abstract to portability or local-context leakage only if the rule can stay generic.
Must not: encode a ban on one private name as if it were the general principle.
```
