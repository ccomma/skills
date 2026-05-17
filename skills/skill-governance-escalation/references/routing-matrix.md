# Routing Matrix

Load this when the higher-level diagnosis is clear but the next implementation workflow is not.

## Routing Rules

### Route To A Skill-Maintenance Workflow When

- one existing skill is the clear owner of the fix
- the issue is internal to that skill's structure, routing, portability, language, output contract, or bundle
- no multi-skill boundary dispute remains
- the remaining work is single-skill audit or repair, whether or not a governance pass also happened earlier

### Route To `skill-architect` When

- the boundary is already clear
- one skill needs a stronger architecture, split, merge, or new bundle shape
- the issue is no longer "where should this live?" but "how should this skill be structured?"

### Route To `skill-referee` When

- multiple skills may overlap, conflict, or plausibly own the same request
- the main ambiguity is ownership between skills and you need owner arbitration before changing any one skill
- fixing one skill alone would not settle responsibility

### Route To A Project Or Document Workflow When

- the issue is local to one project and the owning workflow is already known
- the problem does not justify reusable-skill changes
- governance drift has already been analyzed and the remaining work is ordinary project repair

### Stop At A Runtime Or Platform Constraint When

- the durable upstream cause appears to be registry freshness, session cache, platform limits, runtime loading behavior, or model behavior
- editing more skills would only create compensating complexity rather than fixing the real cause
- the right output is a clear constraint note plus, if needed, a local workaround

## Anti-Routing Rule

Do not route upward merely because a higher layer can also be edited.

Choose the workflow that owns the smallest durable fix.
