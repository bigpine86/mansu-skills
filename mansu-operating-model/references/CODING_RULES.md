# CODING_RULES.md

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

Authority order:
1. explicit user instruction
2. this `CODING_RULES.md`
3. this project's `AGENTS.md`
4. Mansu canonical doctrine
5. generic examples or historical habits

## Runtime Model

Default coding runtime for this project:

- `tmux` for persistent project-scoped session management
- `OpenCode` / `oMo` as the execution worker layer
- `GPT` as the primary implementation and reasoning engine
- `Gemini` as the support engine for visual, multimodal, writing, and alternative exploration work

Default interpretation:
- GPT leads implementation, debugging, and architectural reasoning
- Gemini supports UI direction, screenshots, multimodal analysis, documentation polish, and creative option generation
- work should be routed by task character, not by model novelty

This project does not treat one agent pass as a sufficient delivery workflow for non-trivial work.

## Session Model

Use one named `tmux` session per project or worktree.

Preferred window layout:
1. `plan`
2. `build`
3. `review`
4. `qa`
5. `server`
6. `shell`

Window responsibilities:
- `plan`: task classification, scope, plan drafting, approval preparation
- `build`: approved slice execution only
- `review`: correctness, diff, coupling, and risk review
- `qa`: runtime validation and user/system-perspective verification
- `server`: app runtime, logs, watch processes, local serving
- `shell`: supporting commands and repo utilities

Rules:
- keep one approved slice per builder flow
- do not run conflicting implementations in parallel on the same files
- do not use the `qa` window for implementation work
- do not treat the `review` window as a continuation of `build`
- keep long-running context alive rather than restarting from scratch every turn
- `plan` and `build` stay separate to preserve planning/execution separation
- `review` and `qa` stay separate to preserve gate integrity

## Work Classification in This Project

Classification determines ceremony, approval burden, and validation depth.

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
- approval before build
- vertical slicing
- milestone control
- distinct review
- distinct QA
- explicit ship-or-hold judgment

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

## Strict Mode Rule

Strict mode is a real delivery contract in this project.

If work is declared strict:
- required gates must actually run
- review and QA must remain distinct
- missing prerequisites block strict execution
- fallback options may be proposed only if labeled fallback

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
