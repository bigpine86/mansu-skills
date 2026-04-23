---
name: mansu-tdd-lite
description: Disciplined plan-first, slice-first workflow for work that needs real planning, review, QA, checkpoint, commit, and work logging, but does not always require strict failing-test-first TDD for every slice. Use when the user wants `mansu-tdd-lite`, strong planning and vertical slices with lighter TDD rules, or a workflow where each slice defines its validation path before implementation while keeping review/QA/checkpoint discipline.
---

# Mansu TDD Lite

Use this skill when full `mansu-tdd-strict` is too test-rigid for the task, but the work still must be planned, sliced, validated, recorded, and committed carefully.

## Core promise

- Plan properly before coding.
- Break work into meaningful vertical slices by feature, behavior, or user flow.
- Define the validation path for each slice before implementation.
- Use test-first when it naturally fits the slice; use explicit verification when a strict RED test would be artificial.
- Validate each slice before moving on.
- Keep the active plan current so the next session can resume cleanly.
- Record completed work in a project worklog when the project uses one.

## Best fit

Use this skill for:

- small-to-medium features
- contained refactors
- UI work that still needs structure
- documentation, configuration, and integration work where strict RED tests may be unnatural
- projects where strict failing-test-first TDD would slow momentum without improving confidence

Escalate to full `mansu-tdd-strict` when:

- the work is high-risk or cross-cutting
- architecture is still unstable
- strict failing-test-first TDD is required
- each slice truly needs a mandatory `RED -> GREEN -> REFACTOR` gate
- multiple agents and gstack gates are available and you want the full ritual

## Preflight

Before slice 1, confirm:

- the repo has `git` and write access
- there is an active planning path, preferably `PLAN.md`
- there is a completed-work log path, preferably `개발일지.md` when the project uses Korean worklogs
- review, QA, checkpoint, and commit gates are available or have clear project equivalents
- every planned slice can define a validation path before implementation

If any of those are unclear, decide them before implementation starts.

If you cannot define a meaningful validation path, checkpoint path, or worklog path, stop and clarify the workflow before implementation.

## Default loop

1. Clarify the goal, user value, limits, and references.
2. Draft a proper implementation plan.
   Examples: `Prometheus`, `gstack-autoplan`, `gstack-plan-eng-review`
3. Critique the plan before implementation.
   Examples: `Momus`, `Metis`, `gstack-plan-ceo-review`, `gstack-plan-design-review`
4. Split the work into vertical slices by feature, behavior, or user flow.
5. Implement one slice at a time.
6. For each slice, choose the validation path before coding.
   Examples: failing test, focused tests, `review`, `qa`, visual check, manual verification
7. Implement the slice.
8. Run `review -> qa -> checkpoint`.
9. Commit the slice.
10. Update `PLAN.md` and the project worklog.

## Slice card

Even in lite mode, each slice should leave behind a compact slice card with:

- completion conditions
- impact files
- validation path
- risk notes
- checkpoint and worklog note

Keep it short, but do not skip the structure.

## Working rules

- `PLAN.md` is preferred as the living source of truth.
- If the project already uses another planning doc, update that instead of forcing a rename.
- `개발일지.md` is the preferred completed-work log when the project uses Korean worklogs.
- One commit per slice is the default.
- `RED -> GREEN -> REFACTOR` is required only when strict TDD is useful for the slice.
- For UI, docs, config, and tiny presentational slices, explicit verification may replace the RED test.
- `review`, `qa`, and `checkpoint` are required gates unless the project has an explicit equivalent.
- Choose the validation and checkpoint path before slice 1 rather than improvising them mid-slice.
- Do not keep growing a giant file when a new responsibility boundary appears.

## Minimum slice close

A lite slice is closed enough to move on only when:

1. the chosen validation path is complete
2. the active plan reflects the current status
3. the next starting point is recorded
4. review, QA, and checkpoint are complete
5. the work is committed, or the reason for not committing yet is stated explicitly
6. the completed-work log is updated when the project uses one

Lite mode is flexible about TDD style, not about work quality.

## Required outputs

At minimum, leave behind:

- a current plan with slice status
- the latest completed validation result
- the next starting point
- review, QA, checkpoint, and commit status
- worklog update when applicable
- any new rule or lesson worth reusing

## Suggested prompt shape

Use prompts in this spirit:

- "Plan this properly, critique the plan, then split it into vertical slices by feature or user flow."
- "For each slice, choose whether strict RED testing is useful. If not, define the verification path before coding."
- "Implement slice 1, then run review, QA, checkpoint, commit, and update the worklog."
- "Keep `PLAN.md` alive and keep completed work in the project worklog."

## Closeout

When the work is complete:

- keep only active follow-up items in `PLAN.md`
- move finished multi-slice detail into `개발일지.md` or the project worklog
- avoid leaving the same completed work fully expanded in both places

## Stop and escalate

Switch to full `mansu-tdd-strict` if:

- the slice count keeps growing
- you cannot define clean completion criteria
- validation keeps finding architectural churn
- the task starts touching security, performance, or multi-surface regressions
- the project now needs mandatory failing-test-first TDD and stronger auditability
