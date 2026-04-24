#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FILE="$ROOT_DIR/mansu-debug-rootcause/SKILL.md"

test -f "$FILE"

grep -q '^## Core promise$' "$FILE"
grep -q '^## When to use$' "$FILE"
grep -q '^## What this skill does not do$' "$FILE"
grep -q '^## Debug loop$' "$FILE"
grep -q '^## Evidence rules$' "$FILE"
grep -q '^## Fix rules$' "$FILE"
grep -q '^## Verification and report$' "$FILE"
grep -q '^## Escalation$' "$FILE"

grep -q 'No fixes before root cause' "$FILE"
grep -q 'Reproduce' "$FILE"
grep -q 'Isolate' "$FILE"
grep -q 'Hypothesize' "$FILE"
grep -q 'minimal fix' "$FILE"
grep -q 'regression' "$FILE"
grep -q 'DEBUG REPORT' "$FILE"
grep -q '3 hypotheses' "$FILE"
grep -q 'sanitize' "$FILE"

echo "mansu-debug-rootcause structure OK"
