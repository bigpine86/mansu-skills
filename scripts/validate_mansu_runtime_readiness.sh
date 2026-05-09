#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

RUNTIME_FILES=(
  "$ROOT_DIR/README.md"
  "$ROOT_DIR/docs/runtime-target-matrix.md"
  "$ROOT_DIR/mansu-setting/SKILL.md"
  "$ROOT_DIR/mansu-setting/agents/openai.yaml"
  "$ROOT_DIR/mansu-operating-model/SKILL.md"
  "$ROOT_DIR/mansu-operating-model/agents/openai.yaml"
  "$ROOT_DIR/mansu-operating-model/references/DOCTRINE.md"
  "$ROOT_DIR/mansu-operating-model/references/AGENTS.md"
  "$ROOT_DIR/mansu-operating-model/references/CODING_RULES.md"
  "$ROOT_DIR/mansu-debug-rootcause/SKILL.md"
  "$ROOT_DIR/mansu-debug-rootcause/agents/openai.yaml"
  "$ROOT_DIR/mansu-tdd-total/SKILL.md"
  "$ROOT_DIR/mansu-tdd-total/agents/openai.yaml"
  "$ROOT_DIR/mansu-tdd-strict/SKILL.md"
  "$ROOT_DIR/mansu-tdd-strict/agents/openai.yaml"
  "$ROOT_DIR/mansu-tdd-strict/references/bootstrap.md"
  "$ROOT_DIR/mansu-tdd-strict/references/prerequisites.md"
  "$ROOT_DIR/mansu-tdd-lite/SKILL.md"
  "$ROOT_DIR/mansu-tdd-lite/agents/openai.yaml"
  "$ROOT_DIR/mansu-web-verify/SKILL.md"
  "$ROOT_DIR/mansu-web-verify/agents/openai.yaml"
  "$ROOT_DIR/scripts/validate_mansu_setting.sh"
  "$ROOT_DIR/scripts/validate_mansu_tdd_lite.sh"
  "$ROOT_DIR/scripts/validate_mansu_tdd_series.sh"
  "$ROOT_DIR/scripts/validate_mansu_tdd_total.sh"
  "$ROOT_DIR/scripts/validate_mansu_debug_rootcause.sh"
  "$ROOT_DIR/scripts/validate_mansu_web_verify.sh"
  "$ROOT_DIR/scripts/validate_mansu_skills.sh"
  "$ROOT_DIR/scripts/validate_mansu_runtime_readiness.sh"
  "$ROOT_DIR/scripts/validate_mansu_operating_model.sh"
  "$ROOT_DIR/scripts/validate_mansu_doc_system.sh"
)

failures=0

assert_contains() {
  local pattern="$1"
  local file="$2"
  grep -q "$pattern" "$file"
}

note_pass() {
  echo "PASS: $1"
}

note_fail() {
  echo "FAIL: $1" >&2
  failures=1
}

is_allowed_file() {
  local candidate="$1"
  shift
  local allowed
  for allowed in "$@"; do
    if [ "$candidate" = "$allowed" ]; then
      return 0
    fi
  done
  return 1
}

check_scoped_pattern() {
  local label="$1"
  local pattern="$2"
  shift 2
  local allowed_files=("$@")
  local match_found=0
  local unexpected=()
  local file
  local line

  for file in "${RUNTIME_FILES[@]}"; do
    while IFS= read -r line; do
      [ -n "$line" ] || continue
      match_found=1
      if ! is_allowed_file "$file" "${allowed_files[@]}"; then
        unexpected+=("${line}")
      fi
    done < <(grep -n -E "$pattern" "$file" || true)
  done

  if [ "${#unexpected[@]}" -gt 0 ]; then
    note_fail "$label"
    printf '  %s\n' "${unexpected[@]}" >&2
    return
  fi

  if [ "$match_found" -eq 1 ]; then
    note_pass "$label"
  else
    note_fail "$label (pattern not found in any explicit zone)"
  fi
}

README_FILE="$ROOT_DIR/README.md"
MATRIX_FILE="$ROOT_DIR/docs/runtime-target-matrix.md"
SETTING_FILE="$ROOT_DIR/mansu-setting/SKILL.md"
SETTING_YAML="$ROOT_DIR/mansu-setting/agents/openai.yaml"
SETTING_VALIDATOR="$ROOT_DIR/scripts/validate_mansu_setting.sh"
TDD_SERIES_VALIDATOR="$ROOT_DIR/scripts/validate_mansu_tdd_series.sh"
DEBUG_FILE="$ROOT_DIR/mansu-debug-rootcause/SKILL.md"
DEBUG_VALIDATOR="$ROOT_DIR/scripts/validate_mansu_debug_rootcause.sh"
OPERATING_MODEL_VALIDATOR="$ROOT_DIR/scripts/validate_mansu_operating_model.sh"
SELF_FILE="$ROOT_DIR/scripts/validate_mansu_runtime_readiness.sh"

for file in "${RUNTIME_FILES[@]}"; do
  test -f "$file"
done

# Runtime-first contract must remain visible in the canonical docs.
assert_contains 'runtime target(Hermes, OpenCode, Codex, Claude Code), host, OS' "$README_FILE"
assert_contains 'compatibility check' "$README_FILE"
assert_contains '^# Runtime Target Matrix$' "$MATRIX_FILE"
assert_contains 'runtime target을 먼저 고르고, adapter는 그 다음에 본다' "$MATRIX_FILE"
assert_contains 'validator는 wording뿐 아니라 stale runtime assumptions도 잡아야 한다' "$MATRIX_FILE"
assert_contains 'Treat adapters as runtime-matched compatibility tooling layered on top of the runtime target' "$SETTING_FILE"
assert_contains 'Do not infer adapter requirements from runtime target detection alone' "$SETTING_FILE"
assert_contains 'missing compatibility tooling for the detected runtime should be installed' "$SETTING_FILE"
assert_contains 'report optional adapter compatibility' "$SETTING_YAML"
note_pass 'runtime-first adapter contract remains anchored in README, matrix, and mansu-setting'

# Hardcoded host/runtime path wording should stay inside explicit runtime-target docs and validators.
check_scoped_pattern \
  'host-specific skill target paths stay confined to explicit runtime-target zones' \
  '\$HOME/\.codex/skills|\$HOME/\.claude/skills|~/.config/opencode/skills|\.opencode/skills' \
  "$README_FILE" \
  "$MATRIX_FILE" \
  "$SETTING_FILE" \
  "$SETTING_VALIDATOR" \
  "$DEBUG_VALIDATOR" \
  "$SELF_FILE"

# Bad historical path wording should not come back anywhere in the runtime-facing suite.
check_scoped_pattern \
  'legacy OpenCode home path stays absent from runtime-facing files' \
  '\$HOME/\.opencode/skills' \
  "$SETTING_VALIDATOR" \
  "$SELF_FILE"

# Historical tool names are allowed only in explicit compatibility/reference zones.
check_scoped_pattern \
  'Oh My XX stays restricted to validator-only reference zones' \
  'Oh My XX' \
  "$TDD_SERIES_VALIDATOR" \
  "$SELF_FILE"

check_scoped_pattern \
  'gstack-review stays restricted to validator-only reference zones' \
  'gstack-review' \
  "$TDD_SERIES_VALIDATOR" \
  "$SELF_FILE"

check_scoped_pattern \
  'gstack-qa stays restricted to explicit anti-pattern or validator zones' \
  'gstack-qa' \
  "$DEBUG_FILE" \
  "$TDD_SERIES_VALIDATOR" \
  "$OPERATING_MODEL_VALIDATOR" \
  "$SELF_FILE"

check_scoped_pattern \
  'gstack-checkpoint stays restricted to compatibility or validator zones' \
  'gstack-checkpoint' \
  "$SETTING_FILE" \
  "$TDD_SERIES_VALIDATOR" \
  "$SELF_FILE"

# Adapter wording should not drift into the rest of the suite.
check_scoped_pattern \
  'adapter wording stays confined to startup/runtime-target docs and validators' \
  'adapter' \
  "$README_FILE" \
  "$MATRIX_FILE" \
  "$SETTING_FILE" \
  "$SETTING_YAML" \
  "$SETTING_VALIDATOR" \
  "$ROOT_DIR/scripts/validate_mansu_doc_system.sh" \
  "$OPERATING_MODEL_VALIDATOR" \
  "$SELF_FILE"

if [ "$failures" -ne 0 ]; then
  exit 1
fi

echo 'mansu runtime readiness OK'
