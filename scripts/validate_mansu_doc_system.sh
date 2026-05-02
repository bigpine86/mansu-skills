#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
README_FILE="$ROOT_DIR/README.md"
PHILOSOPHY_FILE="$ROOT_DIR/MANSU_PHILOSOPHY.md"
AGENTS_TEMPLATE="$ROOT_DIR/mansu-operating-model/references/AGENTS.md"
CODING_RULES_TEMPLATE="$ROOT_DIR/mansu-operating-model/references/CODING_RULES.md"
DOCTRINE_REF="$ROOT_DIR/mansu-operating-model/references/DOCTRINE.md"
SOURCE_CATALOG="$ROOT_DIR/mansu-operating-model/references/SOURCE_SKILL_CATALOG.md"
DOC_ORDER="$ROOT_DIR/mansu-operating-model/references/DOCUMENT_CREATION_ORDER.md"
CODE_ORDER="$ROOT_DIR/mansu-operating-model/references/CODE_CONSTRUCTION_ORDER.md"

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
[ -f "$DOCTRINE_REF" ] || fail "missing DOCTRINE reference"
[ -f "$SOURCE_CATALOG" ] || fail "missing SOURCE_SKILL_CATALOG reference"
[ -f "$DOC_ORDER" ] || fail "missing DOCUMENT_CREATION_ORDER reference"
[ -f "$CODE_ORDER" ] || fail "missing CODE_CONSTRUCTION_ORDER reference"

contains "$README_FILE" 'mansu-operating-model' || fail 'README should mention mansu-operating-model'
contains "$README_FILE" 'validate_mansu_operating_model\.sh' || fail 'README should mention validate_mansu_operating_model.sh'
contains "$README_FILE" 'AGENTS\.md' || fail 'README should mention AGENTS template'
contains "$README_FILE" 'CODING_RULES\.md' || fail 'README should mention CODING_RULES template'
contains "$DOCTRINE_REF" '^# Mansu Doctrine Reference$' || fail 'DOCTRINE reference should have canonical title'
contains "$SOURCE_CATALOG" '^# Mansu Source Skill Catalog$' || fail 'SOURCE_SKILL_CATALOG should have canonical title'
contains "$DOC_ORDER" '^# Mansu Document Creation Router$' || fail 'DOCUMENT_CREATION_ORDER should have canonical router title'
contains "$CODE_ORDER" '^# Mansu Code Construction Router$' || fail 'CODE_CONSTRUCTION_ORDER should have canonical router title'
contains "$README_FILE" 'SOURCE_SKILL_CATALOG\.md' || fail 'README should mention source skill catalog'
contains "$README_FILE" 'SOURCE_SKILL_LOCK\.json' || fail 'README should mention source skill lock'
contains "$README_FILE" 'DOCUMENT_CREATION_ORDER\.md' || fail 'README should mention document creation order'
contains "$README_FILE" 'CODE_CONSTRUCTION_ORDER\.md' || fail 'README should mention code construction order'
contains "$README_FILE" 'mansu-project-start' || fail 'README should mention mansu-project-start'
contains "$README_FILE" 'mansu-ship-release' || fail 'README should mention mansu-ship-release'
contains "$README_FILE" 'gstack, Oh My / OMO / OMC, and addyosmani/agent-skills source freshness' || fail 'README should mention source freshness checks'

contains "$PHILOSOPHY_FILE" 'mansu-operating-model' || fail 'MANSU_PHILOSOPHY should mention mansu-operating-model'
contains "$PHILOSOPHY_FILE" 'canonical doctrine' || fail 'MANSU_PHILOSOPHY should describe canonical doctrine role'
contains "$PHILOSOPHY_FILE" 'SOURCE_SKILL_CATALOG\.md' || fail 'MANSU_PHILOSOPHY should mention source skill catalog'
contains "$PHILOSOPHY_FILE" 'stale source map is a' || fail 'MANSU_PHILOSOPHY should treat stale source maps as routing bugs'
contains "$PHILOSOPHY_FILE" 'routing bug, not just old documentation' || fail 'MANSU_PHILOSOPHY should treat stale source maps as routing bugs'
contains "$PHILOSOPHY_FILE" 'addyosmani/agent-skills' || fail 'MANSU_PHILOSOPHY should mention addyosmani source freshness'
contains "$PHILOSOPHY_FILE" 'detects the current' || fail 'MANSU_PHILOSOPHY should mention dynamic coding-order routing'
contains "$PHILOSOPHY_FILE" 'construction phase' || fail 'MANSU_PHILOSOPHY should mention construction phase routing'

echo "mansu doc system references OK"
