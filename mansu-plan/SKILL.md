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
- current phase `PLAN.md` with slice boundaries, validation gates, risks, and
  handoff to `mansu-build`

Do not skip directly to Build unless a current phase plan already exists and is
still valid.
