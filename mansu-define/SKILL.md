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
   In Codex, use tool discovery for `ouroboros interview` first and prefer the
   MCP tool `mcp__ouroboros.ouroboros_interview` when it is exposed. Start the
   interview with `initial_context` set to the user's idea text and `cwd` set to
   the current project directory.
2. If the MCP tool is not exposed but the local CLI exists, use the current
   Ouroboros CLI route for definition (`ouroboros init`, `ouroboros pm`, or the
   installed `ouroboros-interview`/runtime skill route). Treat legacy `ooo
   interview` wording as compatibility only; do not require the `ooo` command.
3. Do not run Claude Code adapter commands unless the detected runtime target or
   host is actually Claude Code. In Codex, Claude plugin or `omc` failures are
   adapter warnings, not a reason to abandon Ouroboros.
4. If the route is missing or broken, route to public `mansu-9setup` in
   `install` mode when Ouroboros is missing, or public `mansu-9setup` in
   `update`/`repair` mode when the installed Ouroboros/runtime MCP integration
   is stale, not exposed, or failing.
5. If setup is blocked by network, package-manager, permission, or runtime
   limits, record `Ouroboros setup blocked reason:` and ask only the smallest
   bridging question needed to keep the user unblocked.

Fallback definition without Ouroboros is allowed only after the setup/update or
repair path was attempted or explicitly declined, and it must be labeled as fallback.
Do not silently replace Ouroboros interview with Mansu-owned questions.

## Post-Ouroboros design-context gate

After Ouroboros interview or cited existing definition evidence completes, check
whether the scope includes user-facing UI, product experience, visible workflow,
interaction design, brand/content surfaces, onboarding, dashboard, website, app,
or other customer/user-facing behavior.

If user-facing UI/product scope is present, route to a source-skill
design-context interview before public `mansu-2plan`.

The default installed route is `gstack-design-consultation`.

Use `gstack-design-shotgun` only when the work needs multiple visible directions,
Open Design only for approved artifact or prototype work, OMO research/deepsearch
only when external design context is needed, and `gstack-plan-design-review` only
for critique of an existing design direction.

Define records a design intent seed and route evidence for handoff only:
audience, product surface, desired feel, constraints, examples, risks, and the
source-skill route used or blocked. DESIGN.md remains owned by mansu-2plan;
Define must not create, rewrite, or claim ownership of `DESIGN.md`.

Do not create a Mansu-owned design questionnaire. If design context is needed,
use the source-skill design-context interview route and record only the design
intent seed/handoff evidence.

Skipping the Ouroboros interview is allowed only when current, repo-visible
definition artifacts already exist, such as an Ouroboros Seed/Ledger or an
equivalent source-of-truth definition, and the user is asking to continue from
that existing definition. In that case, cite the artifact evidence before
proceeding.

## Required references

- `mansu-operating-model/references/SOURCE_SKILL_COMPOSITION.md`

## Conditional references

- Read `mansu-operating-model/references/SOURCE_SKILL_CATALOG.md` only when
  the source route is ambiguous, missing, stale, newly added, or conflicts with
  installed skills.
- Read `mansu-operating-model/references/DOCUMENT_CREATION_ORDER.md` only when
  Define must create, locate, or update artifacts such as `AGENTS.md`,
  `CODING_RULES.md`, spec/TDR/DESIGN handoff notes, or other source-of-truth
  docs.

## Source skill route

- Use Ouroboros `interview`, `pm`, `seed`, and `brownfield` first for fuzzy
  project definition, durable purpose, Seed/Ledger continuity, or repo-aware
  definition.
- Use addyosmani `interview-me`, `idea-refine`, and `spec-driven-development`
  for crisp clarification, requirements, and acceptance criteria.
- Use gstack `gstack-design-consultation` after Ouroboros when user-facing
  UI/product scope needs design-context interview before public `mansu-2plan`.
- Use gstack `office-hours` or `plan-ceo-review` when product wedge, value,
  audience, or strategic direction is weak.

## Outputs

Produce or update only the definition layer:

- purpose, user, problem, success signal, non-goals, constraints
- feature candidates, requirements, acceptance criteria, and priority signals
  such as must-have, later, dependency, risk, user value, and uncertainty
- source-of-truth notes or links to Ouroboros Seed/Ledger output
- design intent seed and source design-context route evidence when user-facing
  UI/product scope is present
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
