---
name: mansu-tdd-strict
description: Strict orchestration workflow for medium-or-larger feature or refactor work that must be planned, critiqued, implemented, and validated as sequential TDD vertical slices with per-slice review, QA, checkpoint, and single-commit gates. Use when the user explicitly wants `mansu-tdd-strict`, a Ralph-style loop, `ralph:` execution, strict slice-by-slice TDD, Prometheus/Metis/Momus plan critique, or a per-slice review/QA/checkpoint/commit workflow with a project plan file (`PLAN.md` or `Plan.md`) as the active source of truth and completed work archived into `개발일지.md`. This skill assumes an Oh My XX orchestration environment (such as Oh My Codex) plus gstack tooling.
---

# Mansu TDD Strict

Use this skill to run a strict, sequential, plan-first delivery loop for non-trivial work.

## Core promise

- Lock a final plan before implementation starts.
- Break the work into the smallest user-visible end-to-end slices.
- Run each slice as `RED -> GREEN -> REFACTOR`.
- Close each slice in the exact order `review -> qa -> checkpoint -> commit`.
- Keep the project plan file (`PLAN.md` by default, or `Plan.md` if the project already uses it) for active truth and `개발일지.md` for completed work.
- Archive the finished loop into `개발일지.md` and trim the plan file back to active follow-up only.

## Read order

1. Read `references/prerequisites.md` first.
2. If any prerequisite is missing, read `references/bootstrap.md`.
3. Read `references/workflow.md` before planning or coding.
4. Read `references/gates.md` before closing a slice.
5. Read `references/templates.md` when writing `PLAN.md`, slice tables, slice reports, or `개발일지.md`.

## Non-negotiable rules

- Do not start implementation before the final plan and slice table are shown.
- Do not start the next slice before the current slice is fully closed.
- Do not implement without a failing RED test.
- Do not skip `review`, `qa`, or `checkpoint`.
- Do not create more than one git commit per slice.
- Do not keep appending to a giant file when the work introduces a new responsibility boundary.

## Required role mapping

Use these roles during planning:

- `Prometheus`: draft the initial plan.
- `Metis`: critique execution and architecture risk.
- `Momus`: critique unnecessary complexity, over-scope, and false elegance.

If your environment uses different agent names, map them to those three responsibilities before proceeding.

## Stop conditions

Stop instead of improvising if any of these are true:

- Oh My XX orchestration or multi-agent support is unavailable.
- `gstack-review`, `gstack-qa`, or `gstack-checkpoint` is unavailable.
- A meaningful RED test cannot be written.
- A slice expands beyond its original completion criteria.
- You cannot update `PLAN.md` or the project’s `개발일지.md`.

When you stop, report the exact missing prerequisite or blocked gate and do not emulate the missing behavior manually.
