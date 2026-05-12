# Quality Bars

Use this when the user wants cross-project consistency, higher professional quality, or when document roles are drifting even if the basic file set exists.

## Principle

Structural completeness is not enough. A mature document system needs consistent quality, not just consistent filenames.

Use these bars to judge whether a document is merely present or actually doing its job well.

## README.md

Good:

- helps a new reader understand what the project is and where to go next
- gives a clear reading path for different readers
- stays focused on project entry, quickstart, and navigation

Bad:

- acts as current-phase status
- copies long design rationale
- absorbs docs-namespace governance

## DESIGN.md

Good:

- explains why the project exists, who it serves, and what long-term boundaries matter
- contains real judgment and tradeoffs, not only aspiration
- explains which paths were not chosen and why the chosen route is the right long-term fit
- makes risk acceptance and non-goals explicit where they matter
- feels worth reading in depth because it stores durable product and architecture thinking

Bad:

- acts like a roadmap, handoff, or docs-governance file
- stores branch steps, load order, or current phase status
- becomes a dumping ground for anything important
- stays structurally correct but too thin to carry real product or architecture judgment

## Entrypoint Files

Good:

- provide the minimum load order and must-know constraints
- stay short enough to function as true cold-start files
- route safely into the formal planning and execution layers

Bad:

- try to replace design, roadmap, and handoff all at once
- omit the formal phase workflow
- only one runtime entrypoint is real while the others drift

## docs/README.md

Good:

- makes ownership clear across the shared namespace
- distinguishes core planning layers from helper layers
- reduces duplication pressure

Bad:

- restates the whole project
- hides source-of-truth decisions in prose instead of showing them clearly

## DEVELOPMENT_FLOW.md

Good:

- makes the planning-to-execution progression explicit
- defines context loading and closeout updates
- prevents phase docs from drifting in structure or sequence

Bad:

- is just a slogan like "PRD -> design -> test -> code"
- acts like a current status board
- gets ignored because entrypoints do not route to it

## Roadmap

Good:

- each phase clearly states goal, inputs, outputs, acceptance criteria, exit conditions, and prerequisites
- helps readers understand sequence and dependency, not just ambition

Bad:

- degrades into a task list
- mixes detailed implementation slicing into the phase map

## PRD

Good:

- makes the phase objective, scope, and success conditions precise
- describes user or workflow needs clearly enough to drive design
- distinguishes requirements from implementation ideas

Bad:

- turns into architecture prose
- mixes speculative discovery notes with accepted requirements
- replaces acceptance criteria with internal tasks

## Technical Design

Good:

- translates requirements into an implementable architecture contract
- explains important interfaces, failure concerns, and tradeoffs
- gives engineers enough structure to implement without redesigning from scratch

Bad:

- merely repeats the PRD
- collapses into class inventory with no system reasoning
- hides important operational or failure concerns

## Test Plan

Good:

- is shaped by real phase risks
- names the important scenarios, fixtures, and commands
- keeps known gaps visible

Bad:

- is generic rather than risk-based
- lists test levels without real scenarios
- pretends planned coverage is the same as executed evidence

## Implementation Plan

Good:

- turns accepted design into a clear execution sequence
- breaks work into slices that reduce coordination and verification risk
- helps another engineer resume work without redesigning the phase

Bad:

- becomes a second technical design
- collapses into a flat todo list with no sequencing logic
- postpones verification thinking until the end

## Handoffs

Good:

- are short, operational, and safe to resume from
- let another agent continue work without re-planning the whole project

Bad:

- read like a second design document
- copy PRD or technical design sections wholesale
- keep stale next-work items

## Project-Visible Templates

Good:

- are lightweight but still self-describing
- give enough short guidance that a human or weaker model can fill them without guessing
- match the owning document layer instead of creating parallel truth

Bad:

- consist only of bare headings
- copy the full reference instead of acting as a reusable skeleton
- drift into a second handbook

## Language Strategy

Good:

- public entry docs and internal working docs follow an intentional language split when needed
- templates, handoffs, and visible labels stay consistent within one document family

Bad:

- language changes because examples drifted
- one artifact family mixes languages without a reason
- public and internal document surfaces are not distinguished

## Acceptance

Good:

- records what actually happened
- includes commands, results, artifacts, evidence, and remaining risks

Bad:

- reports only expected outcomes
- copies the implementation plan
- erases known risk because tests passed
