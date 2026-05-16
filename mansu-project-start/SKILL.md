---
name: mansu-project-start
description: Zero-to-PLAN project kickoff workflow for Mansu. Use when starting a new product, app, repo, major feature family, architecture direction, UI system, or TDR-style project from idea stage; when the agent must use prepared Ouroboros project-definition flows when useful, research references, define purpose, compare source projects, choose architecture/tech stack/UI direction, create the right planning documents, and hand off into `mansu-tdd-total` with an execution-ready phase plan.
---

# Mansu Project Start

Use this skill before implementation when the work is still bigger than a
single feature slice.

This skill creates the project-level thinking layer: intent, research, spec,
Ouroboros Seed/Ledger when useful, TDR/architecture, UI direction when needed,
operating rules, project roadmap/phase order, and the first phase-level
`PLAN.md`.

It does not own slice implementation. It defines the project purpose, source of
truth, large-grain phase roadmap, and current phase handoff. `mansu-tdd-total`
owns the selected phase's detailed slices, implementation loop, review, QA, and
checkpoint.

## Core promise

- Start from purpose, user, desired outcome, and non-goals.
- Use Ouroboros as a project-definition engine when `mansu-setting` has prepared it and the work begins from a vague or high-level idea.
- Find and inspect relevant current references before locking direction.
- Use official/source files first for technical facts; use GitHub, Reddit, and
  Threads for adoption, taste, patterns, and market signal with dates recorded.
- Compare architecture, domain model, language, stack, UI/UX, tradeoffs, and
  philosophy of reference projects.
- Produce only the documents needed for the risk level.
- Verify the plan with distinct product/design/engineering/DX critique.
- Create the large-grain feature/phase order before creating slice plans.
- Hand off into `PLAN.md` with the current phase and its first vertical slice table.

## Orchestration posture

Do not reimplement strong source routes inside Mansu.

Mansu's posture is a thin project-start orchestrator:

- delegate fuzzy project definition to Ouroboros when it is the best available route
- delegate problem/wedge review, spec, research, design, architecture, or DX review
  to gstack, Oh My, addyosmani, or another stronger source route when appropriate
- avoid asking duplicate questions that a selected source route already asks
- ask the user only when a missing answer materially changes scope,
  architecture, cost, security, user flow, or implementation order
- record low-risk assumptions instead of blocking on every unknown
- translate source artifacts into Mansu-owned documents, phase boundaries,
  gate mapping, and `PLAN.md`

If a preferred source route is unavailable, Mansu may do a lightweight fallback
kickoff, but it must label that as fallback and recommend `mansu-setting install`
or `mansu-setting update` when setup is the blocker.

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
| First-time setup or unclear source readiness | `mansu-setting`; Ouroboros `setup` / `welcome` / `help` when Ouroboros is the chosen route | repair setup before project planning |
| Existing repo needs context before questions | Ouroboros `brownfield`; addyosmani `context-engineering` | use discovered repo facts to avoid asking the user factual/codebase questions |
| Vague idea, unclear user/problem/scope | Ouroboros `interview`; `gstack-office-hours`; addyosmani `idea-refine` | route only human-decision questions to the user; record session IDs/artifacts and open questions |
| Product/PRD-style definition is needed | Ouroboros `pm`; addyosmani `spec-driven-development` | treat PM/spec output as upstream product artifact before TDR/PLAN |
| Requirements need crystallizing into source-of-truth | Ouroboros `seed`; Ouroboros `auto --skip-run` when full convergence is useful | stop at definition artifacts; do not start implementation from project-start |
| Reference research should drive direction | Oh My `research` / `deepsearch`; addyosmani `source-driven-development` | record evidence, dates, source URLs, and extracted architecture/design lessons |
| Architecture, stack, API, or DX needs critique | `gstack-autoplan`; focused `gstack-plan-*`; addyosmani `api-and-interface-design` | resolve critique into locked decisions and risks |
| UI direction needs exploration | Open Design when installed/approved; VoltAgent/awesome-design-md `DESIGN.md` reference only, not an execution route; `gstack-plan-design-review`; `gstack-design-consultation`; `gstack-design-shotgun` | route artifact generation to Open Design when available, then convert decisions into `DESIGN.md` or the project's design artifact |
| Existing source session must continue | Ouroboros `status` / `resume-session`; gstack context restore when applicable | restore the right session and preserve IDs/paths in handoff |
| Execution quality needs independent verdict | Ouroboros `evaluate` / `qa`; `gstack-qa-only`; `gstack-review` | use as evidence, then map remaining risks to Mansu gates |
| Project is stuck or looping | Ouroboros `unstuck`; gstack CEO/eng review; Oh My planning critique | preserve alternatives and unresolved assumptions before choosing a path |
| Long-running autonomous improvement was explicitly requested | Ouroboros `evolve` / `ralph`; Oh My `ralph` / `ultrawork` when implementation slices are independent | use only after the user accepts the autonomy/risk tradeoff |
| Source artifact should become team-visible work | Ouroboros `publish`; addyosmani planning/task breakdown; GitHub issue/PR skills | publish only after Mansu confirms scope, labels, and issue boundaries |

Default for a new project:

1. If readiness is unknown, route to `mansu-setting` or the chosen source's
   setup/help route only when missing setup blocks the next project-definition
   step. Otherwise run a lightweight kickoff, record setup uncertainty, and
   ask only the product questions needed to continue.
2. If the repo already exists, gather brownfield/context facts before asking the user.
3. If the idea is fuzzy, choose the best definition route: Ouroboros interview/pm,
   gstack office-hours, or addyosmani idea/spec depending on the artifact needed.
4. Crystallize a source-of-truth artifact: Seed, spec, PRD, TDR, or equivalent.
5. Run research and critique routes before locking architecture, UI direction, or implementation sequence.
6. Only after source artifacts are clear, create the current phase `PLAN.md` and
   hand the selected phase to `mansu-tdd-total` for slice-level execution.

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

## When to use

Use for:

- new repository or product from zero
- major feature family
- architecture or technology stack choice
- UI system or design direction
- TDR/spec work before implementation
- broad refactor where the current direction is unclear

Do not use for:

- small bug fixes
- already-scoped implementation slices
- pure release/ship work

## Source skills to consider

Load only what the current phase needs.

| Need | Source route |
| --- | --- |
| Problem and wedge | `gstack-office-hours`, addyosmani `idea-refine` |
| Project definition seed | Ouroboros PM/interview/Seed/Ledger flows such as `ooo pm`, `ooo interview`, `ooo seed`, or `ouroboros auto --skip-run` when available |
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

1. Define the project intent: who, problem, current workaround, desired outcome,
   not-doing list, success signal. If Ouroboros is available and useful, start
   with its PM/interview/Seed route and capture the resulting artifacts.
2. Classify risk and decide which documents are needed using
   `DOCUMENT_CREATION_ORDER.md`.
3. Create or update `AGENTS.md` and `CODING_RULES.md` when the repo lacks local
   operating rules.
4. Research source projects and references with evidence-ranked sources.
5. Analyze references at code level when they materially influence architecture,
   stack, or UI.
6. When UI exists, check whether Open Design is installed or approved for setup.
   If it is, let Mansu run the Open Design CLI/lifecycle commands and route the
   design artifact generation there instead of recreating that workflow.
7. Inspect relevant VoltAgent/awesome-design-md references and
   create or update `DESIGN.md` with visual atmosphere, color roles, typography,
   component rules, layout, depth/elevation, do/don't guardrails, responsive
   behavior, and agent prompt handoff. Record the reference date/commit and avoid
   copying a brand identity blindly.
8. Draft the spec/TDR layer: domain language, feature groups, data/API boundaries,
   tech stack, architecture, secret/API-key handling, UI direction, roadmap,
   risks, non-goals, and open questions.
9. Decide the large-grain build order: feature groups, dependencies, phase
   sequence, integration strategy, and what should wait.
10. Critique with product, design, engineering, and DX roles or source skills.
11. Resolve critique into a single project direction.
12. Create the current phase `PLAN.md` with ordered vertical slices, validation
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
- Open Design route status, artifact path, preview/export path, or fallback
  reason when UI artifact generation is in scope
- minimum gate status: purpose, user/problem, evidence, assumptions, direction,
  order, and execution bridge
- expanded artifacts used, or the reason expansion was skipped
- locked decisions and why
- open questions and whether they block implementation
- project roadmap or phase order artifact
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
