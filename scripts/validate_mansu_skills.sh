#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

for skill_file in "$ROOT_DIR"/mansu-*/SKILL.md; do
  [ -f "$skill_file" ] || continue
  description="$(
    awk 'BEGIN{in_desc=0; desc=""}
      /^description:/{in_desc=1; sub(/^description:[ ]*/,""); desc=$0; next}
      in_desc && /^---$/{print desc; exit}
      in_desc{desc=desc" "$0}' "$skill_file"
  )"
  [ -n "$description" ] || {
    echo "FAIL: missing description: $skill_file" >&2
    exit 1
  }
  if [ "${#description}" -gt 240 ]; then
    echo "FAIL: description too long (${#description} chars): $skill_file" >&2
    exit 1
  fi
done

"$ROOT_DIR/scripts/validate_mansu_setup.sh"
"$ROOT_DIR/scripts/validate_mansu_help.sh"
"$ROOT_DIR/scripts/validate_mansu_manual.sh"
"$ROOT_DIR/scripts/validate_mansu_project_start_bdd.sh"
"$ROOT_DIR/scripts/validate_mansu_source_curator.sh"
"$ROOT_DIR/scripts/validate_mansu_source_lock.sh"
"$ROOT_DIR/scripts/validate_mansu_project_start.sh"
"$ROOT_DIR/scripts/validate_mansu_operating_model.sh"
"$ROOT_DIR/scripts/validate_mansu_source_composition.sh"
"$ROOT_DIR/scripts/validate_mansu_phase_skills.sh"
"$ROOT_DIR/scripts/validate_mansu_phase_routes.sh"
"$ROOT_DIR/scripts/validate_mansu_lifecycle_bdd.sh"
"$ROOT_DIR/scripts/validate_mansu_doc_system.sh"
"$ROOT_DIR/scripts/validate_mansu_runtime_readiness.sh"
"$ROOT_DIR/scripts/validate_mansu_installed_copies.sh" "$@"
"$ROOT_DIR/scripts/validate_mansu_tdd_series.sh"
"$ROOT_DIR/scripts/validate_mansu_debug_rootcause.sh"
"$ROOT_DIR/scripts/validate_mansu_web_verify.sh"
"$ROOT_DIR/scripts/validate_mansu_ship_release.sh"

echo "mansu skills structure OK"
