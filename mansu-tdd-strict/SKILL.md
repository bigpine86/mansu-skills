---
name: mansu-tdd-strict
description: Strict TDD slice workflow for higher-risk work. Use when `mansu-tdd-total` routes a slice to strict mode with RED/GREEN/REFACTOR and separate review/QA gates.
---

# Mansu TDD Strict

Use this skill to run a strict, sequential, plan-first delivery loop for non-trivial work.
It requires multi-agent support or single-runtime role separation with
independently recorded review, QA, and checkpoint gates.

## Core promise

- Lock a final plan before implementation starts.
- Break the work into the smallest user-visible end-to-end slices.
- Run each slice as `RED -> GREEN -> REFACTOR`.
- Close each slice in the exact order `review -> qa -> checkpoint -> commit`.
- Keep the project plan file (`PLAN.md` by default, or `Plan.md` if the project already uses it) for active truth and `개발일지.md` for completed work.
- Archive the finished loop into `개발일지.md` and trim the plan file back to active follow-up only.

## Role in the Mansu TDD series

In the normal Mansu TDD flow, `mansu-tdd-total` owns planning, critique, slice decomposition, and mode selection.

This skill executes slices marked `strict`.

Use strict mode when a meaningful failing RED test improves confidence, protects risky behavior, or clarifies the design.

When invoked from `mansu-tdd-total`, use the execution-ready plan and slice table as the planning source of truth, then apply this skill's strict execution gates.

When invoked directly without an execution-ready plan, follow the read order below and produce the final plan before implementation starts.

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
- Do not skip the `review`, `qa`, or `checkpoint` gate families.
- Do not create more than one git commit per slice.
- Do not keep appending to a giant file when the work introduces a new responsibility boundary.
- Before writing the RED test, apply the code construction router: detect the current construction phase, read the relevant source skill when needed, then define dependency, context pack, contract boundary, and rollback-friendly slice shape.

## Required role mapping

Use these roles during planning:

- `Prometheus`: draft the initial plan.
- `Metis`: critique execution and architecture risk.
- `Momus`: critique unnecessary complexity, over-scope, and false elegance.

If your environment uses different agent names, map them to those three responsibilities before proceeding.

## Stop conditions

Stop instead of improvising if any of these are true:

- The required current-runtime orchestration or independently recorded gate support is unavailable.
- A callable gate for the required `review`, `qa`, or `checkpoint` stage is unavailable.
- A meaningful RED test cannot be written.
- A slice expands beyond its original completion criteria.
- You cannot update `PLAN.md` or the project’s `개발일지.md`.

When you stop, report the exact missing prerequisite or blocked gate and do not emulate the missing behavior manually.
