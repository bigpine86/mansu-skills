#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
README_FILE="$ROOT_DIR/README.md"
README_KO_FILE="$ROOT_DIR/README.ko.md"
PHILOSOPHY_FILE="$ROOT_DIR/MANSU_PHILOSOPHY.md"
AGENTS_TEMPLATE="$ROOT_DIR/mansu-operating-model/references/AGENTS.md"
CODING_RULES_TEMPLATE="$ROOT_DIR/mansu-operating-model/references/CODING_RULES.md"
DOCTRINE_REF="$ROOT_DIR/mansu-operating-model/references/DOCTRINE.md"
SOURCE_CATALOG="$ROOT_DIR/mansu-operating-model/references/SOURCE_SKILL_CATALOG.md"
DOC_ORDER="$ROOT_DIR/mansu-operating-model/references/DOCUMENT_CREATION_ORDER.md"
CODE_ORDER="$ROOT_DIR/mansu-operating-model/references/CODE_CONSTRUCTION_ORDER.md"
FUTURE_BKIT="$ROOT_DIR/mansu-operating-model/references/FUTURE_BKIT_IDEAS.md"

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
[ -f "$README_KO_FILE" ] || fail "missing README.ko.md"
[ -f "$PHILOSOPHY_FILE" ] || fail "missing MANSU_PHILOSOPHY.md"
[ -f "$AGENTS_TEMPLATE" ] || fail "missing AGENTS template"
[ -f "$CODING_RULES_TEMPLATE" ] || fail "missing CODING_RULES template"
[ -f "$DOCTRINE_REF" ] || fail "missing DOCTRINE reference"
[ -f "$SOURCE_CATALOG" ] || fail "missing SOURCE_SKILL_CATALOG reference"
[ -f "$DOC_ORDER" ] || fail "missing DOCUMENT_CREATION_ORDER reference"
[ -f "$CODE_ORDER" ] || fail "missing CODE_CONSTRUCTION_ORDER reference"
[ -f "$FUTURE_BKIT" ] || fail "missing FUTURE_BKIT_IDEAS reference"

contains "$README_FILE" 'mansu-operating-model' || fail 'README should mention mansu-operating-model'
contains "$README_FILE" 'validate_mansu_operating_model\.sh' || fail 'README should mention validate_mansu_operating_model.sh'
contains "$README_FILE" 'AGENTS\.md' || fail 'README should mention AGENTS template'
contains "$README_FILE" 'CODING_RULES\.md' || fail 'README should mention CODING_RULES template'
contains "$DOCTRINE_REF" '^# Mansu Doctrine Reference$' || fail 'DOCTRINE reference should have canonical title'
contains "$SOURCE_CATALOG" '^# Mansu Source Skill Catalog$' || fail 'SOURCE_SKILL_CATALOG should have canonical title'
contains "$DOC_ORDER" '^# Mansu Document Creation Router$' || fail 'DOCUMENT_CREATION_ORDER should have canonical router title'
contains "$CODE_ORDER" '^# Mansu Code Construction Router$' || fail 'CODE_CONSTRUCTION_ORDER should have canonical router title'
contains "$FUTURE_BKIT" '^# Future bkit Ideas For Mansu$' || fail 'FUTURE_BKIT_IDEAS should have canonical title'
contains "$FUTURE_BKIT" 'not an active routing catalog' || fail 'FUTURE_BKIT_IDEAS should stay outside active routing'
contains "$FUTURE_BKIT" 'Mansu aims for maximum autonomy by default' || fail 'FUTURE_BKIT_IDEAS should preserve full-autonomy stance'
contains "$README_FILE" 'SOURCE_SKILL_CATALOG\.md' || fail 'README should mention source skill catalog'
contains "$README_FILE" 'SOURCE_SKILL_LOCK\.json' || fail 'README should mention source skill lock'
contains "$README_FILE" 'DOCUMENT_CREATION_ORDER\.md' || fail 'README should mention document creation order'
contains "$README_FILE" 'CODE_CONSTRUCTION_ORDER\.md' || fail 'README should mention code construction order'
contains "$README_FILE" 'mansu-project-start' || fail 'README should mention mansu-project-start'
contains "$README_FILE" 'mansu-ship-release' || fail 'README should mention mansu-ship-release'
contains "$README_FILE" '^## Big Picture$' || fail 'README should include big picture model'
contains "$README_FILE" 'Lifecycle phase spine' || fail 'README should mention lifecycle phase spine layer'
contains "$README_FILE" 'Project definition / memory source' || fail 'README should mention project definition and memory layer'
contains "$README_FILE" 'Implementation actor' || fail 'README should mention implementation actor layer'
contains "$README_FILE" 'project roadmap/phase order' || fail 'README should preserve project roadmap/phase order boundary'
contains "$README_FILE" 'Large feature order comes before a phase `PLAN.md`' || fail 'README should preserve large-grain order before phase PLAN'
contains "$README_FILE" 'representative routes, not fixed dependencies' || fail 'README should keep source routes representative, not mandatory'
contains "$README_FILE" 'source route verified by mansu-source-curator' || fail 'README should require source-curator verification for substitute routes'
contains "$README_FILE" 'Last verified: 2026-05-16' || fail 'README freshness date should match source lock'
contains "$README_FILE" 'active phase execution plan' || fail 'README should keep PLAN.md scoped to active phase execution'
contains "$README_FILE" 'Ouroboros, gstack, Oh My / OMO / OMC, addyosmani/agent-skills, VoltAgent/awesome-design-md, and Open Design source freshness' || fail 'README should mention source freshness checks'
contains "$README_FILE" 'install/update Ouroboros, gstack, and the matching Oh My adapter' || fail 'README should mention source tool install/update checks'
contains "$README_FILE" 'MANSU_COMPARE_INSTALLED=1 scripts/validate_mansu_installed_copies\.sh /Users/hansol/\.codex/skills' || fail 'README should document installed copy comparison command'
contains "$README_FILE" 'obsolete `mansu-\*` skill is still installed' || fail 'README should document obsolete installed skill detection'
contains "$README_FILE" '\[한국어\]\(\./README\.ko\.md\)' || fail 'README should link Korean README'
contains "$README_KO_FILE" '\[English\]\(\./README\.md\)' || fail 'Korean README should link English README'
contains "$README_KO_FILE" '최고의 자동화는 모든 것을 직접 만드는 데서 오지 않습니다' || fail 'Korean README should preserve Mansu philosophy'
contains "$README_KO_FILE" '대표 route이지 고정 의존성이 아닙니다' || fail 'Korean README should keep source routes representative'
contains "$README_KO_FILE" '현재 phase의 active execution plan' || fail 'Korean README should keep PLAN.md scoped to active phase execution'
contains "$README_KO_FILE" 'MANSU_COMPARE_INSTALLED=1 scripts/validate_mansu_installed_copies\.sh /Users/hansol/\.codex/skills' || fail 'Korean README should document installed copy comparison command'
contains "$README_KO_FILE" '더 이상 소스에 없는 `mansu-\*` 스킬' || fail 'Korean README should document obsolete installed skill detection'

contains "$PHILOSOPHY_FILE" 'mansu-operating-model' || fail 'MANSU_PHILOSOPHY should mention mansu-operating-model'
contains "$PHILOSOPHY_FILE" 'canonical doctrine' || fail 'MANSU_PHILOSOPHY should describe canonical doctrine role'
contains "$PHILOSOPHY_FILE" 'SOURCE_SKILL_CATALOG\.md' || fail 'MANSU_PHILOSOPHY should mention source skill catalog'
contains "$PHILOSOPHY_FILE" 'stale source map is a' || fail 'MANSU_PHILOSOPHY should treat stale source maps as routing bugs'
contains "$PHILOSOPHY_FILE" 'routing bug, not just old documentation' || fail 'MANSU_PHILOSOPHY should treat stale source maps as routing bugs'
contains "$PHILOSOPHY_FILE" 'addyosmani/agent-skills' || fail 'MANSU_PHILOSOPHY should mention addyosmani source freshness'
contains "$PHILOSOPHY_FILE" 'Open Design' || fail 'MANSU_PHILOSOPHY should mention Open Design source freshness'
contains "$PHILOSOPHY_FILE" 'Mansu runs approved CLI/lifecycle commands' || fail 'MANSU_PHILOSOPHY should say Mansu runs approved design CLI commands'
contains "$PHILOSOPHY_FILE" 'VoltAgent/awesome-design-md' || fail 'MANSU_PHILOSOPHY should mention design reference source freshness'
contains "$PHILOSOPHY_FILE" 'detects the current' || fail 'MANSU_PHILOSOPHY should mention dynamic coding-order routing'
contains "$PHILOSOPHY_FILE" 'current phase' || fail 'MANSU_PHILOSOPHY should mention current phase routing'
contains "$PHILOSOPHY_FILE" 'project roadmap/phase order' || fail 'MANSU_PHILOSOPHY should preserve roadmap before phase PLAN boundary'
contains "$PHILOSOPHY_FILE" '^## Mansu stack model$' || fail 'MANSU_PHILOSOPHY should include stack model'
contains "$PHILOSOPHY_FILE" 'The source names are representative, not mandatory' || fail 'MANSU_PHILOSOPHY should keep source names representative'
contains "$PHILOSOPHY_FILE" 'usable only after `mansu-source-curator` verifies' || fail 'MANSU_PHILOSOPHY should gate substitute routes through source-curator'

scan_files=(
  "$README_FILE"
  "$README_KO_FILE"
  "$PHILOSOPHY_FILE"
  "$SOURCE_CATALOG"
  "$DOC_ORDER"
  "$CODE_ORDER"
  "$ROOT_DIR/mansu-operating-model/references/SOURCE_SKILL_LOCK.json"
  "$ROOT_DIR/docs/mansu-manual.html"
  "$ROOT_DIR/mansu-setup/SKILL.md"
  "$ROOT_DIR/mansu-source-curator/SKILL.md"
)

deny_patterns=(
  'kwakseongjae/oh-my-design'
  'wakseongjae/oh-my-design'
  'google-labs-code/stitch-skills'
  'Leonxlnx/taste-skill'
  'uxjoseph/supanova-design-skill'
  'unclejobs-ai/taste-design-skill'
  'openai/skills.*figma-implement-design'
  'figma-implement-design'
  'supanova-design-skill'
  'stitch-skills'
)

for pattern in "${deny_patterns[@]}"; do
  if grep -E -n "$pattern" "${scan_files[@]}" >/dev/null; then
    fail "unverified design source leaked into active Mansu docs: $pattern"
  fi
done

stale_route_files=(
  "$README_FILE"
  "$README_KO_FILE"
  "$ROOT_DIR/docs/mansu-manual.html"
  "$SOURCE_CATALOG"
  "$DOC_ORDER"
  "$CODE_ORDER"
  "$ROOT_DIR/mansu-help/SKILL.md"
  "$ROOT_DIR/mansu-help/agents/openai.yaml"
  "$ROOT_DIR/mansu-manual/SKILL.md"
  "$ROOT_DIR/mansu-manual/agents/openai.yaml"
  "$ROOT_DIR/mansu-operating-model/SKILL.md"
  "$ROOT_DIR/mansu-operating-model/agents/openai.yaml"
  "$ROOT_DIR/mansu-project-start/SKILL.md"
  "$ROOT_DIR/mansu-project-start/agents/openai.yaml"
  "$ROOT_DIR/mansu-setup/SKILL.md"
  "$ROOT_DIR/mansu-setup/agents/openai.yaml"
  "$ROOT_DIR/mansu-source-curator/SKILL.md"
  "$ROOT_DIR/mansu-source-curator/agents/openai.yaml"
  "$ROOT_DIR/mansu-tdd-total/SKILL.md"
  "$ROOT_DIR/mansu-tdd-total/agents/openai.yaml"
)

for file in "${stale_route_files[@]}"; do
  [ -f "$file" ] || continue
  if grep -n 'mansu-start' "$file" >/dev/null; then
    fail "removed mansu-start route leaked into active docs: $file"
  fi
done

echo "mansu doc system references OK"
