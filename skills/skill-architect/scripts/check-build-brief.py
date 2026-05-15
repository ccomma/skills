#!/usr/bin/env python3

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
if str(SCRIPT_DIR) not in sys.path:
    sys.path.insert(0, str(SCRIPT_DIR))

from _brief_runtime import ValidationResult, validate_brief


def print_text(result: ValidationResult) -> None:
    print(f"status: {result['status']}")
    print(f"consumption_ready: {result['consumption_ready']}")
    print("reasons:")
    for reason in result["reasons"]:
        print(f"- {reason}")
    print("consumption_reasons:")
    for reason in result["consumption_reasons"]:
        print(f"- {reason}")


def main() -> int:
    parser = argparse.ArgumentParser(description="Validate a Skill Architect build brief against protocol v1.")
    parser.add_argument(
        "--format",
        choices=("text", "json"),
        default="text",
        help="Output format for repo-local helper diagnostics.",
    )
    parser.add_argument("brief_file", help="Path to a standalone build brief text artifact.")
    args = parser.parse_args()

    path = Path(args.brief_file)
    text = path.read_text(encoding="utf-8")
    result = validate_brief(text)

    if args.format == "json":
        print(json.dumps(result, indent=2))
    else:
        print_text(result)

    if result["status"] == "valid":
        return 0
    if result["status"] == "incomplete":
        return 1
    return 2


if __name__ == "__main__":
    sys.exit(main())
