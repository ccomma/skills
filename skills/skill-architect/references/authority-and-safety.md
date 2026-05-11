# Skill Architect Authority And Safety

Load this when designing a skill that may edit, execute, install, delete, publish, persist, or otherwise cross a meaningful authority boundary.

## Design Questions

- What is the highest authority level this skill should hold: suggest, draft, edit, execute, install, delete, approve, persist, publish?
- Which actions require user confirmation or a stop point?
- Which risky actions should be explicit rather than hidden inside broad verbs?
- What safety or verification wording must stay in `SKILL.md` instead of being buried in optional references?

## Design Patterns

### 1. Make Authority Visible

If the skill changes files, settings, shared artifacts, or external systems, say so plainly. Do not hide execution in vague verbs such as "handle" or "take care of."

### 2. Keep Risk Gates Close To The Trigger

Authority boundaries and confirmation gates usually belong in `SKILL.md`, not only in references, because they protect the default path.

### 3. Separate Low-Risk Flow From High-Risk Flow

Use lighter, faster paths for safe work and explicit pauses for risky work. Do not force the whole skill into high friction if only one branch is dangerous.

## Pressure Prompts

```text
Prompt: Design a skill that can publish release notes and push tags.
Expected design: explicit authority boundary, confirmation before publishing, and verification before irreversible actions.
```
