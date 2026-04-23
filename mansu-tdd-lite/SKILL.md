---
name: mansu-tdd-lite
description: Lightweight orchestration workflow for small-to-medium feature or refactor work that still benefits from plan-first vertical slices, but does not require the full strict Ralph gates. Use when the user wants `mansu-tdd-lite`, a lighter Ralph-style loop, `ralph-lite:` execution, slice-by-slice progress, a living plan file, and review/QA/checkpoint discipline without the full overhead of strict per-slice TDD and hard stop conditions. Works well with Oh My XX orchestration and gstack, but may degrade gracefully when some gates are replaced with equivalent project checks.
---

# Mansu TDD Lite

Use this skill when full `mansu-tdd-strict` feels too heavy, but you still want a disciplined loop.

## Core promise

- Plan before coding, but keep the planning pass short and implementation-oriented.
- Break work into a few meaningful vertical slices.
- Prefer test-first for logic-heavy work; use explicit verification for tiny UI/content work.
- Validate each slice before moving on.
- Keep the active plan current so the next session can resume cleanly.

## Best fit

Use this skill for:

- small-to-medium features
- contained refactors
- UI work that still needs structure
- projects where full Ralph strict mode would slow momentum

Escalate to full `mansu-tdd-strict` when:

- the work is high-risk or cross-cutting
- architecture is still unstable
- strong TDD gates are required
- each slice truly needs strict `review -> qa -> checkpoint -> commit`
- multiple agents and gstack gates are available and you want the full ritual

## Lightweight preflight

Before slice 1, confirm:

- the repo has `git` and write access
- there is an active planning path such as `PLAN.md`
- there is a chosen validation path for this task
  examples: tests, `review`, `qa`, manual verification, visual check
- there is a chosen checkpoint path for current status and next-step notes
  examples: `PLAN.md`, checkpoint notes, project worklog

If any of those are unclear, decide them before implementation starts.

If you cannot define a meaningful validation path or a place to record current status and next steps, stop and escalate to `mansu-tdd-strict` or a more structured workflow.

## Default loop

1. Clarify the goal, user value, limits, and references.
2. Draft a short plan.
   Examples: `Prometheus`, `gstack-autoplan`, `gstack-plan-eng-review`
3. Critique only as much as needed.
   Examples: `Momus`, `Metis`, `gstack-plan-ceo-review`, `gstack-plan-design-review`
4. Split the work into `2-4` vertical slices unless the task clearly needs more.
5. Implement one slice at a time.
6. Run the right validation for that slice.
   Examples: `review`, `qa`, focused tests, visual check, manual verification
7. Update the plan/checkpoint notes.
8. Commit when the slice is stable enough to stand on its own.

## Slice card

Even in lite mode, each slice should leave behind a compact slice card with:

- completion conditions
- impact files
- validation path
- risk notes

Keep it short, but do not skip the structure entirely.

## Working rules

- `PLAN.md` is preferred as the living source of truth.
- If the project already uses another planning doc, update that instead of forcing a rename.
- `개발일지.md` is optional in lite mode. Use it when the project already benefits from a running history.
- One commit per slice is preferred, but not mandatory.
- `RED -> GREEN -> REFACTOR` is preferred for logic-heavy slices.
- For tiny presentational slices, you may use implementation plus explicit verification instead of forcing artificial tests.
- `review`, `qa`, and `checkpoint` are the default gates. If one is skipped, state why.
- Choose the validation and checkpoint path before slice 1 rather than improvising them mid-slice.
- Do not keep growing a giant file when a new responsibility boundary appears.

## Minimum slice close

A lite slice is closed enough to move on only when:

1. the chosen validation path is complete
2. the active plan reflects the current status
3. the next starting point is recorded
4. the work is committed, or the reason for not committing yet is stated explicitly

Lite mode is flexible about tools, not vague about closure.

## Required outputs

At minimum, leave behind:

- a current plan with slice status
- the latest completed validation result
- the next starting point
- any new rule or lesson worth reusing

## Suggested prompt shape

Use prompts in this spirit:

- "Plan this briefly, critique only the risky parts, then split it into a few vertical slices."
- "Implement slice 1, keep a compact slice card, run the right validation, update the plan, then stop."
- "Keep the plan alive, but do not over-formalize the workflow."

## Closeout

When the work is complete:

- keep only active follow-up items in `PLAN.md`
- move finished multi-slice detail into `개발일지.md` if that log is in use
- avoid leaving the same completed work fully expanded in both places

## Stop and escalate

Switch to full `mansu-tdd-strict` if:

- the slice count keeps growing
- you cannot define clean completion criteria
- validation keeps finding architectural churn
- the task starts touching security, performance, or multi-surface regressions
- the project now needs strict per-slice gates and stronger auditability
