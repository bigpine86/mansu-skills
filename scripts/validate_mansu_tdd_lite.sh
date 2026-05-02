#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FILE="$ROOT_DIR/mansu-tdd-lite/SKILL.md"

grep -q '^## Preflight$' "$FILE"
grep -q '^## Slice card$' "$FILE"
grep -q '^## Minimum slice close$' "$FILE"
grep -q '^## Closeout$' "$FILE"
grep -q 'Plan properly before coding' "$FILE"
grep -q 'Lite mode is not a lower-quality mode' "$FILE"
grep -q 'Planning, slicing, review, QA, checkpoint, commit, and work logging still apply' "$FILE"
grep -q 'must be separately invoked, produce status/evidence' "$FILE"
grep -q 'Do not start the next slice until the current lite slice is closed' "$FILE"
grep -q 'Confirm the construction router before coding' "$FILE"
grep -q 'CODE_CONSTRUCTION_ORDER.md' "$FILE"
grep -q 'review, QA, and checkpoint are complete' "$FILE"
grep -q 'explicit no-commit reason' "$FILE"
grep -q 'Commit-or-explicit-no-commit accounting is mandatory' "$FILE"
grep -q 'If any item is missing, do not start the next slice' "$FILE"
grep -q 'Lite mode is flexible about TDD style, not about work quality' "$FILE"
grep -q 'run the relevant project-level build/test/type/lint suite' "$FILE"
grep -q 'run final QA or browser verification' "$FILE"
grep -q 'final report must include verified checks, unverified checks, remaining risks, and follow-up items' "$FILE"
grep -q 'mandatory failing-test-first TDD' "$FILE"

echo "mansu-tdd-lite structure OK"
