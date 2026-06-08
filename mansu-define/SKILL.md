---
name: mansu-define
description: Define a project, product, app, repo, or major feature before planning or implementation by orchestrating interview, Seed, requirements, and source-of-truth skills.
---

# Mansu Define

Use this skill when the work starts from an idea, vague goal, new project, new
repo, major feature family, or unclear product direction.

Mansu does not invent the interview flow by itself. It routes to the strongest
source skills, then records the definition artifacts needed before planning.

## Required references

- `mansu-operating-model/references/SOURCE_SKILL_COMPOSITION.md`
- `mansu-operating-model/references/SOURCE_SKILL_CATALOG.md`
- `mansu-operating-model/references/DOCUMENT_CREATION_ORDER.md`

## Source skill route

- Use addyosmani `interview-me`, `idea-refine`, and `spec-driven-development`
  for crisp clarification, requirements, and acceptance criteria.
- Use Ouroboros `interview`, `pm`, `seed`, and `brownfield` when the work needs
  durable purpose, Seed/Ledger continuity, or repo-aware definition.
- Use gstack `office-hours` or `plan-ceo-review` when product wedge, value,
  audience, or strategic direction is weak.

## Outputs

Produce or update only the definition layer:

- purpose, user, problem, success signal, non-goals, constraints
- requirements and acceptance criteria
- source-of-truth notes or links to Ouroboros Seed/Ledger output
- `AGENTS.md` and `CODING_RULES.md` candidates when the project needs operating rules
- handoff notes for `mansu-plan`

Do not start implementation. If a build request appears during Define, finish
the definition gate and route to `mansu-plan` first.
