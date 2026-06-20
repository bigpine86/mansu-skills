---
name: mansu-build
description: Execute the current phase through Mansu TDD slices while preserving source-skill routing, checkpoints, validation, and evidence.
---

# Mansu Build

Use this skill when a current phase execution plan exists and the user wants
implementation, refactoring, or code changes.

The build input hierarchy is `Feature Priority / MVP Cut -> Project Phase Roadmap -> Phase Plan -> Slice`.
Build reads the Project Phase Roadmap for phase order, exit criteria, and the
roadmap link/section, then executes only the active Phase Plan's slice table.

The active Phase Plan is a role, not a literal filename. Discovery precedence:
use a concrete user-provided path first; otherwise find active Phase Plan
role/marker discovery signals in `PLAN.md`, `Plan.md`, `.codex/plans/*.md`,
`.omo/plans/*.md`, or linked planning docs. Do not say "no plan" until these candidates have
been checked, and do not reject a valid active Phase Plan only because the
filename is not `PLAN.md`.

Before non-trivial implementation, read the active Phase Plan and its linked
Project Phase Roadmap before any linked spec, TDR, or design direction it names.
If those linked artifacts change the current phase, slice boundaries,
validation gates, or risk profile, update the active Phase Plan before editing
code.

`.omo/plans/*.md` support is explicit active plan path support only. `.omo/*`
remains generated planning/evidence state, not canonical doctrine,
user-facing documentation, or a normal runtime source of truth.

`mansu-build` preserves the existing `mansu-tdd-total` behavior as the default
implementation engine.

If the active Phase Plan is missing, incomplete, or lacks a slice table for the
current/next phase, do not implement; route back to public `mansu-1define` /
`mansu-2plan` so the active phase, slice boundaries, validation gates, and
source skill handoff are created first.

Do not implement from a Project Phase Roadmap alone. A roadmap can point to or
contain the active Phase Plan, but Build may execute only after role/marker
discovery identifies one active Phase Plan with an execution-ready slice table.

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
- next route: public `mansu-4verify`, public `mansu-5review`, `mansu-debug`, or next slice

## Final guidance

End the response by saying what should happen next.

- If the active phase still has open slices, tell the user the next step is the
  next `mansu-build` slice.
- If implementation for the active phase is complete, tell the user the next
  step is public `mansu-4verify` to prove the behavior.
- If validation failed or the cause is unknown, route to `mansu-debug` before
  claiming the build is complete.
- Do not suggest public `mansu-6ship` directly from Build.
