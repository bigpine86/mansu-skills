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

require_terms() {
  local file="$1"
  local message="$2"
  shift 2
  perl -0ne '
    BEGIN {
      our @terms = @ARGV;
      @ARGV = ();
    }
    my $text = lc($_);
    for my $term (@terms) {
      exit 1 if index($text, lc($term)) < 0;
    }
  ' "$@" < "$file" || fail "$message"
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

scenario "Given project kickoff is requested, When Mansu routes it, Then mansu-1define is public and mansu-project-start remains compatibility kickoff"
require_contains "$PROJECT" '^name: mansu-project-start$' 'project-start skill name missing'
require_terms "$PROJECT_YAML" 'project-start OpenAI prompt must keep the compatibility kickoff route' '$mansu-project-start' 'project-start' 'orchestrator'
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
require_terms "$PROJECT_YAML" 'OpenAI prompt must enforce design route gate' 'user-facing UI' 'design source route' 'phase roadmap planning'
require_contains "$SOURCE_CATALOG" 'Default design route stack' 'source catalog must preserve design route stack'
require_contains "$SOURCE_CATALOG" 'Recommended combinations:' 'source catalog must preserve design route combinations'

scenario "Given source artifacts are ready, When phase planning starts, Then roadmap and exactly one active phase are required before mansu-build/tdd-total"
require_contains "$PROJECT" '^## Phase roadmap gate$' 'project-start missing phase roadmap gate'
require_contains "$PROJECT" 'phase list: the large project phases in order' 'roadmap must include phase list'
require_contains "$PROJECT" 'active phase: exactly one phase selected' 'roadmap must select exactly one active phase'
require_contains "$PROJECT" 'Do not hand off to `mansu-tdd-total` when' 'project-start must block tdd-total without roadmap gate'
require_contains "$PROJECT" 'Implementation handoff: blocked' 'project-start must report blocked handoff'
require_contains "$PROJECT" 'Phase list:' 'project-start report must include phase list'
require_contains "$PROJECT" 'Active phase:' 'project-start report must include active phase'
require_terms "$PROJECT_YAML" 'OpenAI prompt must require phase roadmap before tdd-total' '$mansu-tdd-total' 'repo-visible' 'phase roadmap'

scenario "Given mansu-tdd-total is invoked directly, When the active plan path lacks active phase or roadmap link, Then it routes back to the numbered define/plan public routes"
require_contains "$TDD_TOTAL" 'Project Phase Roadmap' 'tdd-total must require roadmap artifact for project-started work'
require_contains "$TDD_TOTAL" 'does not name an active phase plus its Project Phase Roadmap' 'tdd-total must detect missing active phase/roadmap'
require_contains "$TDD_TOTAL" 'Route back to public `mansu-1define` / `mansu-2plan`' 'tdd-total must route back to numbered define/plan instead of implementing'
require_absent "$TDD_TOTAL" 'Route back to `mansu-project-start`' 'tdd-total must not route missing phase plans to legacy project-start'
require_contains "$TDD_TOTAL" 'If a roadmap file or section[[:space:]]*$' 'tdd-total must inspect roadmap-style files before rejecting them'
require_contains "$TDD_TOTAL" 'use only that[[:space:]]*$' 'tdd-total must accept roadmap-style files when they are active phase plans'
require_terms "$TDD_TOTAL_YAML" 'tdd-total OpenAI prompt must find active plan path first' 'active Phase Plan' 'explicit' 'user-provided path'
require_terms "$TDD_TOTAL_YAML" 'tdd-total OpenAI prompt must check OMO plan paths' '.omo/plans/*.md'
require_terms "$TDD_TOTAL_YAML" 'tdd-total OpenAI prompt must not reject plan by filename' 'PLAN.md' 'candidate' 'not a requirement' 'filename differs'
require_terms "$TDD_TOTAL_YAML" 'tdd-total OpenAI prompt must require roadmap/phase-order artifact' 'Project Phase Roadmap' 'link/section'
require_terms "$TDD_TOTAL_YAML" 'tdd-total OpenAI prompt must route missing phase plans to numbered define/plan' 'route back' 'mansu-1define' 'mansu-2plan'
require_absent "$TDD_TOTAL_YAML" 'route back to \$mansu-project-start instead of implementing' 'tdd-total OpenAI prompt must not route missing phase plans to project-start'
require_contains "$DOC_ORDER" 'Before numbered public `mansu-3build` starts through the backing' 'document router must enforce numbered build/tdd-total preflight'

scenario "Given fallback conditions, When source routes are missing, Then Mansu records skipped route reasons instead of silently proceeding"
require_contains "$PROJECT" 'Source skills skipped:' 'project-start report must record skipped source skills'
require_contains "$PROJECT" 'If UI is in scope and no design route is selected' 'UI without design route must block'
require_contains "$PROJECT" 'missing design route decision' 'blocked UI handoff must name missing design route'
require_absent "$PROJECT" 'Mansu should ask its own design questions' 'project-start must not tell Mansu to own design questions'

echo "mansu-project-start BDD scenarios OK"
