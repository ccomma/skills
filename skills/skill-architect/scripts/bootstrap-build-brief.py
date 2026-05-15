#!/usr/bin/env python3

from __future__ import annotations

import argparse
import json
import subprocess
import sys
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
if str(SCRIPT_DIR) not in sys.path:
    sys.path.insert(0, str(SCRIPT_DIR))

from _brief_runtime import classify_repo_local, parse_create_paths, parse_fields


def run_validator(script_dir: Path, brief_file: Path) -> dict[str, object]:
    validator = script_dir / "check-build-brief.py"
    result = subprocess.run(
        [str(validator), "--format", "json", str(brief_file)],
        check=False,
        capture_output=True,
        text=True,
    )
    if result.returncode not in {0, 1, 2}:
        raise RuntimeError(result.stderr.strip() or "validator did not produce a supported exit code")
    try:
        parsed = json.loads(result.stdout)
    except json.JSONDecodeError as exc:
        raise RuntimeError("validator did not return valid JSON diagnostics") from exc
    return parsed


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


def print_text_result(result: dict[str, object]) -> None:
    print(f"validator_status: {result['validator_status']}")
    print(f"consumption_ready: {result['consumption_ready']}")
    print(f"execution_status: {result['execution_status']}")
    print("reasons:")
    for reason in result["reasons"]:
        print(f"- {reason}")
    if result["planned_files"]:
        print("planned_files:")
        for path in result["planned_files"]:
            print(f"- {path}")
    if result["created_files"]:
        print("created_files:")
        for path in result["created_files"]:
            print(f"- {path}")


def main() -> int:
    parser = argparse.ArgumentParser(description="Repo-local consumption proof helper for validated build briefs.")
    parser.add_argument(
        "--format",
        choices=("text", "json"),
        default="text",
        help="Output format for repo-local helper diagnostics.",
    )
    parser.add_argument("brief_file", help="Path to a standalone build brief text artifact.")
    parser.add_argument("target_dir", help="Repo-local target directory for proof initialization.")
    parser.add_argument("--dry-run", action="store_true", help="Print the planned execution without writing files.")
    parser.add_argument("--force", action="store_true", help="Allow execution into a non-empty target directory.")
    args = parser.parse_args()

    brief_file = Path(args.brief_file).resolve()
    target_dir = Path(args.target_dir).resolve()
    fields = parse_fields(brief_file.read_text(encoding="utf-8"))["fields"]
    validator_result = run_validator(SCRIPT_DIR, brief_file)

    bootstrap_result: dict[str, object] = {
        "validator_status": validator_result["status"],
        "consumption_ready": validator_result["consumption_ready"],
        "execution_status": "",
        "reasons": [],
        "planned_files": [],
        "created_files": [],
    }

    if validator_result["status"] != "valid":
        bootstrap_result["execution_status"] = "refused: protocol invalid/incomplete"
        bootstrap_result["reasons"] = validator_result["reasons"]
        if args.format == "json":
            print(json.dumps(bootstrap_result, indent=2))
        else:
            print_text_result(bootstrap_result)
        return 1

    if validator_result["consumption_ready"] != "yes":
        bootstrap_result["execution_status"] = "refused: not consumption-ready"
        bootstrap_result["reasons"] = validator_result["consumption_reasons"]
        if args.format == "json":
            print(json.dumps(bootstrap_result, indent=2))
        else:
            print_text_result(bootstrap_result)
        return 4

    repo_local_state, repo_local_reasons = classify_repo_local(fields)
    if repo_local_state != "executable":
        bootstrap_result["execution_status"] = "refused: repo-local ambiguous"
        bootstrap_result["reasons"] = repo_local_reasons
        if args.format == "json":
            print(json.dumps(bootstrap_result, indent=2))
        else:
            print_text_result(bootstrap_result)
        return 2

    target_dir_state, target_dir_reasons = target_status(target_dir, args.force)
    if target_dir_state != "safe":
        bootstrap_result["execution_status"] = "refused: target-dir safety"
        bootstrap_result["reasons"] = target_dir_reasons
        if args.format == "json":
            print(json.dumps(bootstrap_result, indent=2))
        else:
            print_text_result(bootstrap_result)
        return 3

    create_paths = parse_create_paths(fields.get("Initializer handoff", []))
    if not create_paths:
        create_paths = ["SKILL.md"]
    bootstrap_result["planned_files"] = create_paths
    bootstrap_result["execution_status"] = "planned" if args.dry_run else "executed"

    if args.dry_run:
        if args.format == "json":
            print(json.dumps(bootstrap_result, indent=2))
        else:
            print_text_result(bootstrap_result)
        return 0

    bootstrap_result["created_files"] = execute_bootstrap(target_dir, fields)
    if args.format == "json":
        print(json.dumps(bootstrap_result, indent=2))
    else:
        print_text_result(bootstrap_result)
    return 0


if __name__ == "__main__":
    sys.exit(main())
