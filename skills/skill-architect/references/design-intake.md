# Skill Architect Design Intake

Load this when the user's skill request is too underspecified to extract the kernel honestly.

This file does not own full skill design. Its job is to gather the missing inputs needed for `kernel-extraction.md`.

Render questions in the user's language. Keep option ids stable.

## Quick Intake

Ask these together when the request is mostly clear:

1. What should this skill exist to do?
2. What usually goes wrong without it?
3. What should it do first when triggered?
4. What is the strongest thing it should be especially good at?
5. What should clearly stay out of scope?
6. Are there neighboring skills it must avoid overlapping with?

## Full Intake

Use for broad, risky, reusable, or previously failed ideas when the kernel cannot yet be stated cleanly.

### A. Kernel Inputs

- What user request should trigger this skill?
- What single job should it own?
- What should it do first?
- What makes it stronger than a generic assistant answer?
- What is explicitly out of scope?

### B. Failure Modes

- What mistakes should this skill prevent?
- Does the task often suffer from vague scope, wrong defaults, weak first move, unsafe actions, or skill overlap?
- Which failure most needs the kernel to guard against?

### C. Interaction Strength

Offer fixed options:

- `A. simple` — no questions; use when the task is narrow and safe.
- `B. guided` — flexible sequence; use when expert judgment matters.
- `C. constrained` — fixed options and stop points; use when choices are ambiguous, risky, or often mishandled.
- `D. deterministic` — scripts/tools; use when repeated work must be exact.
- `E. asset-backed` — templates/assets; use when output shape matters.
- `F. recommend for me` — infer from failure modes and output needs.

Do not use this section to pick the bundle yet. Use it only to clarify what the first move and strongest thing must support.

### D. Boundary Inputs

- Which existing skills are adjacent?
- What should this skill own?
- What should it explicitly hand off to another skill?

### E. Kernel Readiness Check

Before leaving intake, confirm you can now state:

- `kernel sentence`
- `trigger boundary`
- `first move`
- `strongest thing`
- `not-this-skill-if...`

If not, keep intake focused on the missing line only.

When the missing lines are filled, return to `kernel-extraction.md` immediately. Do not jump from intake straight into structural expansion.

## Intake Shortcuts

Skip intake when the user already provides:

- skill name
- trigger conditions
- owned job
- boundaries
- first move
- strongest thing

Do not force fixed options when they add more work than they save.
