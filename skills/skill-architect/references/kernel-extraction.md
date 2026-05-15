# Skill Architect Kernel Extraction

Load this when designing or redesigning one skill and the kernel is not yet explicit.

This file has one job: compress the skill idea into the smallest teachable core before you decide sections, references, scripts, assets, or bundle shape.

If the request is too fuzzy to do that honestly, load `design-intake.md` only long enough to gather the missing inputs, then come back here immediately.

Do not skip this step by jumping straight to `design-expansion.md`, `component-paths.md`, or `bundle-design.md`.

## Required Output

Produce exactly these five lines before structural design:

```text
Kernel sentence: This skill exists to ...
Trigger boundary: It should trigger when ...
First move: Its first move is ...
Strongest thing: It is strongest when ...
Not-this-skill-if: If this is not true, this is not the right skill.
```

These lines are the minimum architecture output. A bundle draft without them is not ready.

## Compression Standard

Each line should pass these checks:

- short enough to teach back quickly
- specific enough to exclude neighboring skills
- strong enough that a weaker model could act on it
- stable enough to survive later section or bundle changes

If one line needs a paragraph to work, the kernel is probably still blurry.

## How To Extract The Kernel

1. Name the owned job:
   - what job this skill owns that a neighboring skill should not own
   - what exact user request or failure pattern should trigger it

2. Name the first move:
   - what the skill should do before deeper branching, menus, or supporting components appear
   - prefer one concrete move, not a bag of options

3. Name the strongest thing:
   - what this skill does unusually well compared with a generic prompt, adjacent skill, or plain documentation
   - if you cannot answer this sharply, do not expand structure yet

4. Draw the negative boundary:
   - what must be true for this skill to be the right owner
   - if that condition is false, where should the work go instead

5. Stress the compactness:
   - if two of the five lines are secretly saying the same thing, compress again
   - if one line only describes packaging, file layout, or explanation style, it is not kernel yet

## Kernel Failure Modes

- the design starts from sections or bundle parts before stating the kernel
- the trigger sounds broad, but the strongest thing stays vague
- the first move is really a menu of possibilities instead of one owned opening action
- the strongest thing is actually just "it is thorough" or "it is well structured"
- the wrong-scope boundary cannot be said without naming several examples
- the kernel only describes packaging such as `references/`, `scripts/`, or report sections

## Next Hop

- if the request is too fuzzy to fill the five lines, go to `design-intake.md`, then return here
- if the five lines are explicit and stable, go to `design-expansion.md` only when multidimensional expansion is still needed
- if the kernel is explicit and the next question is already about owner component or bundle shape, go directly to the narrower owner reference instead of forcing expansion

## Pressure Prompts

```text
Prompt: Design a reusable skill for making vague workflows safer.
Expected behavior: produce the five kernel lines before proposing sections, references, or scripts.
```

```text
Prompt: This draft already has SKILL.md sections and two references, but I still cannot tell what the skill is strongest at. What is the next move?
Expected behavior: stop structural design and return to kernel extraction until the strongest thing becomes explicit.
```
