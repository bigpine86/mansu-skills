---
name: mansu-project-start
description: Zero-to-PLAN project kickoff workflow for legacy/specialized Mansu project-start calls. Public lifecycle guidance should prefer `mansu-1define`, then `mansu-2plan`.
---

# Mansu Project Start Compatibility Route

This route remains available for legacy or specialized Zero-to-PLAN kickoff
requests. It is not a public lifecycle phase; user-facing route lists should
prefer `mansu-1define`, then `mansu-2plan`.

Use this skill only when the user explicitly invokes `$mansu-project-start`, or
when an older workflow depends on that callable name. For normal new ideas,
fuzzy discovery, new repos/products, and major feature families, route first to
`mansu-1define`, then to `mansu-2plan`.

This skill creates the project-level thinking layer: intent, research, spec,
Ouroboros init/interview/PM/Seed/Ledger artifacts, TDR/architecture, UI direction when needed,
operating rules, project roadmap/phase order, and the first phase-level
`PLAN.md`.

It does not own slice implementation. It defines the project purpose, source of
truth, large-grain phase roadmap, and current phase handoff. `mansu-tdd-total`
owns the selected phase's detailed slices, implementation loop, review, QA, and
checkpoint.

## Core promise

- Start from purpose, user, desired outcome, and non-goals.
- Use Ouroboros as the default project-definition engine when `mansu-setup` has prepared it and the work begins from a vague or high-level idea.
- Find and inspect relevant current references before locking direction.
- Use official/source files first for technical facts; use GitHub, Reddit, and
  Threads for adoption, taste, patterns, and market signal with dates recorded.
- Compare architecture, domain model, language, stack, UI/UX, tradeoffs, and
  philosophy of reference projects.
- Produce only the documents needed for the risk level.
- Verify the plan with distinct product/design/engineering/DX critique.
- For user-facing UI, choose a design source route before phase roadmap planning;
  do not invent Mansu-owned design discovery questions when a stronger design
  route is available.
- Create the large-grain feature/phase order before creating slice plans.
- Do not enter `mansu-tdd-total` until the project roadmap names the major
  phases and marks exactly one active phase.
- Hand off into `PLAN.md` with the current phase and its first vertical slice table.

## Orchestration posture

Do not reimplement strong source routes inside Mansu.

Mansu's posture is a thin project-start orchestrator:

- delegate fuzzy project definition to Ouroboros first when it is available
- delegate problem/wedge review, spec, research, design, architecture, or DX review
  to gstack, Oh My, addyosmani, or another stronger source route when appropriate
- avoid asking duplicate questions that a selected source route already asks
- ask the user only when a missing answer materially changes scope,
  architecture, cost, security, user flow, or implementation order
- record low-risk assumptions instead of blocking on every unknown
- translate source artifacts into Mansu-owned documents, phase boundaries,
  gate mapping, and `PLAN.md`

If a preferred source route is unavailable, Mansu may do a lightweight fallback
kickoff, but it must label that as fallback and recommend `mansu-setup install`
or `mansu-setup update` when setup is the blocker.

## Mandatory Ouroboros-first rule

For a new product, app, repo, major feature family, or fuzzy idea, Mansu must not
start by inventing its own interview. It must first check whether `ooo` or
`ouroboros` is available and route early definition to Ouroboros:

1. Run or invoke `ouroboros init start` / `ouroboros-interview` for unclear
   user/problem/scope.
2. Use Ouroboros `pm` when product/PRD framing is the next best artifact.
3. Use Ouroboros `seed` or `auto --skip-run` when the idea must become a durable
   source-of-truth before planning.
4. Use Ouroboros `brownfield` before user questions when an existing repo needs
   context.

Mansu may ask at most one bridging question before Ouroboros, and only when it is
needed to choose between `init`/interview, `pm`, `seed`, and `brownfield`.

If Ouroboros is missing, broken, or unsuitable, do not silently continue as if
Mansu owned the interview. Record `Ouroboros skipped reason`, label the kickoff
as fallback, and route to `mansu-setup install/update` unless the user explicitly
asks to continue without Ouroboros.

## Project-start route selector

Before drafting project artifacts, choose the smallest source route that fits the
situation. Do not emulate a source route manually when the matching skill/MCP
tool exists.

Some entries are reference-only sources rather than executable routes.
VoltAgent/awesome-design-md must be inspected as a `DESIGN.md` reference corpus,
not invoked, installed, or treated as a runtime skill.
Open Design (`nexu-io/open-design`) is different: when installed or explicitly
approved for setup, it is a callable design-artifact source route. Mansu should
run the required CLI commands, not ask the user to copy them manually.
Mansu should run the required CLI commands directly.

| Situation | Prefer this source route | Mansu responsibility after it returns |
| --- | --- | --- |
| First-time setup or unclear source readiness | `mansu-setup`; Ouroboros `setup` / `welcome` / `help` when Ouroboros is the chosen route | repair setup before project planning |
| Existing repo needs context before questions | Ouroboros `brownfield`; addyosmani `context-engineering` | use discovered repo facts to avoid asking the user factual/codebase questions |
| Vague idea, unclear user/problem/scope | `ouroboros init start` / `ouroboros-interview`; `gstack-office-hours`; addyosmani `idea-refine` | route only human-decision questions to the user; record session IDs/artifacts and open questions |
| Product/PRD-style definition is needed | Ouroboros `pm`; addyosmani `spec-driven-development` | treat PM/spec output as upstream product artifact before TDR/PLAN |
| Requirements need crystallizing into source-of-truth | Ouroboros `seed`; Ouroboros `auto --skip-run` when full convergence is useful | stop at definition artifacts; do not start implementation from project-start |
| Reference research should drive direction | Oh My `research` / `deepsearch`; addyosmani `source-driven-development` | record evidence, dates, source URLs, and extracted architecture/design lessons |
| Architecture, stack, API, or DX needs critique | `gstack-autoplan`; focused `gstack-plan-*`; addyosmani `api-and-interface-design` | resolve critique into locked decisions and risks |
| UI direction needs exploration | `mansu-setup source-check` when readiness is unclear; Oh My `research` / `deepsearch`; addyosmani `source-driven-development`; Open Design when installed/approved; VoltAgent/awesome-design-md `DESIGN.md` reference only, not an execution route; `gstack-plan-design-review`; `gstack-design-consultation`; `gstack-design-shotgun` | gather visual/taste references before artifact generation when needed; route artifact generation to Open Design when available; then convert decisions into `DESIGN.md` or the project's design artifact |
| Existing source session must continue | Ouroboros `status` / `resume-session`; gstack context restore when applicable | restore the right session and preserve IDs/paths in handoff |
| Execution quality needs independent verdict | Ouroboros `evaluate` / `qa`; `gstack-qa-only`; `gstack-review` | use as evidence, then map remaining risks to Mansu gates |
| Project is stuck or looping | Ouroboros `unstuck`; gstack CEO/eng review; Oh My planning critique | preserve alternatives and unresolved assumptions before choosing a path |
| Long-running autonomous improvement was explicitly requested | Ouroboros `evolve` / `ralph`; Oh My `ralph` / `ultrawork` when implementation slices are independent | use only after the user accepts the autonomy/risk tradeoff |
| Source artifact should become team-visible work | Ouroboros `publish`; addyosmani planning/task breakdown; GitHub issue/PR skills | publish only after Mansu confirms scope, labels, and issue boundaries |

Default for a new project:

1. Check `ooo` / `ouroboros` availability before drafting any Mansu-owned
   project questions. If missing setup blocks Ouroboros, route to `mansu-setup`
   or the chosen source's setup/help route instead of doing a silent fallback.
2. If the repo already exists, gather brownfield/context facts before asking the user.
3. If the idea is fuzzy, prefer Ouroboros init/interview/pm/seed/brownfield first.
   Use gstack office-hours or addyosmani idea/spec only as secondary critique or
   fallback, and record why Ouroboros was skipped.
4. Crystallize a source-of-truth artifact: Seed, spec, PRD, TDR, or equivalent.
5. If user-facing UI is in scope, choose and run the design source route before
   phase roadmap planning.
6. Run research and critique routes before locking architecture, UI direction, or implementation sequence.
7. Only after source artifacts are clear and the project roadmap names the major
   phases, create the current phase `PLAN.md`.
8. Hand the selected phase to `mansu-tdd-total` only when the roadmap artifact,
   active phase, ordered phase list, and current phase `PLAN.md` are all present.

## Zero-to-PLAN minimum gate

Use this as a flexible gate, not a form-filling ritual. Small ideas may satisfy
each item in a short note. Large or risky projects may expand each item into
research notes, spec, TDR, `DESIGN.md`, ADRs, and a phase roadmap.

Before handing off to implementation, the project-start pass must answer:

- Purpose: what are we making, and why does it matter?
- User/problem: who has the problem, what is painful, and what do they do today?
- Evidence: what source route artifacts, references, docs, repos, or community
  signals support this direction, with dates or source paths when available?
- Assumptions: which unsupported guesses are safe for now, which need a source
  route, and which block implementation?
- Direction: what product, technical, architecture, data/API, and UI choices are
  known enough for the current risk level?
- Order: what are the large-grain phases, and which phase starts now?
- Execution bridge: where is the current phase `PLAN.md` or project-convention
  active plan path from `DOCUMENT_CREATION_ORDER.md`, and does it contain
  ordered slices, validation path, gate mapping, and `mansu-tdd-total` mode hints?

If one of these is unknown, either record a safe assumption, route to the right
source skill, or mark it as a blocker. Do not jump into slice implementation just
because the idea sounds exciting.

## Expand when useful

Expand the minimum gate only when the project risk asks for it:

- Market, adoption, or taste risk: inspect GitHub, Reddit, Threads, product
  pages, issues, discussions, and recent activity.
- Technical freshness risk: check official docs, source repos, changelogs,
  release notes, versions, and current examples.
- Architecture or data risk: create or update a spec/TDR and verify it with
  engineering review.
- UI risk: if Open Design is installed or explicitly approved, route design
  artifact generation there first; otherwise inspect VoltAgent/awesome-design-md
  references and create or update `DESIGN.md` before implementation.
- Expensive or durable decision: create an ADR or decision note with alternatives
  and consequences.
- Long project: keep the project roadmap or phase order outside `PLAN.md`, then
  derive the active phase `PLAN.md`.

Expansion decisions must name the risk/ambiguity class, the source route selected
or skipped, the `DOCUMENT_CREATION_ORDER.md` artifact choice, and why the
smallest artifact is enough.

Do not create documents just to satisfy ceremony. Create the smallest artifact
that lets the next agent understand the decision, evidence, and handoff.

## Design route gate

For a user-facing product, app, website, dashboard, editor, mobile flow, or UI
system, project-start must choose a design source route before phase roadmap
planning. Mansu must not replace this with its own design questionnaire unless
all suitable design routes are unavailable and the fallback is recorded.

Choose the smallest route that fits:

| Situation | Prefer this design route | Required output before roadmap |
| --- | --- | --- |
| UI direction, audience, tone, market position, or visual taste is unclear | Oh My `research` / `deepsearch`; addyosmani `source-driven-development`; product references from GitHub, Reddit, Threads, and live product pages | design brief / visual research note with references inspected, selected direction, rejected directions, and taste lessons |
| A visible design artifact or prototype is needed before implementation | Open Design (`nexu-io/open-design`) when installed or explicitly approved for setup | artifact path, preview/export evidence, selected visual direction, and handoff notes |
| A durable agent-readable UI system is needed | VoltAgent/awesome-design-md as `DESIGN.md` reference corpus; `gstack-design-consultation`; `gstack-design-shotgun`; addyosmani `frontend-ui-engineering` | `DESIGN.md` or design doc with visual atmosphere, color roles, typography, components, layout, depth/elevation, do/don't guardrails, responsive behavior, and agent prompt guide |
| The design direction needs independent critique before roadmap lock | `gstack-plan-design-review`; `gstack-design-review` when an artifact exists | review findings resolved or recorded as blockers |
| UI exists and needs runtime/browser evidence | `gstack-browse`; `gstack-qa-only` | screenshot/browser/console/user-flow evidence |

Default design route stack:

1. Detect whether UI/design is in scope from the product definition.
2. For a greenfield UI with no design system or `DESIGN.md`, use
   `gstack-design-consultation` as the default design-system route. It should
   understand the product, research the landscape when needed, propose the design
   system, and create `DESIGN.md`.
3. If taste, market position, competitors, or live product references are
   genuinely unclear, use Oh My / OMO `research` or `deepsearch` before or inside
   the design consultation.
4. Use addyosmani `source-driven-development` when source projects, official UI
   examples, implementation patterns, or reusable frontend architecture should
   shape the design direction.
5. Use `gstack-design-shotgun` when the team needs several visible candidate
   directions before choosing one.
6. For an existing UI or existing plan, use `gstack-plan-design-review` to infer,
   critique, and improve the design plan before implementation.
7. Use `gstack-plan-design-review` before locking the roadmap to critique
   whether the chosen design direction makes sense.
8. If a visible artifact/prototype is needed, route to Open Design when
   installed or explicitly approved.
9. If a durable UI system is needed, use VoltAgent/awesome-design-md as the
   `DESIGN.md` reference corpus and record the resulting `DESIGN.md` or design
   doc path.
10. Record the design route used, skipped routes, references, artifacts, and
   blockers.
11. Only then lock phase roadmap and active phase planning.

Recommended combinations:

- Greenfield app with no design system: `gstack-design-consultation` ->
  `gstack-plan-design-review` -> phase roadmap.
- Ambiguous market/taste: Oh My / OMO `research` or `deepsearch` ->
  addyosmani `source-driven-development` when source examples matter ->
  `gstack-design-consultation` -> `gstack-plan-design-review`.
- Need visible options before choosing: `gstack-design-shotgun` ->
  `gstack-design-consultation` to formalize the chosen direction ->
  `gstack-plan-design-review`.
- Need prototype/artifact before implementation: Open Design ->
  `gstack-plan-design-review` -> `DESIGN.md` / design doc handoff.
- Existing UI or existing plan: `gstack-plan-design-review` first; after
  implementation, use `gstack-design-review`, `gstack-browse`, or
  `gstack-qa-only` for visual/runtime evidence.

If UI is in scope and no design route is selected, do not proceed to
`mansu-tdd-total`. Stop with `Implementation handoff: blocked` and name the
missing design route decision.

## Phase roadmap gate

Project-start must create or update a project roadmap before it creates the
current phase `PLAN.md`.

The roadmap may live in a spec, TDR, design doc, `docs/roadmap/*.md`, or an
existing project convention, but it must be repo-visible unless the user
explicitly asked for a report-only pass.

The roadmap must include:

- phase list: the large project phases in order
- phase goal: the outcome of each phase
- phase boundary: what is inside and outside each phase
- dependency note: which phases depend on previous decisions or artifacts
- active phase: exactly one phase selected for the next `PLAN.md`
- later phase placeholders: enough detail to revisit phase 2, phase 3, and so on
  without pretending their slice plans are final

`PLAN.md` must then be derived from the active phase only. It may mention later
phases as context, but it must not replace the roadmap.

Do not hand off to `mansu-tdd-total` when:

- the roadmap artifact is missing
- the phase list is missing
- no active phase is selected
- multiple phases are selected as active
- the current phase `PLAN.md` contains the whole project instead of one phase

In those cases, stop with a project-start report and say that phase planning is
blocked until the roadmap and active phase are fixed.

## When to use

Use only as an explicit legacy/specialized compatibility route for:

- older workflows that call `$mansu-project-start` by name
- user requests that explicitly ask for `$mansu-project-start`
- compatibility kickoff reports that must preserve the historical
  Zero-to-PLAN callable surface
- architecture or technology stack choice
- UI system or design direction
- TDR/spec work before implementation
- broad refactor where the current direction is unclear

For normal new ideas, fuzzy discovery, new repos/products, major feature
families, architecture direction, UI direction, TDR/spec work, or broad
refactors, use `mansu-1define` first and then `mansu-2plan` unless the user
explicitly asks for `$mansu-project-start` or an older workflow depends on it.

Do not use for:

- small bug fixes
- already-scoped implementation slices
- pure release/ship work

## Source skills to consider

Load only what the current phase needs.

| Need | Source route |
| --- | --- |
| Problem and wedge | `gstack-office-hours`, addyosmani `idea-refine` |
| Project definition seed | Ouroboros init/PM/Seed/Ledger flows such as `ouroboros init start`, `ouroboros pm`, `ouroboros seed` / `ouroboros-auto --skip-run`, or legacy `ooo` wrappers when available |
| Spec and requirements | addyosmani `spec-driven-development` |
| Reference research | Oh My `research` / `deepsearch`, addyosmani `source-driven-development` |
| Product/design/eng/DX critique | `gstack-autoplan`, then focused `gstack-plan-*` reviews |
| DESIGN.md reference / visual taste | VoltAgent/awesome-design-md reference collection |
| Design artifact generation | Open Design (`nexu-io/open-design`) when installed or explicitly approved for setup |
| UI direction | Open Design when available; otherwise `gstack-plan-design-review`, `gstack-design-consultation`, `gstack-design-shotgun` |
| API/module contracts | addyosmani `api-and-interface-design`, `gstack-plan-eng-review` |
| Document routing | `mansu-operating-model/references/DOCUMENT_CREATION_ORDER.md` |
| Coding-order handoff | `mansu-operating-model/references/CODE_CONSTRUCTION_ORDER.md` |

Before inventing a new source route, check
`mansu-operating-model/references/SOURCE_SKILL_CATALOG.md`.

## Research discipline

For technical decisions:

- prefer official docs, source files, changelogs, release notes, and primary
  repositories
- record version, date checked, commit/tag when available, and uncertainty
- use external search when the library, standard, pricing, or ecosystem may have
  changed

For market/product/UI signals:

- inspect GitHub stars/issues/activity, recent commits, forks, discussions, and
  docs quality
- use Reddit and Threads to find pain, enthusiasm, complaints, and taste signals
- prefer recent references, but keep older/classic references when they explain a
  durable architecture or design philosophy
- separate adoption signal from technical truth

Do not copy a reference project. Extract intent, architecture, constraints,
tradeoffs, reusable patterns, and anti-patterns.

## Reference artifact defaults

Follow the project's existing document convention first. If none exists, use
these repo-visible defaults so future agents can find the evidence:

- research and reference evidence: `docs/research/{topic-slug}.md`
- product/spec direction: `docs/specs/{project-or-feature-slug}.md`
- architecture/TDR direction: `docs/technical/{project-or-feature-slug}.md`
- UI direction: `DESIGN.md` for project-wide UI, or `docs/design/{feature-slug}.md`
- active phase execution: `PLAN.md`

`PLAN.md` should link to research/spec/TDR/design artifacts instead of becoming
the full evidence archive.


## Workflow

1. Start with Ouroboros for project definition whenever available: run
   interview, PM, Seed, or brownfield according to the route selector, then
   capture the resulting artifacts before Mansu creates its own documents.
2. Classify risk and decide which documents are needed using
   `DOCUMENT_CREATION_ORDER.md`.
3. Create or update `AGENTS.md` and `CODING_RULES.md` when the repo lacks local
   operating rules.
4. Research source projects and references with evidence-ranked sources.
5. Analyze references at code level when they materially influence architecture,
   stack, or UI.
6. When UI exists, choose and run the design source route from the Design route
   gate. Prefer Open Design for artifact generation when installed/approved;
   use VoltAgent/awesome-design-md as reference corpus for `DESIGN.md`; use
   gstack design skills for consultation, shotgun exploration, review, and
   independent critique.
7. Record design references, selected direction, rejected directions, artifact
   or `DESIGN.md` path, review evidence, and blockers. Avoid copying a brand
   identity blindly.
8. Draft the spec/TDR/roadmap layer: domain language, feature groups, data/API boundaries,
   tech stack, architecture, secret/API-key handling, UI direction, phase roadmap,
   risks, non-goals, and open questions.
9. Decide the large-grain build order: feature groups, dependencies, phase
   sequence, integration strategy, and what should wait.
10. Critique with product, design, engineering, and DX roles or source skills.
11. Resolve critique into a single project direction.
12. Select exactly one active phase from the roadmap.
13. Create the current phase `PLAN.md` with ordered vertical slices, validation
   path, gate mapping, and handoff to `mansu-tdd-total` for phase execution.

## Roadmap vs PLAN.md boundary

The big project plan and `PLAN.md` are different artifacts.

- The project roadmap belongs in the spec/TDR/design layer. It answers questions
  like: Which feature groups exist? Should login, data, menus, board, admin, and
  deployment be built in that order? Which architecture or API contracts must
  exist first? What can wait?
- `PLAN.md` belongs to the active phase. It answers questions like: For the
  login phase, what are the ordered slices, acceptance criteria, touched files,
  validation commands, review/QA gates, and next checkpoint?
- When the active phase changes, make a new or refreshed phase `PLAN.md` from the
  roadmap instead of expanding `PLAN.md` into the whole project memory.

## Required handoff to phase execution

The handoff must name:

- upstream source-of-truth artifacts and paths
- Ouroboros artifacts used, or the reason Ouroboros was skipped
- source skills used and skipped
- references inspected, with date/version/source evidence
- design references used and `DESIGN.md` status when UI is in scope
- design source route selected, or the reason UI/design routing was skipped
- visual/taste research used, selected direction, and rejected directions when
  UI direction was unclear
- Open Design route status, artifact path, preview/export path, or fallback
  reason when UI artifact generation is in scope
- minimum gate status: purpose, user/problem, evidence, assumptions, direction,
  order, and execution bridge
- expanded artifacts used, or the reason expansion was skipped
- locked decisions and why
- open questions and whether they block implementation
- project roadmap or phase order artifact
- phase list and active phase selection
- current phase goal
- ordered vertical slices
- gate mapping: review, QA, checkpoint, commit/no-commit, ship judgment
- validation commands or how they will be discovered
- worklog target
- recommended `mansu-tdd-total` slice modes: `lite`, `strict`, or `blocked`

Project-start must not implement the slices itself. Once the current phase is
execution-ready, the next owner is `mansu-tdd-total`: it takes the phase goal,
slice table, validation path, and gate mapping, then runs the phase as
slice-level work. If blockers, risky choices, or an explicit approval gate remain,
stop with the handoff report instead of entering `mansu-tdd-total`.

If the phase roadmap gate is not satisfied, do not enter `mansu-tdd-total`.
Return the project-start report with `Implementation handoff: blocked` and the
missing roadmap/active-phase fields.

## Final report

Write the report in the user's language or the project's default language.
Field labels may stay canonical, but prose and values should follow that language
unless the user asks otherwise.

```text
MANSU PROJECT START REPORT
Project intent:
Upstream source-of-truth artifacts and paths:
Ouroboros artifacts:
Ouroboros skipped reason:
Documents created/updated:
References researched:
References inspected with date/version/source evidence:
Design references used:
Design route selected:
DESIGN.md status:
Minimum gate status:
- Purpose:
- User/problem:
- Evidence:
- Assumptions:
- Direction:
- Order:
- Execution bridge:
Expanded artifacts used/skipped:
Source skills used:
Source skills skipped:
Architecture/stack decision:
UI direction:
Project roadmap / phase order artifact:
Phase list:
Active phase:
Locked decisions and why:
Open questions and blocker status:
Risks and blockers:
Current phase PLAN:
Current phase goal:
Ordered vertical slices:
Gate mapping:
Validation commands:
Worklog target:
Recommended mansu-tdd-total modes:
Implementation handoff:
Next skill:
```
