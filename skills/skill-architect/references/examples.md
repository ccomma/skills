# Skill Architect Examples

Load this when examples would help choose or explain a skill architecture. Keep examples short; adapt them to the user's domain instead of copying blindly.

## Example 1: Simple Reference Skill

Use when the skill only teaches a narrow recurring convention.

```text
Profile: simple
Layout: SKILL.md only
Why: no multi-step intake, no long variants, no fragile operations
```

Good shape:

- frontmatter trigger is specific
- body has 3-7 rules
- no references unless examples grow large
- no fixed options

Failure to avoid: adding menus or scripts for a task that only needs a short rule.

## Example 2: Constrained Interactive Skill

Use when users often do not know what choice matters, or wrong scope wastes time.

```text
Profile: constrained + references
Layout:
- SKILL.md: rules and state machine
- references/interaction.md: fixed option menus and report template
```

Good shape:

- asks fixed-scope questions before expensive work
- each menu has a recommended option and risk/cost notes
- option meanings stay stable across languages
- body reads only selected references

Failure to avoid: hardcoding one domain's vocabulary into a supposedly general skill.

## Example 3: Deterministic Script-Backed Skill

Use when repeated filesystem, parsing, conversion, or validation work is easy to get subtly wrong.

```text
Profile: deterministic + guided
Layout:
- SKILL.md: when to run and safety rules
- scripts/: deterministic helper
- references/: edge cases and interpretation rules
```

Good shape:

- script handles the fragile repeated operation
- prose explains when to run it and how to interpret output
- validation command is explicit
- script has narrow inputs and predictable output

Failure to avoid: making the model rewrite fragile parsing logic every time.

## Example 4: Asset-Backed Output Skill

Use when the output should follow a reusable structure or visual/resource template.

```text
Profile: asset-backed + guided
Layout:
- SKILL.md: workflow and asset selection rule
- assets/: templates, starter files, media, boilerplate
- references/: style or adaptation rules
```

Good shape:

- assets are copied or transformed, not loaded as long context by default
- references explain how to adapt assets
- output verification checks the final artifact, not just the text description

Failure to avoid: describing a template in prose when a real template file would be more stable.


## Example 5: Wrong-Scope Request

Use when testing that Skill Architect does not take over work it should route away.

```text
Prompt: Help me refactor this Java class.
Expected profile: none; route to a code architecture/refactoring skill.
Why: the user is not asking to design or upgrade a skill.
```

Good shape:

- refuses to design a skill when the task is normal implementation work
- names the neighboring skill category if obvious
- does not create intake questions for unrelated work

Failure to avoid: treating every structured work request as a skill-design request.
