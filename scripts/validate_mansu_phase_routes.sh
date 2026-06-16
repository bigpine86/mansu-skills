#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HELP="$ROOT_DIR/mansu-help/SKILL.md"
README="$ROOT_DIR/README.md"
README_KO="$ROOT_DIR/README.ko.md"
PLAN="$ROOT_DIR/PLAN.md"
LOCK="$ROOT_DIR/mansu-operating-model/references/SOURCE_SKILL_LOCK.json"
MANUAL="$ROOT_DIR/docs/mansu-manual.html"

for route in mansu-0help mansu-1define mansu-2plan mansu-3build mansu-4verify mansu-5review mansu-debug mansu-6ship mansu-9setup mansu-0manual; do
  test -f "$ROOT_DIR/$route/SKILL.md"
  test -f "$ROOT_DIR/$route/agents/openai.yaml"
  grep -q "$route" "$HELP"
  grep -q "$route" "$README"
  grep -q "$route" "$README_KO"
  grep -q "$route" "$MANUAL"
done

check_numbered_route() {
  local route="$1"
  local implementation="$2"
  local skill="$ROOT_DIR/$route/SKILL.md"
  local yaml="$ROOT_DIR/$route/agents/openai.yaml"

  grep -q "^name: $route$" "$skill"
  grep -q "Primary numbered .* route backed by $implementation" "$skill"
  grep -q "compatibility implementation \`$implementation\`" "$skill"
  grep -q "Read and follow the compatibility implementation \`$implementation/SKILL.md\`" "$skill"
  grep -q "Compatibility implementation: \`$implementation\`" "$skill"
  grep -q "Use [$]$route as the primary numbered route backed by $implementation" "$yaml"
  grep -q "Read $implementation/SKILL.md" "$yaml"
}

check_numbered_route mansu-0help mansu-help
check_numbered_route mansu-0manual mansu-manual
check_numbered_route mansu-1define mansu-define
check_numbered_route mansu-2plan mansu-plan
check_numbered_route mansu-3build mansu-build
check_numbered_route mansu-4verify mansu-verify
check_numbered_route mansu-5review mansu-review
check_numbered_route mansu-6ship mansu-ship
check_numbered_route mansu-9setup mansu-setup

for route in mansu-define mansu-plan mansu-build mansu-verify mansu-review mansu-debug mansu-ship; do
  grep -q "$route" "$HELP"
  grep -q "$route" "$README"
  grep -q "$route" "$README_KO"
  grep -q "$route" "$MANUAL"
done

grep -q 'Legacy compatibility aliases' "$HELP"
grep -q 'mansu-help.*mansu-0help' "$HELP"
grep -q 'mansu-manual.*mansu-0manual' "$HELP"
grep -q 'mansu-define.*mansu-1define' "$HELP"
grep -q 'mansu-plan.*mansu-2plan' "$HELP"
grep -q 'mansu-build.*mansu-3build' "$HELP"
grep -q 'mansu-verify.*mansu-4verify' "$HELP"
grep -q 'mansu-review.*mansu-5review' "$HELP"
grep -q 'mansu-ship.*mansu-6ship' "$HELP"
grep -q 'mansu-setup.*mansu-9setup' "$HELP"
grep -q 'mansu-project-start.*mansu-1define' "$HELP"
grep -q 'mansu-tdd-total.*mansu-3build' "$HELP"
grep -q 'mansu-web-verify.*mansu-4verify' "$HELP"
grep -q 'mansu-debug-rootcause.*mansu-debug' "$HELP"
grep -q 'mansu-ship-release.*mansu-6ship' "$HELP"

grep -q 'Wave 6: Manual Finalization' "$PLAN"
grep -q '"kind": "runtime_transport"' "$LOCK"
grep -q 'LazyCodex is the Codex-side OMO route' "$README"
grep -q 'LazyCodex는 Codex에서 OMO 실행 패턴을 쓸 때 확인하는 경로' "$README_KO"
