---
name: mansu-project-start
description: Zero-to-PLAN project kickoff workflow for Mansu. Use when starting a new product, app, repo, major feature family, architecture direction, UI system, or TDR-style project from idea stage; when the agent must research references, define purpose, compare source projects, choose architecture/tech stack/UI direction, create the right planning documents, and hand off into `mansu-tdd-total` with an execution-ready phase plan.
---

# Mansu Project Start

Use this skill before implementation when the work is still bigger than a
single feature slice.

This skill creates the project-level thinking layer: intent, research, spec,
TDR/architecture, UI direction when needed, operating rules, and the first
phase-level `PLAN.md`.

It does not implement the project. It hands off to `mansu-tdd-total` after the
current phase is execution-ready.

## Core promise

- Start from purpose, user, desired outcome, and non-goals.
- Find and inspect relevant current references before locking direction.
- Use official/source files first for technical facts; use GitHub, Reddit, and
  Threads for adoption, taste, patterns, and market signal with dates recorded.
- Compare architecture, domain model, language, stack, UI/UX, tradeoffs, and
  philosophy of reference projects.
- Produce only the documents needed for the risk level.
- Verify the plan with distinct product/design/engineering/DX critique.
- Hand off into `PLAN.md` with ordered phases and the first vertical slice table.

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
| Spec and requirements | addyosmani `spec-driven-development` |
| Reference research | Oh My `research` / `deepsearch`, addyosmani `source-driven-development` |
| Product/design/eng/DX critique | `gstack-autoplan`, then focused `gstack-plan-*` reviews |
| UI direction | `gstack-plan-design-review`, `gstack-design-consultation`, `gstack-design-shotgun` |
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

## Workflow

1. Define the project intent: who, problem, current workaround, desired outcome,
   not-doing list, success signal.
2. Classify risk and decide which documents are needed using
   `DOCUMENT_CREATION_ORDER.md`.
3. Create or update `AGENTS.md` and `CODING_RULES.md` when the repo lacks local
   operating rules.
4. Research source projects and references with evidence-ranked sources.
5. Analyze references at code level when they materially influence architecture,
   stack, or UI.
6. Draft the spec/TDR layer: domain language, feature groups, data/API boundaries,
   tech stack, architecture, secret/API-key handling, UI direction, roadmap,
   risks, non-goals, and open questions.
7. Critique with product, design, engineering, and DX roles or source skills.
8. Resolve critique into a single project direction.
9. Create the current phase `PLAN.md` with ordered vertical slices, validation
   path, gate mapping, and handoff to `mansu-tdd-total`.

## Required handoff to implementation

The handoff must name:

- upstream source-of-truth artifacts and paths
- source skills used and skipped
- references inspected, with date/version/source evidence
- locked decisions and why
- open questions and whether they block implementation
- current phase goal
- ordered vertical slices
- gate mapping: review, QA, checkpoint, commit/no-commit, ship judgment
- validation commands or how they will be discovered
- worklog target
- recommended `mansu-tdd-total` slice modes: `lite`, `strict`, or `blocked`

Mansu continues automatically into `mansu-tdd-total` after the phase plan is
execution-ready unless the user requested approval, the next action is risky, or
blockers remain unresolved.

## Final report

```text
MANSU PROJECT START REPORT
Project intent:
Documents created/updated:
References researched:
Source skills used:
Architecture/stack decision:
UI direction:
Risks and blockers:
Current phase PLAN:
Implementation handoff:
Next skill:
```
