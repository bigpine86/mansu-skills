#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FILE="$ROOT_DIR/mansu-ship-release/SKILL.md"
OPENAI_YAML="$ROOT_DIR/mansu-ship-release/agents/openai.yaml"

test -f "$FILE"
test -f "$OPENAI_YAML"

grep -q '^name: mansu-ship-release$' "$FILE"
grep -q '^description: Mansu release and ship-readiness workflow' "$FILE"
grep -q '^## Core promise$' "$FILE"
grep -q '^## Modes$' "$FILE"
grep -q '^## Source skills to consider$' "$FILE"
grep -q '^## Ship gate$' "$FILE"
grep -q '^## Learning closeout$' "$FILE"
grep -q 'implemented, reviewed, QA-verified, ship-ready, merged, deployed' "$FILE"
grep -q 'gstack-health' "$FILE"
grep -q 'gstack-review' "$FILE"
grep -q 'gstack-ship' "$FILE"
grep -q 'gstack-land-and-deploy' "$FILE"
grep -q 'gstack-canary' "$FILE"
grep -q 'gstack-document-release' "$FILE"
grep -q 'gstack-retro' "$FILE"
grep -q 'gstack-learn' "$FILE"
grep -q 'rollback' "$FILE"
grep -q 'Do not bury durable lessons only in the final chat message' "$FILE"
grep -q "Write the report in the user's language or the project's default language" "$FILE"
grep -q 'Field labels may stay canonical' "$FILE"

grep -q '^interface:$' "$OPENAI_YAML"
grep -q 'display_name: "Mansu Ship Release"' "$OPENAI_YAML"
grep -q 'short_description: "Release readiness and ship gate"' "$OPENAI_YAML"
grep -q 'default_prompt: "Use \$mansu-ship-release' "$OPENAI_YAML"

echo "mansu-ship-release structure OK"
