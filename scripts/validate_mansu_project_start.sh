#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FILE="$ROOT_DIR/mansu-project-start/SKILL.md"
OPENAI_YAML="$ROOT_DIR/mansu-project-start/agents/openai.yaml"

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
  ' "$@" < "$file" || {
    echo "FAIL: $message" >&2
    exit 1
  }
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
  ' "$@" < "$file" || {
    echo "FAIL: $message" >&2
    exit 1
  }
}

forbid_terms() {
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
      exit 0 if index($text, lc($term)) < 0;
    }
    exit 1;
  ' "$@" < "$file" || {
    echo "FAIL: $message" >&2
    exit 1
  }
}

forbid_ordered_terms() {
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
      exit 0 if $idx < 0;
      $pos = $idx + length($term);
    }
    exit 1;
  ' "$@" < "$file" || {
    echo "FAIL: $message" >&2
    exit 1
  }
}

test -f "$FILE"
test -f "$OPENAI_YAML"

grep -q '^name: mansu-project-start$' "$FILE"
description_prefix='description: Zero-to-PLAN project '
description_suffix='kickoff workflow for legacy/specialized Mansu project-start calls. Public lifecycle guidance should prefer `mansu-1define`, then `mansu-2plan`.'
grep -Fq "$description_prefix$description_suffix" "$FILE"
grep -q 'legacy/specialized Mansu project-start calls' "$FILE"
grep -q 'Public lifecycle guidance should prefer `mansu-1define`, then `mansu-2plan`' "$FILE"
grep -q 'Use this skill only when the user explicitly invokes `$mansu-project-start`' "$FILE"
grep -q 'when an older workflow depends on that callable name' "$FILE"
grep -q 'For normal new ideas,' "$FILE"
grep -q 'route first to' "$FILE"
grep -q '`mansu-1define`, then to `mansu-2plan`' "$FILE"
grep -q 'Use only as an explicit legacy/specialized compatibility route for:' "$FILE"
grep -q 'older workflows that call `$mansu-project-start` by name' "$FILE"
grep -q 'user requests that explicitly ask for `$mansu-project-start`' "$FILE"
grep -q 'compatibility kickoff reports that must preserve the historical' "$FILE"
grep -q 'For normal new ideas, fuzzy discovery, new repos/products, major feature' "$FILE"
grep -q 'use `mansu-1define` first and then `mansu-2plan` unless the user' "$FILE"
! grep -q '^Use this skill before implementation when' "$FILE"
! grep -qx -- '- new repository or product from zero' "$FILE"
grep -q '^## Core promise$' "$FILE"
grep -q '^## Orchestration posture$' "$FILE"
grep -q '^## Project-start route selector$' "$FILE"
grep -q '^## Research discipline$' "$FILE"
grep -q '^## Workflow$' "$FILE"
grep -q '^## Required handoff to phase execution$' "$FILE"
grep -q 'GitHub, Reddit, and' "$FILE"
grep -q 'Threads' "$FILE"
grep -q 'official docs, source files, changelogs, release notes' "$FILE"
grep -q 'DOCUMENT_CREATION_ORDER.md' "$FILE"
grep -q 'CODE_CONSTRUCTION_ORDER.md' "$FILE"
grep -q 'gstack-autoplan' "$FILE"
grep -q 'gstack-plan-' "$FILE"
grep -q 'Do not reimplement strong source routes inside Mansu' "$FILE"
grep -q 'thin project-start orchestrator' "$FILE"
grep -q 'delegate fuzzy project definition to Ouroboros first when it is available' "$FILE"
grep -q '^## Mandatory Ouroboros-first rule$' "$FILE"
grep -q 'Mansu must not' "$FILE"
grep -q 'start by inventing its own interview' "$FILE"
grep -q 'mcp__ouroboros\.ouroboros_interview' "$FILE"
grep -q 'current `ouroboros` route' "$FILE"
grep -q 'send[[:space:]]*$' "$FILE"
grep -q 'early definition to Ouroboros' "$FILE"
grep -q 'call `tool_search` for `ouroboros interview mcp`' "$FILE"
grep -q 'Treat `ooo interview` and `ouroboros init start` wording as legacy' "$FILE"
grep -q 'Use Ouroboros `pm`' "$FILE"
grep -q 'Use Ouroboros `seed` or `auto --skip-run`' "$FILE"
grep -q 'Use Ouroboros `brownfield` before user questions' "$FILE"
grep -q 'Mansu may ask at most one bridging question' "$FILE"
grep -q 'do not silently continue' "$FILE"
grep -q 'label the kickoff' "$FILE"
grep -q 'as fallback' "$FILE"
grep -q 'gstack, Oh My, addyosmani, or another stronger source route' "$FILE"
grep -q 'avoid asking duplicate questions' "$FILE"
grep -q 'ask the user only when a missing answer materially changes scope' "$FILE"
grep -q 'translate source artifacts into Mansu-owned documents' "$FILE"
grep -q 'choose the smallest source route that fits' "$FILE"
grep -q 'Do not emulate a source route manually' "$FILE"
grep -q 'reference-only sources rather than executable routes' "$FILE"
grep -q 'not invoked, installed, or treated as a runtime skill' "$FILE"
grep -q 'Open Design (`nexu-io/open-design`) is different' "$FILE"
grep -q 'callable design-artifact source route' "$FILE"
grep -q 'Mansu should run the required CLI commands' "$FILE"
grep -q 'Ouroboros `brownfield`; addyosmani `context-engineering`' "$FILE"
grep -q 'Codex `mcp__ouroboros\.ouroboros_interview`; current Ouroboros interview/PM route' "$FILE"
grep -q '`gstack-office-hours`; addyosmani `idea-refine`' "$FILE"
grep -q 'gstack-office-hours' "$FILE"
grep -q 'addyosmani `idea-refine`' "$FILE"
grep -q 'Ouroboros `pm`' "$FILE"
grep -q 'Ouroboros `seed`' "$FILE"
grep -q 'Oh My `research` / `deepsearch`' "$FILE"
grep -q 'gstack-autoplan' "$FILE"
grep -q 'gstack-design-shotgun' "$FILE"
grep -q 'source-check` when readiness is unclear' "$FILE"
grep -q 'source-driven-development' "$FILE"
grep -q 'Design artifact generation' "$FILE"
grep -q 'Open Design (`nexu-io/open-design`) when installed or explicitly approved for setup' "$FILE"
grep -q 'VoltAgent/awesome-design-md' "$FILE"
grep -q 'reference only, not an execution route' "$FILE"
grep -q '^## Design route gate$' "$FILE"
grep -q 'choose a design source route before phase roadmap' "$FILE"
grep -q 'Mansu must not replace this with its own design questionnaire' "$FILE"
grep -q 'Default design route stack' "$FILE"
grep -q 'For a greenfield UI with no design system or `DESIGN.md`' "$FILE"
grep -q '`gstack-design-consultation` as the default design-system route' "$FILE"
grep -q 'use Oh My / OMO `research` or `deepsearch` before or inside' "$FILE"
grep -q 'Use addyosmani `source-driven-development` when source projects' "$FILE"
grep -q 'Use `gstack-design-shotgun` when the team needs several visible candidate' "$FILE"
grep -q 'Use `gstack-plan-design-review` before locking the roadmap' "$FILE"
grep -q 'Recommended combinations:' "$FILE"
grep -q 'Greenfield app with no design system' "$FILE"
grep -q 'Ambiguous market/taste' "$FILE"
grep -q 'Need visible options before choosing' "$FILE"
grep -q 'Need prototype/artifact before implementation' "$FILE"
grep -q 'Existing UI or existing plan' "$FILE"
grep -q 'Oh My `research` / `deepsearch`; addyosmani `source-driven-development`' "$FILE"
grep -q 'Open Design (`nexu-io/open-design`) when installed or explicitly approved' "$FILE"
grep -q 'VoltAgent/awesome-design-md as `DESIGN.md` reference corpus' "$FILE"
grep -q '`gstack-plan-design-review`; `gstack-design-review`' "$FILE"
grep -q '`gstack-browse`; `gstack-qa-only`' "$FILE"
grep -q 'If UI is in scope and no design route is selected' "$FILE"
grep -q 'DESIGN.md reference / visual taste' "$FILE"
grep -q 'Design references used:' "$FILE"
grep -q 'DESIGN.md status:' "$FILE"
grep -q 'Open Design route status' "$FILE"
grep -q 'visual/taste research used' "$FILE"
grep -q 'selected direction, and rejected directions' "$FILE"
grep -q 'artifact path, preview/export path, or fallback' "$FILE"
grep -q 'visual atmosphere, color roles, typography' "$FILE"
grep -q 'Ouroboros `evaluate` / `qa`' "$FILE"
grep -q 'Ouroboros `evolve` / `ralph`' "$FILE"
grep -q 'Ouroboros' "$FILE"
grep -q 'Seed/Ledger' "$FILE"
grep -q 'Ouroboros `auto --skip-run`' "$FILE"
grep -q 'do not start implementation from project-start' "$FILE"
grep -q 'Check Codex `mcp__ouroboros\.ouroboros_interview` or current `ouroboros`' "$FILE"
grep -q 'route to `mansu-9setup`' "$FILE"
grep -q 'setup blocks Ouroboros' "$FILE"
grep -q 'prefer Ouroboros init/interview/pm/seed/brownfield first' "$FILE"
grep -q 'record why Ouroboros was skipped' "$FILE"
grep -q 'Only after source artifacts are clear and the project roadmap names the major' "$FILE"
grep -q 'Hand the selected phase to `mansu-tdd-total` only when the roadmap artifact' "$FILE"
grep -q '^## Zero-to-PLAN minimum gate$' "$FILE"
grep -q '^## Expand when useful$' "$FILE"
grep -q 'Use this as a flexible gate, not a form-filling ritual' "$FILE"
grep -q 'Purpose: what are we making' "$FILE"
grep -q 'User/problem: who has the problem' "$FILE"
grep -q 'Evidence: what source route artifacts' "$FILE"
grep -q 'Assumptions: which unsupported guesses' "$FILE"
grep -q 'Direction: what product, technical, architecture' "$FILE"
grep -q 'Order: what are the large-grain phases' "$FILE"
grep -q 'Execution bridge: where is the current phase `PLAN.md`' "$FILE"
grep -q 'ordered slices, validation path, gate mapping, and `mansu-tdd-total` mode hints' "$FILE"
grep -q 'Do not jump into slice implementation' "$FILE"
grep -q 'Market, adoption, or taste risk' "$FILE"
grep -q 'Technical freshness risk' "$FILE"
grep -q 'Architecture or data risk' "$FILE"
grep -q 'UI risk' "$FILE"
grep -q 'Expensive or durable decision' "$FILE"
grep -q 'Expansion decisions must name the risk/ambiguity class' "$FILE"
grep -q 'DOCUMENT_CREATION_ORDER.md` artifact choice' "$FILE"
grep -q 'Do not create documents just to satisfy ceremony' "$FILE"
grep -q '^## Reference artifact defaults$' "$FILE"
grep -q 'docs/research/{topic-slug}.md' "$FILE"
grep -q 'docs/specs/{project-or-feature-slug}.md' "$FILE"
grep -q 'docs/technical/{project-or-feature-slug}.md' "$FILE"
grep -q '`PLAN.md` should link to research/spec/TDR/design artifacts' "$FILE"
grep -q 'project roadmap/phase order' "$FILE"
grep -q '^## Phase roadmap gate$' "$FILE"
grep -q 'Project-start must create or update a project roadmap before it creates' "$FILE"
grep -q 'phase list: the large project phases in order' "$FILE"
grep -q 'active phase: exactly one phase selected' "$FILE"
grep -q 'Do not hand off to `mansu-tdd-total` when' "$FILE"
grep -q 'Implementation handoff: blocked' "$FILE"
grep -q '^## Roadmap vs PLAN.md boundary$' "$FILE"
grep -q 'The project roadmap belongs in the spec/TDR/design layer' "$FILE"
grep -q 'belongs to the active phase' "$FILE"
grep -q 'does not own slice implementation' "$FILE"
grep -q 'owns the selected phase' "$FILE"
grep -q 'Project-start must not implement the slices itself' "$FILE"
grep -q 'the next owner is `mansu-tdd-total`' "$FILE"
grep -q 'Ouroboros artifacts used' "$FILE"
grep -q 'upstream source-of-truth artifacts' "$FILE"
grep -q 'project roadmap or phase order artifact' "$FILE"
grep -q 'phase list and active phase selection' "$FILE"
grep -q 'design source route selected' "$FILE"
grep -q 'Source skills skipped:' "$FILE"
grep -q 'Upstream source-of-truth artifacts and paths:' "$FILE"
grep -q 'Ouroboros skipped reason:' "$FILE"
grep -q 'References inspected with date/version/source evidence:' "$FILE"
grep -q 'Design route selected:' "$FILE"
grep -q 'Minimum gate status:' "$FILE"
grep -q -- '- Purpose:' "$FILE"
grep -q -- '- User/problem:' "$FILE"
grep -q -- '- Evidence:' "$FILE"
grep -q -- '- Assumptions:' "$FILE"
grep -q -- '- Direction:' "$FILE"
grep -q -- '- Order:' "$FILE"
grep -q -- '- Execution bridge:' "$FILE"
grep -q 'Expanded artifacts used/skipped:' "$FILE"
grep -q 'Project roadmap / phase order artifact:' "$FILE"
grep -q 'Phase list:' "$FILE"
grep -q 'Active phase:' "$FILE"
grep -q "Write the report in the user's language or the project's default language" "$FILE"
grep -q 'Field labels may stay canonical' "$FILE"
grep -q 'Locked decisions and why:' "$FILE"
grep -q 'Open questions and blocker status:' "$FILE"
grep -q 'Current phase goal:' "$FILE"
grep -q 'Ordered vertical slices:' "$FILE"
grep -q 'Gate mapping:' "$FILE"
grep -q 'Validation commands:' "$FILE"
grep -q 'Worklog target:' "$FILE"
grep -q 'Recommended mansu-tdd-total modes:' "$FILE"
grep -q 'gate mapping' "$FILE"
grep -q 'mansu-tdd-total' "$FILE"

grep -q '^interface:$' "$OPENAI_YAML"
grep -q 'display_name: "Mansu Project Start"' "$OPENAI_YAML"
grep -q 'short_description: "Legacy/specialized compatibility route"' "$OPENAI_YAML"
require_terms "$OPENAI_YAML" 'project-start OpenAI prompt lost legacy compatibility route contract' '$mansu-project-start' 'legacy' 'specialized' 'compatibility route'
require_ordered_terms "$OPENAI_YAML" 'project-start OpenAI prompt lost normal-use public route order' 'normal use' 'new starts' '$mansu-1define' '$mansu-2plan'
require_terms "$OPENAI_YAML" 'project-start OpenAI prompt lost older workflow compatibility condition' 'older workflow' 'callable name'
require_terms "$OPENAI_YAML" 'project-start OpenAI prompt lost thin orchestrator contract' '$mansu-project-start' 'thin' 'project-start' 'orchestrator'
forbid_ordered_terms "$OPENAI_YAML" 'project-start OpenAI prompt reintroduced compatibility route capitalization regression' 'When this compatibility route' 'Use $mansu-project-start'
forbid_terms "$OPENAI_YAML" 'project-start OpenAI prompt reintroduced Zero-to-PLAN positioning' 'Zero-to-PLAN' 'project kickoff'
forbid_terms "$OPENAI_YAML" 'project-start OpenAI prompt reintroduced normal discovery legacy route' 'normal discovery' 'vague ideas' 'broad feature definition'
forbid_terms "$OPENAI_YAML" 'project-start OpenAI prompt reintroduced fuzzy-project default route' 'new or fuzzy project' '$mansu-project-start'
require_terms "$OPENAI_YAML" 'project-start OpenAI prompt lost Ouroboros availability check' 'tool_search' 'ouroboros interview mcp' 'mcp__ouroboros.ouroboros_interview'
require_terms "$OPENAI_YAML" 'project-start OpenAI prompt lost early definition source routes' 'route early definition' 'ouroboros-interview' 'PM' 'Seed' 'brownfield'
require_terms "$OPENAI_YAML" 'project-start OpenAI prompt lost legacy Ouroboros wording boundary' 'ooo interview' 'ouroboros init start' 'legacy compatibility wording only'
require_terms "$OPENAI_YAML" 'project-start OpenAI prompt lost public setup route' '$mansu-9setup' 'repair/update'
require_terms "$OPENAI_YAML" 'project-start OpenAI prompt lost design artifact route distinction' 'Open Design' 'callable' 'design-artifact' 'installed' 'approved'
require_terms "$OPENAI_YAML" 'project-start OpenAI prompt lost DESIGN.md reference route distinction' 'VoltAgent/awesome-design-md' 'DESIGN.md' 'reference-only'
require_terms "$OPENAI_YAML" 'project-start OpenAI prompt lost source route non-duplication boundary' 'avoid' 'duplicating' 'selected source logic'
require_terms "$OPENAI_YAML" 'project-start OpenAI prompt lost UI design route gate' 'user-facing UI' 'design source route' 'phase roadmap planning'
require_terms "$OPENAI_YAML" 'project-start OpenAI prompt lost missing design route block' 'UI' 'scope' 'no design route' 'blocked'
require_terms "$OPENAI_YAML" 'project-start OpenAI prompt lost Ouroboros skipped reason report field' 'Ouroboros' 'skipped reason'
require_terms "$OPENAI_YAML" 'project-start OpenAI prompt lost minimum gate before handoff' 'minimum gate' 'handoff'
require_terms "$OPENAI_YAML" 'project-start OpenAI prompt lost minimum gate dimensions' 'purpose' 'user/problem' 'evidence' 'assumptions' 'direction' 'order' 'execution bridge'
require_terms "$OPENAI_YAML" 'project-start OpenAI prompt lost source artifact boundary' 'source artifacts' 'research' 'spec' 'TDR' 'DESIGN.md' 'design direction' 'project roadmap' 'outside PLAN.md'
require_terms "$OPENAI_YAML" 'project-start OpenAI prompt lost phase roadmap preflight' '$mansu-tdd-total' 'repo-visible' 'phase roadmap'
require_terms "$OPENAI_YAML" 'project-start OpenAI prompt lost active phase cardinality' 'exactly one' 'active phase'
require_terms "$OPENAI_YAML" 'project-start OpenAI prompt lost current phase execution plan derivation' 'current phase' 'execution-ready' 'PLAN.md' 'active phase'
require_terms "$OPENAI_YAML" 'project-start OpenAI prompt lost blocked implementation handoff report' 'Implementation handoff' 'blocked'
require_terms "$OPENAI_YAML" 'project-start OpenAI prompt lost active phase slice table fields' 'ordered slices' 'validation path' 'gate mapping' 'mansu-tdd-total' 'mode hints'
require_terms "$OPENAI_YAML" 'project-start OpenAI prompt lost tdd-total phase handoff boundary' '$mansu-tdd-total' 'slice-level planning' 'implementation' 'review' 'QA' 'checkpoint'

echo "mansu-project-start structure OK"
