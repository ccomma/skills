# Skill Architect Pressure Tests

Load this when you are about to call a reusable skill mature, or when the user asks whether a skill is actually robust.

A pressure test is a realistic prompt or situation designed to reveal whether the skill triggers correctly, asks the right amount, avoids neighbor overlap, and preserves token efficiency.

The deeper goal is not "can this skill be improved from bad version A to better version B". The deeper goal is "does this design already obey the properties of a strong skill, and does it prevent the known weak-skill patterns from being designed in the first place".

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
9. **Bundle pressure** — references and other bundle components should stay aligned and reachable.
10. **Output-contract pressure** — required sections, fields, or artifacts should be intentionally designed rather than implied.
11. **Breadth/depth pressure** — the design should scan major dimensions and deepen only the ones that matter.
12. **First-turn pressure** — the design should make the first move and multi-turn cadence explicit when the skill's power depends on interaction.
13. **Sharpness pressure** — the design should resist redundant sections, late workflow, and explanatory weight that makes the skill read like a document instead of a tool.
14. **Section-ownership pressure** — top-level sections should not compete for the same job.
15. **Real-test pressure** — skill writes should define the smallest real smoke test and the reason if live behavior cannot be exercised.
16. **Principle-closure pressure** — strong-sounding principles should map to an enforcement path instead of floating as slogans.
17. **Component-necessity pressure** — each surviving reference, script, format file, asset, or metadata layer should survive a delete challenge, a merge challenge, and a cost challenge.
18. **Systematization pressure** — related judgments should collapse into a stable system of routes, layers, or rules instead of remaining as scattered local patches.
19. **Kernel-clarity pressure** — the design should state the kernel sentence, first move, strongest thing, and wrong-scope sentence before structural expansion.
20. **Kernel-protection pressure** — later structure choices should be able to explain whether they protect the kernel or only improve explanation comfort.
21. **Public-positioning pressure** — frontmatter, first-screen language, metadata, and supporting docs should all describe the same kernel-first identity.

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
- Could the design state the kernel sentence, trigger boundary, first move, strongest thing, and wrong-scope sentence without falling back to structural prose?
- Did it choose the right interaction strength?
- Did it choose the right interaction intensity?
- Did it make the first move explicit instead of leaving it to chance?
- If the skill depends on questioning pressure, did it define one-question cadence, trunk persistence, and when summaries are allowed?
- Did it avoid redundant sections whose only job is to restate frontmatter or adjacent sections?
- Did each top-level section own a different primary responsibility?
- Did each durable principle close through a step, hard rule, deterministic check, pressure test, or smoke test?
- Did the design turn repeated local judgments into a coherent system instead of merely shortening them?
- Did each surviving component survive a delete challenge, a merge challenge, and a cost challenge?
- Did expansion happen only after the kernel became explicit?
- Can each surviving component explain whether it protects kernel clarity, kernel stability, kernel verification, or only explanation comfort?
- Would the top of the file tell a weaker model what to do before the explanatory text takes over?
- Does each surviving section have a unique job that would be missed if removed?
- Did the design avoid completeness theater such as template sections that survive without a real failure mode behind them?
- Did it avoid unnecessary questions?
- Did it avoid acting before required confirmation?
- Did it load references/scripts/assets only when justified?
- Did scripts have narrow deterministic jobs and compact outputs?
- Did the design explicitly scan major dimensions instead of focusing only on one obvious one?
- Were depth decisions intentional rather than accidental?
- Did it avoid neighboring skill responsibilities?
- Did frontmatter, first-screen language, metadata, and public docs all describe the same kernel-first identity?
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
- The bundle structure can drift because references are not wired back from `SKILL.md`.
- The design looks complete, but the kernel sentence or strongest thing is still fuzzy.
- The design jumps straight to structural expansion before kernel extraction.
- The design jumps straight to references/scripts/assets without a design-expansion pass.
- Every dimension gets deep treatment even though only one or two needed it.
- The skill duplicates another skill's job instead of routing.
- The skill has no wrong-scope behavior.
- The skill says it is mature without scenario evidence.
- The skill is supposed to grill or validate, but it never states whether it should ask one question at a time or keep pushing the same trunk branch.
- The workflow starts too late because overview, boundary, or usage prose swallowed the hot path.
- One path step keeps stacking bullets that are really the same decision with slight condition changes instead of collapsing them into one sharper rule.
- A runtime or capability checklist names five toggles, but they are all just one operational mode that should be expressed once at a higher level.
- The design removed a few duplicates, but the remaining rules still do not add up to a clear system of routes, layers, or governing decisions.
- A supposedly generic rule still hardcodes one brand, one local runtime, or one machine-specific example instead of keeping that detail in adapter-specific material.
- The design keeps sections such as Overview, When To Use, Response Language, or Artifact Contract without proving they add behavior here.
- The design can explain how it improved a bad skill, but still cannot state the properties a strong skill must satisfy.
- `what-to-do`, `workflow`, `boundaries`, or `rules` are all talking about the same job with different wording.
- The design says "test after writing" but never defines the smallest real smoke test or the fallback when no runtime is available.
- The design contains strong principles, but some of them are not backed by any concrete enforcement path.
- A reference exists, but the design never explains what hot-path burden it removes.
- A reference exists, but the design cannot say why repeated local component placement would not already be enough.
- A component exists, but the design cannot say what cost it adds and why that cost is worth paying.
- The design can name sections and references, but cannot answer what the skill is strongest at.
- A component survives even though deleting it would only cost explanation comfort.
- The public sentence still describes a bundle designer even though the real workflow is kernel-first.
- The design relies on headings-only templates for project-visible artifacts.
- The design silently mixes public-facing and internal-working language expectations.
- The design creates a new standard layer when a helper-layer classification would be enough.

## Optional Subagent Validation

If subagents are available and the user wants stronger validation, ask an independent agent to run the pressure prompts against the skill without revealing your intended answer. Use this for reusable or high-impact skills, not tiny personal helpers.

## Minimal Live Smoke

For small component or reference changes, load `minimal-smoke-prompts.md` instead of running this whole suite.

```text
Scenario: abstract rule leaked into a concrete brand
Prompt: This supposedly generic skill rule says "Treat BrandX as one adapter" and then explains the policy through BrandX-only wording. Repair it.
Expected behavior: move the brand-specific detail into adapter-specific material and restate the governing rule in runtime-neutral terms.
Must not: keep one vendor or one local runtime name inside the generic governing rule.
Evidence to check: the repaired rule still teaches the same policy without depending on one named runtime.
```

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
Evidence to check: risky steps are explicit in SKILL.md and references only deepen the policy.
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
Expected behavior: keep the existing kernel if it is still strong, run a design-expansion pass, identify the weak dimensions, and deepen only the ones that materially improve the skill.
Must not: inflate every dimension or turn maintenance drift into a full redesign.
Evidence to check: coverage is explicit and depth choices are selective.
```

### 9. Interactive Grilling Skill Must Define Cadence

```text
Scenario: grilling workflow
Prompt: 帮我设计一个会持续拷打现有方案、直到关键边界说清楚的 skill。
Expected behavior: define the first move, one-question cadence, trunk persistence, concrete counterfactual follow-ups, and the stop condition for switching into summary.
Must not: only say "ask good questions" while leaving cadence and anti-summary behavior implicit.
Evidence to check: the main file makes the interaction contract obvious near the top.
```

### 10. New Or Renamed Skill Should Stay Publishable

```text
Scenario: renamed public skill
Prompt: 把一个公开 skill 改个更短的名字，并补齐需要的文件。
Expected behavior: keep frontmatter YAML valid, keep the description concise, align agent metadata, and update public bundle surfaces such as README when they exist.
Must not: stop after renaming the folder and main file while leaving stale ids, invalid YAML, or missing index updates.
Evidence to check: the renamed skill is internally consistent and publicly enumerable.
```

### 11. Fuzzy Skill Idea Must Yield A Kernel Before Structure

```text
Scenario: fuzzy skill idea
Prompt: Use $skill-architect. 帮我做一个让复杂工作流更稳的 skill。
Expected behavior: ask only enough intake to lock the kernel sentence, trigger boundary, first move, strongest thing, and wrong-scope sentence before proposing sections or companion files.
Must not: jump directly to references, scripts, or bundle shape.
Evidence to check: the first architecture output is the kernel, not the structure.
```

### 12. Clear Skill Idea Should Lock Kernel Fast

```text
Scenario: already clear skill idea
Prompt: Use $skill-architect. 创建一个名为 prompt-router 的 skill；它只负责把模糊请求快速分流到正确工作流，第一步先判定 owner，不需要复杂交互。
Expected behavior: skip long intake, state the kernel quickly, then move into the lightest necessary structure decisions.
Must not: run a full interview after the kernel is already obvious.
Evidence to check: the kernel is explicit before any structural expansion, and intake stays short.
```

### 13. Complete Structure But No Strongest Thing Must Fail

```text
Scenario: structure looks complete but kernel is vague
Prompt: Use $skill-architect. 这个 draft 已经有 sections、references、scripts 了，但我还是说不出它最强的能力是什么。继续设计。
Expected behavior: stop structural work, return to kernel extraction, and refuse to treat expansion as a substitute for core definition.
Must not: keep refining sections while the strongest thing remains unclear.
Evidence to check: the next move is kernel repair, not more bundle growth.
```

### 14. Generic Initialization Should Stay Out Of Scope

```text
Scenario: generic skill creation request
Prompt: Use $skill-architect. 帮我初始化一个 skill folder，补齐 starter files 和基础结构。
Expected behavior: keep generic scaffolding out of this skill's core promise and either redirect that part or restate that this workflow starts after the boundary is clear and the kernel must be locked.
Must not: redefine skill-architect as a generic bundle initializer.
Evidence to check: the answer still frames kernel-first design as the primary job.
```

### 15. Skill Maturity Request Should Start From The Kernel

```text
Scenario: maturity request
Prompt: Use $skill-architect. 帮我把这个 skill 做成熟。
Expected behavior: start by clarifying one strong thing, trigger boundary, and first move before listing structural upgrades.
Must not: open with reference/script/asset expansion as the first answer.
Evidence to check: the first move is kernel-first even for a vague maturity request.
```

### 16. Existing Skill With Unclear Strongest Thing Must Not Skip Maintenance Boundary

```text
Scenario: maintenance comparison
Prompt: Use $skill-architect. 这个已有 skill 结构完整，但 strongest thing 说不清。现在该怎么做？
Expected behavior: distinguish between kernel drift inside an existing role and true role redefinition; do not silently swallow a maintenance-first case as if all such requests belonged here.
Must not: ignore the handoff boundary with skill-maintain.
Evidence to check: the answer explains when repair stays in maintenance and when it becomes redesign.
```

### 17. Public Identity Must Stay Consistent Across Entry Surfaces

```text
Scenario: public entry-surface audit
Prompt: Read the frontmatter description, first-screen intro, agent metadata, and README sentence for this skill. Do they all describe the same job?
Expected behavior: confirm a shared kernel-first identity or flag the drift explicitly.
Must not: accept one surface describing generic bundle design while another describes kernel locking.
Evidence to check: all entry surfaces describe the same first responsibility.
```

### 18. Lean Skill Should Not Read Like A Memo

```text
Scenario: anti-bloat redesign
Prompt: 重构这个 skill。它的问题不是事实错误，而是太啰嗦、重复、workflow 太晚、像文档不像 skill。
Expected behavior: design a thinner skeleton, keep the strongest behavior near the top, and justify every section that remains.
Must not: preserve redundant sections just because they look standard.
Evidence to check: the resulting design is shorter, sharper, and still behaviorally complete.
```

### 19. Section Ownership Must Be Explicit

```text
Scenario: section collision
Prompt: 这个 skill 的 what-to-do 和 workflow 都在讲步骤，rules 和 boundaries 也有部分重复。请重新设计。
Expected behavior: assign one primary job per top-level section and remove or merge overlapping text.
Must not: keep the same instruction repeated across two sections with cosmetic wording changes.
Evidence to check: a reader can explain each section's unique job in one sentence.
```

### 20. Component Must Survive Delete, Merge, And Cost Challenges

```text
Scenario: unnecessary component
Prompt: This skill has a reference, a script, and a format file whose jobs all sound plausible, but I cannot tell what exactly breaks if one disappears, merges, or is simply not worth its cost.
Expected behavior: defend each surviving component with a precise burden, merge collision, and cost justification, or remove/merge it.
Must not: keep a component only because its topic sounds like a sensible category.
Evidence to check: the answer names a concrete burden, a concrete merge collision, and a concrete cost justification for each surviving component.
```

### 21. Skill Write Must Define Minimal Real Testing

```text
Scenario: post-write validation
Prompt: 这个 skill 刚改完。请补充验证方案，但不要浪费太多 token。
Expected behavior: require deterministic bundle checks plus the smallest real smoke test through an available local runtime when possible; otherwise provide manual prompts and mark live behavior unverified.
Must not: stop at static checks alone or prescribe an oversized smoke suite by default.
Evidence to check: verification is real, scoped, and explicit about skipped live tests.
```

### 22. Principle Must Have Closure

```text
Scenario: slogan audit
Prompt: 这个 skill 里有很多强原则句。请检查哪些原则只是口号，哪些原则已经有执行闭环。
Expected behavior: map each durable principle to a workflow step, hard rule, deterministic check, pressure test, or smoke test; cut or operationalize the unsupported ones.
Must not: praise the wording quality without checking enforcement paths.
Evidence to check: unsupported principles are explicitly named instead of being left as "nice guidance".
```

### 23. Reference Must Earn Its Place

```text
Scenario: reference audit
Prompt: 这个 skill 有 references 和 scripts，但我怀疑它们只是为了看起来完整。请检查。
Expected behavior: name the one hot-path burden each reference removes; if none can be named, cut or merge it.
Must not: keep references only because similar skills often have them.
Evidence to check: every reference has a clear and compact justification.
```

### 24. References Must Own Different Questions

```text
Scenario: reference overlap
Prompt: 这两个 references 看起来都在回答“什么时候加载示例和变体规则”，但文件名不同。请检查。
Expected behavior: decide whether they truly own different load questions; if not, merge them or sharply separate their jobs.
Must not: keep both files merely because one is called examples and the other is called patterns.
Evidence to check: each surviving reference owns one clear load question and one primary job.
```
