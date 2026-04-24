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
- Critique the plan before implementation.
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

## Planning loop

1. Clarify the goal, user value, constraints, and references.
2. Draft the implementation plan.
   Examples: `Prometheus`, `gstack-autoplan`, `gstack-plan-eng-review`
3. Critique the plan.
   Examples: `Metis`, `Momus`, `gstack-plan-ceo-review`, `gstack-plan-design-review`
4. Synthesize the accepted plan.
5. Split the work into vertical slices by feature, behavior, or user flow.
6. Assign each slice a mode: `lite`, `strict`, or `blocked`.
7. Record the decision in `PLAN.md`.
8. Ask for approval before implementation starts when the scope is non-trivial.

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

## Mode-change rules

- Escalate from lite to strict if validation reveals hidden behavior risk, architecture churn, or a natural failing RED test.
- Downgrade from strict to lite only before implementation starts and only with a written rationale in `PLAN.md`.
- If a slice expands beyond its completion conditions, stop and re-plan that slice before continuing.
- If the plan keeps changing during execution, return to this skill and re-dispatch the remaining slices.

## Closeout

When all slices are complete:

- keep only active follow-up items in `PLAN.md`
- move completed multi-slice detail into `개발일지.md` or the project worklog
- include the final slice modes and validation results in the worklog
- avoid leaving the same completed work fully expanded in both `PLAN.md` and `개발일지.md`
