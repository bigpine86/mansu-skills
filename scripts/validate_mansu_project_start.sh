#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FILE="$ROOT_DIR/mansu-project-start/SKILL.md"
OPENAI_YAML="$ROOT_DIR/mansu-project-start/agents/openai.yaml"

test -f "$FILE"
test -f "$OPENAI_YAML"

grep -q '^name: mansu-project-start$' "$FILE"
grep -q '^description: Zero-to-PLAN project kickoff workflow' "$FILE"
grep -q '^## Core promise$' "$FILE"
grep -q '^## Research discipline$' "$FILE"
grep -q '^## Workflow$' "$FILE"
grep -q '^## Required handoff to implementation$' "$FILE"
grep -q 'GitHub, Reddit, and' "$FILE"
grep -q 'Threads' "$FILE"
grep -q 'official docs, source files, changelogs, release notes' "$FILE"
grep -q 'DOCUMENT_CREATION_ORDER.md' "$FILE"
grep -q 'CODE_CONSTRUCTION_ORDER.md' "$FILE"
grep -q 'gstack-autoplan' "$FILE"
grep -q 'gstack-plan-' "$FILE"
grep -q 'upstream source-of-truth artifacts' "$FILE"
grep -q 'gate mapping' "$FILE"
grep -q 'mansu-tdd-total' "$FILE"
grep -q 'continues automatically' "$FILE"

grep -q '^interface:$' "$OPENAI_YAML"
grep -q 'display_name: "Mansu Project Start"' "$OPENAI_YAML"
grep -q 'short_description: "Zero-to-PLAN project kickoff"' "$OPENAI_YAML"
grep -q 'default_prompt: "Use \$mansu-project-start' "$OPENAI_YAML"

echo "mansu-project-start structure OK"
