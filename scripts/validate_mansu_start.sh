#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FILE="$ROOT_DIR/mansu-start/SKILL.md"
OPENAI_YAML="$ROOT_DIR/mansu-start/agents/openai.yaml"
README_FILE="$ROOT_DIR/README.md"

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
test -f "$README_FILE"

# Frontmatter and trigger clarity.
line_equals 1 '---' "$FILE"
line_equals 4 '---' "$FILE"
assert_contains '^name: mansu-start$' "$FILE"
assert_contains '^description: Runtime-target-aware bootstrap/update workflow for the Mansu skill suite' "$FILE"
assert_contains 'installing Mansu for the first time' "$FILE"
assert_contains 'Hermes, OpenCode, Codex, or Claude Code' "$FILE"
assert_contains 'checking Oh My / OMO / OMC source skill freshness' "$FILE"
assert_contains 'checking addyosmani/agent-skills freshness' "$FILE"
assert_contains 'optional adapter compatibility' "$FILE"
assert_contains 'mansu-source-curator' "$FILE"

# Required sections.
assert_contains '^## Core promise$' "$FILE"
assert_contains '^## Modes$' "$FILE"
assert_contains '^## Runtime target, host, and OS detection$' "$FILE"
assert_contains '^## Runtime target matrix$' "$FILE"
assert_contains '^## Adapter detection and compatibility$' "$FILE"
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
assert_contains 'Run `scripts/validate_mansu_skills.sh` in the repo before syncing runtime copies' "$FILE"
assert_contains 'only after source curation and validation pass' "$FILE"
assert_contains 'source skill freshness for gstack, Oh My / OMO / OMC, and addyosmani/agent-skills' "$FILE"
assert_contains '`source-check`' "$FILE"
assert_contains '`source-curate`' "$FILE"
assert_contains 'Oh My / OMO / OMC source skill locations' "$FILE"
assert_contains 'addyosmani/agent-skills repo path' "$FILE"
assert_contains 'CODE_CONSTRUCTION_ORDER.md' "$FILE"
assert_contains 'Do not automatically install or copy addyosmani/agent-skills' "$FILE"
assert_contains 'SOURCE_SKILL_CATALOG.md' "$FILE"
assert_contains 'SOURCE_SKILL_LOCK.json' "$FILE"
assert_contains 'addyosmani/agent-skills:' "$FILE"
assert_contains 'Source skill freshness:' "$FILE"
assert_contains 'Source reference curation:' "$FILE"
assert_contains 'uv tool upgrade oh-my-codex' "$FILE"
assert_contains '| Hermes | OpenCode in tmux when detected | OpenCode global `~/.config/opencode/skills` or project `.opencode/skills` | `omo` optional compatibility tooling |' "$FILE"
assert_contains '| OpenCode | `opencode` | OpenCode global `~/.config/opencode/skills` or project `.opencode/skills` | `omo` optional compatibility tooling |' "$FILE"
assert_contains '| Codex | `codex` | `$HOME/.codex/skills` | `omx` optional compatibility tooling |' "$FILE"
assert_contains '| Claude Code | `claude-code` | `$HOME/.claude/skills` when present | `omc` optional compatibility tooling |' "$FILE"
assert_contains '`omx` / Oh My Codex' "$FILE"
assert_contains '`omo` / Oh My OpenCode' "$FILE"
assert_contains '`omc` / Oh My Claude' "$FILE"
assert_contains 'If compatibility tooling is missing, continue with Mansu and gstack checks' "$FILE"
assert_contains 'If the user explicitly asked for adapter update/repair and the matching adapter is missing' "$FILE"
assert_contains 'macOS/Linux' "$FILE"
assert_contains 'Windows' "$FILE"
assert_contains 'WSL' "$FILE"
assert_contains 'gstack-context-save' "$FILE"
assert_contains 'gstack-context-restore' "$FILE"
assert_contains 'local runtime skills are missing or stale' "$FILE"
assert_contains 'Do not assume the current repo was opened by Codex' "$FILE"
assert_contains 'Do not infer adapter requirements from runtime target detection alone' "$FILE"
assert_contains 'Do not overwrite non-Mansu user skills in any host skill directory' "$FILE"
assert_contains 'If a repo is dirty, do not pull or merge it automatically' "$FILE"
assert_contains 'MANSU START REPORT' "$FILE"
assert_contains 'Runtime target:' "$FILE"
assert_contains 'Host:' "$FILE"
assert_contains 'OS:' "$FILE"
assert_contains 'Detection confidence:' "$FILE"
assert_contains 'Skill target:' "$FILE"
assert_contains 'Adapter status:' "$FILE"
assert_contains 'Skipped checks:' "$FILE"

# README alignment and anti-regression checks.
assert_contains 'runtime target(Hermes, OpenCode, Codex, Claude Code), host, OS' "$README_FILE"
assert_contains 'Hermes + tmux + OpenCode runtime' "$README_FILE"
assert_contains '$HOME/.config/opencode/skills/mansu-start' "$README_FILE"
assert_contains '.opencode/skills/mansu-start' "$README_FILE"
assert_contains 'optional compatibility check' "$README_FILE"
assert_not_contains '$HOME/.opencode/skills' "$README_FILE"
assert_not_contains 'Codex example' "$README_FILE"
assert_not_contains '그 다음 Codex에서:' "$README_FILE"

# UI metadata alignment.
assert_contains '^interface:$' "$OPENAI_YAML"
assert_contains 'display_name: "Mansu Start"' "$OPENAI_YAML"
assert_contains 'short_description: "Runtime-aware Mansu bootstrap and updater"' "$OPENAI_YAML"
assert_contains 'default_prompt: "Use \$mansu-start' "$OPENAI_YAML"
assert_contains 'detect the runtime target, agent host, and OS' "$OPENAI_YAML"
assert_contains 'report optional adapter compatibility' "$OPENAI_YAML"
assert_contains 'hand off source-reference drift to \$mansu-source-curator' "$OPENAI_YAML"
assert_contains 'verify gstack, Oh My / OMO / OMC, and addyosmani/agent-skills source freshness' "$OPENAI_YAML"
assert_contains 'report skipped checks or compatibility drift' "$OPENAI_YAML"

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
