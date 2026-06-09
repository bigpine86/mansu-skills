---
name: mansu-plan
description: Turn a defined project into requirements/spec, architecture, design direction, and implementation roadmap by orchestrating source planning and design skills.
---

# Mansu Plan

Use this skill after Define has produced enough purpose, requirements, and
constraints to plan real work.

Mansu Plan's internal order is:

```text
Requirements/Spec -> Architecture -> Design Direction -> Implementation Roadmap
```

## Required references

- `mansu-operating-model/references/SOURCE_SKILL_COMPOSITION.md`
- `mansu-operating-model/references/CODE_CONSTRUCTION_ORDER.md`
- `mansu-operating-model/references/DOCUMENT_CREATION_ORDER.md`

## Source skill route

- Use addyosmani `spec-driven-development`, `planning-and-task-breakdown`,
  `api-and-interface-design`, and `source-driven-development` for spec,
  architecture, contracts, and implementation order.
- Use OMO `ulw-plan` when decomposition benefits from parallel or staged
  planning.
- Use gstack `autoplan`, `plan-ceo-review`, `plan-eng-review`,
  `plan-devex-review`, and `gstack-plan-design-review` for critique.
- For user-facing UI/product work, route design through OMO research/deepsearch
  when available, Open Design, VoltAgent/awesome-design-md, gstack
  `gstack-design-consultation`, `gstack-design-shotgun`, and
  `gstack-plan-design-review`.

## Outputs

- requirements/spec
- architecture and interface notes
- design direction or explicit no-design-needed reason
- full project phase map
- current phase execution plan with slice boundaries, validation gates, risks,
  and handoff to `mansu-build`

The preferred filename is `PLAN.md`, but Mansu must also support active plans in
`Plan.md`, `.codex/plans/*.md`, `.omo/plans/*.md`, or another concrete path the
user references. If an existing roadmap file already identifies the next active
phase, `mansu-plan` may update that file or derive a clearer phase plan from it;
do not force a new file merely because the plan is not named `PLAN.md`.

Do not skip directly to Build unless a current phase execution plan already
exists and is still valid.

## Final guidance

End the response by saying whether Plan is complete.

- If Plan is complete, tell the user the next step is `mansu-build` to implement
  the current phase through slices.
- If Plan is incomplete, name the missing plan evidence: requirements/spec,
  architecture/interface notes, design direction or no-design-needed reason,
  phase map, or current phase execution plan.
- Do not suggest `mansu-verify` or `mansu-ship` before `mansu-build` has
  produced implementation evidence.
