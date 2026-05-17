# Minimal Smoke Prompts

Load this when you need the cheapest useful live proof that `product-explore` still routes correctly on first response.

Use these prompts only after deterministic checks pass. Keep the runtime context snippet-first and stop as soon as the smallest narrow prompt proves the changed behavior clearly.

Default order:

1. `planning-ready`
2. `existing-plan-under-challenge`
3. one positive prompt: `premature-solution` or `ordinary-fuzzy-direction`
4. use `generic-ideation-or-naming` only when route-away behavior is the changed surface
5. use `overspecified-or-impatient` only when the lean path is the changed surface

If the first narrow prompt already proves the owner and first move clearly, stop. Escalate only when a narrow prompt stays ambiguous or the change touched broader routing or cadence.

```text
Prompt 1: Use $product-explore. 方向已定，帮我写 PRD 和 technical design。只返回两行：
owner: <one line>
first_move: <one line>
Pass if: owner routes to documentation or planning rather than product exploration, and first_move does not reopen broad discovery.
```

```text
Prompt 2: Use $product-explore. 拿现有方案和 docs/code 对照拷打，看看哪里还站不住。只返回两行：
owner: <one line>
first_move: <one line>
Pass if: owner routes to design validation rather than product exploration, and first_move does not rebuild the Product Brief.
```

```text
Prompt 3: Use $product-explore. 我想做一个 AI assistant。只返回两行：
owner: <one line>
first_move: <one line>
Pass if: owner stays with product exploration, and first_move restates the idea in problem language instead of jumping straight into solution divergence.
```

```text
Prompt 4: Use $product-explore. 我有个产品方向，但用户和边界还没想清。只返回两行：
owner: <one line>
first_move: <one line>
Pass if: owner stays with product exploration, and first_move starts by clarifying problem, user, value, or boundary rather than writing a brief immediately.
```

```text
Prompt 5: Use $product-explore. 帮我脑暴几个产品名字，或者随便想几个有意思的方向。只返回两行：
owner: <one line>
first_move: <one line>
Pass if: owner routes away from product exploration, and first_move does not pretend this is a Product Brief intake.
```

```text
Prompt 6: Use $product-explore. 别问太多，按这个方向快速给我一个 Product Brief，缺口你先标假设。只返回两行：
owner: <one line>
first_move: <one line>
Pass if: owner stays with product exploration, and first_move chooses the lean brief path with explicit assumptions instead of forcing a full intake.
```
