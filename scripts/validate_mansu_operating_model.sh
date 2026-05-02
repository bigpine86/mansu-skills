#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MODEL="$ROOT_DIR/mansu-operating-model/SKILL.md"
OPENAI_YAML="$ROOT_DIR/mansu-operating-model/agents/openai.yaml"
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
require_file "$AGENTS_TEMPLATE"
require_file "$CODING_RULES_TEMPLATE"

# Core doctrine sections
require_contains "$MODEL" '^## Purpose$' 'operating model missing Purpose section'
require_contains "$MODEL" '^## Core doctrine$' 'operating model missing Core doctrine section'
require_contains "$MODEL" '^## Work classification$' 'operating model missing Work classification section'
require_contains "$MODEL" '^## Delivery spine$' 'operating model missing Delivery spine section'
require_contains "$MODEL" '^## Role model$' 'operating model missing Role model section'
require_contains "$MODEL" '^## Orchestration model$' 'operating model missing Orchestration model section'
require_contains "$MODEL" '^## Strict mode policy$' 'operating model missing Strict mode policy section'
require_contains "$MODEL" '^## Evidence and ship readiness$' 'operating model missing Evidence and ship readiness section'
require_contains "$MODEL" '^## Anti-patterns$' 'operating model missing Anti-patterns section'
require_contains "$MODEL" '^## Document authority$' 'operating model missing Document authority section'

# Required concepts
require_contains "$MODEL" 'non-trivial work starts with planning' 'operating model lost plan-first doctrine'
require_contains "$MODEL" 'Planning and execution are separate phases' 'operating model lost planning/execution separation'
require_contains "$MODEL" 'Code creation is not evidence of correctness' 'operating model lost evidence doctrine'
require_contains "$MODEL" 'strict mode is blocked' 'operating model lost strict blocked rule'
require_contains "$MODEL" 'Route by task character' 'operating model lost task-character routing'
require_contains "$MODEL" 'Merged status and shipped status are not assumed to be equivalent' 'operating model lost merged-vs-shipped distinction'
require_contains "$MODEL" 'continues automatically unless the user explicitly requested a human approval gate' 'operating model lost automatic execution-ready gate rule'
require_contains "$MODEL" 'references/AGENTS.md' 'operating model should point to AGENTS template'
require_contains "$MODEL" 'references/CODING_RULES.md' 'operating model should point to CODING_RULES template'

# Disallowed vague doctrine
forbid_contains "$MODEL" 'strict-ish|best effort strict|if possible review|review if convenient|QA if needed|probably fine|maybe ship-ready' 'operating model contains vague or weakened doctrine'
forbid_contains "$MODEL" 'approval before build' 'operating model reintroduced mandatory approval before build'

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
forbid_contains "$AGENTS_TEMPLATE" 'approval before build' 'AGENTS template reintroduced mandatory approval before build'

# Local rules template essentials
require_contains "$CODING_RULES_TEMPLATE" '^## Validation Commands$' 'CODING_RULES template missing Validation Commands section'
require_contains "$CODING_RULES_TEMPLATE" '^## Dangerous Surfaces$' 'CODING_RULES template missing Dangerous Surfaces section'
require_contains "$CODING_RULES_TEMPLATE" 'An active project is not operationally ready until this section contains runnable commands' 'CODING_RULES template lost runnable-command requirement'
require_contains "$CODING_RULES_TEMPLATE" 'Merged and shipped are not assumed to be the same state in this project' 'CODING_RULES template lost merged-vs-shipped distinction'
require_contains "$CODING_RULES_TEMPLATE" 'execution-ready plan gate before build' 'CODING_RULES template lost execution-ready plan gate'
require_contains "$CODING_RULES_TEMPLATE" 'continue automatically unless the user explicitly requested a human approval gate' 'CODING_RULES template lost automatic execution-ready rule'
forbid_contains "$CODING_RULES_TEMPLATE" 'approval before build' 'CODING_RULES template reintroduced mandatory approval before build'

echo "mansu operating model structure OK"
