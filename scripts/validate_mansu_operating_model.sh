#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MODEL="$ROOT_DIR/mansu-operating-model/SKILL.md"
OPENAI_YAML="$ROOT_DIR/mansu-operating-model/agents/openai.yaml"
DOCTRINE_REF="$ROOT_DIR/mansu-operating-model/references/DOCTRINE.md"
SOURCE_CATALOG="$ROOT_DIR/mansu-operating-model/references/SOURCE_SKILL_CATALOG.md"
SOURCE_LOCK="$ROOT_DIR/mansu-operating-model/references/SOURCE_SKILL_LOCK.json"
DOC_ORDER="$ROOT_DIR/mansu-operating-model/references/DOCUMENT_CREATION_ORDER.md"
CODE_ORDER="$ROOT_DIR/mansu-operating-model/references/CODE_CONSTRUCTION_ORDER.md"
AGENTS_TEMPLATE="$ROOT_DIR/mansu-operating-model/references/AGENTS.md"
CODING_RULES_TEMPLATE="$ROOT_DIR/mansu-operating-model/references/CODING_RULES.md"

fail() {
  echo "FAIL: $1" >&2
  exit 1
}

require_file() {
  [ -f "$1" ] || fail "missing file: $1"
}

require_contains() {
  local file="$1"
  local pattern="$2"
  local message="$3"
  if ! grep -Eqi "$pattern" "$file"; then
    fail "$message"
  fi
}

forbid_contains() {
  local file="$1"
  local pattern="$2"
  local message="$3"
  if grep -Eqi "$pattern" "$file"; then
    fail "$message"
  fi
}

require_file "$MODEL"
require_file "$OPENAI_YAML"
require_file "$DOCTRINE_REF"
require_file "$SOURCE_CATALOG"
require_file "$SOURCE_LOCK"
require_file "$DOC_ORDER"
require_file "$CODE_ORDER"
require_file "$AGENTS_TEMPLATE"
require_file "$CODING_RULES_TEMPLATE"

model_lines="$(wc -l < "$MODEL" | tr -d ' ')"
[ "$model_lines" -lt 500 ] || fail "operating model SKILL.md should stay under 500 lines; move detail into references"

# Skill entry sections
require_contains "$MODEL" '^## Purpose$' 'operating model missing Purpose section'
require_contains "$MODEL" '^## Core doctrine$' 'operating model missing Core doctrine section'
require_contains "$MODEL" '^## Work classes$' 'operating model missing Work classes section'
require_contains "$MODEL" '^## Delivery spine$' 'operating model missing Delivery spine section'
require_contains "$MODEL" '^## Role model$' 'operating model missing Role model section'
require_contains "$MODEL" '^## Strict mode policy$' 'operating model missing Strict mode policy section'
require_contains "$MODEL" '^## Evidence and ship readiness$' 'operating model missing Evidence and ship readiness section'
require_contains "$MODEL" '^## Document authority$' 'operating model missing Document authority section'
require_contains "$MODEL" '^## Reference map$' 'operating model missing Reference map section'
require_contains "$MODEL" 'references/DOCTRINE.md' 'operating model should point to DOCTRINE reference'
require_contains "$MODEL" 'references/SOURCE_SKILL_CATALOG.md' 'operating model should point to source skill catalog'
require_contains "$MODEL" 'references/SOURCE_SKILL_LOCK.json' 'operating model should point to source skill lock'
require_contains "$MODEL" 'references/DOCUMENT_CREATION_ORDER.md' 'operating model should point to document creation order'
require_contains "$MODEL" 'references/CODE_CONSTRUCTION_ORDER.md' 'operating model should point to code construction order'
require_contains "$MODEL" 'check the source skill catalog' 'operating model lost source catalog doctrine'
require_contains "$MODEL" 'document creation order' 'operating model lost document creation order doctrine'
require_contains "$MODEL" 'code construction order' 'operating model lost coding-order doctrine'

# Detailed doctrine sections
require_contains "$DOCTRINE_REF" '^## Contents$' 'doctrine reference missing Contents section'
require_contains "$DOCTRINE_REF" '^## Work Classification$' 'doctrine reference missing Work Classification section'
require_contains "$DOCTRINE_REF" '^## Delivery Spine$' 'doctrine reference missing Delivery Spine section'
require_contains "$DOCTRINE_REF" '^## Role Model$' 'doctrine reference missing Role Model section'
require_contains "$DOCTRINE_REF" '^## Orchestration Model$' 'doctrine reference missing Orchestration Model section'
require_contains "$DOCTRINE_REF" '^## Strict Mode Policy$' 'doctrine reference missing Strict Mode Policy section'
require_contains "$DOCTRINE_REF" '^## Evidence And Ship Readiness$' 'doctrine reference missing Evidence And Ship Readiness section'
require_contains "$DOCTRINE_REF" '^## Anti-Patterns$' 'doctrine reference missing Anti-Patterns section'
require_contains "$DOCTRINE_REF" '^## Document Authority$' 'doctrine reference missing Document Authority section'

# Required concepts
require_contains "$DOCTRINE_REF" 'Non-trivial work starts with planning' 'doctrine reference lost plan-first doctrine'
require_contains "$DOCTRINE_REF" 'Planning and execution are separate phases' 'doctrine reference lost planning/execution separation'
require_contains "$DOCTRINE_REF" 'Code creation is not evidence of correctness' 'doctrine reference lost evidence doctrine'
require_contains "$DOCTRINE_REF" 'strict mode is blocked' 'doctrine reference lost strict blocked rule'
require_contains "$DOCTRINE_REF" 'Route by task character' 'doctrine reference lost task-character routing'
require_contains "$DOCTRINE_REF" 'commit or explicit no-commit reason' 'doctrine reference lost commit/no-commit discipline'
require_contains "$DOCTRINE_REF" 'worklog update' 'doctrine reference lost worklog discipline'
require_contains "$DOCTRINE_REF" 'Learning closeout should choose the right artifact' 'doctrine reference lost learning closeout router'
require_contains "$DOCTRINE_REF" 'An equivalent review gate is valid only when it is separately invoked' 'doctrine reference lost review-equivalence rule'
require_contains "$DOCTRINE_REF" 'An equivalent QA gate is valid only when it is separately invoked' 'doctrine reference lost QA-equivalence rule'
require_contains "$DOCTRINE_REF" 'Merged status and shipped status are not assumed to be equivalent' 'doctrine reference lost merged-vs-shipped distinction'
require_contains "$MODEL" 'continues automatically unless the user' 'operating model lost automatic execution-ready gate rule'
require_contains "$MODEL" 'references/AGENTS.md' 'operating model should point to AGENTS template'
require_contains "$MODEL" 'references/CODING_RULES.md' 'operating model should point to CODING_RULES template'
require_contains "$MODEL" 'Project documents specialize the doctrine; they must not weaken it' 'operating model lost local-doc non-weakening rule'

# Source skill catalog essentials
require_contains "$SOURCE_CATALOG" '^# Mansu Source Skill Catalog$' 'source catalog missing canonical title'
require_contains "$SOURCE_CATALOG" '^## Layer Model$' 'source catalog missing Layer Model section'
require_contains "$SOURCE_CATALOG" '^## Freshness Policy$' 'source catalog missing Freshness Policy section'
require_contains "$SOURCE_CATALOG" 'SOURCE_SKILL_LOCK.json' 'source catalog missing source lock reference'
require_contains "$SOURCE_CATALOG" '^## gstack Capability Map$' 'source catalog missing gstack map'
require_contains "$SOURCE_CATALOG" '^## Oh My / OMO / OMC Capability Map$' 'source catalog missing Oh My map'
require_contains "$SOURCE_CATALOG" '^## addyosmani/agent-skills Capability Map$' 'source catalog missing addyosmani map'
require_contains "$SOURCE_CATALOG" '^## Mansu Composition Recipes$' 'source catalog missing composition recipes'
require_contains "$SOURCE_CATALOG" '^### New Project / Zero-To-PLAN$' 'source catalog missing zero-to-PLAN recipe'
require_contains "$SOURCE_CATALOG" '^### Source Refresh And Reference Curation$' 'source catalog missing source refresh recipe'
require_contains "$SOURCE_CATALOG" 'mansu-source-curator' 'source catalog lost curator route'
require_contains "$SOURCE_CATALOG" 'mansu-project-start' 'source catalog lost project start route'
require_contains "$SOURCE_CATALOG" 'mansu-ship-release' 'source catalog lost ship release route'
require_contains "$SOURCE_CATALOG" 'GitHub, Reddit, and Threads' 'source catalog lost community/source research route'
require_contains "$SOURCE_CATALOG" 'official/current docs' 'source catalog lost evidence-ranked official-source rule'
require_contains "$SOURCE_CATALOG" 'source files first for technical truth' 'source catalog lost evidence-ranked source-file rule'
require_contains "$SOURCE_CATALOG" 'gate mapping' 'source catalog lost gate mapping handoff'
require_contains "$SOURCE_CATALOG" 'scripts/validate_mansu_skills\.sh' 'source catalog lost suite validation route'
require_contains "$SOURCE_CATALOG" 'gstack-design-shotgun' 'source catalog lost design-shotgun route'
require_contains "$SOURCE_CATALOG" 'gstack repo or `gstack-\*` skill set changed' 'source catalog lost gstack freshness check'
require_contains "$SOURCE_CATALOG" 'Oh My / OMO / OMC adapter or source skill set changed' 'source catalog lost Oh My freshness check'
require_contains "$SOURCE_CATALOG" 'addyosmani/agent-skills' 'source catalog lost addyosmani source family'
require_contains "$SOURCE_CATALOG" 'idea-refine' 'source catalog lost idea-refine route'
require_contains "$SOURCE_CATALOG" 'code-simplification' 'source catalog lost code-simplification route'
require_contains "$SOURCE_CATALOG" 'ci-cd-and-automation' 'source catalog lost ci-cd route'
require_contains "$SOURCE_CATALOG" 'deprecation-and-migration' 'source catalog lost deprecation/migration route'
require_contains "$SOURCE_CATALOG" 'stale assumptions' 'source catalog lost stale-source warning'
require_contains "$SOURCE_CATALOG" 'gstack-plan-eng-review' 'source catalog lost eng review route'
require_contains "$SOURCE_CATALOG" 'gstack-qa' 'source catalog lost QA route'
require_contains "$SOURCE_CATALOG" 'ultrawork' 'source catalog lost Oh My parallel route'
require_contains "$SOURCE_CATALOG" 'ralph' 'source catalog lost persistence route'
require_contains "$SOURCE_CATALOG" 'Mansu does not compete with strong specialist skills' 'source catalog lost orchestration stance'
require_contains "$SOURCE_CATALOG" 'Do not clone gstack' 'source catalog lost anti-cloning rule'

# Document creation router essentials
require_contains "$DOC_ORDER" '^# Mansu Document Creation Router$' 'document creation router missing canonical title'
require_contains "$DOC_ORDER" '^## Default Document Flow$' 'document creation router missing default flow'
require_contains "$DOC_ORDER" 'mansu-project-start' 'document creation router lost project-start orchestration route'
require_contains "$DOC_ORDER" '^## Locator Reference Map$' 'document creation router missing locator reference map'
require_contains "$DOC_ORDER" '^## Document Matrix$' 'document creation router missing document matrix'
require_contains "$DOC_ORDER" '^## Verification Order$' 'document creation router missing verification order'
require_contains "$DOC_ORDER" '^## PLAN.md Boundary$' 'document creation router missing PLAN boundary'
require_contains "$DOC_ORDER" 'gstack-office-hours' 'document creation router lost office-hours source'
require_contains "$DOC_ORDER" 'spec-driven-development' 'document creation router lost spec-driven source'
require_contains "$DOC_ORDER" 'planning-and-task-breakdown' 'document creation router lost planning source'
require_contains "$DOC_ORDER" 'documentation-and-adrs' 'document creation router lost ADR source'
require_contains "$DOC_ORDER" 'gstack-autoplan' 'document creation router lost autoplan verification'
require_contains "$DOC_ORDER" 'gstack-plan-eng-review' 'document creation router lost eng verification'
require_contains "$DOC_ORDER" 'mansu-tdd-total' 'document creation router lost PLAN handoff'
require_contains "$DOC_ORDER" 'docs/specs/\{feature-slug\}\.md' 'document creation router lost default spec path'
require_contains "$DOC_ORDER" 'docs/technical/\{feature-slug\}\.md' 'document creation router lost default TDR path'
require_contains "$DOC_ORDER" 'docs/research/\{topic-slug\}\.md' 'document creation router lost default research path'
require_contains "$DOC_ORDER" 'docs/decisions/ADR-001-\{decision-slug\}\.md' 'document creation router lost default ADR path'
require_contains "$DOC_ORDER" 'docs/reports/\{YYYY-MM-DD\}-\{feature-slug\}-verification\.md' 'document creation router lost default verification report path'
require_contains "$DOC_ORDER" 'Handoffs should name the exact path of the next artifact when the path is known' 'document creation router lost locator handoff guidance'
require_contains "$DOC_ORDER" 'suggested fallback path' 'document creation router lost fallback-path guidance'
require_contains "$DOC_ORDER" 'Do not keep fully completed history expanded in `PLAN.md`' 'document creation router lost PLAN/worklog boundary'

# Code construction router essentials
require_contains "$CODE_ORDER" '^# Mansu Code Construction Router$' 'code construction router missing canonical title'
require_contains "$CODE_ORDER" 'does not freeze one universal coding sequence' 'code construction router lost non-hardcoded stance'
require_contains "$CODE_ORDER" '^## Phase Detection$' 'code construction router missing phase detection'
require_contains "$CODE_ORDER" '^## Router Loop$' 'code construction router missing router loop'
require_contains "$CODE_ORDER" '^## Mansu Invariants$' 'code construction router missing Mansu invariants'
require_contains "$CODE_ORDER" '^## Dynamic Construction Checklist$' 'code construction router missing dynamic checklist'
require_contains "$CODE_ORDER" '^## Flexible Construction Patterns$' 'code construction router missing flexible patterns'
require_contains "$CODE_ORDER" '^## File Growth Rule$' 'code construction order missing file growth rule'
require_contains "$CODE_ORDER" '`idea-refine`' 'code construction router lost idea-refine source skill'
require_contains "$CODE_ORDER" '`code-simplification`' 'code construction router lost code-simplification source skill'
require_contains "$CODE_ORDER" '`ci-cd-and-automation`' 'code construction router lost ci-cd source skill'
require_contains "$CODE_ORDER" '`deprecation-and-migration`' 'code construction router lost deprecation/migration source skill'
require_contains "$CODE_ORDER" 'Read the original source skill when the task enters that phase' 'code construction router lost source-skill read rule'
require_contains "$CODE_ORDER" 're-detect the phase before continuing' 'code construction router lost phase redetection rule'
require_contains "$CODE_ORDER" '`safe default`' 'code construction router lost safe-default checklist'
require_contains "$CODE_ORDER" '`rollback`' 'code construction router lost rollback checklist'

# Disallowed vague doctrine
forbid_contains "$MODEL" 'strict-ish|best effort strict|if possible review|review if convenient|QA if needed|probably fine|maybe ship-ready' 'operating model contains vague or weakened doctrine'
forbid_contains "$DOCTRINE_REF" 'strict-ish|best effort strict|if possible review|review if convenient|QA if needed|probably fine|maybe ship-ready' 'doctrine reference contains vague or weakened doctrine'
forbid_contains "$MODEL" '(mandatory|required|human|manual)[[:space:]-]+approval before build|approval before build is required|requires approval before build' 'operating model reintroduced mandatory approval before build'
forbid_contains "$DOCTRINE_REF" '(mandatory|required|human|manual)[[:space:]-]+approval before build|approval before build is required|requires approval before build' 'doctrine reference reintroduced mandatory approval before build'

# UI metadata
require_contains "$OPENAI_YAML" '^interface:$' 'operating model missing interface metadata'
require_contains "$OPENAI_YAML" 'display_name: "Mansu Operating Model"' 'operating model display name drifted'
require_contains "$OPENAI_YAML" 'short_description: "Canonical doctrine for Mansu project operating rules"' 'operating model short description drifted'
require_contains "$OPENAI_YAML" 'default_prompt: "Use \$mansu-operating-model' 'operating model default prompt drifted'

# Router template essentials
require_contains "$AGENTS_TEMPLATE" 'CODING_RULES\.md' 'AGENTS template must point to CODING_RULES.md'
require_contains "$AGENTS_TEMPLATE" 'plan before implementation' 'AGENTS template lost plan-first workflow'
require_contains "$AGENTS_TEMPLATE" 'unmet strict prerequisites block the task' 'AGENTS template lost strict blocked rule'
require_contains "$AGENTS_TEMPLATE" 'Quick work may compress phases' 'AGENTS template lost quick compression boundary'
require_contains "$AGENTS_TEMPLATE" 'continue automatically unless the user explicitly requested a human approval gate' 'AGENTS template lost automatic execution-ready rule'
require_contains "$AGENTS_TEMPLATE" 'critic' 'AGENTS template lost critic role'
require_contains "$AGENTS_TEMPLATE" 'checkpoint' 'AGENTS template lost checkpoint role'
require_contains "$AGENTS_TEMPLATE" 'shipper' 'AGENTS template lost shipper role'
require_contains "$AGENTS_TEMPLATE" 'commit or record explicit no-commit reason' 'AGENTS template lost commit/no-commit discipline'
require_contains "$AGENTS_TEMPLATE" 'worklog update' 'AGENTS template lost worklog discipline'
require_contains "$AGENTS_TEMPLATE" 'must not weaken it' 'AGENTS template lost local-doc non-weakening rule'
forbid_contains "$AGENTS_TEMPLATE" '(mandatory|required|human|manual)[[:space:]-]+approval before build|approval before build is required|requires approval before build' 'AGENTS template reintroduced mandatory approval before build'

# Local rules template essentials
require_contains "$CODING_RULES_TEMPLATE" '^## Contents$' 'CODING_RULES template missing Contents section'
require_contains "$CODING_RULES_TEMPLATE" '^## Validation Commands$' 'CODING_RULES template missing Validation Commands section'
require_contains "$CODING_RULES_TEMPLATE" '^## Gate Mapping$' 'CODING_RULES template missing Gate Mapping section'
require_contains "$CODING_RULES_TEMPLATE" '^## Learning Closeout$' 'CODING_RULES template missing Learning Closeout section'
require_contains "$CODING_RULES_TEMPLATE" '^## Dangerous Surfaces$' 'CODING_RULES template missing Dangerous Surfaces section'
require_contains "$CODING_RULES_TEMPLATE" 'runtime target: `<Hermes \| OpenCode \| Codex \| Claude Code \| other>`' 'CODING_RULES template lost runtime target placeholder'
require_contains "$CODING_RULES_TEMPLATE" 'session manager: `<tmux \| terminal tabs \| IDE workspace \| CI runner \| none>`' 'CODING_RULES template lost session manager placeholder'
require_contains "$CODING_RULES_TEMPLATE" 'Example only' 'CODING_RULES template lost example-only runtime framing'
require_contains "$CODING_RULES_TEMPLATE" 'An active project is not operationally ready until this section contains runnable commands' 'CODING_RULES template lost runnable-command requirement'
require_contains "$CODING_RULES_TEMPLATE" 'Merged and shipped are not assumed to be the same state in this project' 'CODING_RULES template lost merged-vs-shipped distinction'
require_contains "$CODING_RULES_TEMPLATE" 'execution-ready plan gate before build' 'CODING_RULES template lost execution-ready plan gate'
require_contains "$CODING_RULES_TEMPLATE" 'continue automatically unless the user explicitly requested a human approval gate' 'CODING_RULES template lost automatic execution-ready rule'
require_contains "$CODING_RULES_TEMPLATE" 'commit or explicit no-commit reason' 'CODING_RULES template lost commit/no-commit discipline'
require_contains "$CODING_RULES_TEMPLATE" 'worklog update' 'CODING_RULES template lost worklog discipline'
require_contains "$CODING_RULES_TEMPLATE" 'An equivalent gate is valid only when it is' 'CODING_RULES template lost gate-equivalence definition'
require_contains "$CODING_RULES_TEMPLATE" 'separately invoked from implementation' 'CODING_RULES template lost separately-invoked gate rule'
require_contains "$CODING_RULES_TEMPLATE" 'Do not call a casual paragraph a review, QA, or checkpoint gate' 'CODING_RULES template lost anti-gate-theater rule'
require_contains "$CODING_RULES_TEMPLATE" 'Before ending standard or heavy work, decide where each durable lesson belongs' 'CODING_RULES template lost learning closeout rule'
require_contains "$CODING_RULES_TEMPLATE" 'must not weaken it' 'CODING_RULES template lost local-doc non-weakening rule'
forbid_contains "$CODING_RULES_TEMPLATE" '(mandatory|required|human|manual)[[:space:]-]+approval before build|approval before build is required|requires approval before build' 'CODING_RULES template reintroduced mandatory approval before build'

echo "mansu operating model structure OK"
