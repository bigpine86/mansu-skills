#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FILE="$ROOT_DIR/mansu-source-curator/SKILL.md"
OPENAI_YAML="$ROOT_DIR/mansu-source-curator/agents/openai.yaml"
SETTING_FILE="$ROOT_DIR/mansu-setting/SKILL.md"
SOURCE_CATALOG="$ROOT_DIR/mansu-operating-model/references/SOURCE_SKILL_CATALOG.md"

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
assert_contains '^name: mansu-source-curator$' "$FILE"
assert_contains '^description: Hidden/internal maintenance workflow' "$FILE"
assert_contains 'Ouroboros' "$FILE"
assert_contains 'SOURCE_SKILL_CATALOG.md' "$FILE"
assert_contains 'SOURCE_SKILL_LOCK.json' "$FILE"
assert_contains 'DOCUMENT_CREATION_ORDER.md' "$FILE"
assert_contains 'CODE_CONSTRUCTION_ORDER.md' "$FILE"

# Required sections.
assert_contains '^## Core promise$' "$FILE"
assert_contains '^## Modes$' "$FILE"
assert_contains '^## Mansu Self-Evolution Loop$' "$FILE"
assert_contains '^## Source families$' "$FILE"
assert_contains '^## Safety rules$' "$FILE"
assert_contains '^## Phase 0: Preflight$' "$FILE"
assert_contains '^## Phase 1: Source freshness check$' "$FILE"
assert_contains '^## Phase 2: Optional source update$' "$FILE"
assert_contains '^## Phase 3: Curate Mansu references$' "$FILE"
assert_contains '^## Phase 4: Validate and sync$' "$FILE"
assert_contains '^## Required report$' "$FILE"

# Source coverage.
assert_contains 'gstack' "$FILE"
assert_contains 'Ouroboros' "$FILE"
assert_contains 'Oh My / OMO / OMC' "$FILE"
assert_contains 'addyosmani/agent-skills' "$FILE"
assert_contains 'VoltAgent/awesome-design-md' "$FILE"
assert_contains 'Open Design' "$FILE"
assert_contains 'nexu-io/open-design' "$FILE"
assert_contains 'Runtime adapters' "$FILE"
assert_contains 'Mansu repo' "$FILE"
assert_contains 'GitHub API or raw files' "$FILE"
assert_contains 'adapter-owned skill roots' "$FILE"
assert_contains 'Exclude `mansu-\*`, `gstack-\*`' "$FILE"

# Safety and maintenance behavior.
assert_contains 'Never use destructive git commands' "$FILE"
assert_contains 'Do not pull or merge a dirty repo automatically' "$FILE"
assert_contains 'Do not install addyosmani/agent-skills into runtime skill directories' "$FILE"
assert_contains 'Do not install VoltAgent/awesome-design-md into runtime skill directories' "$FILE"
assert_contains 'Do not copy Open Design into runtime skill directories' "$FILE"
assert_contains 'Do not ask the user to run Open Design CLI commands manually' "$FILE"
assert_contains 'Do not copy public brand identities blindly' "$FILE"
assert_contains 'Do not update Mansu references from memory' "$FILE"
assert_contains 'Do not copy whole source workflows into Mansu' "$FILE"
assert_contains 'Do not sync uncommitted Mansu repo changes into installed runtime skill copies unless the user explicitly requests WIP sync' "$FILE"
assert_contains "Keep the HTML manual's agent guide and catalog in sync with source-skill routing" "$FILE"
assert_contains 'Source update without re-inspection is incomplete' "$FILE"
assert_contains 'Do not sync if validation fails' "$FILE"
assert_contains 'do not start a project from the curator' "$FILE"
assert_contains 'Default to `check` for latest/current/stale/freshness/check/refresh wording' "$FILE"
assert_contains 'Only mutate when the user explicitly says update, install, sync, curate' "$FILE"
assert_contains 'Check source freshness from source-of-truth repos' "$FILE"
assert_contains 'Decide routing impact' "$FILE"
assert_contains 'Dry-run the updated routing in check/report-only mode' "$FILE"
assert_contains 'Sync installed Mansu copies only after validation and dry-run pass' "$FILE"

# Reference and validator integration.
assert_contains 'mansu-source-curator' "$SETTING_FILE"
assert_contains 'mansu-source-curator' "$SOURCE_CATALOG"
assert_contains 'docs/mansu-manual.html' "$FILE"
assert_contains 'mansu-manual/SKILL.md' "$FILE"
assert_contains 'scripts/validate_mansu_manual.sh' "$FILE"
assert_contains 'mansu-manual/docs/mansu-manual.html' "$FILE"
assert_contains 'scripts/validate_mansu_skills.sh' "$FILE"
assert_contains 'scripts/validate_mansu_installed_copies.sh' "$FILE"
assert_contains 'git diff --check' "$FILE"
assert_contains '개발일지.md' "$FILE"
assert_contains 'Manual updated:' "$FILE"
assert_contains 'Status: Green/Yellow/Red' "$FILE"
assert_contains 'Read-only or mutating:' "$FILE"
assert_contains 'Routing impact:' "$FILE"
assert_contains 'Dry-run:' "$FILE"
assert_contains 'Changes made:' "$FILE"
assert_contains 'Catalog trustworthy:' "$FILE"
assert_contains 'Approval needed:' "$FILE"
assert_contains 'Beginner next prompt:' "$FILE"
assert_contains 'Worklog:' "$FILE"

# UI metadata alignment.
assert_contains '^interface:$' "$OPENAI_YAML"
assert_contains 'display_name: "Mansu Source Curator"' "$OPENAI_YAML"
assert_contains 'short_description: "Internal source-skill freshness curator"' "$OPENAI_YAML"
assert_contains 'default_prompt: "Use \$mansu-source-curator' "$OPENAI_YAML"
assert_contains 'check or update Ouroboros, gstack' "$OPENAI_YAML"
assert_contains 'VoltAgent/awesome-design-md' "$OPENAI_YAML"
assert_contains 'Open Design' "$OPENAI_YAML"
assert_contains 'Mansu run approved CLI/lifecycle commands directly' "$OPENAI_YAML"
assert_contains 'HTML manual agent guide/catalog' "$OPENAI_YAML"
assert_contains 'update Mansu references, validators, worklog' "$OPENAI_YAML"

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
  *'$mansu-source-curator'*) ;;
  *) exit 1 ;;
esac

echo "mansu-source-curator structure OK"
