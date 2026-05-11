#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  check-skill-bundle.sh /path/to/skill-dir [--expected-name NAME] [--forbid-name NAME ...] [--policy external|internal]

Checks deterministic bundle consistency for one skill:
  - required files exist
  - frontmatter name matches expectation
  - local markdown links resolve
  - agent metadata matches the skill name
  - reference files are reachable from SKILL.md
  - companion format files are reachable and have minimal structure and quality signals
  - forbidden old names are not lingering

Exit codes:
  0  no errors
  1  one or more consistency errors found
  2  usage error

Policy modes:
  external  default; keep companion-format quality and semantic drift as warnings
  internal  stricter; promote companion-format quality findings to errors
USAGE
}

die() {
  printf '%s\n' "$*" >&2
  exit 2
}

skill_dir=""
expected_name=""
policy="external"
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
    --policy)
      [[ $# -ge 2 ]] || die "--policy requires a value"
      policy="$2"
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
[[ "$policy" == "external" || "$policy" == "internal" ]] || die "Policy must be 'external' or 'internal'"

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
  local category="$1"
  shift
  if [[ "$policy" == "internal" && "$category" == "format-quality" ]]; then
    add_error "[$category] $*"
    return 0
  fi
  warnings+=("[$category] $*")
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
    add_warning "bundle" "No references directory found"
  fi
  if [[ -d "$skill_dir/scripts" ]]; then
    :
  fi
}

check_hidden_junk() {
  local junk_name
  while IFS= read -r junk_name; do
    [[ -n "$junk_name" ]] || continue
    add_warning "bundle" "Hidden junk file present in skill bundle: $junk_name"
  done < <(find "$skill_dir" \( -name '.DS_Store' -o -name '._*' \) -type f | sed "s#^$skill_dir/##" | sort)
  return 0
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
  [[ -f "$agent_file" ]] || return 0

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
  done < <(awk '
    BEGIN {
      in_code = 0
    }
    /^```/ {
      in_code = !in_code
      next
    }
    in_code {
      next
    }
    {
      line = $0
      while (match(line, /\[[^]]+\]\(([^)#]+)\)/)) {
        rel = substr(line, RSTART, RLENGTH)
        sub(/^[^[]*\[[^]]+\]\(/, "", rel)
        sub(/\)$/, "", rel)
        print FILENAME "\t" rel
        line = substr(line, RSTART + RLENGTH)
      }
    }
  ' "$skill_dir"/*.md "$skill_dir"/references/*.md 2>/dev/null || true)
  return 0
}

check_references_reachable() {
  [[ -d "$references_dir" ]] || return 0
  local ref_file ref_name
  while IFS= read -r ref_file; do
    ref_name="$(basename "$ref_file")"
    if ! rg -Fq "$ref_name" "$skill_file"; then
      add_warning "reachability" "Reference not linked from SKILL.md: references/$ref_name"
    fi
  done < <(find "$references_dir" -maxdepth 1 -type f | sort)
  return 0
}

check_scripts_reachable() {
  local scripts_dir="$skill_dir/scripts"
  [[ -d "$scripts_dir" ]] || return 0
  local script_file script_name
  while IFS= read -r script_file; do
    script_name="$(basename "$script_file")"
    if ! rg -Fq "$script_name" "$skill_file" "$references_dir" "$agent_file" 2>/dev/null; then
      add_warning "reachability" "Script not mentioned by SKILL.md, references, or agent metadata: scripts/$script_name"
    fi
  done < <(find "$scripts_dir" -maxdepth 1 -type f | sort)
  return 0
}

reference_has_load_language() {
  local target_name="$1"
  local match_lines line
  match_lines="$(rg -nF "$target_name" "$skill_file" 2>/dev/null || true)"
  [[ -n "$match_lines" ]] || return 1

  while IFS= read -r line; do
    [[ -n "$line" ]] || continue
    if printf '%s' "$line" | rg -qi '\b(load|use|using|when|before|during|after|if)\b'; then
      return 0
    fi
  done <<EOF
$match_lines
EOF

  return 1
}

check_known_format_semantics() {
  local base_name="$1"
  local rel_path="$2"
  local content="$3"
  local lowered
  lowered="$(printf '%s' "$base_name" | tr '[:upper:]' '[:lower:]')"

  case "$lowered" in
    *adr-format.md)
      if ! printf '%s' "$content" | rg -qi '\b(hard to reverse|surprising|trade-off|durable|considered options|consequences)\b'; then
        add_warning "semantic-drift" "ADR format file may be missing decision-threshold semantics: $rel_path"
      fi
      ;;
    *context-format.md)
      if ! printf '%s' "$content" | rg -qi '\b(ambiguities|avoid|relationships|language|terms?)\b'; then
        add_warning "semantic-drift" "Context format file may be missing domain-language semantics: $rel_path"
      fi
      ;;
    *handoff-format.md)
      if ! printf '%s' "$content" | rg -qi '\b(next work|verification|branch|resume|current state|avoid list)\b'; then
        add_warning "semantic-drift" "Handoff format file may be missing execution-handoff semantics: $rel_path"
      fi
      ;;
  esac
}

check_companion_format_files() {
  local format_file rel_path base_name content
  while IFS= read -r format_file; do
    [[ -n "$format_file" ]] || continue
    rel_path="${format_file#$skill_dir/}"
    base_name="$(basename "$format_file")"

    if ! rg -Fq "$base_name" "$skill_file" 2>/dev/null; then
      add_warning "reachability" "Companion format file is not referenced from SKILL.md: $rel_path"
    elif ! reference_has_load_language "$base_name"; then
      add_warning "reachability" "Companion format file is mentioned without an explicit load/use condition in SKILL.md: $rel_path"
    fi

    content="$(cat "$format_file")"
    if ! printf '%s' "$content" | rg -qi '^(##|#)[[:space:]]+(Template|Structure)\b'; then
      add_warning "format-quality" "Companion format file may be missing a minimal shape section (Template or Structure): $rel_path"
    fi

    if ! printf '%s' "$content" | rg -qi '\b(when|only when|do not|skip|worth creating|worth using|required|optional)\b'; then
      add_warning "format-quality" "Companion format file may be missing usage-threshold guidance: $rel_path"
    fi

    if ! printf '%s' "$content" | rg -qi '\b(required|must|optional)\b'; then
      add_warning "format-quality" "Companion format file may be missing required-vs-optional guidance: $rel_path"
    fi

    if ! printf '%s' "$content" | rg -qi '\b(do not|should not|when not|skip|instead of|only when)\b'; then
      add_warning "format-quality" "Companion format file may be missing wrong-scope or anti-ritual guidance: $rel_path"
    fi

    check_known_format_semantics "$base_name" "$rel_path" "$content"
  done < <(find "$skill_dir" -type f \( -name '*-format.md' -o -name '*-FORMAT.md' \) ! -path "$references_dir/*" | sort)

  if [[ -d "$references_dir" ]]; then
    while IFS= read -r format_file; do
      [[ -n "$format_file" ]] || continue
      rel_path="${format_file#$skill_dir/}"
      base_name="$(basename "$format_file")"

      if ! rg -Fq "$base_name" "$skill_file" 2>/dev/null; then
        add_warning "reachability" "Referenced format file in references/ is not mentioned by SKILL.md: $rel_path"
      elif ! reference_has_load_language "$base_name"; then
        add_warning "reachability" "Referenced format file in references/ is mentioned without an explicit load/use condition in SKILL.md: $rel_path"
      fi

      content="$(cat "$format_file")"
      check_known_format_semantics "$base_name" "$rel_path" "$content"
    done < <(find "$references_dir" -maxdepth 1 -type f \( -name '*-format.md' -o -name '*-FORMAT.md' \) | sort)
  fi
  return 0
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
  printf 'Policy: %s\n' "$policy"
  printf 'Errors: %d\n' "${#errors[@]}"
  printf 'Warnings: %d\n' "${#warnings[@]}"

  if [[ ${#errors[@]} -gt 0 ]]; then
    printf '\nError details:\n'
    printf -- '- %s\n' "${errors[@]}"
  fi

  if [[ ${#warnings[@]} -gt 0 ]]; then
    printf '\nWarning categories:\n'
    printf '%s\n' "${warnings[@]}" | sed -n 's/^\[\([^]]*\)\].*/\1/p' | sort | uniq -c | awk '{printf "- %s: %s\n", $2, $1}'
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
check_companion_format_files
check_forbidden_names
print_summary

if [[ ${#errors[@]} -gt 0 ]]; then
  exit 1
fi
