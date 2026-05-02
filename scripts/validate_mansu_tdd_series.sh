#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

"$ROOT_DIR/scripts/validate_mansu_tdd_lite.sh"
"$ROOT_DIR/scripts/validate_mansu_tdd_total.sh"

grep -q 'mansu-tdd-total' "$ROOT_DIR/mansu-tdd-lite/SKILL.md"
grep -q 'mansu-tdd-total' "$ROOT_DIR/mansu-tdd-strict/SKILL.md"

if grep -R -n -E 'Oh My XX|gstack-review|gstack-qa|gstack-checkpoint' "$ROOT_DIR/mansu-tdd-strict" >/dev/null; then
  echo "stale strict runtime terminology found"
  exit 1
fi

echo "mansu-tdd series structure OK"
