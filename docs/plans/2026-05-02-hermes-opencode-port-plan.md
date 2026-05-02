# Mansu Hermes/OpenCode Port Implementation Plan

> **For Hermes:** Use tmux/OpenCode-oriented execution and keep this repo as the canonical source while porting runtime assumptions away from Codex-only defaults.

**Goal:** Make `mansu-skills` practically usable in David's current Hermes + tmux + OpenCode workflow without losing the original Mansu philosophy.

**Architecture:** Keep the orchestration philosophy and skill boundaries, but replace environment-coupled assumptions with a runtime adapter model. Prioritize `mansu-start`, `mansu-tdd-total`, and `mansu-debug-rootcause`, then harden validation so the repo checks real runtime readiness instead of only markdown structure.

**Tech Stack:** Markdown skills, bash validators, git worktree, uv virtualenv, tmux session workflow, Hermes skill conventions.

---

## Current facts confirmed

- Worktree path: `/Users/odeci/Desktop/odeci/project/mansu-skills_260502`
- Branch: `refactor/hermes-opencode-port`
- Virtualenv: `.venv` created with `uv venv .venv`
- tmux session: `dev-mansu-skills_260502`
- Current tool availability confirmed in this environment:
  - `uv`, `git`, `tmux`, `codex`, `opencode`, `newproj`, `deva` available
  - `oa`, `omx`, `omo`, `omc` not currently on PATH in this session

## Main gaps to close

1. `README.md` still uses Codex-first install examples (`$HOME/.codex/skills`).
2. `mansu-start` is host-aware in wording but still adapter-centric and weak on Hermes-specific targets.
3. `mansu-debug-rootcause` still points to hardcoded Codex skill paths and old gstack expectations.
4. `mansu-tdd-strict` references `Oh My XX`, `gstack-review`, `gstack-qa`, and `gstack-checkpoint` as hard prerequisites.
5. Validators mostly prove structure, not runtime readiness or mapping drift.

---

## Phase 1: Runtime mapping baseline

### Task 1: Record the real runtime target matrix
**Objective:** Define the actual target environments Mansu should support first.

**Files:**
- Modify: `README.md`
- Modify: `mansu-start/SKILL.md`
- Create: `docs/runtime-target-matrix.md`

**Steps:**
1. Document primary supported hosts: Hermes, OpenCode, Codex, Claude Code.
2. Record preferred skill-directory strategy for each host.
3. Record adapter/tool expectations as `required`, `optional`, or `unknown`.
4. Define how Mansu should behave when a host is detected but adapter tooling is absent.

**Verification:**
- `runtime-target-matrix.md` exists and names host, skill path, adapter, and fallback behavior.
- `README.md` no longer reads like Codex is the default mental model for all users.

### Task 2: Define compatibility language
**Objective:** Replace ambiguous “Oh My XX” and stale checkpoint wording with explicit compatibility language.

**Files:**
- Modify: `mansu-start/SKILL.md`
- Modify: `mansu-tdd-strict/SKILL.md`
- Modify: `mansu-tdd-strict/references/prerequisites.md`
- Modify: `mansu-tdd-strict/references/bootstrap.md`
- Modify: `mansu-tdd-strict/references/gates.md`

**Steps:**
1. Replace `Oh My XX` umbrella wording with explicit current-runtime terminology.
2. Distinguish `required runtime gate`, `recommended source skill`, and `legacy compatibility note`.
3. Reframe `gstack-checkpoint` references against current checkpoint-family equivalents.

**Verification:**
- Search for `Oh My XX` returns zero intended runtime references.
- Search for `gstack-checkpoint` only returns legacy/compatibility notes where appropriate.

---

## Phase 2: Port the three priority skills

### Task 3: Port `mansu-start`
**Objective:** Make `mansu-start` truly usable from Hermes/OpenCode, not just descriptively host-aware.

**Files:**
- Modify: `mansu-start/SKILL.md`
- Modify: `mansu-start/agents/openai.yaml`
- Modify: `README.md`
- Modify: `PLAN.md`

**Key changes:**
- Add Hermes as a first-class host target.
- Prefer explicit skill target table including `~/.hermes/skills` where appropriate.
- Separate `host detection` from `adapter detection`.
- Add fallback behavior when adapter CLI is missing.
- Tighten required report format to include runtime confidence and skipped checks.

**Verification:**
- `mansu-start` instructions can be followed without assuming Codex.
- `README.md` Quick Start includes Hermes/OpenCode-oriented installation guidance.

### Task 4: Port `mansu-tdd-total`
**Objective:** Keep the planning philosophy but make dispatch language fit the current orchestration model.

**Files:**
- Modify: `mansu-tdd-total/SKILL.md`
- Modify: `mansu-tdd-total/agents/openai.yaml`

**Key changes:**
- Keep Planner/Critics/Synthesizer structure.
- Clarify how these roles map in Hermes + tmux + OpenCode sessions.
- Remove implied dependency on unavailable historical tool names when a generic role mapping is enough.
- Tighten blocked-mode behavior when strict prerequisites are not available.

**Verification:**
- A reader can execute the planning loop in current environment terms.
- The skill still preserves strict-vs-lite slice discipline.

### Task 5: Port `mansu-debug-rootcause`
**Objective:** Preserve the debugging discipline while removing path-coupled Codex assumptions.

**Files:**
- Modify: `mansu-debug-rootcause/SKILL.md`
- Modify: `mansu-debug-rootcause/agents/openai.yaml`

**Key changes:**
- Replace hardcoded `$HOME/.codex/skills/...` path references with host/runtime-aware source references.
- Separate mandatory debug gates from optional source-skill enrichments.
- Keep `no fixes before root cause`, `3 hypotheses stop`, `scope-lock`, and `regression proof` as hard invariants.

**Verification:**
- Search for `$HOME/.codex/skills` in this skill returns zero.
- The route table still names the debug branches clearly, but without pretending unavailable paths are guaranteed.

---

## Phase 3: Validation hardening

### Task 6: Add runtime-readiness validation
**Objective:** Extend validation beyond markdown structure.

**Files:**
- Modify: `scripts/validate_mansu_start.sh`
- Modify: `scripts/validate_mansu_debug_rootcause.sh`
- Modify: `scripts/validate_mansu_tdd_series.sh`
- Modify: `scripts/validate_mansu_skills.sh`
- Create: `scripts/validate_mansu_runtime_readiness.sh`

**Checks to add:**
- host/runtime vocabulary consistency
- absence of stale hardcoded Codex-only paths in targeted skills
- legacy checkpoint references flagged intentionally
- presence of Hermes/OpenCode-compatible installation/report language
- validator output that distinguishes `PASS`, `WARN`, and `LEGACY NOTE`

**Verification:**
- Running `scripts/validate_mansu_skills.sh` still passes.
- New runtime validator produces actionable output on drift.

---

## Phase 4: Worklog and ship prep

### Task 7: Update repo narrative and worklog
**Objective:** Leave a clean trail of why the port exists and what changed.

**Files:**
- Modify: `개발일지.md`
- Modify: `PLAN.md`
- Modify: `README.md`

**Steps:**
1. Add a dated worklog entry for Hermes/OpenCode porting.
2. Trim `PLAN.md` to active follow-up after implementation.
3. Update README positioning from “Codex-era bootstrap” to “multi-host Mansu runtime.”

**Verification:**
- `개발일지.md` records the porting rationale and results.
- `PLAN.md` only contains live follow-up after the slice closes.

---

## Slice order recommendation

1. `mansu-start`
2. `README.md` + runtime target matrix
3. `mansu-debug-rootcause`
4. `mansu-tdd-total`
5. `mansu-tdd-strict` compatibility cleanup
6. validators
7. worklog / follow-up trim

## Definition of done

This port is done when:
- the repo no longer reads as Codex-first in its main entry path
- Hermes/OpenCode usage is explicitly supported in docs and skill logic
- the three priority skills are readable and executable in current runtime terms
- validators catch the most obvious runtime-coupling regressions
- the worktree remains cleanly scoped to documentation/validator/runtime-port changes
