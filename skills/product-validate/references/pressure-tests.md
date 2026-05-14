# Pressure Tests

Before calling this skill mature, verify at least these cases:

- a current phase package that is solid enough for implementation -> keep validation narrow and execution-oriented
- a documented future phase or roadmap branch -> allow project-level validation without pretending missing implementation detail already exists
- a strong plan with minor terminology drift -> tighten the owning docs without widening scope
- a contradictory PRD and technical design -> surface the conflict and route the repair to the owning artifacts
- an existing codebase that disagrees with the docs -> identify the contradiction before asking the user
- a platform proposal adds a second approval chain or lifecycle around a downstream system that already owns one -> force the skill to ask whether this is governance around an existing process or accidental duplicate process modeling
- a plan sounds internally coherent after only a few answers, but still has unresolved ownership or dependency questions -> keep grilling until those trunk questions are resolved instead of accepting the first plausible narrative
- a long validation session resolves several vocabulary and boundary decisions -> write them back in small coherent batches instead of saving every repair for a giant final dump
- a tempting durable conclusion appears -> require the hard-to-reverse + surprising + real trade-off gate before escalating it into an ADR
- a tempting new idea raised during grilling -> keep it as validation output or replanning input, not current execution state
- a fuzzy future idea with no durable artifact yet -> route back to exploration or planning instead of stretching validation into speculation
- a project with no `CONTEXT.md` -> still perform terminology and domain-model grilling without inventing a parallel glossary workflow
