---
name: mansu-tdd-total
description: Concise dispatcher and planner for Mansu TDD workflows. Use when the user wants `mansu-tdd-total`, a full Mansu TDD planning pass, or a mixed workflow that decides `mansu-tdd-lite` vs `mansu-tdd-strict` per vertical slice. This skill plans, classifies slices, records the per-slice mode decision in `PLAN.md`, and delegates execution details to the existing lite or strict skills instead of duplicating their workflows.
---

# Mansu TDD Total

Use this skill as the default entry point for Mansu TDD work when the right execution mode is not obvious upfront.

## Mansu philosophy

Mansu does not reinvent strong workflows. It plans, separates roles, routes work to
the right source skill, verifies the result, and records what happened.

Use this skill as the TDD-series orchestrator: it owns planning and mode selection,
then delegates execution to `mansu-tdd-lite` or `mansu-tdd-strict`.

## Core promise

- Plan once.
- Critique the plan before implementation with explicit planning roles.
- Synthesize one execution-ready plan before any slice starts.
- Split the work into vertical slices.
- Choose `mansu-tdd-lite` or `mansu-tdd-strict` for each slice.
- Record the per-slice mode decision and rationale in `PLAN.md`.
- Delegate execution details to the selected skill.

## Shared invariants

These rules do not change between `lite` and `strict`:

- Plan properly before implementation.
- Slice by feature, behavior, or user flow.
- Define completion conditions, impact files, risks, and validation path for every slice.
- Run review, QA, checkpoint, and commit for each slice.
- Do not start the next slice until the current slice is fully closed.
- Keep `PLAN.md` current.
- Record completed work in `개발일지.md` or the project worklog.
- Do not use `lite` as permission to lower work quality.

The only core difference is the RED test requirement:

- `strict`: every slice starts with a meaningful failing RED test.
- `lite`: every slice still defines validation before coding, but does not force an artificial RED test.

## When to use

Use this skill when:

- the work may contain both low-risk and high-risk slices
- you are unsure whether every slice needs strict failing-test-first TDD
- the user asks for a full Mansu TDD flow
- a task needs planning and routing before implementation starts

## What this skill does not do

- Do not duplicate executor details from `mansu-tdd-lite` or `mansu-tdd-strict`.
- Do not copy strict gate templates into this skill.
- Do not manually imitate missing strict prerequisites.
- Do not turn every slice into strict mode just because strict mode exists.
- Do not downgrade a risky slice to lite after implementation has started.

## Preflight

Before planning, confirm:

- the repository has `git` and write access
- there is an active plan path, preferably `PLAN.md`
- there is a completed-work log path, preferably `개발일지.md` when the project uses Korean worklogs
- review, QA, checkpoint, and commit gates are available or have clear project equivalents
- `mansu-tdd-lite` is available for lite slices
- `mansu-tdd-strict` prerequisites are available before assigning strict slices

If strict prerequisites are missing, still plan the work, but mark would-be strict slices as blocked instead of pretending to run strict mode.

## Planning gate

For non-trivial work, do not treat planning as a single-agent TODO list.
Planning must pass through explicit roles before slice dispatch.

## Required planning roles

Use these responsibilities before implementation:

- Planner: draft the plan.
  Examples: `Prometheus`, `gstack-autoplan`, `gstack-plan-eng-review`
- Critics: challenge the plan.
  Examples: `Metis`, `Momus`, `gstack-plan-ceo-review`, `gstack-plan-design-review`
- Synthesizer: merge critique into one execution-ready plan and remove contradictions.

If exact agent names or tools are unavailable, map available tools, agents, or
perspectives to these three roles and record the mapping in `PLAN.md`.

## Real critic agent gate

If actual critic sub-agents or external critic tools are started, their outputs become
planning-gate inputs.

- Record the critic names, responsibilities, and status in `PLAN.md`.
- While critics run, continue only non-overlapping discovery or code reading.
- Do not lock the execution-ready plan or start implementation while an expected critic is still pending.
- If a critic fails or times out, record the failure, run an explicit local fallback for that responsibility, and mark any missing high-risk question as `blocked`.
- Reconcile late critic feedback before starting the next slice, or immediately if it reveals data-contract, security, architecture, or UX-risk issues.

Do not proceed to implementation until the execution-ready plan and slice table are visible.
Once they are visible, continue automatically unless the user explicitly requested
a human approval gate, a risky action requires approval, or a plan gap remains unresolved.

## Execution-ready plan requirements

The execution-ready plan must include:

- goal and user value
- non-goals and constraints
- domain language and DDD-style responsibility boundaries
- architecture and module boundaries
- source skills or tools to use
- risks and mitigation
- test and validation strategy
- documentation and worklog targets
- execution readiness status

If any of these are unknown, mark the gap explicitly instead of pretending the plan is complete.

## Planning loop

1. Clarify the goal, user value, constraints, and references.
2. Map the Planner, Critics, and Synthesizer roles.
3. Draft the implementation plan through the Planner role.
4. Critique the plan through the Critics role.
5. If real critic agents were started, wait for them or record a real failure/timeout fallback.
6. Synthesize the execution-ready plan, including resolved tradeoffs and remaining gaps.
7. Split the work into vertical slices by feature, behavior, or user flow.
8. Assign each slice a mode: `lite`, `strict`, or `blocked`.
9. Record the role mapping, critic status, execution-ready plan, slice table, and mode decisions in `PLAN.md`.
10. Start execution automatically after the plan gate passes; pause only for explicit approval gates, risky actions, or unresolved blockers.

## Dispatch rules

Choose `mansu-tdd-strict` when a slice includes:

- data model, persistence, or migration changes
- auth, permission, security, payment, or privacy risk
- API contract or cross-module behavior changes
- complex state management
- high regression risk or repeated bug history
- a meaningful failing RED test that would improve confidence

Choose `mansu-tdd-lite` when a slice includes:

- UI polish or presentational work
- documentation, README, or copy changes
- configuration, scaffolding, or repository housekeeping
- small contained refactors
- manual, visual, browser, type, or focused validation that is more natural than a forced RED test

Prefer mixed routing when a single feature has different risk levels by slice.

## Slice table

Each planned slice should include:

- slice name
- user-visible or behavior-visible outcome
- completion conditions
- impact files
- risks
- validation path
- mode: `lite`, `strict`, or `blocked`
- why this mode
- delegated skill: `mansu-tdd-lite` or `mansu-tdd-strict`
- close criteria
- worklog note

## Execution handoff

For slices marked `lite`, execute with `mansu-tdd-lite`.

For slices marked `strict`, execute with `mansu-tdd-strict`.

For slices marked `blocked`, stop before implementation and report the missing prerequisite or unresolved plan decision.

## Sequential slice gate

Execute slices in order unless the user explicitly approves a different dependency-free order.

A slice is fully closed only when:

- its delegated skill's close criteria are satisfied
- validation is complete
- review, QA, and checkpoint are complete
- `PLAN.md` reflects the current status and next starting point
- `개발일지.md` or the project worklog is updated when used
- the slice is committed, or the no-commit reason is recorded

Do not start slice N+1 while slice N is open, ambiguous, blocked without a recorded decision,
or missing review/QA/checkpoint evidence.

## Mode-change rules

- Escalate from lite to strict if validation reveals hidden behavior risk, architecture churn, or a natural failing RED test.
- Downgrade from strict to lite only before implementation starts and only with a written rationale in `PLAN.md`.
- If a slice expands beyond its completion conditions, stop and re-plan that slice before continuing.
- If the plan keeps changing during execution, return to this skill and re-dispatch the remaining slices.

## Closeout

When all slices are complete:

- run the project-level build/test/type/lint suite that is relevant to the repo
- run final QA or browser verification when user-visible behavior changed
- keep only active follow-up items in `PLAN.md`
- move completed multi-slice detail into `개발일지.md` or the project worklog
- include the final slice modes and validation results in the worklog
- create the final commit after final validation, or record why a commit was intentionally deferred
- report what was verified, what could not be verified, remaining risks, and any follow-up checks needed
- avoid leaving the same completed work fully expanded in both `PLAN.md` and `개발일지.md`
