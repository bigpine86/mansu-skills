#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FILE="$ROOT_DIR/mansu-tdd-lite/SKILL.md"

grep -q '^## Lightweight preflight$' "$FILE"
grep -q '^## Slice card$' "$FILE"
grep -q '^## Minimum slice close$' "$FILE"
grep -q '^## Closeout$' "$FILE"

echo "mansu-tdd-lite structure OK"
