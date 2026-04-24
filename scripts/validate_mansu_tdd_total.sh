#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FILE="$ROOT_DIR/mansu-tdd-total/SKILL.md"

test -f "$FILE"

grep -q '^## Core promise$' "$FILE"
grep -q '^## Shared invariants$' "$FILE"
grep -q '^## What this skill does not do$' "$FILE"
grep -q '^## Preflight$' "$FILE"
grep -q '^## Planning loop$' "$FILE"
grep -q '^## Dispatch rules$' "$FILE"
grep -q '^## Slice table$' "$FILE"
grep -q '^## Execution handoff$' "$FILE"
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

if grep -q '^### RED$' "$FILE" || grep -q '^### GREEN$' "$FILE" || grep -q '^### REFACTOR$' "$FILE"; then
  echo "mansu-tdd-total should not copy strict executor internals" >&2
  exit 1
fi

echo "mansu-tdd-total structure OK"
