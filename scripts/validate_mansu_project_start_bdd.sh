#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROJECT="$ROOT_DIR/mansu-project-start/SKILL.md"
PROJECT_YAML="$ROOT_DIR/mansu-project-start/agents/openai.yaml"
TDD_TOTAL="$ROOT_DIR/mansu-tdd-total/SKILL.md"
TDD_TOTAL_YAML="$ROOT_DIR/mansu-tdd-total/agents/openai.yaml"
DOC_ORDER="$ROOT_DIR/mansu-operating-model/references/DOCUMENT_CREATION_ORDER.md"
SOURCE_CATALOG="$ROOT_DIR/mansu-operating-model/references/SOURCE_SKILL_CATALOG.md"

fail() {
  echo "FAIL: $1" >&2
  exit 1
}

require_file() {
  [ -f "$1" ] || fail "missing file: $1"
}

require_absent_path() {
  [ ! -e "$1" ] || fail "path should not exist: $1"
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

require_file "$PROJECT"
require_file "$PROJECT_YAML"
require_file "$TDD_TOTAL"
require_file "$TDD_TOTAL_YAML"
require_file "$DOC_ORDER"
require_file "$SOURCE_CATALOG"
require_absent_path "$ROOT_DIR/mansu-start/SKILL.md"
require_absent_path "$ROOT_DIR/mansu-start/agents/openai.yaml"

scenario "Given project kickoff is requested, When Mansu routes it, Then mansu-project-start is the only start skill"
require_contains "$PROJECT" '^name: mansu-project-start$' 'project-start skill name missing'
require_contains "$PROJECT_YAML" 'Use \$mansu-project-start as a thin project-start orchestrator' 'project-start OpenAI prompt must be the direct kickoff route'
require_absent "$PROJECT" 'mansu-start' 'project-start must not refer to the removed mansu-start alias'
require_absent "$PROJECT_YAML" 'mansu-start' 'project-start OpenAI prompt must not refer to the removed mansu-start alias'

scenario "Given a new or fuzzy project, When project-start begins, Then Ouroboros is the first definition route"
require_contains "$PROJECT" '^## Mandatory Ouroboros-first rule$' 'project-start missing Ouroboros-first rule'
require_contains "$PROJECT" 'Mansu must not[[:space:]]*$' 'project-start must forbid Mansu-owned interview'
require_contains "$PROJECT" 'start by inventing its own interview' 'project-start must not invent interview'
require_contains "$PROJECT" 'check whether `ooo` or[[:space:]]*$' 'project-start must check ooo/ouroboros'
require_contains "$PROJECT" '`ouroboros init start` / `ouroboros-interview`' 'project-start must route to current Ouroboros interview command'
require_contains "$PROJECT" 'Mansu may ask at most one bridging question' 'project-start must limit pre-Ouroboros bridging questions'
require_contains "$PROJECT" 'Ouroboros skipped reason' 'project-start must record skipped Ouroboros reason'
require_contains "$PROJECT" 'label the kickoff[[:space:]]*$' 'project-start must label fallback kickoffs'

scenario "Given UI is in scope, When project-start selects design, Then it uses design source routes rather than Mansu questions"
require_contains "$PROJECT" '^## Design route gate$' 'project-start missing design route gate'
require_contains "$PROJECT" 'Mansu must not replace this with its own design questionnaire' 'project-start must not own design questionnaire'
require_contains "$PROJECT" 'gstack-design-consultation` as the default design-system route' 'greenfield UI should default to design-consultation'
require_contains "$PROJECT" 'Oh My / OMO `research` or `deepsearch` before or inside' 'ambiguous taste should use research/deepsearch conditionally'
require_contains "$PROJECT" 'Use addyosmani `source-driven-development` when source projects' 'source examples should use source-driven-development'
require_contains "$PROJECT" 'Use `gstack-design-shotgun` when the team needs several visible candidate' 'multiple options should use design-shotgun'
require_contains "$PROJECT" 'Use `gstack-plan-design-review` before locking the roadmap' 'design direction must be reviewed before roadmap lock'
require_contains "$PROJECT" 'Design route selected:' 'project-start report must name design route'
require_contains "$PROJECT_YAML" 'for user-facing UI, choose a design source route before phase roadmap planning' 'OpenAI prompt must enforce design route gate'
require_contains "$SOURCE_CATALOG" 'Default design route stack' 'source catalog must preserve design route stack'
require_contains "$SOURCE_CATALOG" 'Recommended combinations:' 'source catalog must preserve design route combinations'

scenario "Given source artifacts are ready, When phase planning starts, Then roadmap and exactly one active phase are required before tdd-total"
require_contains "$PROJECT" '^## Phase roadmap gate$' 'project-start missing phase roadmap gate'
require_contains "$PROJECT" 'phase list: the large project phases in order' 'roadmap must include phase list'
require_contains "$PROJECT" 'active phase: exactly one phase selected' 'roadmap must select exactly one active phase'
require_contains "$PROJECT" 'Do not hand off to `mansu-tdd-total` when' 'project-start must block tdd-total without roadmap gate'
require_contains "$PROJECT" 'Implementation handoff: blocked' 'project-start must report blocked handoff'
require_contains "$PROJECT" 'Phase list:' 'project-start report must include phase list'
require_contains "$PROJECT" 'Active phase:' 'project-start report must include active phase'
require_contains "$PROJECT_YAML" 'before calling \$mansu-tdd-total, create or update a repo-visible phase roadmap' 'OpenAI prompt must require phase roadmap before tdd-total'

scenario "Given mansu-tdd-total is invoked directly, When PLAN lacks active phase or roadmap link, Then it routes back to project-start"
require_contains "$TDD_TOTAL" 'project roadmap or phase order artifact' 'tdd-total must require roadmap artifact for project-started work'
require_contains "$TDD_TOTAL" 'does not name an active phase plus its roadmap/phase-order artifact' 'tdd-total must detect missing active phase/roadmap'
require_contains "$TDD_TOTAL" 'Route back to `mansu-project-start`' 'tdd-total must route back instead of implementing'
require_contains "$TDD_TOTAL" 'contains the whole project roadmap instead of one active phase' 'tdd-total must reject whole-project PLAN'
require_contains "$TDD_TOTAL_YAML" 'PLAN\.md names one active phase' 'tdd-total OpenAI prompt must require active phase preflight'
require_contains "$TDD_TOTAL_YAML" 'project roadmap or phase-order artifact' 'tdd-total OpenAI prompt must require roadmap/phase-order artifact'
require_contains "$TDD_TOTAL_YAML" 'route back to \$mansu-project-start instead of implementing' 'tdd-total OpenAI prompt must route back to project-start'
require_contains "$DOC_ORDER" 'Before `mansu-tdd-total` starts, `PLAN.md` must name the active phase' 'document router must enforce tdd-total preflight'

scenario "Given fallback conditions, When source routes are missing, Then Mansu records skipped route reasons instead of silently proceeding"
require_contains "$PROJECT" 'Source skills skipped:' 'project-start report must record skipped source skills'
require_contains "$PROJECT" 'If UI is in scope and no design route is selected' 'UI without design route must block'
require_contains "$PROJECT" 'missing design route decision' 'blocked UI handoff must name missing design route'
require_absent "$PROJECT" 'Mansu should ask its own design questions' 'project-start must not tell Mansu to own design questions'

echo "mansu-project-start BDD scenarios OK"
