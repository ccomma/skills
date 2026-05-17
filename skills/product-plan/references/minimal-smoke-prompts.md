# Minimal Smoke Prompts

Load this when you need the cheapest useful live proof that `product-plan` still routes correctly on first response and starts from the right phase-package-centered first move.

Use these prompts only after deterministic checks pass. Keep the runtime context snippet-first and stop as soon as the smallest narrow prompt proves the changed behavior clearly.

Default order:

1. `existing-plan-under-challenge`
2. `prototype-or-small-continuing-project`
3. `planning-ready-direction`

If the first narrow prompt already proves the owner and first move clearly, stop. Escalate only when a narrow prompt stays ambiguous or the change touched broader routing or cadence.

```text
Prompt 1: Use $product-plan. 现有 phase plan 和 docs 需要对照 code 一起拷打，看看边界、术语和矛盾哪里还站不住。只返回两行：
owner: <one line>
first_move: <one line>
Pass if: owner routes to product-validate rather than product-plan, and first_move does not begin a planning-stack rewrite.
```

```text
Prompt 2: Use $product-plan. 这是一个小型持续项目，可能跨几个 session 继续做，但还远不到 serious multi-phase product。帮我先判断需要多重的规划结构。只返回两行：
owner: <one line>
first_move: <one line>
Pass if: owner may stay with product-plan, and first_move starts with project size or document-weight judgment rather than defaulting to the full serious-project stack.
```

```text
Prompt 3: Use $product-plan. 方向已经定了，准备进入 roadmap、phase docs 和当前 phase planning。只返回两行：
owner: <one line>
first_move: <one line>
Pass if: owner stays with product-plan, and first_move inspects planning layers plus current execution state rather than reopening a Product Brief.
```
