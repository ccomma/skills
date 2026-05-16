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

check_frontmatter_yaml() {
  local parse_output
  if ! command -v ruby >/dev/null 2>&1; then
    add_warning "bundle" "Ruby is unavailable; skipping YAML frontmatter parse check"
    return 0
  fi

  if ! parse_output="$(
    ruby -e '
      require "yaml"
      path = ARGV.fetch(0)
      text = File.read(path)
      match = text.match(/\A---\n(.*?)\n---\n/m)
      raise "missing YAML frontmatter fence" unless match
      data = YAML.safe_load(match[1], permitted_classes: [], aliases: false)
      raise "frontmatter is not a mapping" unless data.is_a?(Hash)
    ' "$skill_file" 2>&1
  )"; then
    add_error "SKILL.md frontmatter is not valid YAML: $parse_output"
  fi
}

extract_display_name() {
  awk -F'"' '/display_name:/ { print $2; exit }' "$1"
}

extract_short_description() {
  awk -F'"' '/short_description:/ { print $2; exit }' "$1"
}

extract_default_prompt() {
  awk -F'"' '/default_prompt:/ { print $2; exit }' "$1"
}

check_loader_consumed_field_length() {
  local field_name="$1"
  local field_value="$2"
  local max_length=1024

  [[ -n "$field_value" ]] || return 0

  if (( ${#field_value} > max_length )); then
    add_error "agents/openai.yaml ${field_name} exceeds ${max_length} characters and may cause the loader to ignore the primary entry surface"
  fi
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

  local display_name short_description default_prompt expected_display
  display_name="$(extract_display_name "$agent_file")"
  short_description="$(extract_short_description "$agent_file")"
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

  check_loader_consumed_field_length "short_description" "$short_description"
  check_loader_consumed_field_length "default_prompt" "$default_prompt"
}

check_primary_surface_contract() {
  [[ -f "$skill_file" ]] || return 0

  local skill_text prompt_text output_contract_file output_text combined_text
  skill_text="$(cat "$skill_file")"
  prompt_text=""
  output_contract_file="$references_dir/output-contracts.md"
  output_text=""

  if [[ -f "$agent_file" ]]; then
    prompt_text="$(extract_default_prompt "$agent_file")"
  fi
  combined_text="$(printf '%s\n%s\n' "$skill_text" "$prompt_text")"

  case "$skill_name" in
    skill-maintain)
      if ! printf '%s' "$skill_text" | rg -qi 'maintenance verdict'; then
        add_warning "semantic-drift" "SKILL.md does not visibly mention the default maintenance verdict on the primary surface"
      fi

      if [[ -n "$prompt_text" ]]; then
        if ! printf '%s' "$prompt_text" | rg -qi 'maintenance verdict'; then
          add_warning "semantic-drift" "agents/openai.yaml default_prompt may be missing the default maintenance verdict contract"
        fi
        if ! printf '%s' "$prompt_text" | rg -Fq '$skill-architect'; then
          add_warning "semantic-drift" "agents/openai.yaml default_prompt may be missing the handoff route to \$skill-architect"
        fi
        if ! printf '%s' "$prompt_text" | rg -Fq '$skill-referee'; then
          add_warning "semantic-drift" "agents/openai.yaml default_prompt may be missing the handoff route to \$skill-referee"
        fi
        if ! printf '%s' "$prompt_text" | rg -Fq '$skill-governance-escalation'; then
          add_warning "semantic-drift" "agents/openai.yaml default_prompt may be missing the handoff route to \$skill-governance-escalation"
        fi
      fi

      if [[ -f "$output_contract_file" ]]; then
        output_text="$(cat "$output_contract_file")"
        if printf '%s' "$output_text" | rg -qi 'default output contract is a `?maintenance verdict`?|default output .*maintenance verdict'; then
          if ! printf '%s' "$skill_text" | rg -qi 'maintenance verdict'; then
            add_warning "semantic-drift" "references/output-contracts.md declares the default maintenance verdict, but SKILL.md does not visibly mirror it"
          fi
          if [[ -n "$prompt_text" ]] && ! printf '%s' "$prompt_text" | rg -qi 'maintenance verdict'; then
            add_warning "semantic-drift" "references/output-contracts.md declares the default maintenance verdict, but agents/openai.yaml default_prompt does not visibly mirror it"
          fi
        fi
      fi
      ;;
    skill-referee)
      if ! printf '%s' "$combined_text" | rg -qi 'metadata-first (owner )?ruling|(owner )?ruling.*metadata-first'; then
        add_warning "semantic-drift" "Primary surface does not visibly state the metadata-first owner ruling contract"
      fi
      if ! printf '%s' "$skill_text" | rg -Fq 'Primary Owner'; then
        add_warning "semantic-drift" "SKILL.md does not visibly expose \`Primary Owner\` on the ruling surface"
      fi
      if ! printf '%s' "$skill_text" | rg -Fq 'Handoff Rule'; then
        add_warning "semantic-drift" "SKILL.md does not visibly expose \`Handoff Rule\` on the ruling surface"
      fi
      if [[ -n "$prompt_text" ]]; then
        if ! printf '%s' "$prompt_text" | rg -Fq '$skill-architect'; then
          add_warning "semantic-drift" "agents/openai.yaml default_prompt may be missing the handoff route to \$skill-architect"
        fi
        if ! printf '%s' "$prompt_text" | rg -Fq '$skill-maintain'; then
          add_warning "semantic-drift" "agents/openai.yaml default_prompt may be missing the handoff route to \$skill-maintain"
        fi
        if ! printf '%s' "$prompt_text" | rg -Fq '$skill-governance-escalation'; then
          add_warning "semantic-drift" "agents/openai.yaml default_prompt may be missing the handoff route to \$skill-governance-escalation"
        fi
      fi
      ;;
  esac

  return 0
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

check_reference_openings() {
  [[ -d "$references_dir" ]] || return 0
  local ref_file rel_path opening
  while IFS= read -r ref_file; do
    [[ -n "$ref_file" ]] || continue
    rel_path="${ref_file#$skill_dir/}"
    opening="$(sed -n '1,8p' "$ref_file")"
    if ! printf '%s' "$opening" | rg -qi 'load this (when|at)'; then
      add_warning "semantic-drift" "Reference opening may be missing an explicit load contract near the top: $rel_path"
    fi
  done < <(find "$references_dir" -maxdepth 1 -type f | sort)
  return 0
}

check_reference_link_style() {
  [[ -f "$skill_file" ]] || return 0

  local linked bare linked_list bare_list
  linked_list="$(rg -o '\[[^]]+\]\((references/[^)]+)\)' "$skill_file" 2>/dev/null | sed -E 's/.*\((references\/[^)]+)\)/\1/' | sort -u || true)"
  bare_list="$(rg -o '`references/[^`]+`' "$skill_file" 2>/dev/null | tr -d '`' | sort -u || true)"

  [[ -n "$linked_list" ]] || return 0
  [[ -n "$bare_list" ]] || return 0

  add_warning "semantic-drift" "SKILL.md mixes Markdown links and bare-path formatting for references; prefer one consistent reference-link style"
  return 0
}

check_usage_section_goal_language() {
  [[ -f "$skill_file" ]] || return 0

  local section_text
  section_text="$(awk '
    BEGIN { in_section = 0 }
    /^##[[:space:]]+(When To Use|Usage|Use Cases|Trigger Cases|Trigger Situations|When This Loads)\b/ {
      in_section = 1
      next
    }
    /^##[[:space:]]+/ {
      if (in_section) exit
    }
    in_section { print }
  ' "$skill_file")"

  [[ -n "$section_text" ]] || return 0

  if printf '%s' "$section_text" | rg -qi '\b(reduce token|token cost|resum|future session|preserve evidence|quality bar|branch-case|policy|governance)\b'; then
    add_warning "semantic-drift" "Usage-expansion section may be mixing workflow goals or policy language into trigger guidance"
  fi
  return 0
}

check_meta_reference_example_abstraction() {
  [[ -d "$references_dir" ]] || return 0

  case "$skill_name" in
    skill-architect|skill-maintain)
      local ref_file rel_path
      while IFS= read -r ref_file; do
        [[ -n "$ref_file" ]] || continue
        rel_path="${ref_file#$skill_dir/}"
        if rg -q '`[A-Z0-9_-]+-FORMAT\.md`' "$ref_file" 2>/dev/null; then
          add_warning "semantic-drift" "Generic meta-skill reference may use overly concrete format-file examples: $rel_path"
        fi
      done < <(find "$references_dir" -maxdepth 1 -type f | sort)
      ;;
  esac
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

check_scripts_syntax_and_self_checks() {
  local scripts_dir="$skill_dir/scripts"
  [[ -d "$scripts_dir" ]] || return 0
  local script_file rel_path script_name

  while IFS= read -r script_file; do
    [[ -n "$script_file" ]] || continue
    rel_path="${script_file#$skill_dir/}"
    if ! bash -n "$script_file" 2>/dev/null; then
      add_error "Shell syntax check failed: $rel_path"
    fi
  done < <(find "$scripts_dir" -maxdepth 1 -type f -name '*.sh' | sort)

  while IFS= read -r script_file; do
    [[ -n "$script_file" ]] || continue
    rel_path="${script_file#$skill_dir/}"
    script_name="$(basename "$script_file")"
    if [[ "$script_name" == "check-skill-bundle.sh" ]]; then
      continue
    fi
    if ! bash "$script_file" >/dev/null 2>&1; then
      add_error "Deterministic script self-check failed: $rel_path"
    fi
  done < <(find "$scripts_dir" -maxdepth 1 -type f -name 'check-*.sh' | sort)
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
[[ -f "$skill_file" ]] && check_frontmatter_yaml
[[ -f "$skill_file" ]] && check_frontmatter_name
check_agent_metadata
check_primary_surface_contract
[[ -f "$skill_file" ]] && check_local_links
check_references_reachable
check_reference_openings
check_reference_link_style
check_usage_section_goal_language
check_meta_reference_example_abstraction
check_scripts_reachable
check_scripts_syntax_and_self_checks
check_companion_format_files
check_forbidden_names
print_summary

if [[ ${#errors[@]} -gt 0 ]]; then
  exit 1
fi
