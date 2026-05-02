#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

"$ROOT_DIR/scripts/validate_mansu_start.sh"
"$ROOT_DIR/scripts/validate_mansu_tdd_series.sh"
"$ROOT_DIR/scripts/validate_mansu_debug_rootcause.sh"
"$ROOT_DIR/scripts/validate_mansu_web_verify.sh"

echo "mansu skills structure OK"
