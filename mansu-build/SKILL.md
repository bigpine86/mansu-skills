---
name: mansu-build
description: Execute the current phase through Mansu TDD slices while preserving source-skill routing, checkpoints, validation, and evidence.
---

# Mansu Build

Use this skill when a current phase execution plan exists and the user wants
implementation, refactoring, or code changes.

The active plan is a role, not a literal filename. Prefer `PLAN.md`, but also
recognize `Plan.md`, `.codex/plans/*.md`, `.omo/plans/*.md`, or a concrete plan
path the user just referenced. Do not say "no plan" until these candidates have
been checked.

`mansu-build` preserves the existing `mansu-tdd-total` behavior as the default
implementation engine.

If the active plan is missing, incomplete, or only contains a whole-project
roadmap without a current/next phase, do not implement; route back to
`mansu-define` / `mansu-plan` so the active phase, slice boundaries, validation
gates, and source skill handoff are created first.

If a roadmap-style file already names the current or next phase and contains
execution-ready slice boundaries and validation gates, treat that file as the
active phase plan even when it is not named `PLAN.md`. Do not reject a valid plan
only because the filename is `.omo/plans/{slug}.md`.

Do not implement from a whole-project roadmap that lacks an active phase and
slice table.

## Required references

- `mansu-operating-model/references/SOURCE_SKILL_COMPOSITION.md`
- `mansu-operating-model/references/CODE_CONSTRUCTION_ORDER.md`

## Source skill route

- Default to `mansu-tdd-total` for phase-aware slice planning and execution.
- Use addyosmani `context-engineering`, `source-driven-development`,
  `incremental-implementation`, and `test-driven-development` for build
  discipline.
- Use OMO `start-work`, `programming`, `ulw-loop`, and `lsp` as execution
  habits only when they fit the slice.
- Use gstack `guard`, `careful`, and `checkpoint` for safety and checkpointing.

LazyCodex is not a source skill family. For Codex it may be the runtime
transport checked by `mansu-setup`, but it does not replace Mansu routing or
`mansu-tdd-total`.

## Outputs

- updated slice table or worklog
- code changes scoped to the active slice
- validation evidence
- checkpoint and commit/no-commit status
- next route: `mansu-verify`, `mansu-review`, `mansu-debug`, or next slice

## Final guidance

End the response by saying what should happen next.

- If the active phase still has open slices, tell the user the next step is the
  next `mansu-build` slice.
- If implementation for the active phase is complete, tell the user the next
  step is `mansu-verify` to prove the behavior.
- If validation failed or the cause is unknown, route to `mansu-debug` before
  claiming the build is complete.
- Do not suggest `mansu-ship` directly from Build.
