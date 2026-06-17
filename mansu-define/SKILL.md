---
name: mansu-define
description: Define a project, product, app, repo, or major feature before planning or implementation by orchestrating interview, Seed, requirements, and source-of-truth skills.
---

# Mansu Define

Use this skill when the work starts from an idea, vague goal, new project, new
repo, major feature family, or unclear product direction.

Mansu does not invent the interview flow by itself. It routes to the strongest
source skills, then records the definition artifacts needed before planning.

## Mandatory Ouroboros definition rule

For a new product, app, repo, major feature family, or fuzzy idea, Ouroboros is
the default project-definition route. Do not present Ouroboros interview as an
optional "if MCP exists" path in user-facing updates.

User-provided idea notes do not satisfy the interview gate. If the user writes
one line, three lines, a rough feature list, or a short product brief and then
invokes `mansu-1define` or `mansu-define`, treat that text as seed context for
Ouroboros `interview`; do not mark Define complete, jump to planning, or replace
the interview with Mansu-owned questions just because the brief sounds clear.

Before asking Mansu-owned definition questions:

1. Load/discover the Ouroboros interview route through the active runtime.
2. If the route is available, start Ouroboros `interview` first and let it
   generate the definition questions.
3. If the route is missing or broken, route to `mansu-9setup` in `install` mode
   when Ouroboros is missing, or `mansu-9setup` in `update` mode when the
   installed Ouroboros/runtime MCP integration is stale or broken.
4. If setup is blocked by network, package-manager, permission, or runtime
   limits, record `Ouroboros setup blocked reason:` and ask only the smallest
   bridging question needed to keep the user unblocked.

Fallback definition without Ouroboros is allowed only after the setup/update
path was attempted or explicitly declined, and it must be labeled as fallback.
Do not silently replace Ouroboros interview with Mansu-owned questions.

Skipping the Ouroboros interview is allowed only when current, repo-visible
definition artifacts already exist, such as an Ouroboros Seed/Ledger or an
equivalent source-of-truth definition, and the user is asking to continue from
that existing definition. In that case, cite the artifact evidence before
proceeding.

## Required references

- `mansu-operating-model/references/SOURCE_SKILL_COMPOSITION.md`
- `mansu-operating-model/references/SOURCE_SKILL_CATALOG.md`
- `mansu-operating-model/references/DOCUMENT_CREATION_ORDER.md`

## Source skill route

- Use Ouroboros `interview`, `pm`, `seed`, and `brownfield` first for fuzzy
  project definition, durable purpose, Seed/Ledger continuity, or repo-aware
  definition.
- Use addyosmani `interview-me`, `idea-refine`, and `spec-driven-development`
  for crisp clarification, requirements, and acceptance criteria.
- Use gstack `office-hours` or `plan-ceo-review` when product wedge, value,
  audience, or strategic direction is weak.

## Outputs

Produce or update only the definition layer:

- purpose, user, problem, success signal, non-goals, constraints
- requirements and acceptance criteria
- source-of-truth notes or links to Ouroboros Seed/Ledger output
- `AGENTS.md` and `CODING_RULES.md` candidates when the project needs operating rules
- handoff notes for public `mansu-2plan`

## Final guidance

End the response by saying whether Define is complete.

- If Define is complete, tell the user the next step is public `mansu-2plan` to
  turn the definition into requirements/spec, architecture, design direction,
  roadmap, and the current phase execution plan.
- If Define is incomplete, name the missing definition evidence before any
  planning.
- Do not suggest public `mansu-3build` directly from Define.

Do not start implementation. If a build request appears during Define, finish
the definition gate and route to public `mansu-2plan` first.
