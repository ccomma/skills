#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
runner="$script_dir/run-runtime-smoke.sh"

tmpdir="$(mktemp -d "${TMPDIR:-/tmp}/skill-maintain-runtime-smoke.XXXXXX")"
trap 'rm -rf "$tmpdir"' EXIT

mkdir -p "$tmpdir/work"
cat > "$tmpdir/prompt.txt" <<'EOF'
Repair the owner component judgment only.
EOF
cat > "$tmpdir/pass.txt" <<'EOF'
Pass if one owner component is named clearly.
EOF
cat > "$tmpdir/context.txt" <<'EOF'
Changed snippet:
- Keep generic governance text abstract.
EOF

declare -a validated_adapters=()
declare -a skipped_adapters=()

adapter_exists() {
  local adapter_name="$1"
  case "$adapter_name" in
    codex)
      command -v codex >/dev/null 2>&1
      ;;
    direct)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

join_csv() {
  if [[ $# -eq 0 ]]; then
    printf 'none\n'
    return 0
  fi

  local first="true"
  local item
  for item in "$@"; do
    if [[ "$first" == "true" ]]; then
      printf '%s' "$item"
      first="false"
    else
      printf ', %s' "$item"
    fi
  done
  printf '\n'
}

check_harness_baseline() {
  bash -n "$runner"

  "$runner" \
    --runtime direct \
    --mode direct-pack \
    --workdir "$tmpdir/work" \
    --prompt-file "$tmpdir/prompt.txt" \
    --context-file "$tmpdir/context.txt" \
    --pass-file "$tmpdir/pass.txt" \
    --output-file "$tmpdir/pack.md"

  rg -q '^# Direct Smoke Pack' "$tmpdir/pack.md"
  rg -q 'target skill: skill-maintain' "$tmpdir/pack.md"
  rg -q '^## Context' "$tmpdir/pack.md"
  rg -q 'Changed snippet:' "$tmpdir/pack.md"

  "$runner" \
    --runtime direct \
    --mode direct-pack \
    --pack-format json \
    --workdir "$tmpdir/work" \
    --prompt-file "$tmpdir/prompt.txt" \
    --context-file "$tmpdir/context.txt" \
    --pass-file "$tmpdir/pass.txt" \
    --output-file "$tmpdir/pack.json"

  python3 - "$tmpdir/pack.json" <<'PY'
import json
import sys

path = sys.argv[1]
with open(path, "r", encoding="utf-8") as fh:
    payload = json.load(fh)

assert payload["target_skill"] == "skill-maintain"
assert payload["runtime_class"] == "direct-smoke"
assert "owner component" in payload["prompt"]
assert "Pass if" in payload["pass_criteria"]
assert payload["context"][0]["label"] == "context.txt"
assert "Changed snippet:" in payload["context"][0]["text"]
assert isinstance(payload["use_rule"], list) and payload["use_rule"]
PY
}

check_codex_adapter() {
  "$runner" \
    --runtime codex \
    --mode lean-cli \
    --dry-run \
    --workdir "$tmpdir/work" \
    --prompt-file "$tmpdir/prompt.txt" \
    --context-file "$tmpdir/context.txt" \
    --output-file "$tmpdir/codex-dry-run.json"

  "$runner" \
    --runtime codex \
    --mode lean-cli \
    --dry-run \
    --no-isolated-home \
    --workdir "$tmpdir/work" \
    --prompt-file "$tmpdir/prompt.txt" \
    --context-file "$tmpdir/context.txt" \
    --output-file "$tmpdir/codex-dry-run-no-home.json"

  python3 - "$tmpdir/codex-dry-run.json" "$tmpdir/codex-dry-run-no-home.json" <<'PY'
import json
import sys

first_path, second_path = sys.argv[1:]

with open(first_path, "r", encoding="utf-8") as fh:
    first = json.load(fh)
with open(second_path, "r", encoding="utf-8") as fh:
    second = json.load(fh)

for payload in (first, second):
    assert payload["runtime"] == "codex"
    assert payload["mode"] == "lean-cli"
    assert payload["skill_name"] == "skill-maintain"
    assert payload["skill_root"].endswith("/skills/skill-maintain")
    assert payload["workdir"].endswith("/work")
    assert isinstance(payload["command"], list) and payload["command"]
    assert "SKILL.md" in payload["composed_prompt"]
    assert "references/output-contracts.md" in payload["composed_prompt"]
    assert "Do not inspect sibling skills" in payload["composed_prompt"]
    assert "--disable" in " ".join(payload["command"])

assert first["uses_isolated_home"] is True
assert second["uses_isolated_home"] is False
PY
}

check_harness_baseline
printf 'runtime smoke baseline passed for skill-maintain\n'

if adapter_exists codex; then
  check_codex_adapter
  validated_adapters+=("codex")
  printf 'codex adapter self-check passed for skill-maintain\n'
else
  skipped_adapters+=("codex")
  printf 'codex adapter check skipped for skill-maintain: codex not installed\n'
fi

validated_summary="none"
skipped_summary="none"

if (( ${#validated_adapters[@]} > 0 )); then
  validated_summary="$(join_csv "${validated_adapters[@]}")"
fi

if (( ${#skipped_adapters[@]} > 0 )); then
  skipped_summary="$(join_csv "${skipped_adapters[@]}")"
fi

printf 'validated adapters: %s\n' "$validated_summary"
printf 'skipped adapters: %s\n' "$skipped_summary"
