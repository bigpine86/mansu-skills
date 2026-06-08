#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HELP="$ROOT_DIR/mansu-help/SKILL.md"
README="$ROOT_DIR/README.md"
README_KO="$ROOT_DIR/README.ko.md"
PLAN="$ROOT_DIR/PLAN.md"
LOCK="$ROOT_DIR/mansu-operating-model/references/SOURCE_SKILL_LOCK.json"
MANUAL="$ROOT_DIR/docs/mansu-manual.html"

for route in mansu-define mansu-plan mansu-build mansu-verify mansu-review mansu-debug mansu-ship; do
  grep -q "$route" "$HELP"
  grep -q "$route" "$README"
  grep -q "$route" "$README_KO"
  grep -q "$route" "$MANUAL"
done

grep -q 'compatibility alias' "$HELP"
grep -q 'mansu-project-start.*mansu-define' "$HELP"
grep -q 'mansu-tdd-total.*mansu-build' "$HELP"
grep -q 'mansu-web-verify.*mansu-verify' "$HELP"
grep -q 'mansu-debug-rootcause.*mansu-debug' "$HELP"
grep -q 'mansu-ship-release.*mansu-ship' "$HELP"

grep -q 'Wave 6: Manual Finalization' "$PLAN"
grep -q '"kind": "runtime_transport"' "$LOCK"
grep -q 'LazyCodex is runtime transport' "$README"
grep -q 'LazyCodex는 runtime transport' "$README_KO"
