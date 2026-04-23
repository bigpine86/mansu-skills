#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FILE="$ROOT_DIR/mansu-tdd-lite/SKILL.md"

grep -q '^## Preflight$' "$FILE"
grep -q '^## Slice card$' "$FILE"
grep -q '^## Minimum slice close$' "$FILE"
grep -q '^## Closeout$' "$FILE"
grep -q 'Plan properly before coding' "$FILE"
grep -q 'review, QA, and checkpoint are complete' "$FILE"
grep -q 'Lite mode is flexible about TDD style, not about work quality' "$FILE"
grep -q 'mandatory failing-test-first TDD' "$FILE"

echo "mansu-tdd-lite structure OK"
