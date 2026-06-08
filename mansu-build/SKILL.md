---
name: mansu-build
description: Execute the current phase through Mansu TDD slices while preserving source-skill routing, checkpoints, validation, and evidence.
---

# Mansu Build

Use this skill when a current phase `PLAN.md` exists and the user wants
implementation, refactoring, or code changes.

`mansu-build` preserves the existing `mansu-tdd-total` behavior as the default
implementation engine.

If the current phase `PLAN.md` is missing, incomplete, or only contains a
whole-project roadmap, do not implement; route back to `mansu-define` / `mansu-plan`
so the active phase, slice boundaries, validation gates, and source skill
handoff are created first. Do not implement from a whole-project roadmap.

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
