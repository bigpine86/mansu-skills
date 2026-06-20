---
name: mansu-plan
description: Turn a defined project into requirements/spec, architecture, design direction, and implementation roadmap by orchestrating source planning and design skills.
---

# Mansu Plan

Use this skill after Define has produced enough purpose, requirements,
constraints, and any design intent seed/handoff to plan real work.

Mansu Plan's internal order is:

```text
Requirements/Spec -> Feature Priority/MVP Cut -> Architecture -> Design Direction -> Implementation Roadmap
```

Mansu Plan's public execution hierarchy is:

```text
Feature Priority / MVP Cut -> Project Phase Roadmap -> Phase Plan -> Slice
```

- `Feature Priority / MVP Cut` chooses what belongs in the first useful release
  and what is intentionally deferred.
- `Project Phase Roadmap` names the large phases, their order, dependency/value
  rationale, and exit criteria.
- `Phase Plan` is the active execution plan for exactly one phase and contains
  the detailed approach for that phase.
- `Slice` is the ordered implementation unit that public `mansu-3build` or
  `mansu-build` executes from the active Phase Plan.

## Plan tiers

- Quick Plan: use the Define handoff, repo-visible evidence, and the smallest
  addyosmani/gstack checks needed to produce a useful Phase Plan.
- Standard Plan: include the full quality gate below, focused source-skill
  critique, and a Project Phase Roadmap plus one active Phase Plan.
- Heavy Plan: use addyosmani `spec-driven-development`,
  `planning-and-task-breakdown`, `api-and-interface-design`, and
  `source-driven-development` routes deeply, plus gstack `office-hours`,
  `plan-ceo-review`, `plan-eng-review`, `plan-devex-review`, and
  `gstack-plan-design-review` critique when their risks apply. Use
  `gstack-autoplan` only as a light final synthesis or critique when needed.
  Do not add OMO ultrawork approval gates, broad research waves, or heavy QA.

## Required references

- `mansu-operating-model/references/SOURCE_SKILL_COMPOSITION.md`
- `mansu-operating-model/references/CODE_CONSTRUCTION_ORDER.md`

## Conditional references

- Read `mansu-operating-model/references/DOCUMENT_CREATION_ORDER.md` only when
  artifact location/order is unclear, when the plan will create, update,
  promote, or archive durable project documents, or when the work is a new
  product, app, repo, major feature family, broad roadmap, or standard/heavy
  planning task.

## Source skill route

- Consume the Define handoff first. `mansu-1define` owns Ouroboros-first
  definition and records design intent seed evidence; `mansu-plan` owns turning
  that handoff into `DESIGN.md`, design artifacts, design direction, and the
  phase roadmap.
- Use addyosmani `spec-driven-development`, `planning-and-task-breakdown`,
  `api-and-interface-design`, and `source-driven-development` for spec,
  architecture, contracts, and implementation order.
- Use gstack `autoplan`, `plan-ceo-review`, `plan-eng-review`,
  `plan-devex-review`, and `gstack-plan-design-review` for critique.
- Use gstack `office-hours` or `plan-ceo-review` when feature priority, MVP
  cut, product value, or scope tradeoffs are unclear.
- OMO `ulw-plan` is allowed only for literal user invocation:
  `$omo:ulw-plan`, `omo:ulw-plan`, `ulw-plan`, or an explicit request for OMO
  ultrawork planning. Generic phrases such as "parallel planning", "staged
  planning", or "decompose the work" do not trigger OMO `ulw-plan`.
- For user-facing UI/product work, route design through OMO research/deepsearch
  when available, Open Design, VoltAgent/awesome-design-md, gstack
  `gstack-design-consultation`, `gstack-design-shotgun`, and
  `gstack-plan-design-review`.

## Plan quality gate

Do not produce a shallow outline for standard/heavy planning. A complete
`mansu-2plan` result must be execution-ready and must include:

- input evidence: Define handoff, source artifacts, existing roadmap/spec/TDR,
  or the reason those artifacts are absent
- feature inventory: candidate features, priority rationale, MVP/later split,
  dependency-first items, risky items, and learning-first items
- requirements/spec: success criteria, non-goals, constraints, open questions,
  and acceptance criteria
- architecture/interface plan: domain model, data/API boundaries, contracts,
  alternatives considered, selected direction, and rejected direction rationale
- design plan: `DESIGN.md` or no-design-needed reason, selected design route,
  artifact expectations, and design review path when UI/product design matters
- environment plan: runtime, package manager, setup commands, validation
  commands, and `uv`/`.venv` decision when Python or a new repo is involved
- Project Phase Roadmap: ordered phases with dependency, user value, risk,
  learning value, exit criteria, and handoff artifact for each phase
- active Phase Plan: current phase goal, ordered vertical slices, acceptance
  criteria, likely impact files, validation commands, review/verify gates,
  risks, blockers, and checkpoint rules

Before declaring Plan complete, run or route to the relevant source-skill
critique when available: `gstack-autoplan` as the broad default, plus focused
`plan-ceo-review`, `gstack-plan-design-review`, `plan-eng-review`, or
`plan-devex-review` when their risk applies. If a critique route is unavailable
or intentionally skipped, record the skipped route and reason.

If any required part is missing, Plan is incomplete. Name the missing evidence
and do not hand off to public `mansu-3build`.

## Outputs

- requirements/spec
- feature inventory, priority rationale, MVP/later split, and active phase
  selection reason
- architecture and interface notes
- environment/dependency setup plan when needed
- `DESIGN.md` creation/refinement or a recorded no-design-needed reason
- design artifacts, selected direction, rejected directions, and source-skill
  evidence when UI/product design matters
- design direction or explicit no-design-needed reason
- full project phase map ordered by user value, dependency, risk, and learning
- current phase execution plan with slice boundaries, validation gates, risks,
  and handoff to public `mansu-3build`

## Environment planning

When `mansu-plan` is planning a new repo, new app, greenfield Python service,
or a project with no established dependency/runtime setup, include an
environment setup slice before feature implementation. Prefer `uv` for Python
projects when available and appropriate.

The plan should say whether to create:

- `pyproject.toml`
- `.python-version` when the project pins Python
- a `uv` virtual environment such as `.venv`
- dependency groups for app, dev, test, lint, or tooling
- setup/validation commands such as `uv sync`, `uv run pytest`, or the
  project-specific equivalent

Do not add a new `uv` environment just because planning is happening. For an
existing project or feature addition, inspect the current repo conventions first
and follow the established package manager, virtual environment, lockfile, and
test commands unless there is a clear reason to change them.

The active plan is a role, not a literal filename. Use exactly one active plan
at a time unless the user explicitly names a different concrete file. Active
plan precedence is:

1. a concrete plan path the user references
2. repo-visible `PLAN.md`
3. repo-visible `Plan.md`
4. `.codex/plans/*.md`
5. `.omo/plans/*.md`

If an existing roadmap file already identifies the next active phase,
`mansu-plan` may update that file or derive a clearer phase plan from it; do not
force a new file merely because the plan is not named `PLAN.md`.
This explicit active plan support does not make `.omo/*` canonical doctrine,
public documentation, or a normal runtime source of truth.

Do not skip directly to Build unless a current phase execution plan already
exists and is still valid.

## Final guidance

End the response by saying whether Plan is complete.

- If Plan is complete, tell the user the next step is public `mansu-3build` to
  implement the current phase through slices.
- If Plan is incomplete, name the missing plan evidence: requirements/spec,
  feature priority/MVP cut, architecture/interface notes, design direction or
  no-design-needed reason, environment/dependency setup plan when needed, phase
  map, or current phase execution plan.
- Do not suggest public `mansu-4verify` or public `mansu-6ship` before public
  `mansu-3build` has produced implementation evidence.
