#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
README_FILE="$ROOT_DIR/README.md"
PHILOSOPHY_FILE="$ROOT_DIR/MANSU_PHILOSOPHY.md"
AGENTS_TEMPLATE="$ROOT_DIR/mansu-operating-model/references/AGENTS.md"
CODING_RULES_TEMPLATE="$ROOT_DIR/mansu-operating-model/references/CODING_RULES.md"

fail() {
  echo "FAIL: $1" >&2
  exit 1
}

contains() {
  local file="$1"
  local pattern="$2"
  grep -Eq "$pattern" "$file"
}

[ -f "$README_FILE" ] || fail "missing README.md"
[ -f "$PHILOSOPHY_FILE" ] || fail "missing MANSU_PHILOSOPHY.md"
[ -f "$AGENTS_TEMPLATE" ] || fail "missing AGENTS template"
[ -f "$CODING_RULES_TEMPLATE" ] || fail "missing CODING_RULES template"

contains "$README_FILE" 'mansu-operating-model' || fail 'README should mention mansu-operating-model'
contains "$README_FILE" 'validate_mansu_operating_model\.sh' || fail 'README should mention validate_mansu_operating_model.sh'
contains "$README_FILE" 'AGENTS\.md' || fail 'README should mention AGENTS template'
contains "$README_FILE" 'CODING_RULES\.md' || fail 'README should mention CODING_RULES template'

contains "$PHILOSOPHY_FILE" 'mansu-operating-model' || fail 'MANSU_PHILOSOPHY should mention mansu-operating-model'
contains "$PHILOSOPHY_FILE" 'canonical doctrine' || fail 'MANSU_PHILOSOPHY should describe canonical doctrine role'

echo "mansu doc system references OK"
