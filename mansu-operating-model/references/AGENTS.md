# AGENTS.md

## Operating Doctrine

This project follows the Mansu operating doctrine for software delivery.

Before doing non-trivial coding work, read:
1. the relevant Mansu doctrine entry or required Mansu skill
2. this project's `CODING_RULES.md`

Do not treat coding work as a single implementation burst unless the task clearly qualifies as quick work.

## Authority Order

Authority works by subject:
- explicit user instruction controls the requested outcome and immediate constraints unless unsafe or impossible
- this project's `CODING_RULES.md` controls project-specific commands, paths, runtimes, validation commands, and dangerous surfaces
- this `AGENTS.md` controls local routing and entry instructions
- Mansu canonical doctrine controls universal workflow gates, role separation, strictness, evidence, and ship-readiness rules

Project-local documents may specialize the doctrine. They must not weaken it.
If local rules appear to contradict a non-negotiable Mansu doctrine rule, report the conflict and use the safer interpretation.

## Required Workflow Interpretation

Interpret non-trivial coding work as an orchestrated process.

Default flow:
1. classify the task
2. plan before implementation
3. keep implementation and review logically separate
4. run validation appropriate to task risk
5. do not claim ship readiness without evidence

For heavy work, the expected flow is:
- plan
- critique
- execution-ready decision
- slice
- build
- checkpoint when needed
- review
- QA
- commit or record explicit no-commit reason
- worklog update
- ship or hold

Once a plan is execution-ready, continue automatically unless the user explicitly requested a human approval gate, the next action is risky, or a blocker remains unresolved.

Quick work may compress phases, but it does not waive direct validation or honest completion reporting.

## Role Contract

Use distinct logical roles:
- operator
- planner
- critic
- builder
- reviewer
- QA
- checkpoint
- shipper

One runtime may execute multiple roles sequentially.
Those roles must not be collapsed into one unexamined pass.

Implementation is not review.
Review is not QA.
QA is not ship approval.

## Routing Contract

Choose the relevant Mansu path based on task character.

First-hop routes:
- unsure what to do next -> `mansu-help`
- first install, stale tools, or unclear runtime/source readiness -> `mansu-setup`
- new product, app, repo, major feature family, architecture direction, UI system, or TDR-style kickoff -> `mansu-project-start`
- current phase implementation or refactor with slices -> `mansu-tdd-total`
- unclear failure, regression, stack trace, or broken behavior -> `mansu-debug-rootcause`
- real-user web flow, buttons, pages, forms, responsive, performance, or safe security verification -> `mansu-web-verify`
- release readiness, commit/PR/release notes, ship-or-hold judgment -> `mansu-ship-release`
- source skill drift, source catalog refresh, or Mansu reference maintenance -> `mansu-source-curator`
- project doctrine, `AGENTS.md`, or `CODING_RULES.md` work -> `mansu-operating-model`

Reference maps:
- source skill selection -> `mansu-operating-model/references/SOURCE_SKILL_CATALOG.md`
- document/artifact order -> `mansu-operating-model/references/DOCUMENT_CREATION_ORDER.md`
- code construction order -> `mansu-operating-model/references/CODE_CONSTRUCTION_ORDER.md`
- project-local commands, paths, validation, dangerous surfaces -> `CODING_RULES.md`

Examples:
- new scoped implementation -> `mansu-tdd-total`
- unclear failure or regression -> `mansu-debug-rootcause`
- runtime or browser behavior claim -> `mansu-web-verify`
- high-assurance request -> `mansu-tdd-total` with strict mode, or block if strict prerequisites are unavailable

If the right path is unclear, classify the task before acting.

## Approval Rule

Do not begin significant implementation until:
- objective is clear
- scope is bounded
- likely change surface is understood
- validation path is known

For standard or heavy work, build begins only after the plan names scope, likely change surfaces, risks, and validation path clearly enough for execution.

## Strict Rule

If a task is declared strict, unmet strict prerequisites block the task.

Do not imitate strict mode with partial substitutes while still calling it strict.

If fallback execution is proposed, label it explicitly as fallback.

## Local Rules Boundary

Project-specific commands, paths, test flows, dangerous surfaces, and ship checks belong in `CODING_RULES.md`.

Do not overload `AGENTS.md` with local command detail that belongs in the local operating manual.
