#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOCK_FILE="$ROOT_DIR/mansu-operating-model/references/SOURCE_SKILL_LOCK.json"
CATALOG="$ROOT_DIR/mansu-operating-model/references/SOURCE_SKILL_CATALOG.md"
CURATOR="$ROOT_DIR/mansu-source-curator/SKILL.md"

test -f "$LOCK_FILE"

python3 -m json.tool "$LOCK_FILE" >/dev/null

grep -q '"id": "gstack"' "$LOCK_FILE"
grep -q '"id": "oh-my-codex-runtime"' "$LOCK_FILE"
grep -q '"id": "addyosmani-agent-skills"' "$LOCK_FILE"
grep -q '"last_checked": "2026-05-03"' "$LOCK_FILE"
grep -q '"skill_inventory"' "$LOCK_FILE"
grep -q '"tracked_capabilities"' "$LOCK_FILE"
grep -q 'inventory_warning' "$LOCK_FILE"
grep -q 'Exclude mansu-\*, gstack-\*' "$LOCK_FILE"
grep -q 'gstack-context-save' "$LOCK_FILE"
grep -q 'gstack-context-restore' "$LOCK_FILE"
grep -q 'planning-and-task-breakdown' "$LOCK_FILE"
grep -q 'shipping-and-launch' "$LOCK_FILE"

grep -q 'SOURCE_SKILL_LOCK.json' "$CATALOG"
grep -q 'SOURCE_SKILL_LOCK.json' "$CURATOR"
grep -q 'adapter-owned skill roots' "$CURATOR"
grep -q 'Exclude `mansu-\*`, `gstack-\*`' "$CURATOR"

echo "mansu source lock OK"
