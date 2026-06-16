#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FILE="$ROOT_DIR/mansu-setting/SKILL.md"
OPENAI_YAML="$ROOT_DIR/mansu-setting/agents/openai.yaml"

test -f "$FILE"
test -f "$OPENAI_YAML"

grep -q '^name: mansu-setting$' "$FILE"
grep -q 'Pure compatibility alias for `mansu-setup`' "$FILE"
grep -q 'must not grow setup behavior of its' "$FILE"
grep -q 'own' "$FILE"
grep -Fq 'Use `$mansu-setup` for the actual setup' "$FILE"
grep -q 'Do not duplicate setup logic in this alias' "$FILE"
grep -q 'Do not present `mansu-setting` as a public setup route' "$FILE"
grep -q 'compatibility alias only' "$OPENAI_YAML"
grep -q 'Use [$]mansu-setup with the same mode and user intent' "$OPENAI_YAML"

! grep -q '^## Workflow$' "$FILE"

"$ROOT_DIR/scripts/validate_mansu_setup.sh"
