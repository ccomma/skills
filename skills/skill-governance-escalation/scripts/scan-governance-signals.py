#!/usr/bin/env python3
"""Deterministic governance-signal scan for text-heavy artifacts.

This script does not decide ownership or routing by itself. It only surfaces
candidate signals that are worth human or workflow-level judgment.
"""

from __future__ import annotations

import argparse
import fnmatch
import os
import re
import sys
from collections import defaultdict
from pathlib import Path


TEXT_SUFFIXES = {".md", ".txt", ".yaml", ".yml"}
LOCAL_CONTEXT_PATTERNS = [
    re.compile(r"/Users/"),
    re.compile(r"~/.+"),
    re.compile(r"\.agents/skills"),
    re.compile(r"\.claude/skills"),
    re.compile(r"\.codex/skills"),
]
ENGLISH_HEADING_RE = re.compile(r"^[A-Za-z][A-Za-z0-9 /&:+().,'_-]{3,}$")
CJK_RE = re.compile(r"[\u4e00-\u9fff]")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Scan text artifacts for deterministic governance signals."
    )
    parser.add_argument("paths", nargs="+", help="File or directory paths to scan")
    parser.add_argument(
        "--exclude",
        action="append",
        default=[],
        help="Glob pattern to exclude from scanning. May be passed multiple times.",
    )
    return parser.parse_args()


def is_excluded(path: Path, patterns: list[str]) -> bool:
    path_text = str(path)
    return any(fnmatch.fnmatch(path_text, pattern) for pattern in patterns)


def collect_files(paths: list[str], exclude_patterns: list[str]) -> list[Path]:
    files: list[Path] = []
    for raw in paths:
        path = Path(raw).expanduser()
        if not path.exists():
            continue
        if path.is_file():
            if path.suffix.lower() in TEXT_SUFFIXES and not is_excluded(path, exclude_patterns):
                files.append(path)
            continue
        for child in sorted(path.rglob("*")):
            if (
                child.is_file()
                and child.suffix.lower() in TEXT_SUFFIXES
                and not is_excluded(child, exclude_patterns)
            ):
                files.append(child)
    return files


def strip_code_spans(text: str) -> str:
    return re.sub(r"`[^`]+`", "", text)


def headings_only_markdown(path: Path, text: str) -> bool:
    if path.suffix.lower() != ".md":
        return False

    in_code = False
    heading_count = 0
    guidance_count = 0

    for raw in text.splitlines():
        line = raw.strip()
        if line.startswith("```"):
            in_code = not in_code
            continue
        if in_code or not line:
            continue
        if line.startswith("#"):
            heading_count += 1
            continue
        if line.startswith(">") or line.startswith("- ") or re.match(r"^\d+\.\s", line):
            guidance_count += 1
            continue
        if line.startswith("|"):
            guidance_count += 1
            continue
        guidance_count += 1

    return heading_count >= 2 and guidance_count == 0


def mixed_language_headings(path: Path, text: str) -> bool:
    if path.suffix.lower() != ".md":
        return False

    has_cjk_heading = False
    has_english_heading = False

    for raw in text.splitlines():
        line = raw.strip()
        if not line.startswith("#"):
            continue
        heading = strip_code_spans(line.lstrip("#").strip())
        if not heading:
            continue
        if CJK_RE.search(heading):
            has_cjk_heading = True
        elif ENGLISH_HEADING_RE.match(heading):
            has_english_heading = True

    return has_cjk_heading and has_english_heading


def local_context_leakage(text: str) -> list[tuple[int, str]]:
    findings: list[tuple[int, str]] = []
    for idx, raw in enumerate(text.splitlines(), start=1):
        for pattern in LOCAL_CONTEXT_PATTERNS:
            if pattern.search(raw):
                findings.append((idx, raw.strip()))
                break
    return findings


def summarize(findings: dict[str, list[str]]) -> None:
    print("Signal summary:")
    if not any(findings.values()):
        print("- no deterministic governance signals found")
        return
    for key in sorted(findings):
        print(f"- {key}: {len(findings[key])}")


def main() -> int:
    args = parse_args()
    files = collect_files(args.paths, args.exclude)

    if not files:
        print("No matching text files found.", file=sys.stderr)
        return 1

    findings: dict[str, list[str]] = defaultdict(list)

    for path in files:
        try:
            text = path.read_text(encoding="utf-8")
        except UnicodeDecodeError:
            text = path.read_text(encoding="utf-8", errors="ignore")

        if headings_only_markdown(path, text):
            findings["headings-only-markdown"].append(str(path))

        if mixed_language_headings(path, text):
            findings["mixed-language-headings"].append(str(path))

        for line_no, line in local_context_leakage(text):
            snippet = line
            if len(snippet) > 120:
                snippet = snippet[:117] + "..."
            findings["local-context-leakage"].append(
                f"{path}:{line_no}: {snippet}"
            )

    summarize(findings)
    if any(findings.values()):
        print("\nFindings:")
        for key in sorted(findings):
            if not findings[key]:
                continue
            print(f"[{key}]")
            for item in findings[key]:
                print(f"- {item}")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
