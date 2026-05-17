# Example Flow

Load this when you need a concrete end-to-end sample after the main workflow and references still leave the desired interaction shape unclear.

This example is illustrative. Keep the actual session in the user's working language and adapt labels accordingly.

A user says: "我想给餐厅做一个智能客服系统。"

## Step 1: Reframe And Diagnose

Restate:

```text
你现在的原始想法是：给餐厅做一个智能客服系统。
我先不直接接受“智能客服系统”这个方案词，而是先把它翻回它真正要解决的问题。
```

Ask hypothesis-driven questions:

```text
Q1. 这个产品最核心的目标更接近哪一个？
A. 减少高峰期人工接待压力
B. 提高点餐/咨询响应速度
C. 降低点错、漏单、过敏误导等错误
D. 扩展到非营业时间也能接待客户
```

```text
Q2. 第一优先用户是谁？
A. 扫码点餐的堂食顾客
B. 打电话或发消息咨询的顾客
C. 餐厅前台/服务员
D. 连锁餐厅的运营管理者
```

## Step 2: Diverge

Pick relevant lenses:

- First principles: customer service = understand need -> find answer or item -> complete transaction -> handle exception.
- Technology-neutral reframing: not "AI chatbot", but "let customers get correct answers and place safe orders without waiting for staff".
- Failure mode: allergy, refund, order modification, unavailable dishes, hallucinated policies.

Expanded possibility space:

```text
方向 A: FAQ-only assistant, low risk and easy to launch.
方向 B: guided ordering assistant, more value but needs menu/inventory integration.
方向 C: exception triage assistant, focuses on staff handoff and risk reduction.
方向 D: full autonomous ordering, highest value but unacceptable risk unless guardrails are strong.
```

## Step 3: Converge

Trade-off table:

```markdown
| 维度 | 保守方案 | 进取方案 | 推荐 |
| --- | --- | --- | --- |
| 首版范围 | FAQ + 人工转接 | 完整点餐闭环 | 从 FAQ + 点餐意图识别开始，过敏/退款/修改订单必须转人工 |
| 数据依赖 | 静态菜单和政策 | 实时库存、订单、会员系统 | 先接静态菜单，后续再接实时系统 |
| 风险控制 | 只回答低风险问题 | 自动处理交易和异常 | 高风险动作必须确认或转人工 |
```

If the user accepts the recommendation, produce a Product Brief in Chinese.

## Step 4: Handoff

Inline by default:

```text
产品简报已完成，可以交给下游文档/规划流程消费。
```

Save only if the project has a docs workflow or the user asks to persist it:

```text
已保存到 docs/discovery/PRODUCT_BRIEF.md，状态为“待下游消费”。
```

## Short Counterexample: Already Planning-Ready

If the user says:

```text
方向已经定了，帮我整理成 PRD 和 technical design。
```

Do not reopen broad exploration. Hand off fast:

```text
这已经不是“先追回问题定义”的场景了，方向已经足够稳定，更适合进入下游文档/规划流程。
如果你愿意，我下一步会按规划类工作来整理 PRD、technical design 和后续交接材料。
```

## Short Counterexample: Generic Ideation Or Naming

If the user says:

```text
帮我脑暴几个产品名字，或者随便想几个有意思的方向。
```

Do not pretend this is `product-explore`:

```text
这还不是一个明确的产品机会重构场景，更像泛 ideation / naming。
我不会把它硬接成 Product Brief 流程；应该先做更宽松的创意发散，或者先明确你想解决的具体产品问题。
```

## Short Counterexample: Existing Plan Under Challenge

If the user says:

```text
拿现有方案和 docs/code 对照拷打，看看哪里还站不住。
```

Do not rebuild the brief. Hand off to validation:

```text
这已经不是前置探索，而是拿既有方案去对照 docs/code 做压力测试。
我不会重开 Product Brief，而是应该进入下游的设计/领域校验流程，先找最危险的矛盾和边界问题。
```

## Short Lean Path: Overspecified Or Impatient

If the user says:

```text
别问太多，按这个方向快速给我一个 Product Brief，缺口你先标假设。
```

Use the lean path instead of reopening full divergence:

```text
我会走精简路径：先用一句话重述你当前的真实问题定义，再直接给出一个 lean Product Brief。
无法确认的用户、边界和成功信号我会明确标成 assumption 或 validation question，而不是假装它们已经成立。
```
