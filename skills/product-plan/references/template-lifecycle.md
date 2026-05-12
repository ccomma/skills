# Template Lifecycle

Use this when deciding whether to create, refresh, or defer project-visible templates in `docs/templates/`.

## Principle

Templates are long-lived anti-drift assets, not one-time scaffolding.

Project-visible templates should be light but self-describing. They are not merely heading dumps.

They do not replace the skill's own companion format references. The skill-level references define the reusable rule. The project-visible templates localize that rule into a project-specific skeleton that humans and future agents can fill without guessing.

## When To Create Templates

Create project-visible templates when:

- the project is clearly in the serious or larger tiers
- phase artifacts repeat with meaningful structure
- multiple writers or runtimes may generate similar documents
- structure drift is already visible or highly likely

## When Not To Create Templates

Avoid creating templates when:

- the project is still lightweight or exploratory
- there is no repeated artifact family yet
- the template would be mostly speculative

## Refresh Rule

Refresh templates when:

- current high-quality documents have evolved past the template
- the template omits governance layers now considered standard
- the template is too skeletal for a human or weaker model to use without guessing
- structure drift keeps recurring because the template is stale

## Drift Rule

If repeated artifacts are diverging in weak ways, strengthen the template.

If repeated artifacts are evolving in strong project-specific ways, refresh the template to match reality instead of forcing reality backward.

## Minimum Template Rule

A mature project-visible template should usually include:

- the smallest good section structure
- one short explanation or cue for each important section
- enough context to keep the artifact in the right owning layer

Avoid:

- headings only with no guidance
- copying the full parent reference into the template
- turning the template into a second handbook
