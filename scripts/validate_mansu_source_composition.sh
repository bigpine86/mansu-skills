#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FILE="$ROOT_DIR/mansu-operating-model/references/SOURCE_SKILL_COMPOSITION.md"
CATALOG="$ROOT_DIR/mansu-operating-model/references/SOURCE_SKILL_CATALOG.md"
CODE_ORDER="$ROOT_DIR/mansu-operating-model/references/CODE_CONSTRUCTION_ORDER.md"
BUILD="$ROOT_DIR/mansu-build/SKILL.md"
BUILD_OPENAI="$ROOT_DIR/mansu-build/agents/openai.yaml"
TDD_TOTAL="$ROOT_DIR/mansu-tdd-total/SKILL.md"
PLAN="$ROOT_DIR/PLAN.md"

forbid_stale_project_start_primary_route() {
  local file="$1"
  ! grep -Eq 'During `mansu-project-start`|zero-to-PLAN kickoff route|Ouroboros project-definition work.*mansu-project-start' "$file"
}

require_heavy_plan_never_defaults_to_ulw_plan() {
  local file="$1"
  require_contains "$file" 'Heavy Plan' 'source composition lost Heavy Plan tier'
  require_contains "$file" 'never' 'source composition lost Heavy Plan never-defaults wording'
  require_contains "$file" 'defaults to `ulw-plan`' 'source composition lost Heavy Plan ulw-plan default prohibition'
}

forbid_default_ulw_plan_route() {
  local file="$1"
  local label="$2"
  ! perl -0ne '
    my $text = $_;
    $text =~ s/Heavy Plan(?:(?!\n\n).)*?\bnever\s+defaults\s+to\s+`ulw-plan`//sig;
    exit($text =~ /(?:Mansu\s+Plan|Heavy\s+Plan|Standard\s+Plan|Quick\s+Plan|Plan)[^\n.]{0,200}(?:default[^\n.]{0,80}`ulw-plan`|`ulw-plan`[^\n.]{0,80}default)/i ? 0 : 1);
  ' "$file" || {
    echo "FAIL: $label presents ulw-plan as a default Plan route" >&2
    exit 1
  }

  ! perl -0ne '
    my $text = $_;
    $text =~ s/Heavy Plan(?:(?!\n\n).)*?\bnever\s+defaults\s+to\s+`ulw-plan`\.?//sig;
    my $bad = 0;
    for my $line (split /\n/, $text) {
      if ($line =~ /`?ulw-plan`?/i
        && $line !~ /only when the user literally invokes/i
        && $line !~ /external planning artifact/i
        && $line !~ /explicit OMO planning/i
        && $line !~ /explicit request for OMO/i
        && $line !~ /allowed only for literal user invocation/i
        && $line !~ /never\s+defaults\s+to\s+`?ulw-plan`?/i
        && $line !~ /do not trigger OMO\s+`?ulw-plan`?/i
        && $line !~ /not public doctrine/i) {
        $bad = 1;
      }
    }
    exit($bad ? 0 : 1);
  ' "$file" || {
    echo "FAIL: $label has an unqualified ulw-plan Plan route; it must be explicit-only" >&2
    exit 1
  }
}

require_contains() {
  local file="$1"
  local pattern="$2"
  local message="$3"
  if ! grep -Eqi -- "$pattern" "$file"; then
    echo "FAIL: $message" >&2
    exit 1
  fi
}

require_absent() {
  local file="$1"
  local pattern="$2"
  local message="$3"
  if grep -Eqi -- "$pattern" "$file"; then
    echo "FAIL: $message" >&2
    exit 1
  fi
}

test -f "$FILE"
test -f "$PLAN"

grep -q '^# Mansu Source Skill Composition' "$FILE"
grep -q 'Define -> Plan -> Build -> Verify -> Review -> Ship' "$FILE"
grep -q '`mansu-debug` is a public special-purpose interrupt route' "$FILE"
grep -q 'interview-me' "$FILE"
grep -q 'Ouroboros' "$FILE"
grep -q 'Use Ouroboros first for new products, apps, repos, major feature families, or fuzzy ideas' "$FILE"
grep -q 'Start with public `mansu-1define`; it discovers and uses Ouroboros `interview` first when available' "$FILE"
grep -q 'design intent seed/handoff' "$FILE"
grep -q 'Plan-owned `DESIGN.md`/design artifacts' "$FILE"
grep -q 'Define owns Ouroboros-first definition plus design intent seed/handoff' "$FILE"
grep -q 'Plan consumes that handoff and owns `DESIGN.md`, design artifacts' "$FILE"
grep -q 'gstack-design-consultation' "$FILE"
grep -q 'office-hours' "$FILE"
require_contains "$FILE" 'Feature Priority / MVP Cut' 'source composition lost Feature Priority / MVP Cut'
require_contains "$FILE" 'Project Phase Roadmap' 'source composition lost Project Phase Roadmap'
require_contains "$FILE" 'Phase Plan' 'source composition lost Phase Plan'
require_contains "$FILE" 'Slice' 'source composition lost Slice handoff'
require_contains "$PLAN" 'Feature Priority / MVP Cut' 'PLAN.md lost Feature Priority / MVP Cut'
require_contains "$PLAN" 'Project Phase Roadmap' 'PLAN.md lost Project Phase Roadmap'
require_contains "$PLAN" 'Phase Plan' 'PLAN.md lost Phase Plan'
require_contains "$PLAN" 'Slice' 'PLAN.md lost Slice handoff'
require_absent "$PLAN" 'Requirements/Spec -> Architecture -> Design Direction -> Implementation Roadmap' 'PLAN.md reintroduced old Plan order'
require_contains "$FILE" 'Quick Plan' 'source composition lost Quick Plan tier'
require_contains "$FILE" 'Standard Plan' 'source composition lost Standard Plan tier'
require_contains "$FILE" 'Heavy Plan' 'source composition lost Heavy Plan tier'
require_heavy_plan_never_defaults_to_ulw_plan "$FILE"
forbid_default_ulw_plan_route "$FILE" 'SOURCE_SKILL_COMPOSITION.md'
forbid_default_ulw_plan_route "$CODE_ORDER" 'CODE_CONSTRUCTION_ORDER.md'
forbid_default_ulw_plan_route "$PLAN" 'PLAN.md'
require_contains "$BUILD" 'user-provided path first' 'build lost user-provided active plan path precedence'
require_contains "$BUILD" 'role/marker discovery' 'build lost role/marker active Phase Plan discovery'
require_contains "$BUILD" '\.omo/plans/\*\.md' 'build lost OMO active plan candidate support'
require_contains "$BUILD_OPENAI" 'role/marker discovery' 'build prompt lost role/marker active Phase Plan discovery'
require_contains "$TDD_TOTAL" 'role/marker discovery' 'tdd-total lost role/marker active Phase Plan discovery'
grep -q 'only when the user literally invokes' "$FILE"
grep -q 'Complex implementation: addyosmani `planning-and-task-breakdown` -> gstack `autoplan`' "$FILE"
require_absent "$FILE" 'Complex implementation:.*ulw-plan' 'source composition reintroduced ulw-plan into complex implementation default route'
grep -q 'Open Design' "$FILE"
grep -q 'VoltAgent/awesome-design-md' "$FILE"
grep -q 'gstack-design-shotgun' "$FILE"
grep -q 'mansu-tdd-total' "$FILE"
grep -q 'Verify proves behavior' "$FILE"
grep -q 'Review judges quality' "$FILE"
grep -q 'continuous sequence by default when verification passes' "$FILE"
grep -q 'Passing Verify hands off to Review by default' "$FILE"
grep -q 'LazyCodex is the Codex-side route for OMO execution patterns' "$FILE"
grep -q 'must not appear as a phase source' "$FILE"
grep -q 'Public lifecycle route names are numbered: `mansu-1define` through' "$FILE"
grep -q 'compatibility implementation names only' "$FILE"
grep -q '| `mansu-1define` |' "$FILE"
grep -q '| `mansu-2plan` |' "$FILE"
grep -q '| `mansu-3build` |' "$FILE"
grep -q '| `mansu-4verify` |' "$FILE"
grep -q '| `mansu-5review` |' "$FILE"
grep -q '| `mansu-6ship` |' "$FILE"
grep -q 'Backed by `mansu-define`' "$FILE"
grep -q 'Backed by `mansu-plan`' "$FILE"
grep -q 'Backed by `mansu-build`' "$FILE"
grep -q 'Backed by `mansu-verify`' "$FILE"
grep -q 'Backed by `mansu-review`' "$FILE"
grep -q 'Backed by `mansu-ship`' "$FILE"
! grep -Eq '^\| `mansu-(define|plan|build|verify|review|ship)` \|' "$FILE"
! grep -Eq -- '- .*-> `mansu-(define|plan|build|verify|review|ship)`([`[:space:]/.,]|$)' "$FILE"
grep -q 'Fuzzy new product: public `mansu-1define` -> Ouroboros' "$FILE"
grep -q 'Clear new project: public `mansu-1define` -> Ouroboros' "$FILE"
require_absent "$FILE" 'Fuzzy new product: addyosmani `interview-me`' 'source composition reintroduced addyosmani-first fuzzy product route'
require_absent "$FILE" 'Fuzzy new product: addyosmani .*->.*Ouroboros' 'source composition reintroduced addyosmani-before-Ouroboros fuzzy product route'
require_absent "$FILE" 'start with `interview-me`' 'source composition reintroduced interview-me as starting route'
require_absent "$FILE" '-> `mansu-2plan`' 'source composition reintroduced direct arrow into numbered plan route'
grep -q 'Fuzzy new product: public `mansu-1define` -> Ouroboros' "$PLAN"
require_absent "$PLAN" 'Fuzzy new product: addyosmani `interview-me`' 'PLAN.md reintroduced addyosmani-first fuzzy product route'
require_absent "$PLAN" 'Fuzzy new product: addyosmani .*->.*Ouroboros' 'PLAN.md reintroduced addyosmani-before-Ouroboros fuzzy product route'
require_absent "$PLAN" 'start with `interview-me`' 'PLAN.md reintroduced interview-me as starting route'
forbid_stale_project_start_primary_route "$PLAN"
forbid_stale_project_start_primary_route "$CATALOG"

grep -q 'SOURCE_SKILL_COMPOSITION.md' "$CATALOG"
grep -q 'SOURCE_SKILL_COMPOSITION.md' "$CODE_ORDER"
grep -q 'Use public routes `mansu-1define` and then `mansu-2plan`' "$CATALOG"
grep -q 'Hand off to public route `mansu-3build`' "$CATALOG"
grep -q 'Use public route `mansu-4verify`' "$CATALOG"
grep -q 'Use public route `mansu-6ship`' "$CATALOG"
! grep -Eiq 'Use[[:space:]]+`mansu-define`[[:space:]]+and[[:space:]]+then[[:space:]]+`mansu-plan`' "$CATALOG"
! grep -Eiq 'use[[:space:]]+`mansu-define`' "$CATALOG"
! grep -Eiq 'Hand off to[[:space:]]+`mansu-build`' "$CATALOG"
! grep -Eiq 'For non-trivial work,[[:space:]]+use[[:space:]]+`mansu-build`' "$CATALOG"
! grep -Eiq 'Use[[:space:]]+`mansu-verify`' "$CATALOG"
! grep -Eiq 'Use[[:space:]]+`mansu-ship`' "$CATALOG"

! grep -q 'LazyCodex/OMO Codex plugin as preferred Codex transport' "$CODE_ORDER"
