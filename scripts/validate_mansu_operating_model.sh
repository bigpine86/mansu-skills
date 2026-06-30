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
PLAN_SKILL="$ROOT_DIR/mansu-plan/SKILL.md"
PLAN_OPENAI="$ROOT_DIR/mansu-plan/agents/openai.yaml"
BUILD_SKILL="$ROOT_DIR/mansu-build/SKILL.md"
BUILD_OPENAI="$ROOT_DIR/mansu-build/agents/openai.yaml"
TDD_TOTAL="$ROOT_DIR/mansu-tdd-total/SKILL.md"

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

require_literal() {
  local file="$1"
  local pattern="$2"
  local message="$3"
  if ! grep -Fqi "$pattern" "$file"; then
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

forbid_stale_spine() {
  local file="$1"
  local message="$2"
  forbid_contains "$file" 'Think[[:space:]]*->[[:space:]]*Plan[[:space:]]*->[[:space:]]*Build[[:space:]]*->[[:space:]]*Review[[:space:]]*->[[:space:]]*Test[[:space:]]*->[[:space:]]*Ship' "$message"
}

forbid_unnumbered_public_lifecycle_route() {
  local file="$1"
  forbid_contains "$file" 'Use[[:space:]]+`mansu-define`[[:space:]]+and[[:space:]]+then[[:space:]]+`mansu-plan`' 'source catalog exposes unnumbered define/plan as public guidance'
  forbid_contains "$file" 'use[[:space:]]+`mansu-define`' 'source catalog exposes mansu-define as active public guidance'
  forbid_contains "$file" 'Hand off to[[:space:]]+`mansu-build`' 'source catalog exposes mansu-build as active public handoff'
  forbid_contains "$file" 'For non-trivial work,[[:space:]]+use[[:space:]]+`mansu-build`' 'source catalog exposes mansu-build as active public guidance'
  forbid_contains "$file" 'Use[[:space:]]+`mansu-verify`' 'source catalog exposes mansu-verify as active public guidance'
  forbid_contains "$file" 'Use[[:space:]]+`mansu-ship`' 'source catalog exposes mansu-ship as active public guidance'
}

forbid_project_start_primary_route() {
  local file="$1"
  forbid_contains "$file" 'During `mansu-project-start`|zero-to-PLAN kickoff route|Ouroboros project-definition work.*mansu-project-start' 'source catalog or plan presents mansu-project-start as the primary zero-to-PLAN route'
}

forbid_default_ulw_plan_route() {
  local file="$1"
  local message="$2"
  if perl -0ne 'exit(/(?:Mansu\s+Plan|Quick\s+Plan|Standard\s+Plan|Heavy\s+Plan|Plan)[^\n.]{0,200}(?:default[^\n.]{0,80}`ulw-plan`|`ulw-plan`[^\n.]{0,80}default)/i ? 0 : 1)' "$file"; then
    fail "$message"
  fi
}

require_plan_tiers() {
  local file="$1"
  local label="$2"
  require_contains "$file" 'Quick Plan' "$label lost Quick Plan tier"
  require_contains "$file" 'Standard Plan' "$label lost Standard Plan tier"
  require_contains "$file" 'Heavy Plan' "$label lost Heavy Plan tier"
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
require_file "$PLAN_SKILL"
require_file "$PLAN_OPENAI"
require_file "$BUILD_SKILL"
require_file "$BUILD_OPENAI"
require_file "$TDD_TOTAL"

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
require_contains "$MODEL" '^## Document ownership map$' 'operating model missing Document ownership map section'
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
require_contains "$DOCTRINE_REF" 'Define -> Plan -> Build -> Verify -> Review -> Ship' 'doctrine reference lost consolidated delivery spine'
for reference_file in "$ROOT_DIR"/mansu-operating-model/references/*; do
  [ -f "$reference_file" ] || continue
  forbid_stale_spine "$reference_file" "stale old lifecycle spine leaked into operating model reference: $reference_file"
done

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
require_contains "$MODEL" 'Keep Mansu documents MECE' 'operating model lost MECE document ownership rule'
require_literal "$MODEL" '`references/AGENTS.md` | project-local first-hop router' 'operating model lost AGENTS ownership boundary'
require_literal "$MODEL" '`references/SOURCE_SKILL_CATALOG.md` | source-family map' 'operating model lost source catalog ownership boundary'
require_literal "$MODEL" '`references/DOCUMENT_CREATION_ORDER.md` | artifact router' 'operating model lost document router ownership boundary'
require_literal "$MODEL" '`mansu-1define/SKILL.md` | public Define phase route' 'operating model lost numbered define ownership boundary'
require_literal "$MODEL" '`mansu-2plan/SKILL.md` | public Plan phase route' 'operating model lost numbered plan ownership boundary'
require_literal "$MODEL" '`mansu-3build/SKILL.md` | public Build phase route' 'operating model lost numbered build ownership boundary'
require_literal "$MODEL" '`mansu-4verify/SKILL.md` | public Verify phase route' 'operating model lost numbered verify ownership boundary'
require_literal "$MODEL" '`mansu-5review/SKILL.md` | public Review phase route' 'operating model lost numbered review ownership boundary'
require_literal "$MODEL" '`mansu-6ship/SKILL.md` | numbered Ship phase route' 'operating model lost numbered ship ownership boundary'
require_literal "$MODEL" '`mansu-define/SKILL.md` through `mansu-ship/SKILL.md` | compatibility/backing implementations for numbered lifecycle phase routes' 'operating model lost unnumbered compatibility/backing boundary'
require_literal "$MODEL" '`mansu-project-start/SKILL.md` | compatibility Zero-to-PLAN workflow' 'operating model lost project-start compatibility boundary'
require_contains "$MODEL" 'link to the owner and summarize only the routing' 'operating model lost anti-duplication linking rule'
require_plan_tiers "$PLAN_SKILL" 'mansu-plan'
require_plan_tiers "$PLAN_OPENAI" 'mansu-plan OpenAI prompt'
require_contains "$BUILD_SKILL" 'role/marker discovery' 'build lost role/marker active Phase Plan discovery'
require_contains "$BUILD_OPENAI" 'role/marker discovery' 'build OpenAI prompt lost role/marker active Phase Plan discovery'
require_contains "$TDD_TOTAL" 'role/marker discovery' 'tdd-total lost role/marker active Phase Plan discovery'
forbid_default_ulw_plan_route "$SOURCE_CATALOG" 'source catalog reintroduced ulw-plan as a default Plan route'
forbid_default_ulw_plan_route "$CODE_ORDER" 'code construction router reintroduced ulw-plan as a default Plan route'
forbid_default_ulw_plan_route "$PLAN_SKILL" 'mansu-plan reintroduced ulw-plan as a default Plan route'

require_contains "$AGENTS_TEMPLATE" '^## Routing Contract$' 'AGENTS template missing routing contract'
require_contains "$AGENTS_TEMPLATE" 'First-hop routes:' 'AGENTS template missing first-hop route map'
require_contains "$AGENTS_TEMPLATE" 'unsure what to do next -> `mansu-help`' 'AGENTS template missing mansu-help route'
require_contains "$AGENTS_TEMPLATE" 'new product, app, repo, major feature family.*-> `mansu-1define`, then `mansu-2plan`' 'AGENTS template missing define/plan route'
require_contains "$AGENTS_TEMPLATE" 'current phase implementation or refactor with slices -> `mansu-3build`' 'AGENTS template missing build route'
require_contains "$AGENTS_TEMPLATE" 'behavior proof, test evidence, QA, or browser/runtime verification -> `mansu-4verify`' 'AGENTS template missing verify route'
require_contains "$AGENTS_TEMPLATE" 'quality, architecture, design, security, or decision-risk review -> `mansu-5review`' 'AGENTS template missing review route'
require_contains "$AGENTS_TEMPLATE" 'unclear failure, regression, stack trace, or broken behavior -> `mansu-debug`' 'AGENTS template missing debug route'
require_contains "$AGENTS_TEMPLATE" 'release readiness, commit/PR/release notes, ship-or-hold judgment -> `mansu-6ship`' 'AGENTS template missing ship route'
require_contains "$AGENTS_TEMPLATE" 'source skill drift, source catalog refresh' 'AGENTS template missing source-curator route'
require_contains "$AGENTS_TEMPLATE" 'Compatibility aliases and backing routes:' 'AGENTS template missing compatibility/backing route map'
require_contains "$AGENTS_TEMPLATE" '`mansu-tdd-total` -> `mansu-3build` numbered route; backing implementation `mansu-build`' 'AGENTS template missing build backing route'
require_contains "$AGENTS_TEMPLATE" '`mansu-web-verify` -> `mansu-4verify` numbered route; backing implementation `mansu-verify`' 'AGENTS template missing verify backing route'
require_contains "$AGENTS_TEMPLATE" '`mansu-ship-release` -> `mansu-6ship` numbered route; backing implementation `mansu-ship`' 'AGENTS template missing ship backing route'
require_contains "$AGENTS_TEMPLATE" 'source skill selection -> `mansu-operating-model/references/SOURCE_SKILL_CATALOG.md`' 'AGENTS template missing source catalog pointer'
require_contains "$AGENTS_TEMPLATE" 'document/artifact order -> `mansu-operating-model/references/DOCUMENT_CREATION_ORDER.md`' 'AGENTS template missing document order pointer'
require_contains "$AGENTS_TEMPLATE" 'project-local commands, paths, validation, dangerous surfaces -> `CODING_RULES.md`' 'AGENTS template missing coding rules pointer'

# Source skill catalog essentials
require_contains "$SOURCE_CATALOG" '^# Mansu Source Skill Catalog$' 'source catalog missing canonical title'
require_contains "$SOURCE_CATALOG" '^## Layer Model$' 'source catalog missing Layer Model section'
require_contains "$SOURCE_CATALOG" '^## Freshness Policy$' 'source catalog missing Freshness Policy section'
require_contains "$SOURCE_CATALOG" 'SOURCE_SKILL_LOCK.json' 'source catalog missing source lock reference'
require_contains "$SOURCE_CATALOG" 'mansu-setup source-check' 'source catalog lost read-only source-check default'
require_contains "$SOURCE_CATALOG" 'Use `Check -> Decide -> Mutate`' 'source catalog lost check-decide-mutate ladder'
require_contains "$SOURCE_CATALOG" 'does not install, update, sync, or edit files' 'source catalog lost source-check read-only guarantee'
require_contains "$SOURCE_CATALOG" 'Mutate only after explicit approval' 'source catalog lost explicit approval before mutation'
require_contains "$SOURCE_CATALOG" 'Lifecycle phase spine' 'source catalog lost lifecycle phase spine layer'
require_contains "$SOURCE_CATALOG" 'Project definition / memory source' 'source catalog lost project definition and memory layer'
require_contains "$SOURCE_CATALOG" 'Design reference source' 'source catalog lost design reference source layer'
require_contains "$SOURCE_CATALOG" 'Design workflow source' 'source catalog lost design workflow source layer'
require_contains "$SOURCE_CATALOG" 'Implementation actor' 'source catalog lost implementation actor layer'
require_contains "$SOURCE_CATALOG" 'Representative mapping' 'source catalog lost representative source mapping'
require_contains "$SOURCE_CATALOG" '^## Source Philosophy Checksums$' 'source catalog missing source philosophy checksums'
require_contains "$SOURCE_CATALOG" '^## Ouroboros Capability Map$' 'source catalog missing Ouroboros map'
require_contains "$SOURCE_CATALOG" '^## gstack Capability Map$' 'source catalog missing gstack map'
require_contains "$SOURCE_CATALOG" '^## VoltAgent/awesome-design-md Capability Map$' 'source catalog missing awesome-design-md map'
require_contains "$SOURCE_CATALOG" '^## Open Design Capability Map$' 'source catalog missing Open Design map'
require_contains "$SOURCE_CATALOG" '^## Oh My / OMO / OMC Capability Map$' 'source catalog missing Oh My map'
require_contains "$SOURCE_CATALOG" '^## addyosmani/agent-skills Capability Map$' 'source catalog missing addyosmani map'
require_contains "$SOURCE_CATALOG" '^## Mansu Composition Recipes$' 'source catalog missing composition recipes'
require_contains "$SOURCE_CATALOG" '^### New Project / Zero-To-PLAN$' 'source catalog missing zero-to-PLAN recipe'
require_contains "$SOURCE_CATALOG" '^### Source Refresh And Reference Curation$' 'source catalog missing source refresh recipe'
require_contains "$SOURCE_CATALOG" 'Use public routes `mansu-1define` and then `mansu-2plan`' 'source catalog lost numbered define/plan public route guidance'
require_contains "$SOURCE_CATALOG" 'Hand off to public route `mansu-3build`' 'source catalog lost numbered build public route guidance'
require_contains "$SOURCE_CATALOG" 'Use public route `mansu-4verify`' 'source catalog lost numbered verify public route guidance'
require_contains "$SOURCE_CATALOG" 'Use public route `mansu-6ship`' 'source catalog lost numbered ship public route guidance'
forbid_unnumbered_public_lifecycle_route "$SOURCE_CATALOG"
forbid_project_start_primary_route "$SOURCE_CATALOG"
forbid_project_start_primary_route "$ROOT_DIR/PLAN.md"
require_contains "$SOURCE_CATALOG" 'mansu-source-curator' 'source catalog lost curator route'
require_contains "$SOURCE_CATALOG" 'mansu-project-start' 'source catalog lost project start route'
require_contains "$SOURCE_CATALOG" 'mansu-ship-release' 'source catalog lost ship release route'
require_contains "$SOURCE_CATALOG" 'Zero-to-PLAN minimum gate: purpose, user/problem' 'source catalog lost Zero-to-PLAN gate'
require_contains "$SOURCE_CATALOG" 'evidence, assumptions, feature priority, direction, order, and execution' 'source catalog lost Zero-to-PLAN gate fields'
require_contains "$SOURCE_CATALOG" 'Expand only when risk or ambiguity asks for it' 'source catalog lost flexible expansion rule'
require_contains "$SOURCE_CATALOG" 'GitHub, Reddit, and Threads' 'source catalog lost community/source research route'
require_contains "$SOURCE_CATALOG" 'official/current docs' 'source catalog lost evidence-ranked official-source rule'
require_contains "$SOURCE_CATALOG" 'source files first for technical truth' 'source catalog lost evidence-ranked source-file rule'
require_contains "$SOURCE_CATALOG" 'gate mapping' 'source catalog lost gate mapping handoff'
require_contains "$SOURCE_CATALOG" 'scripts/validate_mansu_skills\.sh' 'source catalog lost suite validation route'
require_contains "$SOURCE_CATALOG" 'gstack-design-shotgun' 'source catalog lost design-shotgun route'
require_contains "$SOURCE_CATALOG" 'source/tool readiness is unclear' 'source catalog lost design readiness check'
require_contains "$SOURCE_CATALOG" 'reference/taste research' 'source catalog lost design research gate'
require_contains "$SOURCE_CATALOG" 'source-driven-development` before artifact' 'source catalog lost design source-driven handoff'
require_contains "$SOURCE_CATALOG" 'frontend-ui-engineering` and `planning-and-task-breakdown' 'source catalog lost design implementation handoff'
require_contains "$SOURCE_CATALOG" 'VoltAgent/awesome-design-md' 'source catalog lost design reference family'
require_contains "$SOURCE_CATALOG" 'Open Design' 'source catalog lost Open Design family'
require_contains "$SOURCE_CATALOG" 'callable design-artifact source route' 'source catalog lost Open Design callable route rule'
require_contains "$SOURCE_CATALOG" 'Mansu runs the needed CLI commands' 'source catalog lost Mansu-runs-CLI rule'
require_contains "$SOURCE_CATALOG" 'artifact-first rendering' 'source catalog lost Open Design artifact-first route'
require_contains "$SOURCE_CATALOG" 'anti-AI-slop' 'source catalog lost Open Design anti-AI-slop route'
require_contains "$SOURCE_CATALOG" 'user-facing UI must pass through a design route' 'source catalog lost design route gate'
require_contains "$SOURCE_CATALOG" 'Mansu should not substitute its own' 'source catalog lost no-Mansu-design-questionnaire rule'
require_contains "$SOURCE_CATALOG" 'Default design route stack' 'source catalog lost design route order'
require_contains "$SOURCE_CATALOG" 'gstack-design-consultation` as the default design-system route' 'source catalog lost greenfield design consultation default'
require_contains "$SOURCE_CATALOG" 'design intent seed/handoff' 'source catalog lost Define-to-Plan design handoff boundary'
require_contains "$SOURCE_CATALOG" 'mansu-2plan` consumes that' 'source catalog lost Plan consumes design handoff rule'
require_contains "$SOURCE_CATALOG" 'owns `DESIGN\.md` creation/refinement, design artifacts, design' 'source catalog lost Plan-owned DESIGN.md boundary'
require_contains "$SOURCE_CATALOG" 'source capability, not a move' 'source catalog lost source capability vs Mansu phase ownership boundary'
require_contains "$SOURCE_CATALOG" 'Oh My / OMO `research` or `deepsearch` before or' 'source catalog lost conditional design research route'
require_contains "$SOURCE_CATALOG" 'Use addyosmani `source-driven-development` when source projects' 'source catalog lost source-driven design route'
require_contains "$SOURCE_CATALOG" 'Use `gstack-design-shotgun` when multiple visible candidate directions' 'source catalog lost design shotgun route'
require_contains "$SOURCE_CATALOG" 'Use `gstack-plan-design-review` to critique the chosen direction' 'source catalog lost plan design review route'
require_contains "$SOURCE_CATALOG" 'Recommended combinations:' 'source catalog lost design route combinations'
require_contains "$SOURCE_CATALOG" 'Greenfield app with no design system' 'source catalog lost greenfield design combo'
require_contains "$SOURCE_CATALOG" 'Ambiguous market/taste' 'source catalog lost ambiguous design combo'
require_contains "$SOURCE_CATALOG" 'Need visible options before choosing' 'source catalog lost shotgun design combo'
require_contains "$SOURCE_CATALOG" '`DESIGN\.md` format' 'source catalog lost DESIGN.md format route'
require_contains "$SOURCE_CATALOG" 'Visual Theme & Atmosphere' 'source catalog lost visual theme route'
require_contains "$SOURCE_CATALOG" 'Color Palette & Roles' 'source catalog lost color palette route'
require_contains "$SOURCE_CATALOG" 'Typography Rules' 'source catalog lost typography route'
require_contains "$SOURCE_CATALOG" 'Component Stylings' 'source catalog lost component styling route'
require_contains "$SOURCE_CATALOG" 'Responsive Behavior' 'source catalog lost responsive behavior route'
require_contains "$SOURCE_CATALOG" 'Agent Prompt Guide' 'source catalog lost agent prompt guide route'
require_contains "$SOURCE_CATALOG" 'Ouroboros project-definition, Seed, Ledger' 'source catalog lost Ouroboros freshness check'
require_contains "$SOURCE_CATALOG" 'Mansu-setup prepares the host before public `mansu-1define` uses Ouroboros' 'source catalog lost Ouroboros setup route'
require_contains "$SOURCE_CATALOG" 'mcp__ouroboros\.ouroboros_interview' 'source catalog lost Codex Ouroboros MCP route'
require_contains "$SOURCE_CATALOG" 'ouroboros setup --runtime codex --mcp-mode auto --non-interactive' 'source catalog lost Codex Ouroboros setup route'
require_contains "$SOURCE_CATALOG" 'Brownfield scan' 'source catalog lost Ouroboros brownfield route'
require_contains "$SOURCE_CATALOG" 'PM / PRD definition' 'source catalog lost Ouroboros PM route'
require_contains "$SOURCE_CATALOG" 'Execution from Seed' 'source catalog lost Ouroboros run route'
require_contains "$SOURCE_CATALOG" 'Autonomous continuation' 'source catalog lost Ouroboros autonomous route'
require_contains "$SOURCE_CATALOG" 'gstack repo or `gstack-\*` skill set changed' 'source catalog lost gstack freshness check'
require_contains "$SOURCE_CATALOG" 'Oh My / OMO / OMC adapter or source skill set changed' 'source catalog lost Oh My freshness check'
require_contains "$SOURCE_CATALOG" 'LazyCodex' 'source catalog lost LazyCodex Codex route'
require_contains "$SOURCE_CATALOG" 'oh-my-openagent is the core harness source' 'source catalog lost OmO upstream source wording'
require_contains "$SOURCE_CATALOG" 'thin distribution' 'source catalog lost LazyCodex distribution boundary'
require_contains "$SOURCE_CATALOG" 'Codex-side OMO route' 'source catalog lost LazyCodex Codex-side OMO scope'
require_contains "$SOURCE_CATALOG" 'do not treat LazyCodex as a Mansu source skill family' 'source catalog lost LazyCodex source-family boundary'
require_contains "$SOURCE_CATALOG" 'Mansu does not use OMO `ulw-plan` as a default Plan route' 'source catalog lost ulw-plan default-route prohibition'
require_contains "$SOURCE_CATALOG" 'only when the user explicitly invokes' 'source catalog lost ulw-plan explicit invocation whitelist'
require_contains "$SOURCE_CATALOG" 'legacy `omx` is compatibility tooling' 'source catalog lost omx compatibility route'
require_contains "$SOURCE_CATALOG" 'carries Codex-side Oh My execution patterns' 'source catalog lost LazyCodex execution role'
require_contains "$SOURCE_CATALOG" 'Mansu owns routing' 'source catalog lost Mansu role split'
require_contains "$SOURCE_CATALOG" 'gstack provides independent' 'source catalog lost gstack validation role'
require_contains "$SOURCE_CATALOG" 'Ouroboros execution opt-in' 'source catalog lost Ouroboros execution guardrail'
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
require_contains "$DOC_ORDER" 'Feature priority is decided before `PLAN.md`' 'document creation router lost feature priority before PLAN boundary'
require_contains "$DOC_ORDER" 'Feature Priority / MVP Cut -> Project Phase Roadmap -> Phase Plan -> Slice' 'document creation router lost official planning hierarchy'
require_contains "$DOC_ORDER" 'Project Phase Roadmap lives in' 'document creation router lost Project Phase Roadmap ownership'
require_contains "$DOC_ORDER" 'Phase Plan lives in `PLAN\.md`' 'document creation router lost Phase Plan ownership'
require_contains "$DOC_ORDER" 'A Slice lives as a row or task inside that active Phase Plan' 'document creation router lost Slice ownership'
require_contains "$DOC_ORDER" 'prioritized feature list, ordered phase list, and exactly one' 'document creation router lost feature priority roadmap gate'
require_contains "$DOC_ORDER" 'Use the project roadmap or TDR for the whole feature sequence' 'document creation router lost roadmap vs PLAN boundary'
require_contains "$DOC_ORDER" 'artifact names the prioritized feature list' 'document creation router lost phase roadmap gate'
require_contains "$DOC_ORDER" 'active phase, do not enter numbered public `mansu-3build`' 'document creation router lost numbered build block after roadmap gate'
require_contains "$DOC_ORDER" 'Before numbered public `mansu-3build` starts through the backing' 'document creation router lost numbered build phase preflight'
require_contains "$DOC_ORDER" 'gstack-office-hours' 'document creation router lost office-hours source'
require_contains "$DOC_ORDER" 'spec-driven-development' 'document creation router lost spec-driven source'
require_contains "$DOC_ORDER" 'planning-and-task-breakdown' 'document creation router lost planning source'
require_contains "$DOC_ORDER" 'documentation-and-adrs' 'document creation router lost ADR source'
require_contains "$DOC_ORDER" 'gstack-autoplan' 'document creation router lost autoplan verification'
require_contains "$DOC_ORDER" 'gstack-plan-eng-review' 'document creation router lost eng verification'
require_contains "$DOC_ORDER" 'mansu-tdd-total' 'document creation router lost PLAN handoff'
require_contains "$DOC_ORDER" 'VoltAgent/awesome-design-md' 'document creation router lost design reference source'
require_contains "$DOC_ORDER" 'Open Design is a callable design-artifact source route' 'document creation router lost Open Design route'
require_contains "$DOC_ORDER" 'Mansu runs the needed CLI' 'document creation router lost Mansu runs CLI rule'
require_contains "$DOC_ORDER" 'reference-only source' 'document creation router lost design reference-only guardrail'
require_contains "$DOC_ORDER" 'Prefer Open Design when installed/approved' 'document creation router lost Open Design preference'
require_contains "$DOC_ORDER" 'Reference with VoltAgent/awesome-design-md; create/refine with' 'document creation router should distinguish design reference from producer skills'
require_contains "$DOC_ORDER" 'Design brief / visual research note' 'document creation router lost visual research note'
require_contains "$DOC_ORDER" 'selected direction, rejected directions' 'document creation router lost design direction handoff'
require_contains "$DOC_ORDER" 'Open Design artifact / preview / export' 'document creation router lost Open Design artifact handoff'
require_contains "$DOC_ORDER" 'Visual atmosphere, color roles, typography, component rules' 'document creation router lost DESIGN.md exit criteria'
require_contains "$DOC_ORDER" 'choose the design source route before phase roadmap planning' 'document creation router lost design route before roadmap rule'
require_contains "$DOC_ORDER" 'design intent seed/handoff' 'document creation router lost Define design seed handoff'
require_contains "$DOC_ORDER" '`mansu-2plan` creates/refines `DESIGN\.md`' 'document creation router lost Plan-owned DESIGN.md creation rule'
require_contains "$DOC_ORDER" 'gstack-design-consultation` may create or contribute to `DESIGN\.md`' 'document creation router lost gstack source capability wording'
require_contains "$DOC_ORDER" 'Mansu-owned design questionnaire' 'document creation router lost design-route-not-questionnaire guardrail'
require_contains "$DOC_ORDER" 'modern/minimal' 'document creation router lost weak DESIGN.md red flag'
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
require_contains "$CODE_ORDER" 'Define -> Plan -> Build -> Verify -> Review -> Ship' 'code construction router lost addyosmani phase spine'
require_contains "$CODE_ORDER" '`mansu-debug` is a public special-purpose interrupt route' 'code construction router lost debug interrupt route'
require_contains "$CODE_ORDER" '기획 -> 요구사항 정리 -> 스펙 작성 -> 구현 계획 -> 코딩 -> 테스트 -> QA -> 수정/개선 -> 배포/공유' 'code construction router lost Korean detailed flow'
require_contains "$CODE_ORDER" 'These are not competing sequences' 'code construction router should distinguish spine vs detailed flow'
require_contains "$CODE_ORDER" 'when Verify passes, continue into Review by default' 'code construction router lost verify-to-review default handoff'
require_contains "$CODE_ORDER" 'Review handoff' 'code construction router lost verify review handoff output'
require_contains "$CODE_ORDER" '수정/개선.*Review -> Build -> Verify' 'code construction router lost review/build/verify loop mapping'
require_contains "$CODE_ORDER" '^## Phase Detection$' 'code construction router missing phase detection'
require_contains "$CODE_ORDER" 'Feature Priority / MVP Cut -> Project Phase Roadmap -> Phase Plan -> Slice' 'code construction router lost official planning hierarchy'
require_contains "$CODE_ORDER" 'Build reads the Project Phase Roadmap first' 'code construction router lost roadmap-before-phase-plan rule'
require_contains "$CODE_ORDER" 'active Phase Plan.*ordered Slice table' 'code construction router lost active phase plan slice rule'
forbid_default_ulw_plan_route "$CODE_ORDER" 'code construction router reintroduced ulw-plan as a default Plan route'
forbid_contains "$CODE_ORDER" 'Complex implementation:.*ulw-plan' 'code construction router reintroduced ulw-plan into complex implementation route'
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
