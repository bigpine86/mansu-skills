#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

for skill in define plan build verify review debug ship; do
  test -f "$ROOT_DIR/mansu-$skill/SKILL.md"
  test -f "$ROOT_DIR/mansu-$skill/agents/openai.yaml"
  grep -q "name: mansu-$skill" "$ROOT_DIR/mansu-$skill/SKILL.md"
  grep -q 'SOURCE_SKILL_COMPOSITION.md' "$ROOT_DIR/mansu-$skill/SKILL.md"
done

grep -q 'interview-me' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'Ouroboros' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'office-hours' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'AGENTS.md' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'CODING_RULES.md' "$ROOT_DIR/mansu-define/SKILL.md"

grep -q 'Requirements/Spec -> Architecture -> Design Direction -> Implementation Roadmap' "$ROOT_DIR/mansu-plan/SKILL.md"
grep -q 'gstack-plan-design-review' "$ROOT_DIR/mansu-plan/SKILL.md"
grep -q 'gstack-design-shotgun' "$ROOT_DIR/mansu-plan/SKILL.md"

grep -q 'mansu-tdd-total' "$ROOT_DIR/mansu-build/SKILL.md"
grep -q 'LazyCodex is not a source skill family' "$ROOT_DIR/mansu-build/SKILL.md"

grep -q 'QA evidence' "$ROOT_DIR/mansu-verify/SKILL.md"
grep -q 'Verify proves behavior' "$ROOT_DIR/mansu-verify/SKILL.md"

grep -q 'Review judges quality' "$ROOT_DIR/mansu-review/SKILL.md"
grep -q 'not QA' "$ROOT_DIR/mansu-review/SKILL.md"

grep -q 'mansu-debug-rootcause' "$ROOT_DIR/mansu-debug/SKILL.md"
grep -q 'root cause' "$ROOT_DIR/mansu-debug/SKILL.md"

grep -q 'mansu-ship-release' "$ROOT_DIR/mansu-ship/SKILL.md"
grep -q 'ship/hold' "$ROOT_DIR/mansu-ship/SKILL.md"
