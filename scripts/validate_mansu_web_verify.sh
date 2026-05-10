#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FILE="$ROOT_DIR/mansu-web-verify/SKILL.md"
OPENAI_YAML="$ROOT_DIR/mansu-web-verify/agents/openai.yaml"

assert_contains() {
  local pattern="$1"
  local file="$2"
  grep -q "$pattern" "$file"
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
assert_contains '^name: mansu-web-verify$' "$FILE"
assert_contains '^description: Plan-first, report-only web verification workflow' "$FILE"
assert_contains 'Default is verification and reporting, not fixing' "$FILE"

# Required sections.
assert_contains '^## Core promise$' "$FILE"
assert_contains '^## Source skill map$' "$FILE"
assert_contains '^## Mansu-owned orchestration$' "$FILE"
assert_contains '^## Modes$' "$FILE"
assert_contains '^## Bounded Ralph loop$' "$FILE"
assert_contains '^## Phase 0: Preflight$' "$FILE"
assert_contains '^## Phase 1: Product surface discovery$' "$FILE"
assert_contains '^## Phase 2: Verification plan$' "$FILE"
assert_contains '^## Phase 3: Browser verification$' "$FILE"
assert_contains '^## Phase 4: Stability checks$' "$FILE"
assert_contains '^## Phase 5: Performance checks$' "$FILE"
assert_contains '^## Phase 6: Safe security checks$' "$FILE"
assert_contains '^## Phase 7: Issue routing$' "$FILE"
assert_contains '^## Final report$' "$FILE"
assert_contains '^## Completion rule$' "$FILE"

# Safety and mode gates.
assert_contains 'Default to report-only' "$FILE"
assert_contains 'bounded Ralph loop' "$FILE"
assert_contains 'Do not use infinite Ralph behavior' "$FILE"
assert_contains 'Never perform destructive' "$FILE"
assert_contains 'report-only' "$FILE"
assert_contains 'diff-aware' "$FILE"
assert_contains 'quick' "$FILE"
assert_contains 'full' "$FILE"
assert_contains 'regression' "$FILE"
assert_contains 'fix-approved' "$FILE"
assert_contains 'post-deploy' "$FILE"
assert_contains 'forbidden actions' "$FILE"
assert_contains 'safe substitutes' "$FILE"

# Verification coverage.
assert_contains 'surface map' "$FILE"
assert_contains 'Read source to plan coverage, but judge behavior from browser evidence' "$FILE"
assert_contains 'core user flows' "$FILE"
assert_contains 'buttons and links' "$FILE"
assert_contains 'responsive viewports' "$FILE"
assert_contains 'console errors' "$FILE"
assert_contains 'failed network requests' "$FILE"
assert_contains 'Performance' "$FILE"
assert_contains 'Core Web Vitals' "$FILE"
assert_contains 'greater than 50% or greater than 500ms' "$FILE"
assert_contains 'greater than 25%' "$FILE"
assert_contains 'Safe security checks' "$FILE"
assert_contains 'auth-only pages' "$FILE"
assert_contains 'sensitive data' "$FILE"

# Routing and source skills.
assert_contains 'Mansu owns the plan, safety boundary, routing, and final report' "$FILE"
assert_contains 'gstack `browse`' "$FILE"
assert_contains 'gstack `qa-only`' "$FILE"
assert_contains 'gstack `qa` only in approved fix mode' "$FILE"
assert_contains 'gstack `benchmark`' "$FILE"
assert_contains 'gstack `cso`' "$FILE"
assert_contains 'gstack `canary`' "$FILE"
assert_contains 'gstack `setup-browser-cookies` / `open-gstack-browser`' "$FILE"
assert_contains 'Oh My `playwright`' "$FILE"
assert_contains 'Oh My `ultraqa`' "$FILE"
assert_contains 'Oh My `security-review`' "$FILE"
assert_contains 'Oh My `ralph`' "$FILE"
assert_contains 'mansu-debug-rootcause' "$FILE"
assert_contains 'route durable regression automation to Oh My `playwright`' "$FILE"

# Report fields.
assert_contains 'WEB VERIFY REPORT' "$FILE"
assert_contains "Write the report in the user's language or the project's default language" "$FILE"
assert_contains 'Field labels may stay canonical' "$FILE"
assert_contains 'Surface map:' "$FILE"
assert_contains 'Source skills:' "$FILE"
assert_contains 'Flows tested:' "$FILE"
assert_contains 'Responsive:' "$FILE"
assert_contains 'Stability:' "$FILE"
assert_contains 'Security:' "$FILE"
assert_contains 'Forbidden actions:' "$FILE"
assert_contains 'Status:            DONE | DONE_WITH_CONCERNS | BLOCKED' "$FILE"

# UI metadata alignment.
assert_contains '^interface:$' "$OPENAI_YAML"
assert_contains 'display_name: "Mansu Web Verify"' "$OPENAI_YAML"
assert_contains 'short_description: "Orchestrated real-user web verification"' "$OPENAI_YAML"
assert_contains 'default_prompt: "Use \$mansu-web-verify' "$OPENAI_YAML"
assert_contains 'delegate specialized checks to the right gstack or Oh My skills' "$OPENAI_YAML"

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
  *'$mansu-web-verify'*) ;;
  *) exit 1 ;;
esac

echo "mansu-web-verify structure OK"
