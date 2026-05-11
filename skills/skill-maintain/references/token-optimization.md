# Skill Maintain Token Optimization

Load this when token/context cost is the primary failure mode. Use it to restore the stronger optimization workflow that protects decision quality while reducing load.

## Cost Model

Separate these layers:

- **default cost**: frontmatter plus `SKILL.md` loaded on trigger
- **conditional cost**: references, scripts, assets, and extra reads loaded only when justified
- **conversation cost**: repeated verbose interaction during long workflows
- **coordination cost**: overlap with neighboring workflows causing duplicate loading or repeated explanations

Optimize in that order.

## Strong Optimization Moves

### 1. Progressive Disclosure

Keep in `SKILL.md`:

- trigger boundary
- non-goals and neighboring workflows
- core rules
- workflow skeleton
- explicit load conditions for references
- output shape

Move to `references/`:

- long examples
- detailed checklists
- fixed menus
- troubleshooting catalogs
- pressure tests
- report templates

### 2. Adaptive Verbosity

For long-running maintenance sessions:

- start detailed when ambiguity or risk is high
- switch to compact wording after repeated agreement
- expand again when the user disagrees, asks for reasoning, or the next step touches safety, persistence, or routing boundaries

### 3. Batch Low-Risk Decisions

Use batches only when decisions are independent and low risk. Keep one-question-at-a-time flow for sequential, safety-sensitive, or architecture-sensitive choices.

### 4. Trigger Tightening

Descriptions should say when the skill should load, not summarize every step it might take. If the skill starts matching generic editing or general prompt work, narrow it.

### 5. Reference Routing

Each reference should have a one-hop load condition. Avoid vague rules like "read references as needed" when the skill has several modules.

### 6. Script Extraction

Move repeated or fragile operations into scripts when prose causes token waste or inconsistent execution, such as:

- counting lines or sections
- validating layout
- comparing metadata
- checking broken links
- generating compact reports

## High-Risk Token Changes

Treat these as risky and validate explicitly:

- broadening or narrowing the frontmatter description
- removing examples that disambiguate behavior
- turning a sequential flow into batch mode
- moving safety or verification rules into optional references
- deleting routing guidance

## Optimization Plan Template

```text
Target:
Main cost drivers:
Capability baseline:
Recommended changes:
- Safe:
- Moderate:
- Risky:
Expected token impact:
Decision-quality risks:
Regression tests:
```
