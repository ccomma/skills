#!/usr/bin/env python3

from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
from pathlib import Path


FIELD_PATTERN = re.compile(
    r"^(Kernel sentence|Trigger boundary|First move|Strongest thing|Not-this-skill-if|"
    r"Minimal shape|Component decisions|Do-not-add|Validation starter|Initializer handoff):\s*(.*)$"
)


def parse_fields(text: str) -> dict[str, list[str]]:
    fields: dict[str, list[str]] = {}
    current_label: str | None = None
    for line in text.splitlines():
        match = FIELD_PATTERN.match(line)
        if match:
            current_label = match.group(1)
            fields[current_label] = []
            remainder = match.group(2).strip()
            if remainder:
                fields[current_label].append(remainder)
            continue
        if current_label is not None:
            fields[current_label].append(line)
    return fields


def run_validator(script_dir: Path, brief_file: Path) -> tuple[str, str, list[str], list[str]]:
    validator = script_dir / "check-build-brief.py"
    result = subprocess.run(
        [str(validator), str(brief_file)],
        check=False,
        capture_output=True,
        text=True,
    )
    lines = [line.rstrip() for line in result.stdout.splitlines()]
    status = "unknown"
    consumption_ready = "unknown"
    reasons: list[str] = []
    consumption_reasons: list[str] = []
    in_reasons = False
    in_consumption_reasons = False
    for line in lines:
        if line.startswith("status: "):
            status = line.split(": ", 1)[1].strip()
            in_reasons = False
            in_consumption_reasons = False
        elif line.startswith("consumption_ready: "):
            consumption_ready = line.split(": ", 1)[1].strip()
            in_reasons = False
            in_consumption_reasons = False
        elif line == "reasons:":
            in_reasons = True
            in_consumption_reasons = False
        elif line == "consumption_reasons:":
            in_reasons = False
            in_consumption_reasons = True
        elif in_reasons and line.startswith("- "):
            reasons.append(line[2:])
        elif in_consumption_reasons and line.startswith("- "):
            consumption_reasons.append(line[2:])
    return status, consumption_ready, reasons, consumption_reasons


def parse_create_paths(lines: list[str]) -> list[str]:
    in_initialize = False
    paths: list[str] = []
    for raw_line in lines:
        stripped = raw_line.strip()
        if stripped == "- Initialize:":
            in_initialize = True
            continue
        if stripped == "- Do not invent:":
            in_initialize = False
            continue
        if not in_initialize:
            continue
        match = re.match(r"^- create\s+`([^`]+)`\s*$", stripped)
        if match:
            paths.append(match.group(1))
    return paths


def normalize_shape(shape: str) -> str:
    return re.sub(r"\s+", " ", shape.strip().lower())


def classify_repo_local(fields: dict[str, list[str]]) -> tuple[str, list[str]]:
    shape = normalize_shape("\n".join(fields.get("Minimal shape", [])))
    create_paths = parse_create_paths(fields.get("Initializer handoff", []))
    reasons: list[str] = []

    if shape == "skill.md only":
        if not create_paths:
            return "executable", []
        if create_paths == ["SKILL.md"]:
            return "executable", []
        return "ambiguous", ["`SKILL.md only` may only initialize `SKILL.md`"]

    if shape == "skill.md + one reference":
        if len(create_paths) != 2:
            return "ambiguous", ["repo-local execution needs exactly two create paths: `SKILL.md` and one `references/...` file"]
        if "SKILL.md" not in create_paths:
            return "ambiguous", ["repo-local execution needs explicit `SKILL.md` in `Initializer handoff`"]
        other_paths = [path for path in create_paths if path != "SKILL.md"]
        if len(other_paths) != 1 or not other_paths[0].startswith("references/"):
            return "ambiguous", ["`SKILL.md + one reference` needs one explicit `references/...` path"]
        return "executable", []

    if shape == "skill.md + one script":
        if len(create_paths) != 2:
            return "ambiguous", ["repo-local execution needs exactly two create paths: `SKILL.md` and one `scripts/...` file"]
        if "SKILL.md" not in create_paths:
            return "ambiguous", ["repo-local execution needs explicit `SKILL.md` in `Initializer handoff`"]
        other_paths = [path for path in create_paths if path != "SKILL.md"]
        if len(other_paths) != 1 or not other_paths[0].startswith("scripts/"):
            return "ambiguous", ["`SKILL.md + one script` needs one explicit `scripts/...` path"]
        return "executable", []

    reasons.append(f"unsupported repo-local shape: `{shape}`")
    reasons.append("Phase 6 only supports `SKILL.md only`, `SKILL.md + one reference`, and `SKILL.md + one script`")
    return "ambiguous", reasons


def target_status(target_dir: Path, force: bool) -> tuple[str, list[str]]:
    if not target_dir.exists():
        return "safe", []
    if not target_dir.is_dir():
        return "unsafe", [f"target exists and is not a directory: `{target_dir}`"]
    entries = list(target_dir.iterdir())
    if not entries:
        return "safe", []
    if force:
        return "safe", []
    return "unsafe", [f"target directory is non-empty and requires `--force`: `{target_dir}`"]


def build_skill_md_content(target_dir: Path, fields: dict[str, list[str]]) -> str:
    title = target_dir.name.replace("-", " ").replace("_", " ").strip() or "Bootstrap Proof"
    title = " ".join(word.capitalize() for word in title.split())
    kernel = " ".join(line.strip() for line in fields.get("Kernel sentence", []) if line.strip())
    trigger = " ".join(line.strip() for line in fields.get("Trigger boundary", []) if line.strip())
    first_move = " ".join(line.strip() for line in fields.get("First move", []) if line.strip())
    strongest = " ".join(line.strip() for line in fields.get("Strongest thing", []) if line.strip())
    wrong_scope = " ".join(line.strip() for line in fields.get("Not-this-skill-if", []) if line.strip())
    description = kernel.replace('"', "'")
    return (
        "---\n"
        f"name: {target_dir.name}\n"
        f'description: "{description}"\n'
        "---\n\n"
        f"# {title}\n\n"
        "Repo-local consumption proof generated from a validated build brief.\n\n"
        "## Frozen Kernel\n\n"
        f"- Kernel sentence: {kernel}\n"
        f"- Trigger boundary: {trigger}\n"
        f"- First move: {first_move}\n"
        f"- Strongest thing: {strongest}\n"
        f"- Not-this-skill-if: {wrong_scope}\n"
    )


def build_placeholder_content(path: str, fields: dict[str, list[str]]) -> str:
    strongest = " ".join(line.strip() for line in fields.get("Strongest thing", []) if line.strip())
    if path.startswith("references/"):
        return (
            f"# {Path(path).stem.replace('-', ' ').replace('_', ' ').title()}\n\n"
            "Repo-local proof placeholder generated from a validated build brief.\n\n"
            f"- Protected strongest thing: {strongest}\n"
            "- This file exists only because the brief explicitly allowed one reference surface.\n"
        )
    if path.startswith("scripts/"):
        return (
            "#!/usr/bin/env bash\n"
            "set -euo pipefail\n\n"
            "# Repo-local proof placeholder generated from a validated build brief.\n"
            f'printf "%s\\n" "Protected strongest thing: {strongest}"\n'
        )
    raise ValueError(f"Unsupported proof path: {path}")


def execute_bootstrap(target_dir: Path, fields: dict[str, list[str]]) -> list[str]:
    create_paths = parse_create_paths(fields.get("Initializer handoff", []))
    if not create_paths:
        create_paths = ["SKILL.md"]
    created: list[str] = []
    for relative_path in create_paths:
        output_path = target_dir / relative_path
        output_path.parent.mkdir(parents=True, exist_ok=True)
        if relative_path == "SKILL.md":
            output_path.write_text(build_skill_md_content(target_dir, fields), encoding="utf-8")
        else:
            output_path.write_text(build_placeholder_content(relative_path, fields), encoding="utf-8")
            if relative_path.startswith("scripts/"):
                output_path.chmod(0o755)
        created.append(relative_path)
    return created


def main() -> int:
    parser = argparse.ArgumentParser(description="Repo-local consumption proof helper for validated build briefs.")
    parser.add_argument("brief_file", help="Path to a standalone build brief text artifact.")
    parser.add_argument("target_dir", help="Repo-local target directory for proof initialization.")
    parser.add_argument("--dry-run", action="store_true", help="Print the planned execution without writing files.")
    parser.add_argument("--force", action="store_true", help="Allow execution into a non-empty target directory.")
    args = parser.parse_args()

    script_dir = Path(__file__).resolve().parent
    brief_file = Path(args.brief_file).resolve()
    target_dir = Path(args.target_dir).resolve()
    fields = parse_fields(brief_file.read_text(encoding="utf-8"))

    validator_status, consumption_ready, validator_reasons, consumption_reasons = run_validator(script_dir, brief_file)
    if validator_status != "valid":
        print("execution_status: refused: protocol invalid/incomplete")
        print(f"validator_status: {validator_status}")
        print(f"consumption_ready: {consumption_ready}")
        print("reasons:")
        for reason in validator_reasons:
            print(f"- {reason}")
        return 1

    if consumption_ready != "yes":
        print("execution_status: refused: not consumption-ready")
        print(f"validator_status: {validator_status}")
        print(f"consumption_ready: {consumption_ready}")
        print("reasons:")
        for reason in consumption_reasons:
            print(f"- {reason}")
        return 4

    repo_local_state, repo_local_reasons = classify_repo_local(fields)
    if repo_local_state != "executable":
        print("execution_status: refused: repo-local ambiguous")
        print("validator_status: valid")
        print(f"consumption_ready: {consumption_ready}")
        print("reasons:")
        for reason in repo_local_reasons:
            print(f"- {reason}")
        return 2

    target_dir_state, target_dir_reasons = target_status(target_dir, args.force)
    if target_dir_state != "safe":
        print("execution_status: refused: target-dir safety")
        print("validator_status: valid")
        print(f"consumption_ready: {consumption_ready}")
        print("reasons:")
        for reason in target_dir_reasons:
            print(f"- {reason}")
        return 3

    create_paths = parse_create_paths(fields.get("Initializer handoff", []))
    if not create_paths:
        create_paths = ["SKILL.md"]

    print("validator_status: valid")
    print(f"consumption_ready: {consumption_ready}")
    print(f"execution_status: {'planned' if args.dry_run else 'executed'}")
    print("planned_files:")
    for path in create_paths:
        print(f"- {path}")

    if args.dry_run:
        return 0

    created = execute_bootstrap(target_dir, fields)
    print("created_files:")
    for path in created:
        print(f"- {path}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
