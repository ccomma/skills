# Skills

Personal agent skills that I use and maintain publicly.

These skills are designed to be small, composable, and easy to install into different agent skill directories. The repository is the source of truth; local agent skill folders can symlink to the skills here so there is only one maintained copy.

## Skills

- [`product-explore`](./skills/product-explore/SKILL.md): Explores a fuzzy product or feature idea, clarifies the real problem and users, and converges on a Product Brief before planning.
- [`product-plan`](./skills/product-plan/SKILL.md): Builds and maintains durable product context, planning docs, phase handoffs, and evidence for multi-phase product work.
- [`skill-referee`](./skills/skill-referee/SKILL.md): Referees responsibility boundaries between skills across any domain, using metadata-first discovery and controlled review depth.
- [`skill-architect`](./skills/skill-architect/SKILL.md): Designs mature, token-efficient skills with explicit authority boundaries, output contracts, interaction intensity, references, scripts, assets, validation, and bundle structure.
- [`skill-maintain`](./skills/skill-maintain/SKILL.md): Audits and repairs one existing skill through modular checks for portability, language consistency, output contracts, interaction intensity, bundle integrity, authority boundaries, structure, routing, and token/context cost without taking over multi-skill boundary design.

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
```

`agents/openai.yaml` is optional, but when present it should stay aligned with the skill name, display name, and default prompt.

When installed through symlinks, your local agent runtime reads the same files from this repository, so public maintenance and personal usage do not drift apart.

## Safety

`scripts/install.sh` only writes to the selected target directory. It does not automatically modify `~/.agents/skills`, `~/.cc-switch/skills`, or any other agent folder unless you explicitly choose that target/profile.

## License

MIT
