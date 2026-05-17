from __future__ import annotations

import re
from typing import TypedDict


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

WEAK_READY_ITEM_PATTERNS = [
    re.compile(r"^(none|n/?a|nothing yet|no constraints|no special restrictions)$", re.I),
    re.compile(r"^(tbd|todo|decide later|same as above)$", re.I),
    re.compile(r"^follow the brief$", re.I),
]

SMALLEST_SMOKE_PATTERNS = [
    re.compile(r"\b(start|begin|default)\b.*\b(one|1|single)\b.*\b(prompt|smoke)\b", re.I),
    re.compile(r"\b(one or two|single|smallest|minimal|narrow)\b.*\b(smoke|prompt)\b", re.I),
    re.compile(r"\bfirst\b.*\b(smoke|prompt)\b", re.I),
]

STOP_RULE_PATTERNS = [
    re.compile(r"\bif\b.*\b(first|initial)\b.*\b(smoke|prompt)\b.*\bpass(?:es)?\b.*\bstop\b", re.I),
    re.compile(r"\bstop there\b", re.I),
    re.compile(r"\bdo not widen\b", re.I),
    re.compile(r"\binstead of widening\b", re.I),
]

ESCALATION_RULE_PATTERNS = [
    re.compile(r"\bescalat(?:e|ion)\b.*\bonly when\b", re.I),
    re.compile(r"\bonly when\b.*\b(trigger boundary|authority|cadence|broader routing|multi-turn|broader risk|broader smoke)\b", re.I),
    re.compile(r"\buse broader\b.*\bwhen\b", re.I),
    re.compile(r"\bfull runtime smoke\b.*\bonly\b", re.I),
]


class ParsedBrief(TypedDict):
    fields: dict[str, list[str]]
    positions: dict[str, int]
    duplicates: list[str]


class ValidationResult(TypedDict):
    status: str
    consumption_ready: str
    reasons: list[str]
    consumption_reasons: list[str]


def parse_fields(text: str) -> ParsedBrief:
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

    return {"fields": fields, "positions": positions, "duplicates": duplicates}


def block_text(block: list[str]) -> str:
    return "\n".join(block).strip()


def has_subitem(block: list[str], subitem: str) -> bool:
    target = f"- {subitem}:"
    return any(line.strip() == target for line in block)


def collect_nested_items(block: list[str], subitem: str) -> list[str]:
    target = f"- {subitem}:"
    items: list[str] = []
    in_section = False
    for line in block:
        stripped = line.strip()
        if stripped == target:
            in_section = True
            continue
        if not in_section:
            continue
        if stripped.startswith("- ") and not re.match(r"^\s{2,}-\s+", line):
            break
        if re.match(r"^\s{2,}-\s+\S", line):
            items.append(re.sub(r"^\s{2,}-\s+", "", line).strip())
            continue
        if items and line.startswith("    ") and stripped:
            items[-1] = f"{items[-1]} {stripped}"
    return items


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


def check_readiness_items(items: list[str], label: str) -> list[str]:
    reasons: list[str] = []
    if not items:
        reasons.append(f"`{label}` needs at least one non-empty item")
        return reasons
    weak = [item for item in items if any(pattern.match(item) for pattern in WEAK_READY_ITEM_PATTERNS)]
    if weak:
        reasons.append(f"manual review needed: `{label}` is too weak or placeholder-like ({', '.join(f'`{item}`' for item in weak)})")
    return reasons


def has_role(items: list[str], patterns: list[re.Pattern[str]]) -> bool:
    return any(pattern.search(item) for item in items for pattern in patterns)


def check_smoke_prompt_readiness(items: list[str], label: str) -> list[str]:
    reasons = check_readiness_items(items, label)
    if reasons:
        return reasons

    if len(items) < 2:
        reasons.append(f"`{label}` needs at least two non-empty items so the smallest smoke ladder is recoverable")

    if not has_role(items, SMALLEST_SMOKE_PATTERNS):
        reasons.append(f"`{label}` must name the default narrow live smoke")

    if not has_role(items, STOP_RULE_PATTERNS):
        reasons.append(f"`{label}` must say when the first narrow smoke passing is enough to stop")

    if not has_role(items, ESCALATION_RULE_PATTERNS):
        reasons.append(f"`{label}` must say when broader live smoke is warranted")

    return reasons


def validate_brief(text: str) -> ValidationResult:
    parsed = parse_fields(text)
    fields = parsed["fields"]
    positions = parsed["positions"]
    duplicates = parsed["duplicates"]
    reasons: list[str] = []
    consumption_reasons: list[str] = []
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

    if status == "valid":
        validation_block = fields.get("Validation starter", [])
        handoff_block = fields.get("Initializer handoff", [])
        consumption_reasons.extend(
            check_readiness_items(
                collect_nested_items(validation_block, "Deterministic checks"),
                "Validation starter -> Deterministic checks",
            )
        )
        consumption_reasons.extend(
            check_smoke_prompt_readiness(
                collect_nested_items(validation_block, "Smoke prompts"),
                "Validation starter -> Smoke prompts",
            )
        )
        consumption_reasons.extend(
            check_readiness_items(
                collect_nested_items(handoff_block, "Initialize"),
                "Initializer handoff -> Initialize",
            )
        )
        consumption_reasons.extend(
            check_readiness_items(
                collect_nested_items(handoff_block, "Do not invent"),
                "Initializer handoff -> Do not invent",
            )
        )

    if not reasons:
        reasons.append("brief matches protocol `v1` deterministic checks")

    consumption_ready = "yes"
    if status != "valid":
        consumption_ready = "no"
        consumption_reasons = ["protocol must be valid before readiness can be satisfied"]
    elif not consumption_reasons:
        consumption_reasons.append("brief is ready for downstream consumption")
    else:
        consumption_ready = "no"

    return {
        "status": status,
        "consumption_ready": consumption_ready,
        "reasons": reasons,
        "consumption_reasons": consumption_reasons,
    }


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
