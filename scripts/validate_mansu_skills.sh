#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

"$ROOT_DIR/scripts/validate_mansu_setting.sh"
"$ROOT_DIR/scripts/validate_mansu_help.sh"
"$ROOT_DIR/scripts/validate_mansu_manual.sh"
"$ROOT_DIR/scripts/validate_mansu_source_curator.sh"
"$ROOT_DIR/scripts/validate_mansu_source_lock.sh"
"$ROOT_DIR/scripts/validate_mansu_project_start.sh"
"$ROOT_DIR/scripts/validate_mansu_operating_model.sh"
"$ROOT_DIR/scripts/validate_mansu_doc_system.sh"
"$ROOT_DIR/scripts/validate_mansu_runtime_readiness.sh"
"$ROOT_DIR/scripts/validate_mansu_tdd_series.sh"
"$ROOT_DIR/scripts/validate_mansu_debug_rootcause.sh"
"$ROOT_DIR/scripts/validate_mansu_web_verify.sh"
"$ROOT_DIR/scripts/validate_mansu_ship_release.sh"

echo "mansu skills structure OK"
