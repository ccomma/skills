# Abstraction Rules

Use this when converting a concrete problem into a reusable governance failure mode.

## Principle

Abstract the failure pattern, not the surface noun.

The goal is to produce a rule that:

- explains the current issue
- can apply to future similar issues
- stays portable across runtimes and repositories
- does not overfit one user's local setup

## Good Abstraction Moves

Prefer:

- ownership drift
- portability leakage
- local-context leakage
- language-strategy drift
- template self-descriptiveness failure
- thin-but-correct core artifact
- helper-layer misplacement
- entrypoint-role blur
- governance-layer overreach

Over:

- "this one file mentions X"
- "never write Y exact filename"
- "fix this one template heading"

## Red Flags

The abstraction is too concrete when it:

- names one private tool, path, or workflow as the rule itself
- only fits one repository
- can be replaced by "do not repeat this exact accident"

The abstraction is too broad when it:

- would require redesigning several layers to fix one local issue
- cannot explain what evidence would falsify it
- turns one symptom into a universal ban

## Compression Test

After naming the failure mode, ask:

1. Could this rule be understood without knowing the original filename?
2. Could it apply to another repository with different names?
3. Does it still point to a concrete repair direction?
4. Would the rule still make sense if the exact tools changed?

If any answer is "no", narrow or rename the abstraction.
