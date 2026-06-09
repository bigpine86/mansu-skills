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
grep -q 'If Define is complete, tell the user the next step is `mansu-plan`' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'if complete, tell the user to use mansu-plan next' "$ROOT_DIR/mansu-define/agents/openai.yaml"

grep -q 'Requirements/Spec -> Architecture -> Design Direction -> Implementation Roadmap' "$ROOT_DIR/mansu-plan/SKILL.md"
grep -q 'gstack-plan-design-review' "$ROOT_DIR/mansu-plan/SKILL.md"
grep -q 'gstack-design-shotgun' "$ROOT_DIR/mansu-plan/SKILL.md"
grep -q '.omo/plans/\*.md' "$ROOT_DIR/mansu-plan/SKILL.md"
grep -q 'If Plan is complete, tell the user the next step is `mansu-build`' "$ROOT_DIR/mansu-plan/SKILL.md"
grep -q 'if complete, tell the user to use mansu-build next' "$ROOT_DIR/mansu-plan/agents/openai.yaml"

grep -q 'mansu-tdd-total' "$ROOT_DIR/mansu-build/SKILL.md"
grep -q 'LazyCodex is not a source skill family' "$ROOT_DIR/mansu-build/SKILL.md"
grep -q 'The active plan is a role, not a literal filename' "$ROOT_DIR/mansu-build/SKILL.md"
grep -q '.omo/plans/\*.md' "$ROOT_DIR/mansu-build/SKILL.md"
grep -q 'If implementation for the active phase is complete, tell the user the next' "$ROOT_DIR/mansu-build/SKILL.md"
grep -q 'End by naming the next route: next mansu-build slice, mansu-verify, or mansu-debug' "$ROOT_DIR/mansu-build/agents/openai.yaml"

grep -q 'QA evidence' "$ROOT_DIR/mansu-verify/SKILL.md"
grep -q 'Verify proves behavior' "$ROOT_DIR/mansu-verify/SKILL.md"
grep -q 'If verification passes, run `mansu-review` next by default' "$ROOT_DIR/mansu-verify/SKILL.md"
grep -q 'reporting whether review was run or is the immediate next step' "$ROOT_DIR/mansu-verify/agents/openai.yaml"

grep -q 'Review judges quality' "$ROOT_DIR/mansu-review/SKILL.md"
grep -q 'not QA' "$ROOT_DIR/mansu-review/SKILL.md"
grep -q 'If Review passes and Verify evidence exists, tell the user the next step is' "$ROOT_DIR/mansu-review/SKILL.md"
grep -q 'mansu-ship if review passes' "$ROOT_DIR/mansu-review/agents/openai.yaml"

grep -q 'mansu-debug-rootcause' "$ROOT_DIR/mansu-debug/SKILL.md"
grep -q 'root cause' "$ROOT_DIR/mansu-debug/SKILL.md"

grep -q 'mansu-ship-release' "$ROOT_DIR/mansu-ship/SKILL.md"
grep -q 'ship/hold' "$ROOT_DIR/mansu-ship/SKILL.md"
grep -q 'End the response with a clear ship status' "$ROOT_DIR/mansu-ship/SKILL.md"
grep -q 'End with a clear ship/hold status' "$ROOT_DIR/mansu-ship/agents/openai.yaml"
