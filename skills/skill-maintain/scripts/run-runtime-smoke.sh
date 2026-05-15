#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  run-runtime-smoke.sh \
    --runtime codex|direct \
    --mode direct-pack|lean-cli|full-cli \
    --workdir /path/to/repo \
    --prompt-file /path/to/prompt.txt \
    --output-file /path/to/output.txt \
    [--context-file /path/to/context.txt] \
    [--pass-file /path/to/pass.txt] \
    [--pack-format markdown|json] \
    [--no-isolated-home]

Runs one minimal live smoke through a supported runtime adapter.

Current adapters:
  codex   supports lean-cli and full-cli
  direct  supports direct-pack
USAGE
}

die() {
  printf '%s\n' "$*" >&2
  exit 2
}

runtime=""
mode="lean-cli"
workdir=""
prompt_file=""
output_file=""
use_isolated_home="true"
pass_file=""
pack_format="markdown"
context_files=()
context_file_count=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      usage
      exit 0
      ;;
    --runtime)
      [[ $# -ge 2 ]] || die "--runtime requires a value"
      runtime="$2"
      shift 2
      ;;
    --mode)
      [[ $# -ge 2 ]] || die "--mode requires a value"
      mode="$2"
      shift 2
      ;;
    --workdir)
      [[ $# -ge 2 ]] || die "--workdir requires a value"
      workdir="$2"
      shift 2
      ;;
    --prompt-file)
      [[ $# -ge 2 ]] || die "--prompt-file requires a value"
      prompt_file="$2"
      shift 2
      ;;
    --output-file)
      [[ $# -ge 2 ]] || die "--output-file requires a value"
      output_file="$2"
      shift 2
      ;;
    --context-file)
      [[ $# -ge 2 ]] || die "--context-file requires a value"
      context_files+=("$2")
      context_file_count=$((context_file_count + 1))
      shift 2
      ;;
    --pass-file)
      [[ $# -ge 2 ]] || die "--pass-file requires a value"
      pass_file="$2"
      shift 2
      ;;
    --pack-format)
      [[ $# -ge 2 ]] || die "--pack-format requires a value"
      pack_format="$2"
      shift 2
      ;;
    --no-isolated-home)
      use_isolated_home="false"
      shift
      ;;
    *)
      die "Unknown argument: $1"
      ;;
  esac
done

[[ -n "$runtime" ]] || die "--runtime is required"
[[ -n "$workdir" ]] || die "--workdir is required"
[[ -n "$prompt_file" ]] || die "--prompt-file is required"
[[ -n "$output_file" ]] || die "--output-file is required"
[[ -d "$workdir" ]] || die "Workdir not found: $workdir"
[[ -f "$prompt_file" ]] || die "Prompt file not found: $prompt_file"
if (( context_file_count > 0 )); then
  for context_file in "${context_files[@]}"; do
    [[ -f "$context_file" ]] || die "Context file not found: $context_file"
  done
fi

case "$runtime" in
  codex)
    command -v codex >/dev/null 2>&1 || die "codex is not installed"
    ;;
  direct)
    ;;
  *)
    die "Unsupported runtime adapter: $runtime"
    ;;
esac

case "$mode" in
  direct-pack|lean-cli|full-cli)
    ;;
  *)
    die "Unsupported mode: $mode"
    ;;
esac

case "$pack_format" in
  markdown|json)
    ;;
  *)
    die "Unsupported pack format: $pack_format"
    ;;
esac

if [[ "$mode" == "direct-pack" ]]; then
  [[ -n "$pass_file" ]] || die "--pass-file is required for direct-pack"
  [[ -f "$pass_file" ]] || die "Pass file not found: $pass_file"
fi

emit_direct_pack() {
  local skill_root skill_name
  skill_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
  skill_name="$(basename "$skill_root")"
  if [[ "$pack_format" == "json" ]]; then
    python3 - "$skill_name" "$workdir" "$prompt_file" "$pass_file" "${context_files[@]+"${context_files[@]}"}" > "$output_file" <<'PY'
import json
import pathlib
import sys

skill_name, workdir, prompt_path, pass_path, *context_paths = sys.argv[1:]
payload = {
    "target_skill": skill_name,
    "runtime_class": "direct-smoke",
    "workdir": workdir,
    "prompt": pathlib.Path(prompt_path).read_text(),
    "pass_criteria": pathlib.Path(pass_path).read_text(),
    "context": [
        {
            "label": pathlib.Path(path).name,
            "text": pathlib.Path(path).read_text(),
        }
        for path in context_paths
    ],
    "use_rule": [
        "Use this pack with the lightest available model wrapper, API harness, or agent test runner that can load only the target skill or changed artifact.",
        "Prefer changed snippets or tiny context extracts over full-file reads when they are enough to prove the behavior.",
        "Keep the answer brief and tied to the repaired behavior only.",
        "If this smoke passes clearly, stop.",
        "If it exposes one in-scope issue, repair it and rerun the same pack.",
        "Escalate to lean agent-CLI or broader regression/pressure tests only when this pack cannot prove the repaired behavior."
    ]
}
json.dump(payload, sys.stdout, ensure_ascii=True, indent=2)
sys.stdout.write("\n")
PY
    return 0
  fi
  cat > "$output_file" <<EOF
# Direct Smoke Pack

- target skill: $skill_name
- runtime class: direct-smoke
- workdir: $workdir

## Prompt

\`\`\`text
$(cat "$prompt_file")
\`\`\`

EOF
  if (( context_file_count > 0 )); then
    {
      printf '\n## Context\n\n'
      for context_file in "${context_files[@]}"; do
        printf '### %s\n\n' "$(basename "$context_file")"
        printf '```text\n'
        cat "$context_file"
        printf '\n```\n\n'
      done
    } >> "$output_file"
  fi
  cat >> "$output_file" <<EOF

## Pass Criteria

\`\`\`text
$(cat "$pass_file")
\`\`\`

## Use Rule

- Use this pack with the lightest available model wrapper, API harness, or agent test runner that can load only the target skill or changed artifact.
- Prefer changed snippets or tiny context extracts over full-file reads when they are enough to prove the behavior.
- Keep the answer brief and tied to the repaired behavior only.
- If this smoke passes clearly, stop.
- If it exposes one in-scope issue, repair it and rerun the same pack.
- Escalate to lean agent-CLI or broader regression/pressure tests only when this pack cannot prove the repaired behavior.
EOF
}

compose_prompt() {
  cat "$prompt_file"
  if (( context_file_count > 0 )); then
    printf '\n\nUse the following changed snippets or tiny context extracts first. Do not read broader files unless this context is insufficient.\n'
    for context_file in "${context_files[@]}"; do
      printf '\n[%s]\n' "$(basename "$context_file")"
      cat "$context_file"
      printf '\n'
    done
  fi
}

run_codex() {
  local -a cmd
  local skill_root skill_name smoke_home=""
  skill_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
  skill_name="$(basename "$skill_root")"
  cmd=(
    codex exec
    --ephemeral
    --ignore-user-config
    --ignore-rules
    -s read-only
    -C "$workdir"
    -o "$output_file"
  )

  if [[ "$mode" == "lean-cli" ]]; then
    cmd+=(
      --disable plugins
      --disable apps
      --disable browser_use
      --disable computer_use
      --disable memories
    )
  fi

  cmd+=("$(compose_prompt)")

  if [[ "$mode" == "lean-cli" && "$use_isolated_home" == "true" ]]; then
    smoke_home="$(mktemp -d "${TMPDIR:-/tmp}/codex-smoke-home.XXXXXX")"
    trap 'if [[ -n "${smoke_home:-}" ]]; then rm -rf "${smoke_home:-}"; fi' EXIT
    mkdir -p "$smoke_home/skills"
    if [[ -f "${CODEX_HOME:-$HOME/.codex}/auth.json" ]]; then
      cp "${CODEX_HOME:-$HOME/.codex}/auth.json" "$smoke_home/auth.json"
    fi
    if [[ -f "${CODEX_HOME:-$HOME/.codex}/version.json" ]]; then
      cp "${CODEX_HOME:-$HOME/.codex}/version.json" "$smoke_home/version.json"
    fi
    cp -R "$skill_root" "$smoke_home/skills/$skill_name"
    HOME="$smoke_home" CODEX_HOME="$smoke_home" "${cmd[@]}"
  else
    "${cmd[@]}"
  fi
}

case "$runtime" in
  direct)
    emit_direct_pack
    ;;
  codex)
    if [[ "$mode" == "direct-pack" ]]; then
      emit_direct_pack
    else
      run_codex
    fi
    ;;
esac
