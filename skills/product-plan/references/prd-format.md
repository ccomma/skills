# PRD Format

Use this when creating or repairing a phase PRD.

## Purpose

The PRD explains what the phase must deliver, for whom, and how success will be judged.

It is not the place for module internals, storage choices, or detailed implementation sequencing.

## Required Structure

```text
Phase objective
Problem or opportunity
Users, operators, or consumers
In scope
Out of scope
Key use cases or workflows
Requirements
Acceptance criteria
Dependencies or assumptions
```

## Required Quality Bar

- The objective should align with the roadmap phase goal.
- Requirements should be testable and specific enough to drive technical design.
- In-scope versus out-of-scope should reduce later debate.
- Acceptance criteria should describe externally meaningful success, not only internal tasks.

## Anti-Patterns

Avoid:

- describing class structure or storage design here
- replacing acceptance criteria with implementation tasks
- letting discovery notes remain unfiltered inside the PRD
- making the PRD so broad that phase boundaries disappear
