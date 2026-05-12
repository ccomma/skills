# Existing Quality Assessment

Use this before deciding whether to preserve, lightly repair, or broadly rewrite an existing document system.

## Purpose

This reference helps distinguish:

- low-quality systems that need reshaping
- mixed systems that need selective repair
- high-quality systems that should mostly be preserved

## Signals Of Low Quality

- multiple files claim the same source-of-truth responsibility
- entrypoint files do not route safely into execution-state docs
- current phase state is unclear or contradictory
- roadmap, handoff, and design layers are heavily blended
- repeated artifacts drift widely in structure

Recommended action:

- medium or heavy repair

## Signals Of Mixed Quality

- core structure exists, but one or two layers are misplaced
- phase docs exist but governance layers are missing
- some documents are strong while others are weak or stale
- helper directories are present but not clearly classified

Recommended action:

- light or medium repair
- preserve strong layers

## Signals Of High Quality

- ownership is already mostly clear
- entrypoint and handoff chain already works
- long docs and short docs are well separated
- repeated phase artifacts already look consistent
- only a few missing governance or template assets remain

Recommended action:

- light repair
- avoid broad rewrites

## Preservation Rule

A strong document should not be rewritten just because a newer standard exists. Rewrite only when:

- ownership is wrong
- execution safety is harmed
- phase continuity is harmed
- the document is actively misleading
