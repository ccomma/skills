# Skills

Personal agent skills that I use and maintain publicly.

These skills are designed to be small, composable, and easy to install into different agent skill directories. The repository is the source of truth; local agent skill folders can symlink to the skills here so there is only one maintained copy.

## Skills

- [`product-explore`](./skills/product-explore/SKILL.md): Explores a fuzzy product or feature idea, clarifies the real problem and users, and converges on a Product Brief before planning.
- [`product-plan`](./skills/product-plan/SKILL.md): Builds and maintains durable product context, planning docs, phase handoffs, and evidence for multi-phase product work.
- [`product-validate`](./skills/product-validate/SKILL.md): Stress-tests an existing product plan against docs, terminology, code, and decision boundaries before execution or replanning continues.
- [`skill-governance-escalation`](./skills/skill-governance-escalation/SKILL.md): Runs an upward-check from a concrete issue before or alongside local repair, so local drift, reusable-skill failures, multi-skill boundary conflicts, higher governance gaps, and runtime constraints do not get mixed together.
- [`skill-referee`](./skills/skill-referee/SKILL.md): Referees responsibility boundaries between skills across any domain, using metadata-first discovery and controlled review depth.
- [`skill-architect`](./skills/skill-architect/SKILL.md): Designs mature, token-efficient skills with explicit authority boundaries, output contracts, interaction intensity, references, scripts, assets, validation, and bundle structure.
- [`skill-maintain`](./skills/skill-maintain/SKILL.md): Audits and repairs one existing skill through modular checks for portability, language consistency, output contracts, interaction intensity, bundle integrity, authority boundaries, structure, routing, companion format-file opportunities, and token/context cost without taking over multi-skill boundary design.

## Product Workflow

`product-explore -> product-plan -> product-validate -> implementation`

```mermaid
flowchart TD
    A["Fuzzy Product Idea"] --> B["product-explore"]
    B --> B1["Output: Product Brief"]

    B1 --> C["product-plan"]
    C --> C1["DESIGN.md"]
    C --> C2["roadmap"]
    C --> C3["CURRENT_HANDOFF.md"]
    C --> C4["Current Phase HANDOFF.md"]
    C --> C5["Current Phase PRD"]
    C --> C6["Current Phase Technical Design"]
    C --> C7["Current Phase Test Plan"]

    C5 --> D["IMPLEMENTATION_PLAN.md"]
    C6 --> D
    C7 --> D

    D --> E["product-validate"]
    E --> E1["Check Terminology, Boundaries, and Contradictions"]
    E --> E2["Write Back to DESIGN / PRD / Technical / ADR When Needed"]

    E --> F["Implementation"]
    F --> G["Verification / Testing"]
    G --> H["ACCEPTANCE.md"]
    H --> I["Update Phase HANDOFF"]
    I --> J["Update CURRENT_HANDOFF.md"]

    J --> K{"Another Phase?"}
    K -->|Yes| C
    K -->|No| L["Project Complete"]
```

These three product-oriented skills should connect through artifact contracts, not through vague intuition:

- `product-explore`
  - Use when the idea is still fuzzy.
  - Output: `Product Brief`.
  - Does not directly mutate execution-state documents such as `CURRENT_HANDOFF.md`.
- `product-plan`
  - Use when the direction is clear enough to become durable planning context.
  - Output: the planning stack for serious multi-phase work, centered on `DESIGN.md`, roadmap, current handoff, phase handoffs, PRDs, technical designs, test plans, `IMPLEMENTATION_PLAN.md`, and `ACCEPTANCE.md`.
  - Treats `Product Brief` as upstream input, not as current execution state.
- `product-validate`
  - Use after planning and before implementation, or before a major replan.
  - Challenges the plan against existing docs, code, terminology, and decision boundaries.
  - Can propose document repairs and ADR-worthy decisions, but does not directly take over current-phase execution state.

The most common path is:

1. Explore the product idea until it becomes a usable `Product Brief`
2. Turn that brief into durable planning documents
3. Use `product-validate` to challenge terminology, code, and decision boundaries
4. Hand off to implementation only after the plan is coherent enough

### Document Layers

`product-plan` uses a layered document model. The key distinction is not "one folder per phase" versus "one folder per document type", but **which layer owns which kind of truth**.

- `DESIGN.md`
  - Holds durable product judgment and long-lived design direction.
  - Best kept at the repository root so it remains visibly distinct from phase and reference docs.
- `docs/roadmap/PROJECT_DEVELOPMENT_PLAN.md`
  - Holds phase sequence, exit conditions, and prerequisites.
- `docs/context/CURRENT_HANDOFF.md`
  - Holds current execution state: active phase, active branch, next work, and verification commands.
- `docs/phases/phase-XX-<slug>/HANDOFF.md`
  - Holds operational handoff information for one phase.
- `docs/prd/`, `docs/technical/`, `docs/testing/`
  - Hold phase requirements, architecture contracts, and test strategy.
- `docs/phases/phase-XX-<slug>/IMPLEMENTATION_PLAN.md`
  - Holds execution slicing and delivery order for the current phase. It is not a second technical design.
- `docs/phases/phase-XX-<slug>/ACCEPTANCE.md`
  - Holds phase-close evidence: commands, results, artifacts, commits, and residual risk.
- `docs/adr/`
  - Holds cross-phase decisions worth preserving long term.

The usual planning-document build order is:

1. `DESIGN.md`
2. roadmap
3. Runtime entrypoint such as `AGENTS.md` or `CLAUDE.md`
4. `docs/context/CURRENT_HANDOFF.md`
5. Current phase `HANDOFF.md`
6. Current phase PRD, technical design, and test plan
7. Current phase `IMPLEMENTATION_PLAN.md`
8. Current phase `ACCEPTANCE.md`

Future phases should usually stay coarse in the roadmap until they are close enough to implement. Unless there is a strong reason, do not fully write every future phase PRD, technical design, and implementation plan up front.

```mermaid
flowchart TD
    A["PRD"] --> A1["Defines What to Build"]
    A --> A2["Defines Who It Is For"]
    A --> A3["Defines Boundaries and Success Criteria"]

    B["Technical Design"] --> B1["Defines How the System Is Designed"]
    B --> B2["Defines Modules / Interfaces / Data Structures"]
    B --> B3["Defines Technical Constraints and Trade-offs"]

    A --> C["IMPLEMENTATION_PLAN"]
    B --> C
    C --> C1["Breaks Design into Executable Steps"]
    C --> C2["Orders the Work"]
    C --> C3["Defines How Each Step Is Verified"]

    C --> D["Implementation and Testing"]
    D --> E["ACCEPTANCE"]

    E --> E1["Records Whether Exit Criteria Were Met"]
    E --> E2["Records Which Commands Actually Ran"]
    E --> E3["Records Results / Artifacts / Residual Risk"]

    A -.answers.-> X["Why Build It"]
    B -.answers.-> Y["How to Design It"]
    C -.answers.-> Z["How to Deliver It"]
    E -.answers.-> W["Was It Actually Completed"]
```

## Skill Workflow

`skill-governance-escalation -> skill-referee / skill-architect / skill-maintain / project workflow / runtime constraint note`

```mermaid
flowchart TD
    A["Concrete Issue With Unclear Fix Layer"] --> B["skill-governance-escalation"]
    B --> B1["Artifact / Reusable Skill / Governance / Runtime Judgment"]
    B --> B2["Recommended Next Workflow"]

    B2 --> C["skill-referee"]
    B2 --> D["skill-architect"]
    B2 --> E["skill-maintain"]

    C --> C1["Clarified Multi-Skill Boundary"]
    C1 --> D

    D --> D1["Create / Split / Merge / Reshape One Skill"]
    D1 --> E

    E --> E1["Audit One Existing Skill"]
    E --> E2["Repair Drift, Contracts, or Bundle Quality"]

    E --> F{"Need Higher-Layer Recheck?"}
    F -->|Yes| B
    F -->|No| G["Stable Skill Bundle"]
```

These governance skills solve different layers of the same problem:

- `skill-governance-escalation`
  - Use when a concrete issue should trigger an upward-check for reusable causes before or alongside local repair.
  - Output: layer classification, abstract failure mode, escalation judgment, immediate local fix locus, durable upstream fix locus, and routing guidance.
  - Best used before editing when the real uncertainty is not only "how do I patch this now?" but also "what layer should prevent this from recurring?"

- `skill-referee`
  - Use when multiple skills may overlap, conflict, trigger too broadly, or need clearer routing.
  - Output: clearer boundaries, routing guidance, and conflict classification.
  - Best used before redesigning one specific skill when the real uncertainty is still between skills.
- `skill-architect`
  - Use when the boundary is already clear and the remaining question is how one skill should be shaped.
  - Output: a stronger skill design or implementation plan covering authority boundaries, output contracts, interaction model, references, scripts, assets, validation, and bundle structure.
  - This is the right place to decide whether a repeated artifact deserves a companion format file.
- `skill-maintain`
  - Use when one existing skill already exists and needs an audit or repair.
  - Output: focused repairs for portability, structure, routing, output contracts, safety, bundle consistency, format-file opportunities, format-file quality, or token cost.
  - This is not the right tool for deciding whether multiple skills should be split, merged, or rerouted from scratch.

The most common skill-management paths are:

1. If a concrete issue may need more than a local patch, use `skill-governance-escalation` first.
2. If the real problem is boundary confusion between skills, use `skill-referee`.
3. Once one skill's boundary is clear, use `skill-architect` to design or redesign the right shape.
4. After the skill exists, use `skill-maintain` to audit and repair it over time.

### Companion Format Files

Many mature skills use companion format files in `references/` for repeated high-value artifact shapes such as product briefs, handoffs, acceptance evidence, or ADRs.

The rule of thumb is:

- use `skill-architect` to decide whether a format file should exist
- use `skill-maintain` to check whether a format file is missing, bloated, vague, ritualized, or drifted from the parent skill

High-quality format files should stay short, define when to use them, define when not to use them, distinguish required structure from optional detail, and stay aligned with the parent skill's artifact contract.

## Install

Clone this repository:

```bash
git clone git@github.com:ccomma/skills.git
cd skills
```

Install to a specific skill directory:

```bash
./scripts/install.sh --target ~/.agents/skills
./scripts/install.sh --target ~/.claude/skills
./scripts/install.sh --target ~/.cc-switch/skills
```

Install by profile:

```bash
./scripts/install.sh --profile codex
./scripts/install.sh --profile claude
./scripts/install.sh --profile cc-switch
```

Default install uses the Codex-style target:

```bash
./scripts/install.sh
```

Install to every known target directory that already exists on this machine:

```bash
./scripts/install.sh --all
```

The installer creates symlinks from the target skill directory to this repository. It does not overwrite existing non-symlink skill directories. If a target already has one of these skills as a real directory, back it up or remove it before installing.

## Maintenance

Edit skills in this repository:

```text
skills/<skill-name>/SKILL.md
skills/<skill-name>/references/
skills/<skill-name>/agents/openai.yaml
skills/<skill-name>/scripts/
```

`agents/openai.yaml` is optional, but when present it should stay aligned with the skill name, display name, and default prompt.

Many skills also use companion format files in `references/` for repeated artifact shapes such as product briefs, handoffs, acceptance evidence, or ADRs. Keep those format files short, explicit about when to use them, and aligned with the parent skill's artifact contract.

Use the deterministic bundle checker when a skill is renamed, restructured, or given new references, scripts, or format files:

```bash
./skills/skill-maintain/scripts/check-skill-bundle.sh ./skills/<skill-name> --expected-name <skill-name>
./skills/skill-maintain/scripts/check-skill-bundle.sh ./skills/<skill-name> --expected-name <skill-name> --policy internal
```

The default `external` policy is suitable for third-party or imported skills. The `internal` policy is stricter and is intended for the skills maintained in this repository.

When installed through symlinks, your local agent runtime reads the same files from this repository, so public maintenance and personal usage do not drift apart.

## Safety

`scripts/install.sh` only writes to the selected target directory. It does not automatically modify `~/.agents/skills`, `~/.cc-switch/skills`, or any other agent folder unless you explicitly choose that target/profile.

## License

MIT
