# Divergence Lenses

Load this when Step 2 needs divergence lenses after Step 1 has already restated the idea in product-problem terms.

Use these lenses to widen the option space after the default reframe, not to replace the default reframe. Pick 2-3 based on the idea's risk profile. Do not apply every lens mechanically.

## Lens A: First-Principles Decomposition

Use when the user names a familiar solution too early, such as "recommendation system", "dashboard", "AI assistant", "workflow automation", or "marketplace".

Ask:

- What job is this solution really trying to perform?
- What are the irreducible inputs, decisions, and outputs?
- If the named technology did not exist, how would users solve this?
- Is the real problem the proposed feature, or a more basic friction underneath it?

Example:

```text
"I want a recommendation system"
-> What is a recommendation? Matching a user's latent need to an available option.
-> What signals reveal that latent need?
-> What if there is no historical data?
-> Is the problem "recommend items" or "reduce search friction"?
```

## Lens B: Technology-Neutral Reframing

Use when the idea contains technology words that might hide the real product need.

Ask the agent to restate the idea with no technology nouns:

- Not "build an AI chatbot" but "help customers get answers without waiting for a human"
- Not "add vector search" but "let users find similar things from rough descriptions"
- Not "use agents" but "complete multi-step work while checking intermediate results"

Then compare the technology-specific and technology-neutral versions. The gap often reveals cheaper, safer, or more useful alternatives.

## Lens C: Jobs-To-Be-Done

Use when user motivation is unclear or multiple user segments might want different outcomes.

Ask:

- When users reach for this product, what situation are they in?
- What progress are they trying to make?
- What workaround do they use today?
- What anxiety, habit, switching cost, or social pressure blocks adoption?

Output a compact job statement:

```text
When [situation], [user] wants to [make progress], so they can [desired outcome] without [current friction].
```

## Lens D: Adjacent Users And Scenarios

Use when the current user model feels too narrow.

Ask:

- Who benefits indirectly from this?
- Who pays, operates, supports, audits, or is harmed by it?
- What happens immediately before and after the core use case?
- What would the minimal, premium, and internal-operator versions look like?
- What changes if the same idea is deployed in a different industry or scale?

## Lens E: Failure Mode Exploration

Use when the idea has safety, trust, operational, compliance, reputational, or adoption risk.

Ask:

- What assumption, if false, kills the product?
- What is the worst credible user experience?
- What edge cases break the core value proposition?
- What would make a user churn after trying it once?
- What would a competitor or substitute do to make this irrelevant?

Separate:

- product failure
- UX failure
- business failure
- operational failure
- technical failure

## Lens F: Constraint Removal And Reintroduction

Use when constraints may be causing premature convergence.

Ask:

- What if budget, time, latency, staffing, or platform limits disappeared?
- Which unconstrained idea reveals the real ambition?
- Which part can be kept inside the actual constraints?
- Which constraint is real, and which is only habit?

Then reintroduce constraints one by one and keep the strongest surviving option.

## Lens G: Quantitative Framing

Use when success is vague or the user is unsure whether the opportunity is worth building.

Ask:

- How often does the problem occur?
- How painful is each occurrence?
- How many people experience it?
- What current cost, delay, error rate, drop-off, or manual effort exists?
- What improvement would make this worth the effort?

If no real data exists, label the numbers as assumptions and move them to validation questions.

## Lens H: Adoption And Distribution

Use when the idea might be valuable but hard to get used.

Ask:

- How will the first users discover this?
- What existing workflow must change?
- What switching cost or trust hurdle blocks adoption?
- Who has to approve, configure, or champion it?
- What is the smallest moment of value a user can experience quickly?

This lens protects against products that are useful in theory but never enter the user's actual routine.
