#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FILE="$ROOT_DIR/mansu-debug-rootcause/SKILL.md"
OPENAI_YAML="$ROOT_DIR/mansu-debug-rootcause/agents/openai.yaml"

assert_contains() {
  local pattern="$1"
  local file="$2"
  grep -q "$pattern" "$file"
}

assert_not_contains() {
  local pattern="$1"
  local file="$2"
  ! grep -q "$pattern" "$file"
}

line_equals() {
  local line_no="$1"
  local expected="$2"
  local file="$3"
  [ "$(sed -n "${line_no}p" "$file")" = "$expected" ]
}

test -f "$FILE"
test -f "$OPENAI_YAML"

# Frontmatter and trigger clarity.
line_equals 1 '---' "$FILE"
line_equals 4 '---' "$FILE"
assert_contains '^name: mansu-debug-rootcause$' "$FILE"
assert_contains '^description: Root-cause debugging workflow for bugs' "$FILE"
assert_contains 'Not for planned feature work' "$FILE"

# Required structure.
assert_contains '^## Core promise$' "$FILE"
assert_contains '^## Source skill map$' "$FILE"
assert_contains '^## Mansu-owned boundary$' "$FILE"
assert_contains '^## When to use$' "$FILE"
assert_contains '^## What this skill does not do$' "$FILE"
assert_contains '^## Route table$' "$FILE"
assert_contains '^## Six-stage loop with gstack gates$' "$FILE"
assert_contains '^## Evidence rules$' "$FILE"
assert_contains '^## Fix rules$' "$FILE"
assert_contains '^## Verification and report$' "$FILE"
assert_contains '^## Escalation$' "$FILE"

# Source relationship and progressive disclosure.
assert_contains 'Do not load every source skill by default' "$FILE"
assert_contains 'optional runtime-aware' "$FILE"
assert_contains 'runtime-local if available' "$FILE"
assert_contains 'installed gstack skill if available' "$FILE"
assert_not_contains '\$HOME/.codex/skills' "$FILE"
assert_contains 'Load source skills only when' "$FILE"
assert_contains '| Source skill | Use it for | Load or invoke when |' "$FILE"
assert_contains 'Oh My `debug`' "$FILE"
assert_contains 'gstack `investigate`' "$FILE"
assert_contains 'Source skills own the specialized craft' "$FILE"
assert_contains 'Keep this skill thin where it can be thin and strict where it must be strict' "$FILE"
assert_contains 'Mansu owns the root-cause discipline' "$FILE"
assert_contains 'route to the right source skill when specialized depth is needed' "$FILE"
assert_contains 'If a source skill is unavailable in the current runtime' "$FILE"

# Route coverage.
assert_contains 'build-fix' "$FILE"
assert_contains 'doctor' "$FILE"
assert_contains 'git bisect' "$FILE"
assert_contains 'browse' "$FILE"
assert_contains 'qa-only' "$FILE"
assert_contains 'gstack `qa`, only after root cause is confirmed' "$FILE"
assert_contains 'runtime-local skill handles or installed equivalents instead of hardcoded paths' "$FILE"
assert_contains 'gstack `benchmark` or installed equivalent benchmark workflow' "$FILE"
assert_contains 'trace' "$FILE"

# Mandatory debug gates.
assert_contains 'No fixes before root cause' "$FILE"
assert_contains 'ask exactly one highest-leverage question' "$FILE"
assert_contains 'Pattern analysis checkpoint' "$FILE"
assert_contains 'TODOS.md' "$FILE"
assert_contains 'same-file recurring fixes' "$FILE"
assert_contains 'sanitized external sources' "$FILE"
assert_contains 'scope-lock the narrowest affected directory or document why scope lock is skipped' "$FILE"
assert_contains 'If 3 hypotheses fail, stop and escalate' "$FILE"
assert_contains 'If the fix touches more than 5 files' "$FILE"
assert_contains 'Run the new regression proof' "$FILE"
assert_contains 'Run the relevant automated suite' "$FILE"

# Regression and verification proof.
assert_contains 'Add a regression test by default' "$FILE"
assert_contains 'fail before the fix and pass after the fix' "$FILE"
assert_contains 'automated regression proof is not feasible' "$FILE"
assert_contains 'manual verification path' "$FILE"
assert_contains 'DEBUG REPORT' "$FILE"
assert_contains 'Source skills loaded:' "$FILE"
assert_contains 'runtime handles / installed skills and why' "$FILE"
assert_contains 'Pattern check:' "$FILE"
assert_contains 'Scope lock:' "$FILE"
assert_contains 'Suite:' "$FILE"

# UI metadata alignment.
assert_contains '^interface:$' "$OPENAI_YAML"
assert_contains 'display_name: "Mansu Debug Rootcause"' "$OPENAI_YAML"
assert_contains 'short_description: "Root-cause debugging with verification gates"' "$OPENAI_YAML"
assert_contains 'default_prompt: "Use \$mansu-debug-rootcause' "$OPENAI_YAML"

short_description="$(
  sed -n 's/^  short_description: "\(.*\)"$/\1/p' "$OPENAI_YAML"
)"
default_prompt="$(
  sed -n 's/^  default_prompt: "\(.*\)"$/\1/p' "$OPENAI_YAML"
)"

[ -n "$short_description" ]
[ "${#short_description}" -le 80 ]
[ -n "$default_prompt" ]
case "$default_prompt" in
  *'$mansu-debug-rootcause'*) ;;
  *) exit 1 ;;
esac

echo "mansu-debug-rootcause structure OK"
