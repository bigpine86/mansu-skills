#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FILE="$ROOT_DIR/mansu-operating-model/references/SOURCE_SKILL_COMPOSITION.md"
CATALOG="$ROOT_DIR/mansu-operating-model/references/SOURCE_SKILL_CATALOG.md"
CODE_ORDER="$ROOT_DIR/mansu-operating-model/references/CODE_CONSTRUCTION_ORDER.md"

test -f "$FILE"

grep -q '^# Mansu Source Skill Composition' "$FILE"
grep -q 'Define -> Plan -> Build -> Verify -> Review -> Ship' "$FILE"
grep -q '`mansu-debug` is a public special-purpose interrupt route' "$FILE"
grep -q 'interview-me' "$FILE"
grep -q 'Ouroboros' "$FILE"
grep -q 'office-hours' "$FILE"
grep -q 'Requirements/Spec -> Architecture -> Design Direction -> Implementation Roadmap' "$FILE"
grep -q 'Open Design' "$FILE"
grep -q 'VoltAgent/awesome-design-md' "$FILE"
grep -q 'gstack-design-shotgun' "$FILE"
grep -q 'mansu-tdd-total' "$FILE"
grep -q 'Verify proves behavior' "$FILE"
grep -q 'Review judges quality' "$FILE"
grep -q 'continuous sequence by default when verification passes' "$FILE"
grep -q 'Passing Verify hands off to Review by default' "$FILE"
grep -q 'LazyCodex is the Codex-side route for OMO execution patterns' "$FILE"
grep -q 'must not appear as a phase source' "$FILE"

grep -q 'SOURCE_SKILL_COMPOSITION.md' "$CATALOG"
grep -q 'SOURCE_SKILL_COMPOSITION.md' "$CODE_ORDER"

! grep -q 'LazyCodex/OMO Codex plugin as preferred Codex transport' "$CODE_ORDER"
