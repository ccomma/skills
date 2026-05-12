# Skill Architect Pressure Tests

Load this before calling a reusable skill mature, or when the user asks whether a skill is actually robust.

A pressure test is a realistic prompt or situation designed to reveal whether the skill triggers correctly, asks the right amount, avoids neighbor overlap, and preserves token efficiency.

## Minimum Test Set

Create at least these scenarios for non-trivial skills:

1. **Happy path** — user gives the expected request.
2. **Underspecified request** — user gives too little information.
3. **Overspecified request** — user already answered likely questions; the skill should not over-interview.
4. **Wrong-scope request** — request belongs to a neighboring skill or no skill.
5. **Neighbor conflict** — request could trigger two adjacent skills; routing should be clear.
6. **Token pressure** — request should use metadata, references, scripts, or assets lazily instead of loading everything.
7. **Language/style pressure** — if the skill is user-facing, menus and reports should follow the user's language and tone.
8. **Authority pressure** — risky actions should have explicit boundaries and confirmation design.
9. **Bundle pressure** — support files should stay aligned and reachable.
10. **Output-contract pressure** — required sections, fields, or artifacts should be intentionally designed rather than implied.
11. **Breadth/depth pressure** — the design should scan major dimensions and deepen only the ones that matter.

## Test Format

```text
Scenario:
Prompt:
Expected behavior:
Must not:
Evidence to check:
```

## Evaluation Questions

For each scenario, ask:

- Did the skill trigger only when appropriate?
- Did it choose the right interaction strength?
- Did it choose the right interaction intensity?
- Did it avoid unnecessary questions?
- Did it avoid acting before required confirmation?
- Did it load references/scripts/assets only when justified?
- Did scripts have narrow deterministic jobs and compact outputs?
- Did the design explicitly scan major dimensions instead of focusing only on one obvious one?
- Were depth decisions intentional rather than accidental?
- Did it avoid neighboring skill responsibilities?
- Did output format and language match the user's need?
- Did it choose a language strategy explicitly when the skill emits user-facing artifacts or templates?
- Would a project-visible template remain understandable to a human or weaker model without hidden context?
- Did it avoid depending on non-owned local context in public guidance?
- Did it avoid promoting an optional helper layer into a default standard layer without strong justification?
- If the skill owns a core document artifact, did it protect both purity and decision depth?

## Red Flags

- The description is so broad the skill triggers on ordinary tasks.
- The skill asks fixed questions after the user already supplied the answers.
- The skill loads all references by default.
- The skill has no explicit authority boundary despite risky actions.
- The skill promises a stable artifact but never defines the contract.
- The script layer is broad and policy-heavy instead of deterministic.
- The bundle structure can drift because support files are not wired back from `SKILL.md`.
- The design jumps straight to references/scripts/assets without a coverage pass.
- Every dimension gets deep treatment even though only one or two needed it.
- The skill duplicates another skill's job instead of routing.
- The skill has no wrong-scope behavior.
- The skill says it is mature without scenario evidence.
- The design relies on headings-only templates for project-visible artifacts.
- The design silently mixes public-facing and internal-working language expectations.
- The design creates a new standard layer when a helper-layer classification would be enough.

## Optional Subagent Validation

If subagents are available and the user wants stronger validation, ask an independent agent to run the pressure prompts against the skill without revealing your intended answer. Use this for reusable or high-impact skills, not tiny personal helpers.


## Built-in Regression Prompts

Use these as a smoke suite after changing Skill Architect.

### 1. Simple Skill Should Stay Simple

```text
Scenario: simple reference skill
Prompt: 帮我做一个读取 PDF 的 skill。
Expected behavior: recommend `simple` or light `references/`; ask at most a short intake if the output is unclear.
Must not: force multi-turn constrained menus or scripts by default.
Evidence to check: architecture is not heavier than the task.
```

### 2. Complex Interactive Skill Should Use Constraints

```text
Scenario: constrained interactive skill
Prompt: 帮我做一个需要多轮选项和冲突仲裁的 skill。
Expected behavior: recommend `constrained + references`; design fixed options, stop points, and lazy-loaded menu/report references.
Must not: put all menus into SKILL.md or skip validation scenarios.
Evidence to check: SKILL.md remains a router, references hold bulky menus.
```

### 3. Repeated Fragile Work Should Use Scripts

```text
Scenario: deterministic skill
Prompt: 帮我做一个批量检查 markdown frontmatter 的 skill。
Expected behavior: recommend `deterministic + guided`, with a script for parsing/validation.
Must not: rely only on prose for repeated fragile parsing.
Evidence to check: script has narrow inputs and predictable output.
```

### 4. Template-Shaped Output Should Use Assets

```text
Scenario: asset-backed skill
Prompt: 帮我做一个生成固定格式 PPT 的 skill。
Expected behavior: recommend `asset-backed + guided`, with templates/assets and output verification.
Must not: describe the whole template only in prose.
Evidence to check: assets are used without loading large files into context by default.
```

### 5. Authority-Sensitive Skill Should Design Risk Gates

```text
Scenario: authority-sensitive skill
Prompt: 帮我做一个会修改配置并发布结果的 skill。
Expected behavior: design explicit authority levels, confirmation gates, and verification before irreversible actions.
Must not: hide execution inside vague prose.
Evidence to check: risky steps are explicit in SKILL.md and support files only deepen the policy.
```

### 6. Wrong-Scope Request Should Route Away

```text
Scenario: wrong-scope request
Prompt: 帮我审查这个 Java 类怎么重构。
Expected behavior: do not use Skill Architect as the main workflow; route to an engineering/refactoring skill.
Must not: ask skill-design intake questions.
Evidence to check: boundary with neighboring skills is preserved.
```

### 7. Overspecified Request Should Skip Intake

```text
Scenario: overspecified skill request
Prompt: 创建一个名为 transcript-cleaner 的 skill，用 scripts/ 清理 JSONL transcript，用 references/ 记录字段规则，不需要交互，输出清理报告。
Expected behavior: skip intake and produce architecture or files directly.
Must not: ask the full intake again.
Evidence to check: uses provided name, layout, interaction model, and output.
```

### 8. Breadth-And-Depth Upgrade Should Stay Targeted

```text
Scenario: maturity upgrade
Prompt: 升级这个已有 skill，让它更成熟，但不要整体重写。
Expected behavior: run a breadth-and-depth pass, identify the weak dimensions, and deepen only the ones that materially improve the skill.
Must not: inflate every dimension or turn maintenance drift into a full redesign.
Evidence to check: coverage is explicit and depth choices are selective.
```

### 9. New Or Renamed Skill Should Stay Publishable

```text
Scenario: renamed public skill
Prompt: 把一个公开 skill 改个更短的名字，并补齐需要的文件。
Expected behavior: keep frontmatter YAML valid, keep the description concise, align agent metadata, and update public bundle surfaces such as README when they exist.
Must not: stop after renaming the folder and main file while leaving stale ids, invalid YAML, or missing index updates.
Evidence to check: the renamed skill is internally consistent and publicly enumerable.
```
