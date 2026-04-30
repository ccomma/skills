#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="$ROOT/skills"

usage() {
  cat <<'USAGE'
Usage:
  ./scripts/install.sh [--profile codex|cc-switch|claude] [--target PATH] [--all]

Options:
  --profile NAME   Install to a known profile target.
                   codex     -> ~/.agents/skills
                   cc-switch -> ~/.cc-switch/skills
                   claude    -> ~/.claude/skills
  --target PATH    Install to a custom skill directory.
  --all            Install to known target directories that already exist.
  -h, --help       Show this help.

Default:
  ./scripts/install.sh is equivalent to ./scripts/install.sh --profile codex

The installer creates symlinks and refuses to overwrite existing non-symlink
skill directories.
USAGE
}

profile_target() {
  case "$1" in
    codex) printf '%s\n' "$HOME/.agents/skills" ;;
    cc-switch) printf '%s\n' "$HOME/.cc-switch/skills" ;;
    claude) printf '%s\n' "$HOME/.claude/skills" ;;
    *)
      printf 'Unknown profile: %s\n' "$1" >&2
      return 1
      ;;
  esac
}

expand_path() {
  local value="$1"
  if [[ "$value" == ~/* ]]; then
    printf '%s/%s\n' "$HOME" "${value#~/}"
  else
    printf '%s\n' "$value"
  fi
}

install_one_skill() {
  local target_dir="$1"
  local skill_name="$2"
  local source_path="$SKILLS_DIR/$skill_name"
  local target_path="$target_dir/$skill_name"

  if [[ ! -d "$source_path" ]]; then
    printf 'Missing source skill: %s\n' "$source_path" >&2
    return 1
  fi

  mkdir -p "$target_dir"

  if [[ -L "$target_path" ]]; then
    local current
    current="$(readlink "$target_path")"
    if [[ "$current" == "$source_path" ]]; then
      printf 'Already installed: %s -> %s\n' "$target_path" "$source_path"
      return 0
    fi
    rm "$target_path"
  elif [[ -e "$target_path" ]]; then
    printf 'Refusing to overwrite existing non-symlink: %s\n' "$target_path" >&2
    printf 'Back it up or remove it, then run the installer again.\n' >&2
    return 1
  fi

  ln -s "$source_path" "$target_path"
  printf 'Installed: %s -> %s\n' "$target_path" "$source_path"
}

check_target_conflicts() {
  local target_dir="$1"
  local has_conflict=false

  for skill_path in "$SKILLS_DIR"/*; do
    [[ -d "$skill_path" ]] || continue

    local skill_name
    local target_path
    skill_name="$(basename "$skill_path")"
    target_path="$target_dir/$skill_name"

    if [[ -e "$target_path" && ! -L "$target_path" ]]; then
      printf 'Refusing to overwrite existing non-symlink: %s\n' "$target_path" >&2
      has_conflict=true
    fi
  done

  if [[ "$has_conflict" == true ]]; then
    printf 'Back up or remove conflicting paths, then run the installer again.\n' >&2
    return 1
  fi
}

install_to_target() {
  local target_dir
  target_dir="$(expand_path "$1")"

  check_target_conflicts "$target_dir"

  for skill_path in "$SKILLS_DIR"/*; do
    [[ -d "$skill_path" ]] || continue
    install_one_skill "$target_dir" "$(basename "$skill_path")"
  done
}

profile=""
target=""
install_all=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --profile)
      [[ $# -ge 2 ]] || { printf '--profile requires a value\n' >&2; exit 1; }
      profile="$2"
      shift 2
      ;;
    --target)
      [[ $# -ge 2 ]] || { printf '--target requires a value\n' >&2; exit 1; }
      target="$2"
      shift 2
      ;;
    --all)
      install_all=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      printf 'Unknown argument: %s\n' "$1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if [[ "$install_all" == true ]]; then
  if [[ -n "$profile" || -n "$target" ]]; then
    printf '--all cannot be combined with --profile or --target\n' >&2
    exit 1
  fi
  found=false
  for candidate in "$HOME/.agents/skills" "$HOME/.cc-switch/skills" "$HOME/.claude/skills"; do
    if [[ -d "$candidate" ]]; then
      found=true
      install_to_target "$candidate"
    fi
  done
  if [[ "$found" == false ]]; then
    printf 'No known existing skill target directories found. Use --target PATH.\n' >&2
    exit 1
  fi
  exit 0
fi

if [[ -n "$profile" && -n "$target" ]]; then
  printf 'Use either --profile or --target, not both.\n' >&2
  exit 1
fi

if [[ -n "$target" ]]; then
  install_to_target "$target"
else
  install_to_target "$(profile_target "${profile:-codex}")"
fi
