#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FILE="$ROOT_DIR/mansu-start/SKILL.md"
OPENAI_YAML="$ROOT_DIR/mansu-start/agents/openai.yaml"

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
assert_contains '^name: mansu-start$' "$FILE"
assert_contains '^description: Host-aware and OS-aware bootstrap/update workflow for the Mansu skill suite' "$FILE"
assert_contains 'installing Mansu for the first time' "$FILE"
assert_contains 'Codex, OpenCode, or Claude Code' "$FILE"
assert_contains 'matching Oh My adapter' "$FILE"

# Required sections.
assert_contains '^## Core promise$' "$FILE"
assert_contains '^## Modes$' "$FILE"
assert_contains '^## Host and OS detection$' "$FILE"
assert_contains '^## Host adapter map$' "$FILE"
assert_contains '^## OS path rules$' "$FILE"
assert_contains '^## Safety rules$' "$FILE"
assert_contains '^## Preflight$' "$FILE"
assert_contains '^## First install$' "$FILE"
assert_contains '^## Update$' "$FILE"
assert_contains '^## Repair$' "$FILE"
assert_contains '^## Compatibility checks$' "$FILE"
assert_contains '^## Required report$' "$FILE"

# Required operational gates.
assert_contains 'git pull --ff-only' "$FILE"
assert_contains 'git merge --ff-only' "$FILE"
assert_contains 'scripts/validate_mansu_skills.sh' "$FILE"
assert_contains 'uv tool upgrade oh-my-codex' "$FILE"
assert_contains 'Codex uses `omx`, OpenCode uses `omo`, Claude Code uses `omc`' "$FILE"
assert_contains '`omx` / Oh My Codex' "$FILE"
assert_contains '`omo` / Oh My OpenCode' "$FILE"
assert_contains '`omc` / Oh My Claude' "$FILE"
assert_contains 'macOS/Linux' "$FILE"
assert_contains 'Windows' "$FILE"
assert_contains 'WSL' "$FILE"
assert_contains 'gstack-context-save' "$FILE"
assert_contains 'gstack-context-restore' "$FILE"
assert_contains 'local host skills are missing or stale' "$FILE"
assert_contains 'Do not assume the current repo was opened by Codex' "$FILE"
assert_contains 'Do not overwrite non-Mansu user skills in any host skill directory' "$FILE"
assert_contains 'If a repo is dirty, do not pull or merge it automatically' "$FILE"
assert_contains 'MANSU START REPORT' "$FILE"
assert_contains 'Host:' "$FILE"
assert_contains 'OS:' "$FILE"
assert_contains 'Skill target:' "$FILE"
assert_contains 'Oh My adapter:' "$FILE"

# UI metadata alignment.
assert_contains '^interface:$' "$OPENAI_YAML"
assert_contains 'display_name: "Mansu Start"' "$OPENAI_YAML"
assert_contains 'short_description: "Host-aware Mansu bootstrap and updater"' "$OPENAI_YAML"
assert_contains 'default_prompt: "Use \$mansu-start' "$OPENAI_YAML"
assert_contains 'detect the agent host and OS' "$OPENAI_YAML"
assert_contains 'matching Oh My adapter' "$OPENAI_YAML"

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
  *'$mansu-start'*) ;;
  *) exit 1 ;;
esac

echo "mansu-start structure OK"
