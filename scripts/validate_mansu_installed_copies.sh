#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_DIR="${1:-${MANSU_INSTALLED_SKILL_DIR:-}}"
COMPARE="${MANSU_COMPARE_INSTALLED:-0}"

fail() {
  echo "FAIL: $1" >&2
  exit 1
}

if [ -z "$TARGET_DIR" ]; then
  echo "mansu installed-copy validation skipped: set MANSU_INSTALLED_SKILL_DIR or pass <runtime-skill-dir>"
  exit 0
fi

[ -d "$TARGET_DIR" ] || fail "runtime skill directory not found: $TARGET_DIR"

for installed_mansu_skill in "$TARGET_DIR"/mansu-*; do
  [ -d "$installed_mansu_skill" ] || continue
  skill_name="$(basename "$installed_mansu_skill")"
  source_skill="$ROOT_DIR/$skill_name"
  [ -d "$source_skill" ] || fail "obsolete installed Mansu skill directory: $installed_mansu_skill"
done

for source_skill in "$ROOT_DIR"/mansu-*; do
  [ -d "$source_skill" ] || continue
  skill_name="$(basename "$source_skill")"
  installed_skill="$TARGET_DIR/$skill_name"

  [ -d "$installed_skill" ] || fail "missing installed skill directory: $installed_skill"
  [ -f "$installed_skill/SKILL.md" ] || fail "missing installed SKILL.md: $installed_skill/SKILL.md"

  if [ -f "$source_skill/agents/openai.yaml" ]; then
    [ -f "$installed_skill/agents/openai.yaml" ] || fail "missing installed openai.yaml: $installed_skill/agents/openai.yaml"
  fi

  if [ "$COMPARE" = "1" ]; then
    cmp -s "$source_skill/SKILL.md" "$installed_skill/SKILL.md" || fail "installed SKILL.md differs: $skill_name"
    if [ -f "$source_skill/agents/openai.yaml" ]; then
      cmp -s "$source_skill/agents/openai.yaml" "$installed_skill/agents/openai.yaml" || fail "installed openai.yaml differs: $skill_name"
    fi

    while IFS= read -r source_file; do
      rel_path="${source_file#"$source_skill/"}"
      installed_file="$installed_skill/$rel_path"
      [ -f "$installed_file" ] || fail "missing installed file: $installed_file"
      cmp -s "$source_file" "$installed_file" || fail "installed file differs: $skill_name/$rel_path"
    done < <(find "$source_skill" -type f | sort)

    while IFS= read -r installed_file; do
      rel_path="${installed_file#"$installed_skill/"}"
      if [ "$skill_name" = "mansu-manual" ] && [ "$rel_path" = "docs/mansu-manual.html" ]; then
        continue
      fi
      [ -f "$source_skill/$rel_path" ] || fail "unexpected installed file: $skill_name/$rel_path"
    done < <(find "$installed_skill" -type f | sort)
  fi
done

[ -f "$TARGET_DIR/mansu-manual/docs/mansu-manual.html" ] || fail "missing installed manual HTML artifact"

if [ "$COMPARE" = "1" ]; then
  cmp -s "$ROOT_DIR/docs/mansu-manual.html" "$TARGET_DIR/mansu-manual/docs/mansu-manual.html" || fail "installed manual HTML differs"
fi

echo "mansu installed copies OK"
