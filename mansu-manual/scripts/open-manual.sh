#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

manual_path=""
for candidate in \
  "$SKILL_DIR/docs/mansu-manual.html" \
  "$SKILL_DIR/../docs/mansu-manual.html"
do
  if [ -f "$candidate" ]; then
    manual_path="$(cd "$(dirname "$candidate")" && pwd)/$(basename "$candidate")"
    break
  fi
done

if [ -z "$manual_path" ]; then
  echo "FAIL: mansu manual HTML not found" >&2
  echo "Checked:" >&2
  echo "- $SKILL_DIR/docs/mansu-manual.html" >&2
  echo "- $SKILL_DIR/../docs/mansu-manual.html" >&2
  exit 1
fi

if command -v open >/dev/null 2>&1; then
  open "$manual_path"
elif command -v xdg-open >/dev/null 2>&1; then
  xdg-open "$manual_path" >/dev/null 2>&1 &
else
  echo "OPEN_UNAVAILABLE:$manual_path"
  exit 2
fi

echo "OPENED:$manual_path"
