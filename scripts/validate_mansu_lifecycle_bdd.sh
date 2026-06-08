#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

DEFINE="$ROOT_DIR/mansu-define/SKILL.md"
PLAN="$ROOT_DIR/mansu-plan/SKILL.md"
BUILD="$ROOT_DIR/mansu-build/SKILL.md"
VERIFY="$ROOT_DIR/mansu-verify/SKILL.md"
REVIEW="$ROOT_DIR/mansu-review/SKILL.md"
DEBUG="$ROOT_DIR/mansu-debug/SKILL.md"
SHIP="$ROOT_DIR/mansu-ship/SKILL.md"
BUILD_OPENAI="$ROOT_DIR/mansu-build/agents/openai.yaml"
VERIFY_OPENAI="$ROOT_DIR/mansu-verify/agents/openai.yaml"
REVIEW_OPENAI="$ROOT_DIR/mansu-review/agents/openai.yaml"
DEBUG_OPENAI="$ROOT_DIR/mansu-debug/agents/openai.yaml"
SHIP_OPENAI="$ROOT_DIR/mansu-ship/agents/openai.yaml"
AGENTS_TEMPLATE="$ROOT_DIR/mansu-operating-model/references/AGENTS.md"
DOC_ORDER="$ROOT_DIR/mansu-operating-model/references/DOCUMENT_CREATION_ORDER.md"
SOURCE_COMPOSITION="$ROOT_DIR/mansu-operating-model/references/SOURCE_SKILL_COMPOSITION.md"
GITIGNORE="$ROOT_DIR/.gitignore"

fail() {
  echo "FAIL: $1" >&2
  exit 1
}

require_contains() {
  local file="$1"
  local pattern="$2"
  local message="$3"
  grep -Eq "$pattern" "$file" || fail "$message"
}

require_absent() {
  local file="$1"
  local pattern="$2"
  local message="$3"
  ! grep -Eq "$pattern" "$file" || fail "$message"
}

scenario() {
  printf 'SCENARIO: %s\n' "$1"
}

scenario "Given a new idea, When Mansu defines it, Then source-skill interview happens before planning and no implementation starts"
require_contains "$DEFINE" 'Use addyosmani `interview-me`' 'define must name addyosmani interview route'
require_contains "$DEFINE" 'Use Ouroboros `interview`, `pm`, `seed`, and `brownfield`' 'define must name Ouroboros definition route'
require_contains "$DEFINE" 'Do not start implementation' 'define must block implementation'
require_contains "$DEFINE" 'route to `mansu-plan` first' 'define must hand off to plan before build'

scenario "Given definition outputs exist, When Mansu plans, Then design direction and current phase roadmap are required before Build"
require_contains "$PLAN" 'Requirements/Spec -> Architecture -> Design Direction -> Implementation Roadmap' 'plan must preserve internal order'
require_contains "$PLAN" 'design direction or explicit no-design-needed reason' 'plan must require design decision or explicit no-design reason'
require_contains "$PLAN" 'current phase `PLAN.md`' 'plan must produce current phase PLAN'
require_contains "$PLAN" 'Do not skip directly to Build' 'plan must block direct build without valid current phase plan'

scenario "Given Build is invoked without a current phase plan, Then Mansu blocks implementation and routes back to Define/Plan"
require_contains "$BUILD" 'current phase `PLAN.md` exists' 'build must require current phase PLAN'
require_contains "$BUILD" 'If the current phase `PLAN.md` is missing' 'build must explicitly handle missing PLAN'
require_contains "$BUILD" 'route back to `mansu-define` / `mansu-plan`' 'build must route missing plan back to define/plan'
require_contains "$BUILD" 'Do not implement from a whole-project roadmap' 'build must reject whole-project roadmap as active phase plan'
require_contains "$BUILD_OPENAI" 'current phase PLAN\.md exists' 'build OpenAI prompt must require current phase PLAN'
require_contains "$BUILD_OPENAI" 'route back to mansu-define / mansu-plan' 'build OpenAI prompt must route missing PLAN back to define/plan'
require_contains "$BUILD_OPENAI" 'Do not implement from a whole-project roadmap' 'build OpenAI prompt must reject whole-project roadmap'

scenario "Given verification and review are separate gates, Then Verify proves behavior and Review judges quality"
require_contains "$VERIFY" 'Verify proves behavior' 'verify must state behavior proof role'
require_contains "$VERIFY" 'QA evidence' 'verify must require QA evidence'
require_contains "$VERIFY" 'Use `mansu-web-verify` as the compatibility route' 'verify must preserve web-verify compatibility route'
require_contains "$REVIEW" 'Review judges quality' 'review must state quality judgment role'
require_contains "$REVIEW" 'Review is not QA' 'review must not replace QA'
require_contains "$REVIEW" 'required fixes or route to `mansu-debug`' 'review must route unknown issues to debug'
require_contains "$VERIFY_OPENAI" 'prove behavior' 'verify OpenAI prompt must preserve behavior proof role'
require_contains "$VERIFY_OPENAI" 'QA evidence' 'verify OpenAI prompt must require QA evidence'
require_contains "$REVIEW_OPENAI" 'Review is not QA' 'review OpenAI prompt must not replace QA'
require_contains "$REVIEW_OPENAI" 'route unknown issues to mansu-debug' 'review OpenAI prompt must route unknown issues to debug'

scenario "Given an unknown failure appears in any phase, Then Debug interrupts and proves root cause before fixing"
require_contains "$DEBUG" 'Debug can interrupt any phase' 'debug must be phase-interrupt route'
require_contains "$DEBUG" 'Do not patch first and explain later' 'debug must block patch-first behavior'
require_contains "$DEBUG" 'Default to `mansu-debug-rootcause`' 'debug must delegate to rootcause route'
require_contains "$DEBUG_OPENAI" 'Do not patch first' 'debug OpenAI prompt must block patch-first behavior'
require_contains "$DEBUG_OPENAI" 'prove root cause' 'debug OpenAI prompt must require root cause proof'

scenario "Given Ship is requested, Then Mansu requires verify and review evidence before ship/hold"
require_contains "$SHIP" 'implementation has been verified and reviewed' 'ship must require verified and reviewed state'
require_contains "$SHIP" 'If verification evidence or review/risk notes are missing' 'ship must explicitly block missing evidence'
require_contains "$SHIP" 'route back to `mansu-verify` or `mansu-review`' 'ship must route missing gates backward'
require_contains "$SHIP" 'ship/hold decision' 'ship must keep ship/hold output'
require_contains "$SHIP_OPENAI" 'verification evidence' 'ship OpenAI prompt must require verification evidence'
require_contains "$SHIP_OPENAI" 'review/risk notes' 'ship OpenAI prompt must require review/risk notes'
require_contains "$SHIP_OPENAI" 'route back to mansu-verify or mansu-review' 'ship OpenAI prompt must route missing gates backward'

scenario "Given public lifecycle routes exist, Then templates prefer public routes and keep compatibility aliases secondary"
require_contains "$AGENTS_TEMPLATE" 'new product, app, repo, major feature family.*`mansu-define`, then `mansu-plan`' 'AGENTS must prefer define/plan'
require_contains "$AGENTS_TEMPLATE" 'current phase implementation or refactor with slices -> `mansu-build`' 'AGENTS must prefer build'
require_contains "$AGENTS_TEMPLATE" 'Compatibility aliases:' 'AGENTS must record compatibility alias map'
require_contains "$DOC_ORDER" 'use `mansu-define` and then[[:space:]]*$' 'document order must prefer define/plan'
require_contains "$DOC_ORDER" 'then hand off to[[:space:]]*$' 'document order must describe build handoff'
require_contains "$SOURCE_COMPOSITION" 'LazyCodex is runtime transport' 'composition must keep LazyCodex runtime-only'
require_contains "$SOURCE_COMPOSITION" 'must not appear as a phase source' 'composition must ban LazyCodex as phase source'

scenario "Given ulw-loop evidence exists locally, Then repo ignore prevents evidence from polluting commits"
require_contains "$GITIGNORE" '^\.omo/$' '.gitignore must ignore ulw-loop state'
require_absent <(git -C "$ROOT_DIR" status --short --untracked-files=all) '^\?\? \.omo/' '.omo should not appear as untracked status'

echo "mansu lifecycle BDD scenarios OK"
