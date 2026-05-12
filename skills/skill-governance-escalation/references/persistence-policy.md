# Governance Persistence Policy

Use this when deciding whether governance findings should stay inside the current report only or also become durable governance memory.

## Persistence Threshold

Persist governance memory only when the upstream status is:

- `provisional candidate`
- `promote now`

Do not persist `local-only` findings.

## Storage Principle

Governance memory is:

- user-level
- agent-neutral
- outside any project repository
- outside the skill bundle source

It should persist under an agent-state location, not inside project docs and not inside the reusable skill's own folder.

## Path Resolution Order

Resolve the governance-state root in this order:

1. `AGENT_HOME`
2. `AGENT_STATE_HOME`
3. OS fallback

Resolved ledger path:

- `<state-root>/governance/skill-governance-escalation/GOVERNANCE_CANDIDATES.md`

### OS Fallback

- Linux or other Unix:
  - `XDG_STATE_HOME/agent`
  - fallback: `~/.local/state/agent`
- macOS:
  - `~/Library/Application Support/Agent`
- Windows:
  - roaming application-data directory plus `Agent`

## Current-Machine Default

If this environment uses `~/.agents` as agent home, the default ledger path becomes:

- `~/.agents/governance/skill-governance-escalation/GOVERNANCE_CANDIDATES.md`

## Review-Only Versus Implementation Paths

- Review-only path:
  - emit a governance note block
  - do not assume the file will be written in this pass
- Implementation or repair path:
  - create or update the governance ledger when the status is persistent

## Anti-Patterns

- storing governance memory inside the current project repo
- storing governance memory inside the reusable skill directory
- persisting every local-only finding
- using vendor-specific runtime homes as the only supported root
