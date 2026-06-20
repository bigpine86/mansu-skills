#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FILE="$ROOT_DIR/mansu-tdd-total/SKILL.md"
OPENAI_YAML="$ROOT_DIR/mansu-tdd-total/agents/openai.yaml"
PLAN="$ROOT_DIR/mansu-plan/SKILL.md"
PLAN_OPENAI="$ROOT_DIR/mansu-plan/agents/openai.yaml"

fail() {
  echo "$1" >&2
  exit 1
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

forbid_default_ulw_plan_route() {
  local file="$1"
  local message="$2"
  if perl -0ne 'exit(/(?:Mansu\s+Plan|Quick\s+Plan|Standard\s+Plan|Heavy\s+Plan|Plan)[^\n.]{0,200}(?:default[^\n.]{0,80}`ulw-plan`|`ulw-plan`[^\n.]{0,80}default)/i ? 0 : 1)' "$file"; then
    fail "$message"
  fi
}

test -f "$FILE"
test -f "$OPENAI_YAML"
test -f "$PLAN"
test -f "$PLAN_OPENAI"

grep -q '^## Core promise$' "$FILE"
grep -q '^## Shared invariants$' "$FILE"
grep -q '^## What this skill does not do$' "$FILE"
grep -q '^## Preflight$' "$FILE"
grep -q '^## Planning gate$' "$FILE"
grep -q '^## Required planning roles$' "$FILE"
grep -q '^## Real critic agent gate$' "$FILE"
grep -q '^## Oh My execution-mode mapping$' "$FILE"
grep -q '^## Gstack gate mapping$' "$FILE"
grep -q '^## Execution-ready plan requirements$' "$FILE"
grep -q '^## Planning loop$' "$FILE"
grep -q '^## Dispatch rules$' "$FILE"
grep -q '^## Slice table$' "$FILE"
grep -q '^## Execution handoff$' "$FILE"
grep -q '^## Sequential slice gate$' "$FILE"
grep -q '^## No-skip completion checklist$' "$FILE"
grep -q '^## Mode-change rules$' "$FILE"
grep -q '^## Closeout$' "$FILE"

grep -q 'mansu-tdd-lite' "$FILE"
grep -q 'mansu-tdd-strict' "$FILE"
grep -q 'PLAN.md' "$FILE"
grep -q '.omo/plans/\*.md' "$FILE"
grep -q 'user-provided path first' "$FILE"
grep -q 'role/marker discovery' "$FILE"
require_terms "$OPENAI_YAML" 'tdd-total prompt lost active plan discovery contract' 'active Phase Plan' 'role/marker discovery'
require_terms "$PLAN" 'mansu-plan lost plan tier contract' 'Quick Plan' 'Standard Plan' 'Heavy Plan'
require_terms "$PLAN_OPENAI" 'mansu-plan prompt lost plan tier contract' 'Quick Plan' 'Standard Plan' 'Heavy Plan'
forbid_default_ulw_plan_route "$PLAN" 'mansu-plan reintroduced ulw-plan as a default Plan route'
forbid_default_ulw_plan_route "$PLAN_OPENAI" 'mansu-plan prompt reintroduced ulw-plan as a default Plan route'
grep -q 'Project Phase Roadmap' "$FILE"
grep -q 'active Phase Plan' "$FILE"
grep -q 'slice table' "$FILE"
require_contains "$FILE" 'active phase' 'tdd-total must identify active phase contract language'
require_contains "$FILE" 'Project Phase Roadmap' 'tdd-total must name Project Phase Roadmap contract'
grep -q 'Route back to public `mansu-1define` / `mansu-2plan`' "$FILE"
! grep -q 'Route back to `mansu-project-start`' "$FILE"
require_contains "$FILE" 'Project Phase Roadmap alone' 'tdd-total must reject roadmap-only execution'
require_contains "$FILE" 'marked active Phase Plan' 'tdd-total must allow marked active Phase Plan discovery'
require_contains "$FILE" 'execution-ready slice table' 'tdd-total must require execution-ready slice table'
require_terms "$OPENAI_YAML" 'tdd-total prompt lost explicit active-plan path priority' 'active Phase Plan' 'explicit' 'user-provided path'
require_terms "$OPENAI_YAML" 'tdd-total prompt lost OMO plan path discovery' '.omo/plans/*.md'
require_terms "$OPENAI_YAML" 'tdd-total prompt lost non-PLAN.md handling' 'PLAN.md' 'candidate' 'not a requirement' 'filename differs'
require_terms "$OPENAI_YAML" 'tdd-total prompt lost phase hierarchy contract' 'Project Phase Roadmap' 'active Phase Plan' 'slice table'
require_terms "$OPENAI_YAML" 'tdd-total prompt lost roadmap-only rejection contract' 'Project Phase Roadmap alone' 'route back' 'mansu-1define' 'mansu-2plan'
! grep -Fq 'route back to $mansu-project-start instead of implementing' "$OPENAI_YAML"
grep -q '개발일지.md' "$FILE"
grep -q 'per-slice mode' "$FILE"
grep -q 'End-to-end dispatcher, planner, and completion orchestrator' "$FILE"
grep -q 'Execute every unblocked slice in order through the selected skill' "$FILE"
grep -q 'Persist in a Ralph-style loop until all slices are closed' "$FILE"
grep -q 'Run final project-level verification, worklog update, and commit accounting' "$FILE"
grep -q 'remains responsible for making sure the overall workflow actually finishes' "$FILE"
grep -q 'clear execution modes used by this workflow' "$FILE"
grep -q 'persistence loop: `ralph`' "$FILE"
grep -q 'strict TDD habit: `tdd`' "$FILE"
grep -q 'Use `ralph` as the persistence rule for the whole workflow' "$FILE"
grep -q 'Use `tdd` only inside slices routed to `mansu-tdd-strict`' "$FILE"
grep -q 'Do not use parallel Oh My modes such as `ultrawork` or `ultrapilot`' "$FILE"
grep -q "Mansu's default implementation gates come from the gstack family" "$FILE"
grep -q 'Use these core gstack skills by name when they are installed' "$FILE"
grep -q 'review gate: `gstack-review`' "$FILE"
grep -q 'QA evidence without fixes: `gstack-qa-only` or `gstack-browse`' "$FILE"
grep -q 'QA test-fix-verify loop when fixes are approved: `gstack-qa`' "$FILE"
grep -q 'checkpoint/state handoff: `gstack-context-save` and `gstack-context-restore`' "$FILE"
grep -q '`gstack-checkpoint` only when the installed runtime still exposes it' "$FILE"
grep -q 'health gate: `gstack-health`' "$FILE"
grep -q '`gstack-health` is mandatory at final closeout' "$FILE"
grep -q 'health is deferred to' "$FILE"
grep -q 'Optional escalation gates:' "$FILE"
grep -q 'use `gstack-cso` only when the slice changes auth' "$FILE"
grep -q 'use `gstack-benchmark` only when the slice can affect loading' "$FILE"
grep -q 'Do not run `gstack-ship` from this TDD loop by default' "$FILE"
grep -q 'map the concrete gstack' "$FILE"
grep -q 'A builder saying "I reviewed it" is not enough' "$FILE"
grep -q 'Do not duplicate executor details' "$FILE"
grep -q 'Escalate from lite to strict' "$FILE"
grep -q 'Do not use `lite` as permission to lower work quality' "$FILE"
grep -q 'Treat missing review, QA, checkpoint, worklog, or commit evidence as an open slice' "$FILE"
grep -q 'The only core difference is the RED test requirement' "$FILE"
grep -q 'Do not start the next slice until the current slice is fully closed' "$FILE"
grep -q 'Commit policy:' "$FILE"
grep -q 'Default to per-slice commits during implementation' "$FILE"
grep -q 'Strict slices treat a slice commit as part of the close gate' "$FILE"
grep -q 'mark the slice `commit-deferred` instead of fully closed' "$FILE"
grep -q 'Use a final release/docs commit only for final docs' "$FILE"
grep -q 'record the no-commit reason' "$FILE"
grep -q 'Execute slices in order unless the user explicitly approves a different dependency-free order' "$FILE"
grep -q 'A slice is fully closed only when' "$FILE"
grep -q 'Do not start slice N+1 while slice N is open' "$FILE"
grep -q 'do not treat planning as a single-agent TODO list' "$FILE"
grep -q 'Planner: draft the plan' "$FILE"
grep -q 'Critics: challenge the plan' "$FILE"
grep -q 'Synthesizer: merge critique into one execution-ready plan' "$FILE"
grep -q 'runtime-neutral orchestration' "$FILE"
grep -q 'current runtime session' "$FILE"
grep -q 'runtime-backed helper' "$FILE"
grep -q 'When actual multi-agent or helper-session critique is available' "$FILE"
grep -q 'Available safely means the host supports it' "$FILE"
grep -q 'Real critic attempt/evidence is required for any multi-slice' "$FILE"
grep -q 'single low-risk lite slice' "$FILE"
grep -q 'when the runtime can provide critics safely. Local role separation is only a' "$FILE"
grep -q 'reason and fallback critique when using the fallback' "$FILE"
grep -q 'real critic agents, helper sessions, or external critique tools' "$FILE"
grep -q 'historical agent names or tools are unavailable' "$FILE"
grep -q 'strict prerequisites are unavailable in the current runtime' "$FILE"
grep -q 'record the mapping in the active Phase Plan' "$FILE"
grep -q 'PLAN.md` is only one common' "$FILE"
grep -q 'Do not lock the execution-ready plan or start implementation while an expected critic is still pending' "$FILE"
grep -q 'Do not declare a critic unavailable merely because it is slower' "$FILE"
grep -q 'If a critic fails or times out' "$FILE"
grep -q 'Do not proceed to implementation until the execution-ready plan and slice table are visible' "$FILE"
grep -q 'continue automatically unless the user explicitly requested' "$FILE"
grep -q 'domain language and DDD-style responsibility boundaries' "$FILE"
grep -q 'architecture and module boundaries' "$FILE"
grep -q 'pre-refactor and file/module split plan' "$FILE"
grep -q 'source skills or tools to use' "$FILE"
grep -q 'Oh My execution-mode mapping: `ralph` for persistence and `tdd` for strict slices' "$FILE"
grep -q 'gstack gate mapping: concrete names for `gstack-review`, `gstack-qa-only`/`gstack-browse`, `gstack-qa`, `gstack-context-save` and `gstack-context-restore`, and `gstack-health`, or their current-runtime equivalents' "$FILE"
grep -q 'code construction router' "$FILE"
grep -q 'detailed coding-flow step' "$FILE"
grep -q '기획`, `요구사항 정리`, `스펙 작성`' "$FILE"
grep -q '`수정/개선`, `배포/공유`' "$FILE"
grep -q 'source skill to read' "$FILE"
grep -q 'CODE_CONSTRUCTION_ORDER.md' "$FILE"
grep -q 'construction router notes' "$FILE"
grep -q 'execution readiness status' "$FILE"
grep -q 'must be separately invoked, produce' "$FILE"
grep -q 'upstream source-of-truth artifacts and paths' "$FILE"
grep -q 'locked decisions and open-question carryover' "$FILE"
grep -q 'upstream artifact or decision this slice implements' "$FILE"
grep -q 'Oh My execution mode: `ralph` persistence plus `tdd` only when strict RED/GREEN/REFACTOR is selected' "$FILE"
grep -q 'gstack gate path: which named gstack skills or current-runtime equivalents close this slice' "$FILE"
grep -q 'do not accept builder self-review as gate evidence' "$FILE"
grep -q 'gstack-review -> gstack-qa-only or gstack-qa -> gstack-context-save -> commit' "$FILE"
grep -q 'For slices marked `blocked`, do not implement that slice' "$FILE"
grep -q 'Continue to later' "$FILE"
grep -q 'independent unblocked slices only when dependency order' "$FILE"
grep -q 'Do not claim the Mansu TDD Total workflow is complete until this checklist is' "$FILE"
grep -q '\[NS-PLAN-ROLES\]' "$FILE"
grep -q '\[NS-REAL-CRITICS\]' "$FILE"
grep -q '\[NS-CRITIC-FALLBACK\]' "$FILE"
grep -q '\[NS-PLAN-SLICES\]' "$FILE"
grep -q '\[NS-SLICE-CARDS\]' "$FILE"
grep -q '\[NS-SLICE-STATUS\]' "$FILE"
grep -q '\[NS-VALIDATION\]' "$FILE"
grep -q '\[NS-GATES\]' "$FILE"
grep -q '\[NS-STRICT-COMMIT\]' "$FILE"
grep -q '\[NS-GATE-EXCEPTIONS\]' "$FILE"
grep -q '\[NS-NEXT-POINT\]' "$FILE"
grep -q '\[NS-WORKLOG\]' "$FILE"
grep -q '\[NS-FINAL-BUILD\]' "$FILE"
grep -q '\[NS-FINAL-QA\]' "$FILE"
grep -q '\[NS-FINAL-REVIEW\]' "$FILE"
grep -q '\[NS-FINAL-HEALTH\]' "$FILE"
grep -q '\[NS-RISKS\]' "$FILE"
grep -q 'The active Phase Plan contains the Planner / Critics / Synthesizer role mapping' "$FILE"
grep -q 'If real critic agents were not used for non-trivial work, the fallback reason' "$FILE"
grep -q 'Every slice has mode, rationale, validation path, Oh My execution mode, gstack' "$FILE"
grep -q 'Every closed slice has review, QA, checkpoint/state handoff, and commit status' "$FILE"
grep -q 'Strict slices have per-slice commit evidence' "$FILE"
grep -q 'recorded as `commit-deferred` and resolved during final commit accounting' "$FILE"
grep -q 'Every skipped or replaced gate has a reason and an equivalent evidence path' "$FILE"
grep -q 'Final project-level build/test/type/lint or the project equivalent has run' "$FILE"
grep -q 'Final QA/browser verification has run when user-visible behavior changed' "$FILE"
grep -q 'Final `gstack-health` or equivalent project health check has run when available' "$FILE"
grep -q 'The final response must include a compact checklist summary' "$FILE"
grep -q 'If any required' "$FILE"
grep -q 'item is missing, say the workflow is not fully complete yet' "$FILE"
grep -q 'Keep the `NS-\*` identifiers stable' "$FILE"
grep -q 'Map the Planner, Critics, and Synthesizer roles' "$FILE"
grep -q 'wait for them or record a real failure/timeout fallback' "$FILE"
grep -q 'Record the role mapping, critic status, execution-ready plan' "$FILE"
grep -q 'Start execution automatically after the plan gate passes' "$FILE"
grep -q 'Continue the sequential slice loop until every unblocked slice is closed' "$FILE"
grep -q 'Run final closeout verification and commit accounting' "$FILE"
grep -q 'pre-refactor notes' "$FILE"
grep -q 'After each delegated slice returns' "$FILE"
grep -q 'Ralph-style persistence means retrying or re-routing reasonable failures' "$FILE"
grep -q 'run the project-level build/test/type/lint suite' "$FILE"
grep -q 'run final QA or browser verification' "$FILE"
grep -q 'run a final diff review or equivalent project review gate' "$FILE"
grep -q 'create a final release/docs commit only when final docs' "$FILE"
grep -q 'if per-slice commits were skipped or deferred, create the final implementation commit' "$FILE"
grep -q 'what could not be verified, remaining risks, and any follow-up checks needed' "$FILE"

require_terms "$OPENAI_YAML" 'tdd-total OpenAI metadata lost orchestration role' 'short_description' 'TDD' 'plans' 'slices' 'verifies'
require_terms "$OPENAI_YAML" 'tdd-total OpenAI prompt lost end-to-end invocation' 'default_prompt' '$mansu-tdd-total' 'end to end'
require_terms "$OPENAI_YAML" 'tdd-total OpenAI prompt lost critic gate contract' 'critic' 'non-trivial' 'safely available'
require_terms "$OPENAI_YAML" 'tdd-total OpenAI prompt lost mode mapping contract' 'ralph' 'tdd' 'gstack'
require_terms "$OPENAI_YAML" 'tdd-total OpenAI prompt lost core gstack gate contract' 'gstack-review' 'gstack-qa-only' 'gstack-browse' 'gstack-qa' 'gstack-context-save' 'gstack-context-restore' 'gstack-health'
require_terms "$OPENAI_YAML" 'tdd-total OpenAI prompt lost strict prerequisite contract' 'strict-prerequisite-missing' 'blocked' 'downgrading'
require_terms "$OPENAI_YAML" 'tdd-total OpenAI prompt lost sequential slice gate contract' 'unblocked slice' 'sequential' 'mapped gates' 'commit'
require_terms "$OPENAI_YAML" 'tdd-total OpenAI prompt lost closeout evidence contract' 'project-level verification' 'final commit accounting' 'remaining risks' 'follow-up checks' 'no-skip'
require_terms "$OPENAI_YAML" 'tdd-total OpenAI prompt lost incomplete-evidence guard' 'completion' 'required evidence' 'missing'

if grep -q 'Hermes/OpenCode orchestration' "$FILE" || grep -q 'Hermes + OpenCode session' "$FILE"; then
  echo "mansu-tdd-total should stay runtime-neutral" >&2
  exit 1
fi

if grep -q '^### RED$' "$FILE" || grep -q '^### GREEN$' "$FILE" || grep -q '^### REFACTOR$' "$FILE"; then
  echo "mansu-tdd-total should not copy strict executor internals" >&2
  exit 1
fi

echo "mansu-tdd-total structure OK"
