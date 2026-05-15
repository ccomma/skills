#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
runner="$script_dir/run-runtime-smoke.sh"

tmpdir="$(mktemp -d "${TMPDIR:-/tmp}/skill-architect-runtime-smoke.XXXXXX")"
trap 'rm -rf "$tmpdir"' EXIT

mkdir -p "$tmpdir/work"
cat > "$tmpdir/prompt.txt" <<'EOF'
Decide the owner component only.
EOF
cat > "$tmpdir/pass.txt" <<'EOF'
Pass if one owner component is named clearly.
EOF
cat > "$tmpdir/context.txt" <<'EOF'
Changed snippet:
- Treat each provider/runtime as an adapter, not as the harness definition.
EOF

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
rg -q 'target skill: skill-architect' "$tmpdir/pack.md"
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

assert payload["target_skill"] == "skill-architect"
assert payload["runtime_class"] == "direct-smoke"
assert "owner component" in payload["prompt"]
assert "Pass if" in payload["pass_criteria"]
assert payload["context"][0]["label"] == "context.txt"
assert "Changed snippet:" in payload["context"][0]["text"]
assert isinstance(payload["use_rule"], list) and payload["use_rule"]
PY

printf 'runtime smoke self-check passed for skill-architect\n'
