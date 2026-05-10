#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FILE="$ROOT_DIR/mansu-tdd-total/SKILL.md"

test -f "$FILE"

grep -q '^## Core promise$' "$FILE"
grep -q '^## Shared invariants$' "$FILE"
grep -q '^## What this skill does not do$' "$FILE"
grep -q '^## Preflight$' "$FILE"
grep -q '^## Planning gate$' "$FILE"
grep -q '^## Required planning roles$' "$FILE"
grep -q '^## Real critic agent gate$' "$FILE"
grep -q '^## Execution-ready plan requirements$' "$FILE"
grep -q '^## Planning loop$' "$FILE"
grep -q '^## Dispatch rules$' "$FILE"
grep -q '^## Slice table$' "$FILE"
grep -q '^## Execution handoff$' "$FILE"
grep -q '^## Sequential slice gate$' "$FILE"
grep -q '^## Mode-change rules$' "$FILE"
grep -q '^## Closeout$' "$FILE"

grep -q 'mansu-tdd-lite' "$FILE"
grep -q 'mansu-tdd-strict' "$FILE"
grep -q 'PLAN.md' "$FILE"
grep -q '개발일지.md' "$FILE"
grep -q 'per-slice mode' "$FILE"
grep -q 'Do not duplicate executor details' "$FILE"
grep -q 'Escalate from lite to strict' "$FILE"
grep -q 'Do not use `lite` as permission to lower work quality' "$FILE"
grep -q 'The only core difference is the RED test requirement' "$FILE"
grep -q 'Do not start the next slice until the current slice is fully closed' "$FILE"
grep -q 'Commit policy:' "$FILE"
grep -q 'Default to per-slice commits during implementation' "$FILE"
grep -q 'Use a final release/docs commit only for final docs' "$FILE"
grep -q 'record the no-commit reason' "$FILE"
grep -q 'Execute slices in order unless the user explicitly approves a different dependency-free order' "$FILE"
grep -q 'A slice is fully closed only when' "$FILE"
grep -q 'Do not start slice N+1 while slice N is open' "$FILE"
grep -q 'do not treat planning as a single-agent TODO list' "$FILE"
grep -q 'Planner: draft the plan' "$FILE"
grep -q 'Critics: challenge the plan' "$FILE"
grep -q 'Synthesizer: merge critique into one execution-ready plan' "$FILE"
grep -q 'runtime-neutral orchestration' "$FILE"
grep -q 'current runtime session' "$FILE"
grep -q 'runtime-backed helper sessions' "$FILE"
grep -q 'If exact historical agent names or tools are unavailable' "$FILE"
grep -q 'strict prerequisites are unavailable in the current runtime' "$FILE"
grep -q 'record the mapping in `PLAN.md`' "$FILE"
grep -q 'Do not lock the execution-ready plan or start implementation while an expected critic is still pending' "$FILE"
grep -q 'If a critic fails or times out' "$FILE"
grep -q 'Do not proceed to implementation until the execution-ready plan and slice table are visible' "$FILE"
grep -q 'continue automatically unless the user explicitly requested' "$FILE"
grep -q 'domain language and DDD-style responsibility boundaries' "$FILE"
grep -q 'architecture and module boundaries' "$FILE"
grep -q 'source skills or tools to use' "$FILE"
grep -q 'code construction router' "$FILE"
grep -q 'source skill to read' "$FILE"
grep -q 'CODE_CONSTRUCTION_ORDER.md' "$FILE"
grep -q 'construction router notes' "$FILE"
grep -q 'execution readiness status' "$FILE"
grep -q 'must be separately invoked, produce' "$FILE"
grep -q 'upstream source-of-truth artifacts and paths' "$FILE"
grep -q 'locked decisions and open-question carryover' "$FILE"
grep -q 'upstream artifact or decision this slice implements' "$FILE"
grep -q 'Map the Planner, Critics, and Synthesizer roles' "$FILE"
grep -q 'wait for them or record a real failure/timeout fallback' "$FILE"
grep -q 'Record the role mapping, critic status, execution-ready plan' "$FILE"
grep -q 'Start execution automatically after the plan gate passes' "$FILE"
grep -q 'run the project-level build/test/type/lint suite' "$FILE"
grep -q 'run final QA or browser verification' "$FILE"
grep -q 'create a final release/docs commit only when final docs' "$FILE"
grep -q 'what could not be verified, remaining risks, and any follow-up checks needed' "$FILE"

if grep -q 'Hermes/OpenCode orchestration' "$FILE" || grep -q 'Hermes + OpenCode session' "$FILE"; then
  echo "mansu-tdd-total should stay runtime-neutral" >&2
  exit 1
fi

if grep -q '^### RED$' "$FILE" || grep -q '^### GREEN$' "$FILE" || grep -q '^### REFACTOR$' "$FILE"; then
  echo "mansu-tdd-total should not copy strict executor internals" >&2
  exit 1
fi

echo "mansu-tdd-total structure OK"
