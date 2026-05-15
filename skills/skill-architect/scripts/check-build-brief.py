#!/usr/bin/env python3

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path


FIELD_LABELS = [
    "Kernel sentence",
    "Trigger boundary",
    "First move",
    "Strongest thing",
    "Not-this-skill-if",
    "Minimal shape",
    "Component decisions",
    "Do-not-add",
    "Validation starter",
    "Initializer handoff",
]

FIELD_PATTERN = re.compile(
    r"^(Kernel sentence|Trigger boundary|First move|Strongest thing|Not-this-skill-if|"
    r"Minimal shape|Component decisions|Do-not-add|Validation starter|Initializer handoff):\s*(.*)$"
)

WEAK_DO_NOT_ADD_PATTERNS = [
    re.compile(r"^\s*-\s*(none|n/?a|nothing yet|no constraints|no special restrictions)\s*$", re.I),
    re.compile(r"^\s*-\s*(tbd|todo|decide later)\s*$", re.I),
    re.compile(r"^\s*-\s*try not to\b", re.I),
    re.compile(r"^\s*-\s*avoid if possible\b", re.I),
]


def parse_fields(text: str) -> tuple[dict[str, list[str]], dict[str, int], list[str]]:
    fields: dict[str, list[str]] = {}
    positions: dict[str, int] = {}
    duplicates: list[str] = []
    current_label: str | None = None

    for lineno, line in enumerate(text.splitlines(), start=1):
        match = FIELD_PATTERN.match(line)
        if match:
            label = match.group(1)
            if label in fields:
                duplicates.append(f"duplicate field `{label}` at line {lineno}")
            else:
                fields[label] = []
                positions[label] = lineno
            current_label = label
            remainder = match.group(2).strip()
            if remainder:
                fields[label].append(remainder)
            continue
        if current_label is not None:
            fields[current_label].append(line)

    return fields, positions, duplicates


def block_text(block: list[str]) -> str:
    return "\n".join(block).strip()


def has_subitem(block: list[str], subitem: str) -> bool:
    target = f"- {subitem}:"
    return any(line.strip() == target for line in block)


def find_shape_conflict(minimal_shape: str, component_block: list[str]) -> str | None:
    shape = minimal_shape.strip().lower()
    component_text = "\n".join(component_block).lower()
    if shape == "skill.md only":
        patterns = [
            r"^\s*-\s*reference:",
            r"^\s*-\s*script:",
            r"\bone reference\b",
            r"\bone script\b",
            r"\ba reference\b",
            r"\ba script\b",
        ]
        for pattern in patterns:
            if re.search(pattern, component_text, re.M):
                return "shape conflict: `Minimal shape` says `SKILL.md only` but `Component decisions` still adds a reference or script"
    return None


def check_do_not_add(block: list[str]) -> tuple[str | None, str | None]:
    bullets = [line for line in block if line.strip().startswith("-")]
    if not bullets:
        return "incomplete", "`Do-not-add` is missing bullet items"
    for line in bullets:
        for pattern in WEAK_DO_NOT_ADD_PATTERNS:
            if pattern.match(line):
                return "invalid", f"manual review needed: `Do-not-add` is too weak or placeholder-like (`{line.strip()}`)"
    return None, None


def validate(text: str) -> tuple[str, list[str]]:
    fields, positions, duplicates = parse_fields(text)
    reasons: list[str] = []
    status = "valid"

    if duplicates:
        status = "invalid"
        reasons.extend(duplicates)

    missing = [label for label in FIELD_LABELS if label not in fields]
    if missing:
        if status != "invalid":
            status = "incomplete"
        reasons.append("missing required fields: " + ", ".join(f"`{label}`" for label in missing))

    present_labels = [label for label in FIELD_LABELS if label in positions]
    if present_labels:
        ordered = sorted(present_labels, key=lambda label: positions[label])
        if ordered != present_labels:
            status = "invalid"
            reasons.append("field order is invalid; required order must match protocol `v1`")

    if "Validation starter" in fields:
        block = fields["Validation starter"]
        if not has_subitem(block, "Deterministic checks"):
            if status != "invalid":
                status = "incomplete"
            reasons.append("`Validation starter` is missing `- Deterministic checks:`")
        if not has_subitem(block, "Smoke prompts"):
            if status != "invalid":
                status = "incomplete"
            reasons.append("`Validation starter` is missing `- Smoke prompts:`")

    if "Initializer handoff" in fields:
        block = fields["Initializer handoff"]
        if not has_subitem(block, "Initialize"):
            if status != "invalid":
                status = "incomplete"
            reasons.append("`Initializer handoff` is missing `- Initialize:`")
        if not has_subitem(block, "Do not invent"):
            if status != "invalid":
                status = "incomplete"
            reasons.append("`Initializer handoff` is missing `- Do not invent:`")

    if "Minimal shape" in fields and "Component decisions" in fields:
        conflict = find_shape_conflict(block_text(fields["Minimal shape"]), fields["Component decisions"])
        if conflict:
            status = "invalid"
            reasons.append(conflict)

    if "Do-not-add" in fields:
        do_not_add_status, do_not_add_reason = check_do_not_add(fields["Do-not-add"])
        if do_not_add_reason:
            if do_not_add_status == "invalid":
                status = "invalid"
            elif status != "invalid":
                status = "incomplete"
            reasons.append(do_not_add_reason)

    if not reasons:
        reasons.append("brief matches protocol `v1` deterministic checks")

    return status, reasons


def main() -> int:
    parser = argparse.ArgumentParser(description="Validate a Skill Architect build brief against protocol v1.")
    parser.add_argument("brief_file", help="Path to a standalone build brief text artifact.")
    args = parser.parse_args()

    path = Path(args.brief_file)
    text = path.read_text(encoding="utf-8")
    status, reasons = validate(text)

    print(f"status: {status}")
    print("reasons:")
    for reason in reasons:
        print(f"- {reason}")

    if status == "valid":
        return 0
    if status == "incomplete":
        return 1
    return 2


if __name__ == "__main__":
    sys.exit(main())
