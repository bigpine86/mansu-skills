# CODING_RULES.md

## Contents

- Purpose and Authority
- Runtime Model
- Session Model
- Work Classification in This Project
- Validation Commands
- Gate Mapping
- Strict Mode Rule
- Ship Readiness Rule
- Learning Closeout
- Dangerous Surfaces
- Maintenance Rule

## Purpose and Authority

This document is the local operating manual for coding work in this project.

It applies the Mansu operating doctrine to this repository's actual runtime, session layout, command flow, validation practice, and ship-readiness checks.

Use this file to answer project-local questions such as:
- which runtime to use
- how sessions are laid out
- how work is classified here
- which commands verify correctness
- what counts as ship-ready in this repo
- which surfaces are dangerous

If this file conflicts with generic examples elsewhere, follow this file for project-local execution.

Authority works by subject:
- explicit user instruction controls the requested outcome and immediate constraints unless unsafe or impossible
- this `CODING_RULES.md` controls project-specific commands, paths, runtimes, validation commands, and dangerous surfaces
- this project's `AGENTS.md` controls local routing and entry instructions
- Mansu canonical doctrine controls universal workflow gates, role separation, strictness, evidence, and ship-readiness rules

Project-local rules may specialize the doctrine. They must not weaken it.
If this file appears to contradict a non-negotiable Mansu doctrine rule, report the conflict and use the safer interpretation.

## Runtime Model

Fill in the actual runtime target for this project:

- runtime target: `<Hermes | OpenCode | Codex | Claude Code | other>`
- session manager: `<tmux | terminal tabs | IDE workspace | CI runner | none>`
- execution worker layer: `<OpenCode | Codex | Claude Code | gstack | other>`
- primary implementation model/tool: `<fill in>`
- support model/tooling: `<fill in>`

Example only:
- Hermes + tmux + OpenCode may use `tmux` for persistent sessions and OpenCode as the worker layer.
- A Codex-only project may use the current Codex workspace and omit tmux entirely.

Interpretation rule:
- work should be routed by task character, not by model novelty or runtime fashion

This project does not treat one agent pass as a sufficient delivery workflow for non-trivial work.

## Session Model

Describe the active session layout for this project.

If using `tmux`, prefer one named session per project or worktree.
If not using `tmux`, map the same responsibilities to tabs, workspaces, or explicit workflow stages.

Suggested responsibility layout:
1. `plan`
2. `build`
3. `review`
4. `qa`
5. `server`
6. `shell`

Window responsibilities:
- `plan`: task classification, scope, plan drafting, execution-readiness preparation
- `build`: execution-ready slice execution only
- `review`: correctness, diff, coupling, and risk review
- `qa`: runtime validation and user/system-perspective verification
- `server`: app runtime, logs, watch processes, local serving
- `shell`: supporting commands and repo utilities

Rules:
- keep one execution-ready slice per builder flow
- do not run conflicting implementations in parallel on the same files
- do not use the `qa` window for implementation work
- do not treat the `review` window as a continuation of `build`
- keep long-running context alive rather than restarting from scratch every turn
- `plan` and `build` stay separate to preserve planning/execution separation
- `review` and `qa` stay separate to preserve gate integrity

## Work Classification in This Project

Classification determines ceremony, planning gate burden, and validation depth.

### Quick

Use quick only when all of the following are true:
- the change is narrow
- the approach is obvious
- rollback is simple
- no meaningful architecture judgment is required
- no meaningful user-flow risk is introduced
- validation is direct and cheap

Quick still requires:
- clear statement of what changed
- direct validation
- honest reporting of uncertainty

Quick does not allow silent scope growth.

### Standard

Use standard when any of the following are true:
- multiple files are likely to change
- the task changes behavior in a meaningful way
- the task requires module-level reasoning
- debugging requires investigation rather than an obvious fix
- tests or validation meaningfully expand
- product intent requires interpretation

Standard requires:
- explicit plan
- clear change surface
- implementation with scope discipline
- distinct review
- validation evidence before completion claim

### Heavy

Use heavy when any of the following are true:
- architecture changes materially
- shared core behavior changes
- release risk is high
- user-facing failure cost is high
- auth, permissions, billing, deployment, schema, or security surfaces are involved
- the task is broad enough to require checkpointing or staged verification

Heavy requires:
- plan
- critique
- execution-ready plan gate before build
- vertical slicing
- milestone control
- distinct review
- distinct QA
- commit or explicit no-commit reason
- worklog update
- explicit ship-or-hold judgment

Once a plan is execution-ready, continue automatically unless the user explicitly requested a human approval gate, the next action is risky, or a blocker remains unresolved.

If classification is unclear, do not default downward. Escalate to the safer class.

## Validation Commands

This section must contain real commands for the current project.

An active project is not operationally ready until this section contains runnable commands.

Document at least:
- environment bootstrap
- unit test command
- integration or end-to-end test command if applicable
- lint command
- typecheck command if applicable
- app run command
- build command if applicable

Template:
- bootstrap: `...`
- unit tests: `...`
- integration tests: `...`
- lint: `...`
- typecheck: `...`
- run app: `...`
- production build: `...`

Do not leave this section vague once the project is active.

## Gate Mapping

This section maps Mansu's universal gates to this project's actual tools.

An equivalent gate is valid only when it is:
- separately invoked from implementation
- distinguishable from the builder's self-summary
- able to produce status and evidence
- recorded in `PLAN.md`, the checkpoint, or the worklog

Template:
- review gate: `<tool/skill/command/manual protocol>` -> evidence output: `<where status is recorded>`
- QA gate: `<tool/skill/command/manual protocol>` -> evidence output: `<where status is recorded>`
- checkpoint gate: `<tool/skill/command/manual protocol>` -> evidence output: `<where next state is recorded>`
- health gate: `<tool/skill/command/manual protocol>` -> evidence output: `<where result is recorded>`
- ship gate: `<tool/skill/command/manual protocol>` -> evidence output: `<where ship/hold decision is recorded>`
- learning gate: `<tool/skill/command/manual protocol>` -> evidence output: `<where reusable lessons go>`

Do not call a casual paragraph a review, QA, or checkpoint gate. If a gate cannot
be separately invoked and evidenced, mark it missing and choose a fallback mode.

## Strict Mode Rule

Strict mode is a real delivery contract in this project.

If work is declared strict:
- required gates must actually run
- review and QA must remain distinct
- missing prerequisites block strict execution
- fallback options may be proposed only if labeled fallback
- single-runtime execution is allowed only when each gate is separately invoked,
  evidenced, and distinguishable from the builder's implementation summary

Do not call work strict when:
- a required gate was skipped
- QA was replaced by casual confidence
- missing prerequisites were hand-waved
- review was reduced to a builder self-summary

## Ship Readiness Rule

A task must not be called ship-ready unless:
- agreed scope is complete
- review status is known
- validation evidence exists
- QA status is known where applicable
- unresolved risks are named
- the final claim matches actual evidence

Possible terminal states:
- **implemented**
- **reviewed**
- **QA-verified**
- **ship-ready**
- **held**

Use the most honest state.

Merged and shipped are not assumed to be the same state in this project.

Do not upgrade the state for convenience.

## Learning Closeout

Before ending standard or heavy work, decide where each durable lesson belongs.

Use this router:
- worklog: what happened, decisions, actual flow, remaining risk
- `CODING_RULES.md`: repeated project rule, command, danger, or gate mapping
- ADR: durable architecture or technology tradeoff
- tests: regression, invariant, contract, or browser flow that should not break again
- docs/release notes: user-facing behavior, setup, migration, rollback, or known limitation
- source catalog: reusable source-skill routing insight

Do not leave reusable learning only in chat. If no durable lesson exists, record
that no learning artifact was needed.

## Dangerous Surfaces

This section must name project-specific high-risk areas.

If this project touches authentication, billing, deletion, irreversible writes, deployment, or external side effects, those surfaces must be named here.

Template:
- `surface-name`: why it is dangerous, what extra caution is required
- `surface-name`: why it is dangerous, what must be checked before ship

Do not keep this section generic once the project matures.

## Maintenance Rule

This file is part of the operating system of the project.

Update it when:
- the runtime model changes
- the validation commands change
- dangerous surfaces become clearer
- classification thresholds need refinement
- repeated mistakes reveal a missing rule

Do not let this file drift behind actual working practice.
If the real workflow and the documented workflow diverge, fix the document or fix the workflow.
