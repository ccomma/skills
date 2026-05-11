#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  check-skill-bundle.sh /path/to/skill-dir [--expected-name NAME] [--forbid-name NAME ...]

Checks deterministic bundle consistency for one skill:
  - required files exist
  - frontmatter name matches expectation
  - local markdown links resolve
  - agent metadata matches the skill name
  - reference files are reachable from SKILL.md
  - forbidden old names are not lingering

Exit codes:
  0  no errors
  1  one or more consistency errors found
  2  usage error
USAGE
}

die() {
  printf '%s\n' "$*" >&2
  exit 2
}

skill_dir=""
expected_name=""
declare -a forbid_names=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      usage
      exit 0
      ;;
    --expected-name)
      [[ $# -ge 2 ]] || die "--expected-name requires a value"
      expected_name="$2"
      shift 2
      ;;
    --forbid-name)
      [[ $# -ge 2 ]] || die "--forbid-name requires a value"
      forbid_names+=("$2")
      shift 2
      ;;
    -*)
      die "Unknown option: $1"
      ;;
    *)
      if [[ -n "$skill_dir" ]]; then
        die "Only one skill directory may be provided"
      fi
      skill_dir="$1"
      shift
      ;;
  esac
done

[[ -n "$skill_dir" ]] || die "A skill directory is required"
[[ -d "$skill_dir" ]] || die "Skill directory not found: $skill_dir"

if ! command -v rg >/dev/null 2>&1; then
  die "This script requires rg"
fi

skill_dir="$(cd "$skill_dir" && pwd)"
skill_name="${expected_name:-$(basename "$skill_dir")}"
skill_file="$skill_dir/SKILL.md"
agent_file="$skill_dir/agents/openai.yaml"
references_dir="$skill_dir/references"

declare -a errors=()
declare -a warnings=()

add_error() {
  errors+=("$*")
}

add_warning() {
  warnings+=("$*")
}

extract_frontmatter_name() {
  awk '
    NR == 1 && $0 == "---" { in_frontmatter = 1; next }
    in_frontmatter && $0 == "---" { exit }
    in_frontmatter && $1 == "name:" {
      sub(/^name:[[:space:]]*/, "", $0)
      print $0
      exit
    }
  ' "$1"
}

extract_display_name() {
  awk -F'"' '/display_name:/ { print $2; exit }' "$1"
}

extract_default_prompt() {
  awk -F'"' '/default_prompt:/ { print $2; exit }' "$1"
}

normalize_for_display() {
  local input="$1"
  local part
  local result=""
  IFS='-' read -r -a parts <<<"$input"
  for part in "${parts[@]}"; do
    [[ -n "$part" ]] || continue
    result+="$(printf '%s' "$part" | awk '{print toupper(substr($0, 1, 1)) substr($0, 2)}') "
  done
  printf '%s\n' "${result% }"
}

check_required_files() {
  [[ -f "$skill_file" ]] || add_error "Missing SKILL.md"
  if [[ -d "$references_dir" ]]; then
    :
  else
    add_warning "No references directory found"
  fi
  if [[ -d "$skill_dir/scripts" ]]; then
    :
  fi
}

check_hidden_junk() {
  local junk_name
  while IFS= read -r junk_name; do
    [[ -n "$junk_name" ]] || continue
    add_warning "Hidden junk file present in skill bundle: $junk_name"
  done < <(find "$skill_dir" \( -name '.DS_Store' -o -name '._*' \) -type f | sed "s#^$skill_dir/##" | sort)
}

check_frontmatter_name() {
  local actual
  actual="$(extract_frontmatter_name "$skill_file")"
  if [[ -z "$actual" ]]; then
    add_error "Could not find frontmatter name in SKILL.md"
    return
  fi
  if [[ "$actual" != "$skill_name" ]]; then
    add_error "Frontmatter name mismatch: expected '$skill_name', found '$actual'"
  fi
}

check_agent_metadata() {
  [[ -f "$agent_file" ]] || return

  local display_name default_prompt expected_display
  display_name="$(extract_display_name "$agent_file")"
  default_prompt="$(extract_default_prompt "$agent_file")"
  expected_display="$(normalize_for_display "$skill_name")"

  if [[ -z "$display_name" ]]; then
    add_error "agents/openai.yaml is missing display_name"
  elif [[ "$display_name" != "$expected_display" ]]; then
    add_error "agents/openai.yaml display_name mismatch: expected '$expected_display', found '$display_name'"
  fi

  if [[ -z "$default_prompt" ]]; then
    add_error "agents/openai.yaml is missing default_prompt"
  elif [[ "$default_prompt" != *"\$${skill_name}"* ]]; then
    add_error "agents/openai.yaml default_prompt does not reference '$skill_name'"
  fi
}

check_local_links() {
  local file rel target
  while IFS=$'\t' read -r file rel; do
    [[ -n "$rel" ]] || continue
    [[ "$rel" == http* ]] && continue
    [[ "$rel" == \#* ]] && continue
    target="$(cd "$(dirname "$file")" && printf '%s/%s\n' "$(pwd)" "$rel")"
    if [[ ! -e "$target" ]]; then
      add_error "Broken local link in ${file#$skill_dir/}: $rel"
    fi
  done < <(rg -NoH '\[[^]]+\]\(([^)#]+)\)' "$skill_dir" --glob '*.md' --replace '$1' | awk -F: '{
    file=$1
    sub(/^[^:]*:/, "", $0)
    print file "\t" $0
  }')
}

check_references_reachable() {
  [[ -d "$references_dir" ]] || return
  local ref_file ref_name
  while IFS= read -r ref_file; do
    ref_name="$(basename "$ref_file")"
    if ! rg -Fq "$ref_name" "$skill_file"; then
      add_warning "Reference not linked from SKILL.md: references/$ref_name"
    fi
  done < <(find "$references_dir" -maxdepth 1 -type f | sort)
}

check_scripts_reachable() {
  local scripts_dir="$skill_dir/scripts"
  [[ -d "$scripts_dir" ]] || return 0
  local script_file script_name
  while IFS= read -r script_file; do
    script_name="$(basename "$script_file")"
    if ! rg -Fq "$script_name" "$skill_file" "$references_dir" "$agent_file" 2>/dev/null; then
      add_warning "Script not mentioned by SKILL.md, references, or agent metadata: scripts/$script_name"
    fi
  done < <(find "$scripts_dir" -maxdepth 1 -type f | sort)
}

check_forbidden_names() {
  if [[ ${#forbid_names[@]} -eq 0 ]]; then
    return
  fi
  local old_name
  for old_name in "${forbid_names[@]}"; do
    if rg -nF "$old_name" "$skill_dir" >/dev/null 2>&1; then
      add_error "Forbidden old name still present: $old_name"
    fi
  done
}

print_summary() {
  printf 'Bundle check: %s\n' "$skill_name"
  printf 'Skill dir: %s\n' "$skill_dir"
  printf 'Errors: %d\n' "${#errors[@]}"
  printf 'Warnings: %d\n' "${#warnings[@]}"

  if [[ ${#errors[@]} -gt 0 ]]; then
    printf '\nError details:\n'
    printf -- '- %s\n' "${errors[@]}"
  fi

  if [[ ${#warnings[@]} -gt 0 ]]; then
    printf '\nWarning details:\n'
    printf -- '- %s\n' "${warnings[@]}"
  fi
}

check_required_files
check_hidden_junk
[[ -f "$skill_file" ]] && check_frontmatter_name
check_agent_metadata
[[ -f "$skill_file" ]] && check_local_links
check_references_reachable
check_scripts_reachable
check_forbidden_names
print_summary

if [[ ${#errors[@]} -gt 0 ]]; then
  exit 1
fi
