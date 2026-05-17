# Escalation Tests

Load this when deciding whether a problem should move to a higher governance layer.

## Decision Questions

Ask all of these:

1. Is the issue isolated to one artifact, or has the evidence already become reusable?
2. Would a local repair be enough for the foreseeable future?
3. Can the higher-layer rule be written abstractly and portably?
4. Would the higher-layer fix materially reduce future cleanup?
5. Would the higher-layer fix distort the owning workflow by adding a narrow special case?
6. Should the issue be remembered even if it is not promoted immediately?

Escalate only when the answers support a reusable higher-layer rule.

## Status Meanings

- `local-only`
  - Keep the fix at the local layer.
  - Do not create a durable governance candidate note.
- `provisional candidate`
  - The reusable pattern is real enough to remember, but promotion is not yet mandatory.
  - Emit or update a governance candidate note and include a promotion trigger.
- `promote now`
  - The current evidence already justifies an upstream repair.
  - Emit or update a governance candidate note and name the durable upstream owner.

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
Expected judgment: `local-only`; keep the repair at artifact or project-workflow level.
Must not: jump straight to a reusable governance rule or write durable candidate memory.
```

### 2. Local Drift Worth Remembering

```text
Scenario: the current evidence already suggests a reusable pattern, but local cleanup should still happen first
Prompt: 这次改动里有一个本地问题，但我怀疑它背后还有上游原因。
Expected judgment: `provisional candidate`; keep the local fix actionable, emit a governance note, and state what future evidence would trigger promotion.
Must not: force a full upstream redesign immediately or lose the local repair plan.
```

### 3. Promote Now

```text
Scenario: the same governance failure is already clear enough to justify an upstream repair
Prompt: 这次问题已经足够说明上层规则该修了，不需要再等。
Expected judgment: `promote now`; name both the immediate local fix and the durable upstream fix.
Must not: defer promotion just because this is the first time it appeared in this session.
```

### 4. Multi-Skill Ownership Conflict

```text
Scenario: the real problem is overlap between skills
Prompt: 这类请求到底应该由 A 还是 B 处理？
Expected judgment: keep the status focused on the issue, then route to `skill-referee`.
Must not: treat this as one-skill maintenance or a meta-skill rule by default.
```

### 5. Runtime Or Platform Constraint

```text
Scenario: the observed issue may come from session cache or runtime behavior
Prompt: 我明明已经把 skill 放到本地了，但当前会话就是触发不了它。
Expected judgment: classify the durable upstream cause as runtime/platform constraint unless stronger evidence points back to the skill text; status may still be `local-only` if no reusable skill repair is justified.
Must not: patch several skills to compensate for a registry or session-freshness problem.
```

### 6. Overfitted Meta Rule

```text
Scenario: a complaint names one private local tool
Prompt: 文档里出现了我本地才有的名字。
Expected judgment: abstract to portability or local-context leakage only if the rule can stay generic; often this stays `local-only` or `provisional candidate`.
Must not: encode a ban on one private name as if it were the general principle.
```
