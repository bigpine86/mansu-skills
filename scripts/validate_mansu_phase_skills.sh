#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

require_contains() {
  local file="$1"
  local pattern="$2"
  local message="$3"
  if ! grep -Eqi "$pattern" "$file"; then
    echo "FAIL: $message" >&2
    exit 1
  fi
}

require_literal() {
  local file="$1"
  local pattern="$2"
  local message="$3"
  if ! grep -Fqi "$pattern" "$file"; then
    echo "FAIL: $message" >&2
    exit 1
  fi
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
  ' "$@" < "$file" || {
    echo "FAIL: $message" >&2
    exit 1
  }
}

forbid_contains() {
  local file="$1"
  local pattern="$2"
  local message="$3"
  if grep -Eqi "$pattern" "$file"; then
    echo "FAIL: $message" >&2
    exit 1
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
  ' "$@" < "$file" || {
    echo "FAIL: $message" >&2
    exit 1
  }
}

for skill in define plan build verify review debug ship; do
  test -f "$ROOT_DIR/mansu-$skill/SKILL.md"
  test -f "$ROOT_DIR/mansu-$skill/agents/openai.yaml"
  grep -q "name: mansu-$skill" "$ROOT_DIR/mansu-$skill/SKILL.md"
  grep -q 'SOURCE_SKILL_COMPOSITION.md' "$ROOT_DIR/mansu-$skill/SKILL.md"
done

grep -q 'interview-me' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'Ouroboros' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q '^## Mandatory Ouroboros definition rule$' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'Do not present Ouroboros interview as an' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'User-provided idea notes do not satisfy the interview gate' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'treat that text as seed context for' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'do not mark Define complete, jump to planning, or replace' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'Skipping the Ouroboros interview is allowed only when current, repo-visible' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q '^## Conditional references$' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'SOURCE_SKILL_CATALOG.md` only when' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'DOCUMENT_CREATION_ORDER.md` only when' "$ROOT_DIR/mansu-define/SKILL.md"
require_terms "$ROOT_DIR/mansu-define/SKILL.md" 'define lost setup install route' 'route to public `mansu-9setup`' '`install` mode' 'Ouroboros is missing'
require_terms "$ROOT_DIR/mansu-define/SKILL.md" 'define lost setup update/repair route' 'public `mansu-9setup`' '`update`/`repair` mode' 'MCP integration'
grep -q 'mcp__ouroboros\.ouroboros_interview' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'Do not run Claude Code adapter commands unless' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'do not require the `ooo` command' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q '`update`/`repair` mode' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'Ouroboros setup blocked reason:' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'Do not silently replace Ouroboros interview with Mansu-owned questions' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'Do not substitute ULW deep interview' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'planning density, product/design critique, or specialist' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'Do not use ULW deep interview or OMO `ulw-plan` as a Define substitute' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q '^## Post-Ouroboros design-context gate$' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'user-facing UI/product scope is present' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'design-context interview before public `mansu-2plan`' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'default installed.*gstack-design-consultation' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'gstack-design-shotgun' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'Open Design' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'gstack-plan-design-review' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'design intent seed' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'DESIGN.md.*mansu-2plan' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'Mansu-owned design questionnaire' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'office-hours' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'AGENTS.md' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'CODING_RULES.md' "$ROOT_DIR/mansu-define/SKILL.md"
grep -q 'If Define is complete, tell the user the next step is .*`mansu-2plan`' "$ROOT_DIR/mansu-define/SKILL.md"
require_terms "$ROOT_DIR/mansu-define/agents/openai.yaml" 'define OpenAI prompt lost next public route' 'complete' 'mansu-2plan'
require_terms "$ROOT_DIR/mansu-define/agents/openai.yaml" 'define OpenAI prompt lost Ouroboros-first contract' 'Ouroboros' 'interview' 'first'
require_terms "$ROOT_DIR/mansu-define/agents/openai.yaml" 'define OpenAI prompt lost Codex Ouroboros MCP route' 'Codex' 'mcp__ouroboros.ouroboros_interview' 'initial_context' 'cwd'
require_terms "$ROOT_DIR/mansu-define/agents/openai.yaml" 'define OpenAI prompt lost Claude adapter guard' 'do not run Claude' 'unless' 'Claude Code'
require_terms "$ROOT_DIR/mansu-define/agents/openai.yaml" 'define OpenAI prompt lost short-idea seed contract' 'short' 'idea' 'seed context' 'Ouroboros'
require_terms "$ROOT_DIR/mansu-define/agents/openai.yaml" 'define OpenAI prompt lost interview role split' 'Do not substitute ULW deep interview' 'Ouroboros definition gate' 'planning density'
require_terms "$ROOT_DIR/mansu-define/agents/openai.yaml" 'define OpenAI prompt lost design source-route contract' 'design-context' 'mansu-2plan' 'gstack-design-consultation'
require_terms "$ROOT_DIR/mansu-define/agents/openai.yaml" 'define OpenAI prompt lost design handoff contract' 'design intent seed' 'DESIGN.md' 'mansu-2plan'
require_terms "$ROOT_DIR/mansu-define/agents/openai.yaml" 'define OpenAI prompt lost Mansu design questionnaire boundary' 'Mansu-owned' 'design questionnaire'
require_terms "$ROOT_DIR/mansu-1define/agents/openai.yaml" 'public define OpenAI prompt lost short-idea seed contract' 'short' 'idea' 'seed context' 'Ouroboros'
require_terms "$ROOT_DIR/mansu-1define/agents/openai.yaml" 'public define OpenAI prompt lost interview role split' 'Do not substitute ULW deep interview' 'Ouroboros definition gate'
require_terms "$ROOT_DIR/mansu-1define/agents/openai.yaml" 'public define OpenAI prompt lost Codex Ouroboros MCP route' 'Codex' 'mcp__ouroboros.ouroboros_interview' 'initial_context' 'cwd'
require_terms "$ROOT_DIR/mansu-1define/agents/openai.yaml" 'public define OpenAI prompt lost setup repair route' 'mansu-9setup' 'install' 'update' 'repair'
require_terms "$ROOT_DIR/mansu-1define/agents/openai.yaml" 'public define OpenAI prompt lost design source-route contract' 'design-context' 'mansu-2plan' 'gstack-design-consultation'
require_terms "$ROOT_DIR/mansu-1define/agents/openai.yaml" 'public define OpenAI prompt lost design handoff contract' 'design intent seed' 'DESIGN.md' 'mansu-2plan'
require_terms "$ROOT_DIR/mansu-1define/agents/openai.yaml" 'public define OpenAI prompt lost Mansu design questionnaire boundary' 'Mansu-owned' 'design questionnaire'
require_terms "$ROOT_DIR/mansu-define/agents/openai.yaml" 'define OpenAI prompt lost setup install route' 'mansu-9setup' 'install'
require_terms "$ROOT_DIR/mansu-define/agents/openai.yaml" 'define OpenAI prompt lost setup update route' 'mansu-9setup' 'update'

require_ordered_terms "$ROOT_DIR/mansu-plan/SKILL.md" 'plan skill lost planning order terms' 'Requirements/Spec' 'Feature Priority' 'Architecture' 'Design Direction' 'Implementation Roadmap'
require_literal "$ROOT_DIR/mansu-plan/SKILL.md" 'Feature Priority / MVP Cut' 'plan skill lost Feature Priority / MVP Cut'
require_literal "$ROOT_DIR/mansu-plan/SKILL.md" 'Project Phase Roadmap' 'plan skill lost Project Phase Roadmap'
require_literal "$ROOT_DIR/mansu-plan/SKILL.md" 'Phase Plan' 'plan skill lost Phase Plan'
require_literal "$ROOT_DIR/mansu-plan/SKILL.md" 'Slice' 'plan skill lost Slice'
require_literal "$ROOT_DIR/mansu-plan/SKILL.md" 'Quick Plan' 'plan skill lost Quick Plan tier'
require_literal "$ROOT_DIR/mansu-plan/SKILL.md" 'Standard Plan' 'plan skill lost Standard Plan tier'
require_literal "$ROOT_DIR/mansu-plan/SKILL.md" 'Heavy Plan' 'plan skill lost Heavy Plan tier'
require_ordered_terms "$ROOT_DIR/mansu-plan/SKILL.md" 'plan skill lost hierarchy terms' 'Feature Priority' 'Project Phase Roadmap' 'Phase Plan' 'Slice'
require_literal "$ROOT_DIR/mansu-plan/SKILL.md" 'OMO `ulw-plan` is allowed only for literal user invocation' 'plan skill lost explicit-use-only ulw-plan whitelist'
require_literal "$ROOT_DIR/mansu-plan/SKILL.md" 'ULW deep interview is planning-density support, not project definition' 'plan skill lost ULW deep interview role boundary'
require_terms "$ROOT_DIR/mansu-plan/SKILL.md" 'plan skill lost ULW reconciliation contract' 'reconcile' 'Feature Priority / MVP Cut' 'Project Phase Roadmap' 'Phase Plan' 'Slice'
grep -q 'Generic phrases such as "parallel planning"' "$ROOT_DIR/mansu-plan/SKILL.md"
forbid_contains "$ROOT_DIR/mansu-plan/SKILL.md" 'Use OMO.*ulw-plan|ulw-plan when decomposition|Heavy Plan.*ulw-plan|ulw-plan.*Heavy Plan' 'plan skill reintroduced default Plan-route ulw-plan'
grep -q 'feature inventory, priority rationale, MVP/later split' "$ROOT_DIR/mansu-plan/SKILL.md"
grep -q 'feature priority/MVP cut' "$ROOT_DIR/mansu-plan/SKILL.md"
grep -q '^## Plan quality gate$' "$ROOT_DIR/mansu-plan/SKILL.md"
grep -q 'Do not produce a shallow outline' "$ROOT_DIR/mansu-plan/SKILL.md"
grep -q 'input evidence: Define handoff' "$ROOT_DIR/mansu-plan/SKILL.md"
grep -q 'active Phase Plan: current phase goal, ordered vertical slices' "$ROOT_DIR/mansu-plan/SKILL.md"
grep -q 'If any required part is missing, Plan is incomplete' "$ROOT_DIR/mansu-plan/SKILL.md"
grep -q 'environment/dependency setup plan when needed' "$ROOT_DIR/mansu-plan/SKILL.md"
grep -q 'Prefer `uv` for Python' "$ROOT_DIR/mansu-plan/SKILL.md"
grep -q 'Do not add a new `uv` environment just because planning is happening' "$ROOT_DIR/mansu-plan/SKILL.md"
grep -q '^## Conditional references$' "$ROOT_DIR/mansu-plan/SKILL.md"
grep -q 'DOCUMENT_CREATION_ORDER.md` only when' "$ROOT_DIR/mansu-plan/SKILL.md"
grep -q 'gstack-plan-design-review' "$ROOT_DIR/mansu-plan/SKILL.md"
grep -q 'gstack-design-shotgun' "$ROOT_DIR/mansu-plan/SKILL.md"
grep -q '.omo/plans/\*.md' "$ROOT_DIR/mansu-plan/SKILL.md"
grep -q 'The active plan is a role, not a literal filename' "$ROOT_DIR/mansu-plan/SKILL.md"
grep -q 'Use exactly one active plan' "$ROOT_DIR/mansu-plan/SKILL.md"
grep -q 'plan precedence is:' "$ROOT_DIR/mansu-plan/SKILL.md"
grep -Fq 'explicit active plan support does not make `.omo/*` canonical doctrine' "$ROOT_DIR/mansu-plan/SKILL.md"
grep -q 'If Plan is complete, tell the user the next step is .*`mansu-3build`' "$ROOT_DIR/mansu-plan/SKILL.md"
require_terms "$ROOT_DIR/mansu-plan/agents/openai.yaml" 'plan OpenAI prompt lost next public route' 'complete' 'mansu-3build'
require_terms "$ROOT_DIR/mansu-plan/agents/openai.yaml" 'plan OpenAI prompt lost Feature Priority / MVP Cut concepts' 'Feature Priority' 'MVP' 'Cut'
require_terms "$ROOT_DIR/mansu-plan/agents/openai.yaml" 'plan OpenAI prompt lost Project Phase Roadmap concept' 'Project' 'Phase' 'Roadmap'
require_terms "$ROOT_DIR/mansu-plan/agents/openai.yaml" 'plan OpenAI prompt lost Phase Plan concept' 'Phase' 'Plan'
require_terms "$ROOT_DIR/mansu-plan/agents/openai.yaml" 'plan OpenAI prompt lost Slice guidance' 'Slice' 'acceptance criteria' 'impact' 'files'
require_terms "$ROOT_DIR/mansu-plan/agents/openai.yaml" 'plan OpenAI prompt lost plan tier contract' 'Quick Plan' 'Standard Plan' 'Heavy Plan'
require_terms "$ROOT_DIR/mansu-plan/agents/openai.yaml" 'plan OpenAI prompt lost ULW deep interview role boundary' 'ULW deep interview' 'planning-density support' 'after definition'
require_terms "$ROOT_DIR/mansu-plan/agents/openai.yaml" 'plan OpenAI prompt lost quality gate contract' 'shallow' 'outline' 'exit criteria'
forbid_contains "$ROOT_DIR/mansu-plan/agents/openai.yaml" 'Heavy Plan.*ulw-plan|ulw-plan.*Heavy Plan|default.*ulw-plan|ulw-plan.*default' 'plan OpenAI prompt reintroduced default Plan-route ulw-plan'
require_terms "$ROOT_DIR/mansu-2plan/agents/openai.yaml" 'public plan OpenAI prompt lost Define handoff priority concepts' 'feature candidates' 'priority signals'
require_terms "$ROOT_DIR/mansu-2plan/agents/openai.yaml" 'public plan OpenAI prompt lost Feature Priority / MVP Cut concepts' 'Feature Priority' 'MVP' 'Cut'
require_terms "$ROOT_DIR/mansu-2plan/agents/openai.yaml" 'public plan OpenAI prompt lost Project Phase Roadmap concept' 'Project' 'Phase' 'Roadmap'
require_terms "$ROOT_DIR/mansu-2plan/agents/openai.yaml" 'public plan OpenAI prompt lost Phase Plan concept' 'Phase' 'Plan'
require_terms "$ROOT_DIR/mansu-2plan/agents/openai.yaml" 'public plan OpenAI prompt lost Slice guidance' 'Slice' 'acceptance criteria' 'impact' 'files'
require_terms "$ROOT_DIR/mansu-2plan/agents/openai.yaml" 'public plan OpenAI prompt lost plan tier contract' 'Quick Plan' 'Standard Plan' 'Heavy Plan'
require_terms "$ROOT_DIR/mansu-2plan/agents/openai.yaml" 'public plan OpenAI prompt lost ULW deep interview role boundary' 'ULW deep interview' 'planning-density support' 'not a substitute for Ouroboros definition'
require_terms "$ROOT_DIR/mansu-2plan/agents/openai.yaml" 'public plan OpenAI prompt lost quality gate contract' 'shallow' 'outline' 'exit criteria'
forbid_contains "$ROOT_DIR/mansu-2plan/agents/openai.yaml" 'Heavy Plan.*ulw-plan|ulw-plan.*Heavy Plan|default.*ulw-plan|ulw-plan.*default' 'public plan OpenAI prompt reintroduced default Plan-route ulw-plan'
require_terms "$ROOT_DIR/mansu-plan/agents/openai.yaml" 'plan OpenAI prompt lost Python environment setup preference' 'Python' 'uv' '.venv' 'appropriate'

grep -q 'mansu-tdd-total' "$ROOT_DIR/mansu-build/SKILL.md"
grep -q 'LazyCodex is not a source skill family' "$ROOT_DIR/mansu-build/SKILL.md"
require_contains "$ROOT_DIR/mansu-build/SKILL.md" 'active Phase Plan is a role, not a literal filename' 'build skill lost active Phase Plan role/marker discovery boundary'
grep -q '.omo/plans/\*.md' "$ROOT_DIR/mansu-build/SKILL.md"
require_contains "$ROOT_DIR/mansu-build/SKILL.md" 'read the active Phase Plan and its linked' 'build skill lost active Phase Plan read preflight'
require_contains "$ROOT_DIR/mansu-build/SKILL.md" 'Project Phase Roadmap before any linked spec, TDR, or design direction' 'build skill lost roadmap-before-linked-artifacts rule'
require_contains "$ROOT_DIR/mansu-build/SKILL.md" 'update the active Phase Plan before editing' 'build skill lost stale active Phase Plan update rule'
grep -q 'support is explicit active plan path support only' "$ROOT_DIR/mansu-build/SKILL.md"
grep -q 'not canonical doctrine' "$ROOT_DIR/mansu-build/SKILL.md"
grep -q 'If implementation for the active phase is complete, tell the user the next' "$ROOT_DIR/mansu-build/SKILL.md"
require_terms "$ROOT_DIR/mansu-build/agents/openai.yaml" 'build OpenAI prompt lost next-route contract' 'next route' 'mansu-3build' 'mansu-4verify' 'mansu-debug'
require_terms "$ROOT_DIR/mansu-build/agents/openai.yaml" 'build OpenAI prompt lost active Phase Plan and roadmap read preflight' 'read' 'active Phase Plan' 'Project Phase Roadmap'

grep -q 'QA evidence' "$ROOT_DIR/mansu-verify/SKILL.md"
grep -q 'Verify proves behavior' "$ROOT_DIR/mansu-verify/SKILL.md"
grep -q 'Use BDD-style evidence' "$ROOT_DIR/mansu-verify/SKILL.md"
grep -q 'Given/When/Then' "$ROOT_DIR/mansu-verify/SKILL.md"
grep -q 'observable pass/fail result' "$ROOT_DIR/mansu-verify/SKILL.md"
grep -q 'If verification passes, run .*`mansu-5review` next by default' "$ROOT_DIR/mansu-verify/SKILL.md"
require_terms "$ROOT_DIR/mansu-verify/agents/openai.yaml" 'verify OpenAI prompt lost review handoff contract' 'review' 'run' 'next step'

grep -q 'Review judges quality' "$ROOT_DIR/mansu-review/SKILL.md"
grep -q 'not QA' "$ROOT_DIR/mansu-review/SKILL.md"
grep -q 'Mansu Review does not invent refactoring judgment by itself' "$ROOT_DIR/mansu-review/SKILL.md"
grep -q 'Use gstack `review` as the primary diff/code review route' "$ROOT_DIR/mansu-review/SKILL.md"
grep -q 'source-skill refactoring/simplification findings' "$ROOT_DIR/mansu-review/SKILL.md"
grep -q 'addyosmani `code-simplification`, or OMO `remove-ai-slops`' "$ROOT_DIR/mansu-review/SKILL.md"
grep -q 'over-complex code, dead code, and AI-slop' "$ROOT_DIR/mansu-review/SKILL.md"
grep -q 'If Review passes and Verify evidence exists, tell the user the next step is' "$ROOT_DIR/mansu-review/SKILL.md"
require_terms "$ROOT_DIR/mansu-review/agents/openai.yaml" 'review OpenAI prompt lost ship handoff contract' 'review passes' 'mansu-6ship'
require_terms "$ROOT_DIR/mansu-review/agents/openai.yaml" 'review OpenAI prompt lost source review route contract' 'source review' 'gstack review'

grep -q 'mansu-debug-rootcause' "$ROOT_DIR/mansu-debug/SKILL.md"
grep -q 'root cause' "$ROOT_DIR/mansu-debug/SKILL.md"

grep -q 'mansu-ship-release' "$ROOT_DIR/mansu-ship/SKILL.md"
grep -q 'ship/hold' "$ROOT_DIR/mansu-ship/SKILL.md"
grep -q 'End the response with a clear ship status' "$ROOT_DIR/mansu-ship/SKILL.md"
require_terms "$ROOT_DIR/mansu-ship/agents/openai.yaml" 'ship OpenAI prompt lost final ship/hold status contract' 'ship/hold' 'status'

grep -q 'Generated planning state boundary' "$ROOT_DIR/mansu-operating-model/SKILL.md"
grep -Fq '`.omo/*` is generated planning and evidence state' "$ROOT_DIR/mansu-operating-model/SKILL.md"
grep -q 'not a normal runtime source of truth' "$ROOT_DIR/mansu-operating-model/SKILL.md"
grep -q 'Treat older generated plans as archive after promotion' "$ROOT_DIR/mansu-operating-model/SKILL.md"
grep -Fq '`.omo/plans/*.md` may still be a concrete plan path' "$ROOT_DIR/mansu-operating-model/SKILL.md"
grep -Fq '`.omo/*` is generated planning/evidence state' "$ROOT_DIR/mansu-operating-model/references/DOCUMENT_CREATION_ORDER.md"
grep -q 'archive it in place unless the user explicitly approves deletion' "$ROOT_DIR/mansu-operating-model/references/DOCUMENT_CREATION_ORDER.md"
grep -Fq '`.omo/plans/*.md` remains allowed as an explicit active plan location' "$ROOT_DIR/mansu-operating-model/references/DOCUMENT_CREATION_ORDER.md"
