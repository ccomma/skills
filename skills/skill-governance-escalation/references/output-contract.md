# Governance Output Contract

Use this when producing the final report from `skill-governance-escalation`.

## Required Sections

The report must include:

1. observed issue
2. evidence
3. findings
4. layer classification
5. upstream status
6. abstract failure mode
7. escalation judgment
8. immediate local fix locus, if one is justified
9. durable upstream fix locus, if one is justified
10. promotion trigger when the status is `provisional candidate`
11. governance note action
12. recommended next workflow
13. layers not to change
14. rationale

## Quality Bar

A good report:

- starts from concrete evidence
- makes the findings list explicit before escalation
- makes the upstream status explicit before durable-fix routing
- names one primary owning layer
- explains abstraction without overfitting
- distinguishes immediate local cleanup from durable upstream repair when both matter
- states whether durable governance memory should be created, updated, or skipped
- recommends one next workflow, not a vague list
- says which higher layers should stay untouched when escalation is not justified

A weak report:

- merely restates the complaint
- treats every finding as an upstream problem by default
- names several layers without choosing one
- abstracts too broadly to be actionable
- recommends editing everything "for completeness"
