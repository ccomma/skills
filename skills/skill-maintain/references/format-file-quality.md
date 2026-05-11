# Skill Maintain Format File Quality

Load this when auditing or repairing a companion format file such as `ADR-FORMAT.md`, `CONTEXT-FORMAT.md`, handoff formats, report templates, or other artifact-shape references.

## Audit Questions

Check the format file directly:

1. Does it govern one clear artifact?
2. Does it define the smallest useful good shape?
3. Does it say what is required versus optional?
4. Does it say when the artifact should not be created?
5. Does it fit the owning document layer instead of creating parallel truth?
6. Could a weaker model follow it and still produce a decent artifact?

## Common Failure Modes

- **Bureaucratic template**: too many sections, too little value
- **Threshold-free template**: describes shape but never says when to create the artifact
- **Parallel-truth template**: encourages writing into a side document that should not own the decision
- **Example takeover**: examples are more specific than the rule, so the example becomes the real contract
- **Weak-model fragility**: a weaker model following the file would produce fluff, boilerplate, or overlong output
- **Drift from parent skill**: the format file no longer matches the owning skill's artifact contract

## Repair Moves

Use the smallest repair that works:

- reduce the template to the smallest high-value structure
- add explicit "when not to use this" guidance
- add required versus optional distinctions
- add owning-layer mapping
- replace long examples with one smaller, higher-signal example or no example
- move generic workflow explanation back out of the format file if it belongs in `SKILL.md`

## Quality Regression Prompts

Pressure-test a repaired format file with:

- a minimal strong artifact
- an overbuilt artifact that should be simplified
- a wrong-scope artifact that should be rejected
- a weak-model draft that tends toward empty filler

If the repaired file still invites filler or ritualized structure, it is not done.
