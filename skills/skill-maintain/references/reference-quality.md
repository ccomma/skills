# Skill Maintain Reference Quality

Load this when auditing or repairing references inside one skill bundle.

## Routing Position

- common upstream:
  - `reference-routing.md`
  - `repair-expansion.md`
- if the real question is owner component, jump to `component-paths.md`
- if the real question is bundle-wide drift, jump to `bundle-consistency.md`
- if the reference issue is only one symptom inside a broader repair, jump back to `repair-expansion.md`

## What To Check

Check three things:

1. **opening clarity**
   - can a weaker model tell when to load the file and what single job it does
   - do the title, opening, and body all point at that same load question

2. **boundary clarity**
   - is the file deepening one part of the main path instead of repeating it
   - do two references answer different load questions
   - is the file reachable from the main skill through a clear load condition

3. **necessity**
   - delete challenge: what exact burden returns if this file disappears
   - merge challenge: what exact collision appears if it merges with its nearest neighbor
   - cost challenge: what token, read, maintenance, or drift cost it adds, and why that cost is worth paying

## Repair Patterns

### 1. Rewrite The Opening

If the top of the file does not make load condition plus job obvious, rewrite the opening before touching deeper prose.

### 2. Merge Duplicates

If two references answer the same question or are usually loaded together for the same reason, merge them or sharply separate their jobs.

### 3. Split Mixed Jobs

If one file mixes unrelated responsibilities, split it by load question, not by document length alone.

### 4. Remove Storage-Bin Drift

If a reference is only holding overflow explanation, either cut it or move the real judgment back into the main skill surface.

### 5. Run The Necessity Challenge

If a file cannot answer "why not delete me", "why not merge me", and "why is this cost worth it", it is probably not a real reference boundary yet.

## Regression Prompts

```text
Prompt: These two references both explain when to load examples and how to choose one. Repair the support layer.
Pass if: either the files merge or their jobs become clearly distinct.
```

```text
Prompt: This reference starts with a page of explanation, but I still do not know when to load it. Repair it.
Pass if: the opening makes the load condition and single job obvious without directory browsing.
```

```text
Prompt: This reference sounds reasonable, but I cannot tell what exactly breaks if it disappears or merges with the closest neighboring reference. Repair the reference layer.
Pass if: the answer either defends the file with a precise burden, merge collision, and cost justification or removes/merges it.
```
