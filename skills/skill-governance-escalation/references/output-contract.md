# Governance Output Contract

Use this when producing the final report from `skill-governance-escalation`.

## Required Sections

The report must include:

1. observed issue
2. evidence
3. findings
4. layer classification
5. abstract failure mode
6. escalation judgment
7. immediate local fix locus, if one is justified
8. durable upstream fix locus, if one is justified
9. recommended next workflow
10. layers not to change
11. rationale

## Quality Bar

A good report:

- starts from concrete evidence
- makes the findings list explicit before escalation
- names one primary owning layer
- explains abstraction without overfitting
- distinguishes immediate local cleanup from durable upstream repair when both matter
- recommends one next workflow, not a vague list
- says which higher layers should stay untouched when escalation is not justified

A weak report:

- merely restates the complaint
- names several layers without choosing one
- abstracts too broadly to be actionable
- recommends editing everything "for completeness"
