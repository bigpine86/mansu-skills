#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

DEFINE="$ROOT_DIR/mansu-define/SKILL.md"
PLAN="$ROOT_DIR/mansu-plan/SKILL.md"
PLAN_OPENAI="$ROOT_DIR/mansu-plan/agents/openai.yaml"
BUILD="$ROOT_DIR/mansu-build/SKILL.md"
VERIFY="$ROOT_DIR/mansu-verify/SKILL.md"
REVIEW="$ROOT_DIR/mansu-review/SKILL.md"
DEBUG="$ROOT_DIR/mansu-debug/SKILL.md"
SHIP="$ROOT_DIR/mansu-ship/SKILL.md"
DEFINE_PUBLIC="$ROOT_DIR/mansu-1define/SKILL.md"
PLAN_PUBLIC="$ROOT_DIR/mansu-2plan/SKILL.md"
BUILD_PUBLIC="$ROOT_DIR/mansu-3build/SKILL.md"
VERIFY_PUBLIC="$ROOT_DIR/mansu-4verify/SKILL.md"
REVIEW_PUBLIC="$ROOT_DIR/mansu-5review/SKILL.md"
SHIP_PUBLIC="$ROOT_DIR/mansu-6ship/SKILL.md"
BUILD_OPENAI="$ROOT_DIR/mansu-build/agents/openai.yaml"
BUILD_PUBLIC_OPENAI="$ROOT_DIR/mansu-3build/agents/openai.yaml"
VERIFY_OPENAI="$ROOT_DIR/mansu-verify/agents/openai.yaml"
REVIEW_OPENAI="$ROOT_DIR/mansu-review/agents/openai.yaml"
DEBUG_OPENAI="$ROOT_DIR/mansu-debug/agents/openai.yaml"
SHIP_OPENAI="$ROOT_DIR/mansu-ship/agents/openai.yaml"
README="$ROOT_DIR/README.md"
README_KO="$ROOT_DIR/README.ko.md"
HELP="$ROOT_DIR/mansu-help/SKILL.md"
MANUAL="$ROOT_DIR/docs/mansu-manual.html"
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

forbid_default_ulw_plan_route() {
  local file="$1"
  local message="$2"
  if perl -0ne '
    my $text = $_;
    $text =~ s/Heavy Plan(?:(?!\n\n).)*?\bnever\s+defaults\s+to\s+`ulw-plan`\.?//sig;
    exit($text =~ /(?:Mansu\s+Plan|Quick\s+Plan|Standard\s+Plan|Heavy\s+Plan|Plan)[^\n.]{0,200}(?:default[^\n.]{0,80}`ulw-plan`|`ulw-plan`[^\n.]{0,80}default)/i ? 0 : 1);
  ' "$file"; then
    fail "$message"
  fi

  if perl -ne '
    BEGIN { $bad = 0; }
    if (/`?ulw-plan`?/i
      && !/only when the user literally invokes/i
      && !/external planning artifact/i
      && !/explicit OMO planning/i
      && !/explicit request for OMO/i
      && !/allowed only for literal user invocation/i
      && !/never\s+defaults\s+to\s+`?ulw-plan`?/i
      && !/do not trigger OMO\s+`?ulw-plan`?/i
      && !/not public doctrine/i) {
      $bad = 1;
    }
    END { exit($bad ? 0 : 1); }
  ' "$file"; then
    fail "$message"
  fi
}

require_ordered_terms() {
  local file="$1"
  local message="$2"
  shift 2
  perl -0ne '
    BEGIN {
      our @terms = @ARGV;
      @ARGV = ();
    }
    my $pos = 0;
    for my $term (@terms) {
      my $idx = index(lc($_), lc($term), $pos);
      exit 1 if $idx < 0;
      $pos = $idx + length($term);
    }
  ' "$@" < "$file" || fail "$message"
}

scenario() {
  printf 'SCENARIO: %s\n' "$1"
}

scenario "Given a new idea, When Mansu defines it, Then source-skill interview happens before planning and no implementation starts"
require_contains "$DEFINE" 'Use addyosmani `interview-me`' 'define must name addyosmani interview route'
require_contains "$DEFINE" 'Use Ouroboros `interview`, `pm`, `seed`, and `brownfield`' 'define must name Ouroboros definition route'
require_contains "$DEFINE" '^## Mandatory Ouroboros definition rule$' 'define must make Ouroboros the default definition route'
require_contains "$DEFINE" 'User-provided idea notes do not satisfy the interview gate' 'define must not treat short user notes as completed definition'
require_contains "$DEFINE" 'treat that text as seed context for' 'define must treat short user notes as interview context'
require_contains "$DEFINE" 'Ouroboros `interview`; do not mark Define complete' 'define must pass short user notes into Ouroboros interview'
require_contains "$DEFINE" 'the interview with Mansu-owned questions' 'define must not skip Ouroboros because a short brief exists'
require_contains "$DEFINE" 'route to `mansu-9setup` in `install` mode' 'define must route missing Ouroboros to setup install mode'
require_contains "$DEFINE" '`mansu-9setup` in `update` mode' 'define must route stale/broken Ouroboros to setup update mode'
require_contains "$DEFINE" 'Do not silently replace Ouroboros interview with Mansu-owned questions' 'define must not silently fallback from Ouroboros'
require_contains "$DEFINE" 'Skipping the Ouroboros interview is allowed only when current, repo-visible' 'define must only skip Ouroboros with current artifact evidence'
require_contains "$DEFINE" 'definition artifacts already exist' 'define must cite existing definition artifacts before skipping Ouroboros'
require_contains "$DEFINE" 'Do not start implementation' 'define must block implementation'
require_contains "$DEFINE_PUBLIC" 'Next route when complete: `mansu-2plan`' 'public define must hand off to numbered plan route'
require_contains "$DEFINE_PUBLIC" 'Compatibility implementation: `mansu-define`' 'numbered define route must label unnumbered define as compatibility implementation'

scenario "Given Ouroboros finds user-facing product scope, Then Define routes design context before Plan without owning DESIGN.md"
require_contains "$DEFINE" '^## Post-Ouroboros design-context gate$' 'define must have a post-Ouroboros design-context gate'
require_contains "$DEFINE" 'user-facing UI/product scope is present' 'define must detect user-facing UI/product scope after Ouroboros'
require_contains "$DEFINE" 'design-context interview before public `mansu-2plan`' 'define must route design context before numbered plan'
require_contains "$DEFINE" 'default installed' 'define must identify the default installed design-context route'
require_contains "$DEFINE" 'gstack-design-consultation' 'define must name gstack-design-consultation'
require_contains "$DEFINE" 'gstack-design-shotgun' 'define must keep design-shotgun route'
require_contains "$DEFINE" 'Open Design' 'define must keep Open Design route'
require_contains "$DEFINE" 'gstack-plan-design-review' 'define must keep design review route'
require_contains "$DEFINE" 'critique' 'define must name critique purpose'
require_contains "$DEFINE" 'design intent seed' 'define must record design intent seed'
require_contains "$DEFINE" 'route evidence' 'define must record route evidence'
require_contains "$DEFINE" 'DESIGN.md.*mansu-2plan' 'define must keep DESIGN.md owned by plan'
require_contains "$DEFINE" 'not create.*DESIGN.md' 'define must not create DESIGN.md'
require_contains "$DEFINE" 'Do not create a Mansu-owned design questionnaire' 'define must not replace source design interview with Mansu questionnaire'
require_contains "$DEFINE" 'source-skill design-context interview route' 'define must use a source-skill design-context interview'
require_contains "$DEFINE" 'intent seed/handoff evidence' 'define must hand off design intent without owning artifacts'
require_contains "$DEFINE" 'Ouroboros' 'define source route must preserve Ouroboros ordering'
require_contains "$DEFINE" 'design-context route evidence' 'define outputs must include design-context route evidence'
require_contains "$ROOT_DIR/mansu-define/agents/openai.yaml" 'source-skill design-context interview' 'define OpenAI prompt must route design context through source skill'
require_contains "$ROOT_DIR/mansu-define/agents/openai.yaml" 'public mansu-2plan' 'define OpenAI prompt must route before numbered plan'
require_contains "$ROOT_DIR/mansu-define/agents/openai.yaml" 'gstack-design-consultation' 'define OpenAI prompt must name default installed design route'
require_contains "$ROOT_DIR/mansu-define/agents/openai.yaml" 'design intent seed' 'define OpenAI prompt must record design seed'
require_contains "$ROOT_DIR/mansu-define/agents/openai.yaml" 'route evidence' 'define OpenAI prompt must record route evidence'
require_contains "$ROOT_DIR/mansu-define/agents/openai.yaml" 'DESIGN.md.*mansu-2plan' 'define OpenAI prompt must keep DESIGN.md in plan'
require_contains "$ROOT_DIR/mansu-define/agents/openai.yaml" 'Mansu-owned design questionnaire' 'define OpenAI prompt must ban Mansu-owned design questionnaire'
require_contains "$ROOT_DIR/mansu-1define/agents/openai.yaml" 'source-skill design-context interview' 'public define OpenAI prompt must route design context through source skill'
require_contains "$ROOT_DIR/mansu-1define/agents/openai.yaml" 'mansu-2plan' 'public define OpenAI prompt must route before numbered plan'
require_contains "$ROOT_DIR/mansu-1define/agents/openai.yaml" 'gstack-design-consultation' 'public define OpenAI prompt must name default installed design route'
require_contains "$ROOT_DIR/mansu-1define/agents/openai.yaml" 'design intent seed' 'public define OpenAI prompt must record design seed'
require_contains "$ROOT_DIR/mansu-1define/agents/openai.yaml" 'handoff evidence' 'public define OpenAI prompt must record handoff evidence'
require_contains "$ROOT_DIR/mansu-1define/agents/openai.yaml" 'DESIGN.md.*mansu-2plan' 'public define OpenAI prompt must keep DESIGN.md in plan'
require_contains "$ROOT_DIR/mansu-1define/agents/openai.yaml" 'Mansu-owned design questionnaire' 'public define OpenAI prompt must ban Mansu-owned design questionnaire'

scenario "Given definition outputs exist, When Mansu plans, Then design direction and current phase execution plan are required before Build"
require_ordered_terms "$PLAN" 'plan must preserve official planning hierarchy' 'Feature Priority / MVP Cut' 'Project Phase Roadmap' 'Phase Plan' 'Slice'
require_absent "$ROOT_DIR/PLAN.md" 'Requirements/Spec -> Architecture -> Design Direction -> Implementation Roadmap' 'PLAN.md reintroduced old Plan order'
forbid_default_ulw_plan_route "$ROOT_DIR/PLAN.md" 'PLAN.md must not make ulw-plan a default Plan route'
require_contains "$PLAN" 'Quick Plan' 'plan must define Quick Plan tier'
require_contains "$PLAN" 'Standard Plan' 'plan must define Standard Plan tier'
require_contains "$PLAN" 'Heavy Plan' 'plan must define Heavy Plan tier'
require_contains "$PLAN_OPENAI" 'Quick Plan' 'plan OpenAI prompt must define Quick Plan tier'
require_contains "$PLAN_OPENAI" 'Standard Plan' 'plan OpenAI prompt must define Standard Plan tier'
require_contains "$PLAN_OPENAI" 'Heavy Plan' 'plan OpenAI prompt must define Heavy Plan tier'
forbid_default_ulw_plan_route "$PLAN" 'plan must not make ulw-plan a default Plan route'
forbid_default_ulw_plan_route "$PLAN_OPENAI" 'plan OpenAI prompt must not make ulw-plan a default Plan route'
require_contains "$PLAN" 'feature inventory, priority rationale, MVP/later split' 'plan must require feature priority evidence'
require_contains "$PLAN" 'environment/dependency setup plan when needed' 'plan must include conditional environment setup planning'
require_contains "$PLAN" 'Prefer `uv` for Python' 'plan must prefer uv for new Python setup when appropriate'
require_contains "$PLAN" 'Do not add a new `uv` environment just because planning is happening' 'plan must not force uv onto existing projects'
require_contains "$PLAN" 'design direction or explicit no-design-needed reason' 'plan must require design decision or explicit no-design reason'
require_contains "$PLAN" 'current phase execution plan' 'plan must produce current phase execution plan'
require_contains "$PLAN" '\.omo/plans/\*\.md' 'plan must support OMO plan paths'
require_contains "$PLAN" 'Do not skip directly to Build' 'plan must block direct build without valid current phase plan'
require_contains "$PLAN_PUBLIC" 'Next route when complete: `mansu-3build`' 'public plan must end by routing to numbered build route'
require_contains "$PLAN_PUBLIC" 'Compatibility implementation: `mansu-plan`' 'public plan must label unnumbered plan as compatibility implementation'

scenario "Given Build is invoked without a current phase plan, Then Mansu blocks implementation and routes back to Define/Plan"
require_contains "$BUILD" 'current phase execution plan exists' 'build must require active phase execution plan'
require_contains "$BUILD" 'Project Phase Roadmap -> Phase Plan -> Slice' 'build must name roadmap-to-phase-to-slice hierarchy'
require_contains "$BUILD" 'active Phase Plan is a role, not a literal filename' 'build must not treat PLAN.md as the only plan filename'
require_contains "$BUILD" 'user-provided path first' 'build must prefer user-provided plan paths'
require_contains "$BUILD" 'role/marker discovery' 'build must use role/marker discovery for phase plans'
require_contains "$BUILD" '\.omo/plans/\*\.md' 'build must search OMO plan paths'
require_contains "$BUILD" 'read the active Phase Plan and its linked' 'build must read linked artifacts before non-trivial work'
require_contains "$BUILD" 'Project Phase Roadmap before any linked spec, TDR, or design direction' 'build must read roadmap before spec/TDR/design artifacts'
require_contains "$BUILD" 'update the active Phase Plan before editing' 'build must update stale active plan before coding'
require_contains "$BUILD" 'Do not say "no plan" until these candidates have' 'build must check plan candidates before claiming no plan'
require_contains "$BUILD" 'been checked' 'build must finish the no-plan candidate check instruction'
require_contains "$BUILD" 'route back to' 'build must route missing plan backward'
require_contains "$BUILD_PUBLIC" 'route back to `mansu-1define` /' 'public build must route missing plan back to numbered define route'
require_contains "$BUILD_PUBLIC" '`mansu-2plan`' 'public build must route missing plan back to numbered plan route'
require_contains "$BUILD_PUBLIC" 'Compatibility implementation: `mansu-build`' 'public build must label unnumbered build as compatibility implementation'
require_contains "$BUILD" 'do not reject a valid active Phase Plan only' 'build must not reject valid phase plan filename'
require_contains "$BUILD" 'filename is not `PLAN\.md`' 'build must name non-PLAN filename case'
require_ordered_terms "$BUILD" 'build must reject roadmap-only implementation' 'do not implement' 'project phase roadmap' 'alone'
require_contains "$BUILD" 'execution-ready slice table' 'build must require a slice table before implementation'
require_contains "$BUILD" 'If implementation for the active phase is complete, tell the user the next' 'build must route complete implementation to verify'
require_contains "$BUILD_OPENAI" 'active Phase Plan exists' 'build OpenAI prompt must require active phase plan'
require_contains "$BUILD_OPENAI" 'Project Phase Roadmap -> Phase Plan -> Slice' 'build OpenAI prompt must name roadmap-to-slice hierarchy'
require_contains "$BUILD_OPENAI" 'role/marker discovery' 'build OpenAI prompt must use role/marker discovery'
require_contains "$BUILD_OPENAI" '\.omo/plans/\*\.md' 'build OpenAI prompt must search OMO plan paths'
require_ordered_terms "$BUILD_OPENAI" 'build OpenAI prompt must not reject plan by filename' 'filename' 'differs'
require_ordered_terms "$BUILD_OPENAI" 'build OpenAI prompt must read active phase plan before linked roadmap artifacts' 'non-trivial implementation' 'active phase plan' 'linked project phase roadmap'
require_ordered_terms "$BUILD_OPENAI" 'backing build OpenAI prompt must route missing plan to numbered public routes' 'missing' 'route back' 'mansu-1define' 'mansu-2plan'
require_ordered_terms "$BUILD_OPENAI" 'build OpenAI prompt must reject roadmap-only implementation' 'do not implement' 'project phase roadmap' 'alone'
require_ordered_terms "$BUILD_PUBLIC_OPENAI" 'public build OpenAI prompt must name roadmap-to-active-phase-to-slice hierarchy' 'project phase roadmap' 'active phase plan' 'slice table'
require_ordered_terms "$BUILD_PUBLIC_OPENAI" 'public build OpenAI prompt must read linked roadmap first' 'read' 'linked project phase roadmap' 'first'
require_contains "$BUILD_PUBLIC_OPENAI" 'user-provided path first' 'public build OpenAI prompt must prefer user-provided plan paths'
require_contains "$BUILD_PUBLIC_OPENAI" 'role/marker discovery' 'public build OpenAI prompt must use role/marker discovery'
require_contains "$BUILD_PUBLIC_OPENAI" 'Plan\.md' 'public build OpenAI prompt must include Plan.md candidate'
require_contains "$BUILD_PUBLIC_OPENAI" '\.codex/plans/\*\.md' 'public build OpenAI prompt must include Codex plan path candidates'
require_contains "$BUILD_PUBLIC_OPENAI" '\.omo/plans/\*\.md' 'public build OpenAI prompt must search OMO plan paths'
require_ordered_terms "$BUILD_PUBLIC_OPENAI" 'public build OpenAI prompt must execute only active phase plan slices' 'only' 'active phase plan' 'slice table'
require_ordered_terms "$BUILD_PUBLIC_OPENAI" 'public build OpenAI prompt must reject roadmap-only implementation' 'do not implement' 'project phase roadmap' 'alone'

scenario "Given verification and review are separate gates, Then Verify proves behavior and Review judges quality"
require_contains "$VERIFY" 'Verify proves behavior' 'verify must state behavior proof role'
require_contains "$VERIFY" 'QA evidence' 'verify must require QA evidence'
require_contains "$VERIFY" 'Use BDD-style evidence' 'verify must use BDD-style evidence for workflow-shaped behavior'
require_contains "$VERIFY" 'Given/When/Then' 'verify must name Given/When/Then proof shape'
require_contains "$VERIFY" 'observable pass/fail result' 'verify must require observable pass/fail result'
require_contains "$VERIFY" 'Use `mansu-web-verify` as the compatibility route' 'verify must preserve web-verify compatibility route'
require_absent "$VERIFY" 'public `mansu-5review`, or public[[:space:]]+`mansu-6ship`' 'verify outputs must not route directly to ship before review evidence exists'
require_contains "$VERIFY_PUBLIC" 'Next route when verification passes: `mansu-5review`' 'public verify must hand off to numbered review after passing verification'
require_contains "$VERIFY_PUBLIC" 'Compatibility implementation: `mansu-verify`' 'public verify must label unnumbered verify as compatibility implementation'
require_contains "$REVIEW" 'Review judges quality' 'review must state quality judgment role'
require_contains "$REVIEW" 'Review is not QA' 'review must not replace QA'
require_contains "$REVIEW" 'Mansu Review does not invent refactoring judgment by itself' 'review must not invent refactoring judgment'
require_contains "$REVIEW" 'Use gstack `review` as the primary diff/code review route' 'review must route refactoring judgment through gstack review'
require_contains "$REVIEW" 'source-skill refactoring/simplification findings' 'review must record source-skill refactoring findings'
require_contains "$REVIEW" 'over-complex code, dead code, and AI-slop' 'review must name concrete refactoring signals'
require_contains "$REVIEW" 'required fixes or route to `mansu-debug`' 'review must route unknown issues to debug'
require_contains "$REVIEW" 'If Review passes and Verify evidence exists, tell the user the next step is' 'review must route passing review to ship'
require_contains "$REVIEW" 'public `mansu-6ship`' 'review must route passing review to numbered public ship route'
require_contains "$REVIEW" '`mansu-3build` and then public `mansu-4verify`' 'review must route clear fixes through numbered public build and verify routes'
require_contains "$VERIFY_OPENAI" 'prove behavior' 'verify OpenAI prompt must preserve behavior proof role'
require_contains "$VERIFY_OPENAI" 'QA evidence' 'verify OpenAI prompt must require QA evidence'
require_contains "$VERIFY_OPENAI" 'continue directly into public mansu-5review by default' 'backing verify OpenAI prompt must continue to numbered public review route'
require_contains "$VERIFY_OPENAI" 'stop before review only when verification fails' 'verify OpenAI prompt must define stop conditions before review'
require_contains "$REVIEW_OPENAI" 'Review is not QA' 'review OpenAI prompt must not replace QA'
require_contains "$REVIEW_OPENAI" 'use source review routes such as gstack review' 'review OpenAI prompt must use source skills for refactoring judgment'
require_contains "$REVIEW_OPENAI" 'route unknown issues to mansu-debug' 'review OpenAI prompt must route unknown issues to debug'
require_contains "$REVIEW_OPENAI" 'public mansu-6ship if review passes' 'review OpenAI prompt must route passing review to numbered public ship route'
require_contains "$REVIEW_OPENAI" 'public mansu-3build then public mansu-4verify' 'review OpenAI prompt must route clear fixes through numbered public build and verify routes'

scenario "Given an unknown failure appears in any phase, Then Debug interrupts and proves root cause before fixing"
require_contains "$DEBUG" 'Debug can interrupt any phase' 'debug must be phase-interrupt route'
require_contains "$DEBUG" 'Do not patch first and explain later' 'debug must block patch-first behavior'
require_contains "$DEBUG" 'Default to `mansu-debug-rootcause`' 'debug must delegate to rootcause route'
require_contains "$DEBUG_OPENAI" 'Do not patch first' 'debug OpenAI prompt must block patch-first behavior'
require_contains "$DEBUG_OPENAI" 'prove root cause' 'debug OpenAI prompt must require root cause proof'

scenario "Given Ship is requested, Then Mansu requires verify and review evidence before ship/hold"
require_contains "$SHIP" 'implementation has been verified and reviewed' 'ship must require verified and reviewed state'
require_contains "$SHIP" 'If verification evidence or review/risk notes are missing' 'ship must explicitly block missing evidence'
require_contains "$SHIP_PUBLIC" 'route back to `mansu-4verify`' 'public ship must route missing verification gate backward to numbered verify'
require_contains "$SHIP_PUBLIC" '`mansu-5review`' 'public ship must route missing review gate backward to numbered review'
require_contains "$SHIP_PUBLIC" 'Compatibility implementation: `mansu-ship`' 'public ship must label unnumbered ship as compatibility implementation'
require_contains "$SHIP" 'ship/hold decision' 'ship must keep ship/hold output'
require_contains "$SHIP_OPENAI" 'verification evidence' 'ship OpenAI prompt must require verification evidence'
require_contains "$SHIP_OPENAI" 'review/risk notes' 'ship OpenAI prompt must require review/risk notes'
require_contains "$SHIP_OPENAI" 'route back to public mansu-4verify or mansu-5review' 'backing ship OpenAI prompt must route missing gates to numbered public routes'

scenario "Given public lifecycle routes exist, Then templates prefer public routes and keep compatibility aliases secondary"
require_contains "$AGENTS_TEMPLATE" 'new product, app, repo, major feature family.*`mansu-1define`, then `mansu-2plan`' 'AGENTS must prefer numbered define/plan public routes'
require_contains "$AGENTS_TEMPLATE" 'current phase implementation or refactor with slices -> `mansu-3build`' 'AGENTS must prefer numbered build public route'
require_contains "$AGENTS_TEMPLATE" 'behavior proof, test evidence, QA, or browser/runtime verification -> `mansu-4verify`' 'AGENTS must prefer numbered verify public route'
require_contains "$AGENTS_TEMPLATE" 'quality, architecture, design, security, or decision-risk review -> `mansu-5review`' 'AGENTS must prefer numbered review public route'
require_contains "$AGENTS_TEMPLATE" 'release readiness, commit/PR/release notes, ship-or-hold judgment -> `mansu-6ship`' 'AGENTS must prefer numbered ship public route'
require_contains "$AGENTS_TEMPLATE" 'Compatibility aliases and backing routes:' 'AGENTS must record compatibility/backing alias map'
require_contains "$AGENTS_TEMPLATE" 'backing implementation `mansu-define`' 'AGENTS may mention unnumbered define only as backing implementation'
require_contains "$AGENTS_TEMPLATE" 'backing implementation `mansu-build`' 'AGENTS may mention unnumbered build only as backing implementation'
require_contains "$AGENTS_TEMPLATE" 'backing implementation `mansu-verify`' 'AGENTS may mention unnumbered verify only as backing implementation'
require_contains "$AGENTS_TEMPLATE" 'backing implementation `mansu-ship`' 'AGENTS may mention unnumbered ship only as backing implementation'
require_absent "$AGENTS_TEMPLATE" '^- .*-> `mansu-(define|plan|build|verify|review|ship)`' 'AGENTS must not use unnumbered lifecycle skills as first-hop public routes'
require_contains "$DOC_ORDER" 'use `mansu-1define` and then[[:space:]]*$' 'document order must prefer numbered define route'
require_contains "$DOC_ORDER" '`mansu-2plan` as the public orchestrators' 'document order must prefer numbered plan route'
require_contains "$DOC_ORDER" 'then hand off to[[:space:]]*$' 'document order must describe build handoff'
require_contains "$DOC_ORDER" '`mansu-3build`, whose backing implementation `mansu-build`' 'document order must describe numbered build with backing implementation'
require_contains "$SOURCE_COMPOSITION" 'LazyCodex is the Codex-side route for OMO execution patterns' 'composition must keep LazyCodex runtime-only'
require_contains "$SOURCE_COMPOSITION" 'must not appear as a phase source' 'composition must ban LazyCodex as phase source'
require_contains "$SOURCE_COMPOSITION" 'Public lifecycle route names are numbered: `mansu-1define` through[[:space:]]*$' 'composition must state numbered lifecycle routes are public'
require_contains "$SOURCE_COMPOSITION" '`mansu-6ship`\. Unnumbered names such as `mansu-define`, `mansu-plan`' 'composition must treat unnumbered names as implementation names'
require_contains "$SOURCE_COMPOSITION" 'compatibility implementation names only' 'composition must keep unnumbered lifecycle names secondary'
require_contains "$SOURCE_COMPOSITION" '\| `mansu-1define` \|' 'composition must use numbered define phase row'
require_contains "$SOURCE_COMPOSITION" '\| `mansu-2plan` \|' 'composition must use numbered plan phase row'
require_contains "$SOURCE_COMPOSITION" '\| `mansu-3build` \|' 'composition must use numbered build phase row'
require_contains "$SOURCE_COMPOSITION" '\| `mansu-4verify` \|' 'composition must use numbered verify phase row'
require_contains "$SOURCE_COMPOSITION" '\| `mansu-5review` \|' 'composition must use numbered review phase row'
require_contains "$SOURCE_COMPOSITION" '\| `mansu-6ship` \|' 'composition must use numbered ship phase row'
require_contains "$SOURCE_COMPOSITION" 'Backed by `mansu-define`' 'composition may mention unnumbered define only as backing'
require_contains "$SOURCE_COMPOSITION" 'Backed by `mansu-build`' 'composition may mention unnumbered build only as backing'

scenario "Given consolidation rules are public, Then public docs keep numbered lifecycle routes primary and compatibility routes secondary"
for public_doc in "$README" "$README_KO" "$ROOT_DIR/mansu-0help/SKILL.md" "$HELP" "$MANUAL"; do
  for public_route in mansu-1define mansu-2plan mansu-3build mansu-4verify mansu-5review mansu-6ship; do
    require_contains "$public_doc" "$public_route" "public doc must include numbered lifecycle route $public_route: $public_doc"
  done
done
require_contains "$README" 'mansu-project-start.*compatibility-only alias' 'README must keep project-start compatibility-only'
require_contains "$README_KO" 'mansu-project-start.*compatibility-only alias|mansu-project-start.*compatibility alias' 'README.ko must keep project-start compatibility-only'
require_contains "$HELP" 'mansu-project-start.*legacy/specialized Zero-to-PLAN kickoff surface' 'help must keep project-start secondary'
require_contains "$MANUAL" 'mansu-project-start.*compatibility alias' 'manual must keep project-start secondary'
require_absent "$MANUAL" 'data-detail="project-start"|data-detail-card="project-start"|<td><code>Project Start</code></td>' 'manual must not present project-start as a core lifecycle phase'
require_contains "$MANUAL" 'aria-label="Mansu lifecycle compatibility aliases"' 'manual must document lifecycle aliases in a compatibility table'
require_contains "$MANUAL" '<tr><td><code>mansu-define</code></td><td><code>mansu-1define</code></td><td>정의 단계 backing implementation</td></tr>' 'manual must map define alias to numbered public define route'
require_contains "$MANUAL" '<tr><td><code>mansu-plan</code></td><td><code>mansu-2plan</code></td><td>계획 단계 backing implementation</td></tr>' 'manual must map plan alias to numbered public plan route'
require_contains "$MANUAL" '<tr><td><code>mansu-build</code></td><td><code>mansu-3build</code></td><td>구현 단계 backing implementation</td></tr>' 'manual must map build alias to numbered public build route'
require_contains "$MANUAL" '<tr><td><code>mansu-verify</code></td><td><code>mansu-4verify</code></td><td>검증 단계 backing implementation</td></tr>' 'manual must map verify alias to numbered public verify route'
require_contains "$MANUAL" '<tr><td><code>mansu-review</code></td><td><code>mansu-5review</code></td><td>리뷰 단계 backing implementation</td></tr>' 'manual must map review alias to numbered public review route'
require_contains "$MANUAL" '<tr><td><code>mansu-ship</code></td><td><code>mansu-6ship</code></td><td>출하 판단 단계 backing implementation</td></tr>' 'manual must map ship alias to numbered public ship route'
require_absent "$MANUAL" 'class="skill-card mansu-skill-card" id="mansu-(define|plan|build|verify|review|ship)"' 'manual must not expose unnumbered lifecycle aliases as clickable direct-call cards'

scenario "Given generated plan artifacts exist, Then OMO plans can be explicit active plans but not public doctrine"
require_contains "$PLAN" '\.omo/plans/\*\.md' 'plan must keep OMO explicit active plan support'
require_contains "$BUILD" '\.omo/plans/\*\.md' 'build must keep OMO explicit active plan support'
require_contains "$PLAN" 'does not make `\.omo/\*` canonical doctrine' 'plan must keep OMO non-doctrine boundary'
require_contains "$BUILD" 'not canonical doctrine' 'build must keep OMO non-doctrine boundary'
require_contains "$DOC_ORDER" '\.omo/plans/\*\.md.*explicit active plan location' 'document order must allow explicit OMO plan paths'

scenario "Given ulw-loop evidence exists locally, Then repo ignore prevents evidence from polluting commits"
require_contains "$GITIGNORE" '^\.omo/$' '.gitignore must ignore ulw-loop state'
require_absent <(git -C "$ROOT_DIR" status --short --untracked-files=all) '^\?\? \.omo/' '.omo should not appear as untracked status'

echo "mansu lifecycle BDD scenarios OK"
