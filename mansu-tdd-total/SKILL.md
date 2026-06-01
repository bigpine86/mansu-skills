---
name: mansu-tdd-total
description: End-to-end dispatcher, planner, and completion orchestrator for Mansu TDD workflows. Use when the user wants `mansu-tdd-total`, a full Mansu TDD planning pass, or a mixed workflow that decides `mansu-tdd-lite` vs `mansu-tdd-strict` per vertical slice. This skill plans, critiques, records the execution-ready plan in `PLAN.md`, classifies slices, runs every unblocked slice through the selected lite or strict skill, and closes the work with final verification, worklog, and commit accounting.
---

# Mansu TDD Total

Use this skill as the default entry point for Mansu TDD work when the right execution mode is not obvious upfront.

For the current runtime, read this as runtime-neutral orchestration: keep the planning roles explicit, keep slice routing explicit, and avoid pretending legacy tool names are required when equivalent current-runtime roles are available.

## Mansu philosophy

Mansu does not reinvent strong workflows. It plans, separates roles, routes work to
the right source skill, verifies the result, and records what happened.

Use this skill as the TDD-series orchestrator: it owns planning, critique,
mode selection, sequential dispatch, and final closeout. It delegates each
slice's execution details to `mansu-tdd-lite` or `mansu-tdd-strict`, but it
remains responsible for making sure the overall workflow actually finishes.

## Core promise

- Plan once.
- Critique the plan before implementation with explicit planning roles.
- Synthesize one execution-ready plan before any slice starts.
- Split the work into vertical slices.
- Choose `mansu-tdd-lite` or `mansu-tdd-strict` for each slice.
- Record the per-slice mode decision and rationale in `PLAN.md`.
- Execute every unblocked slice in order through the selected skill.
- Persist in a Ralph-style loop until all slices are closed, blocked with a recorded reason, or explicitly stopped by the user.
- Run final project-level verification, worklog update, and commit accounting after the slices are complete.

## Shared invariants

These rules do not change between `lite` and `strict`:

- Plan properly before implementation.
- Slice by feature, behavior, or user flow.
- Define completion conditions, impact files, risks, and validation path for every slice.
- Run review, QA, checkpoint, and commit for each slice.
- Do not start the next slice until the current slice is fully closed.
- Keep `PLAN.md` current.
- Record completed work in `개발일지.md` or the project worklog.
- Do not use `lite` as permission to lower work quality.
- Treat missing review, QA, checkpoint, worklog, or commit evidence as an open slice, not as a finished slice.

## Oh My execution-mode mapping

Mansu TDD Total uses Oh My / OMO / OMC execution-mode skills by name when they
are installed. This is not a generic list of every Oh My skill; these are the
clear execution modes used by this workflow:

- persistence loop: `ralph`
- strict TDD habit: `tdd`

Use `ralph` as the persistence rule for the whole workflow: keep retrying,
re-routing, and verifying until every unblocked slice is closed or the work is
explicitly blocked.

Use `tdd` only inside slices routed to `mansu-tdd-strict`, where a meaningful
RED -> GREEN -> REFACTOR loop improves confidence.

Do not use parallel Oh My modes such as `ultrawork` or `ultrapilot` for the
default slice execution loop. Mansu TDD slices are sequential by default. Use
parallel modes only for dependency-free discovery or explicitly approved
independent work that cannot affect the current slice order.

## Gstack gate mapping

Mansu's default implementation gates come from the gstack family when those
skills are installed in the current runtime. Do not treat `review`, `QA`,
`checkpoint`, or `health` as vague self-check words.

Use these core gstack skills by name when they are installed:

- review gate: `gstack-review`
- QA evidence without fixes: `gstack-qa-only` or `gstack-browse`
- QA test-fix-verify loop when fixes are approved: `gstack-qa`
- checkpoint/state handoff: `gstack-context-save` and `gstack-context-restore`;
  `gstack-checkpoint` only when the installed runtime still exposes it
- health gate: `gstack-health`

If the current runtime exposes these under shorter commands such as `review`,
`qa`, `qa-only`, `browse`, or `health`, map the concrete gstack skill above to
that callable command and record the mapping.

`gstack-health` is mandatory at final closeout when the project has an equivalent
health command. Run it per-slice only for strict, high-risk, or broad code-changing
slices when the check is cheap enough; otherwise record that health is deferred to
final closeout.

Optional escalation gates:

- use `gstack-cso` only when the slice changes auth, permissions, secrets,
  data exposure, supply chain, or LLM trust boundaries
- use `gstack-benchmark` only when the slice can affect loading, runtime
  latency, bundle/resource size, or performance-sensitive paths

Do not run `gstack-ship` from this TDD loop by default. Hand release and PR
workflow to `mansu-ship-release` when the implementation work is complete.

If the gstack gate is unavailable, use a project-standard equivalent only when
it is separately invoked, produces evidence, and is recorded in `PLAN.md` or the
worklog. A builder saying "I reviewed it" is not enough.

Commit policy:

- Default to per-slice commits during implementation when the repo/project allows it.
- Strict slices treat a slice commit as part of the close gate after review, QA,
  and checkpoint. If user or project policy forbids a commit, record the policy
  override and mark the slice `commit-deferred` instead of fully closed until
  final commit accounting resolves it.
- Use a final release/docs commit only for final docs, version, changelog, or when the project policy explicitly deferred slice commits.
- If any commit is deferred, record the no-commit reason, remaining diff scope, and next owner in `PLAN.md` or the worklog.

The only core difference is the RED test requirement:

- `strict`: every slice starts with a meaningful failing RED test.
- `lite`: every slice still defines validation before coding, but does not force an artificial RED test.

## When to use

Use this skill when:

- the work may contain both low-risk and high-risk slices
- you are unsure whether every slice needs strict failing-test-first TDD
- the user asks for a full Mansu TDD flow
- a task needs planning and routing before implementation starts

## What this skill does not do

- Do not duplicate executor details from `mansu-tdd-lite` or `mansu-tdd-strict`.
- Do not copy strict gate templates into this skill.
- Do not manually imitate missing strict prerequisites.
- Do not turn every slice into strict mode just because strict mode exists.
- Do not downgrade a risky slice to lite after implementation has started.

## Preflight

Before planning, confirm:

- the repository has `git` and write access
- there is an active plan path, preferably `PLAN.md`
- for project-started work, `PLAN.md` names the active phase and links to a
  project roadmap or phase order artifact
- there is a completed-work log path, preferably `개발일지.md` when the project uses Korean worklogs
- review, QA, checkpoint, and commit gates are available or have clear project equivalents
- if the current host supports subagents, helper sessions, or external critic tools, there is a usable path for real critic review before implementation
- the current-runtime names for `ralph`, `tdd`, `gstack-review`, `gstack-qa-only`, `gstack-browse`, `gstack-qa`, `gstack-context-save`/`gstack-context-restore`, and `gstack-health` are known, or explicit project equivalents are recorded
- `mansu-tdd-lite` is available for lite slices
- `mansu-tdd-strict` prerequisites are available before assigning strict slices

If the work came from a new product/app/repo/major feature-family kickoff and
`PLAN.md` does not name an active phase plus its roadmap/phase-order artifact,
do not start implementation. Route back to `mansu-project-start` to create the
phase roadmap and active phase plan first.

If `PLAN.md` contains the whole project roadmap instead of one active phase,
split it: keep the roadmap in the spec/TDR/design layer, then derive a phase-only
`PLAN.md` before slice execution.

An equivalent review, QA, or checkpoint gate must be separately invoked, produce
status/evidence, and be distinguishable from the builder's self-summary.

When actual multi-agent or helper-session critique is available safely, use it
for non-trivial work instead of silently replacing it with a single-session role
play. Available safely means the host supports it, current runtime instructions
and user direction permit it, task data can be shared safely, and the critic path
can return useful feedback for the planning gate.

Real critic attempt/evidence is required for any multi-slice, strict,
architecture, data-contract, security, UX-risk, or user-visible behavior work
when the runtime can provide critics safely. Local role separation is only a
fallback for a single low-risk lite slice, unsupported hosts, unsafe data/scope,
critic setup failure/timeout, or an explicit user speed tradeoff. Record the
reason and fallback critique when using the fallback.

If strict prerequisites are missing, still plan the work, but mark would-be strict slices as blocked instead of pretending to run strict mode.

## Planning gate

For non-trivial work, do not treat planning as a single-agent TODO list.
Planning must pass through explicit roles before slice dispatch.

## Required planning roles

Use these responsibilities before implementation:

- Planner: draft the plan.
  Example mapping: the main planning pass in the current runtime session, or a dedicated planning tool when one exists.
- Critics: challenge the plan.
  Example mapping: one or more critique passes, reviewer sessions, or critic tools that challenge scope, risk, and design.
- Synthesizer: merge critique into one execution-ready plan and remove contradictions.

Depending on the runtime, the mapping may be a mix of runtime-backed helper
sessions, subagents, external review tools, or local review passes.

For non-trivial work, prefer actual independent critic agents, helper sessions,
or external critic tools when the runtime can provide them safely. If exact
historical agent names or tools are unavailable, map the available runtime
roles, tools, sessions, or perspectives to these three responsibilities and
record the mapping in `PLAN.md`.

## Real critic agent gate

If actual critic sub-agents, helper sessions, or external critic tools are started, their outputs become
planning-gate inputs.

- Record the critic names, responsibilities, and status in `PLAN.md`.
- While critics run, continue only non-overlapping discovery or code reading.
- Do not lock the execution-ready plan or start implementation while an expected critic is still pending.
- Do not declare a critic unavailable merely because it is slower than local
  role-play; wait for it or record a real timeout/failure.
- If a critic fails or times out, record the failure, run an explicit local fallback for that responsibility, and mark any missing high-risk question as `blocked`.
- Reconcile late critic feedback before starting the next slice, or immediately if it reveals data-contract, security, architecture, or UX-risk issues.

If a slice would require `mansu-tdd-strict` but the strict prerequisites are unavailable in the current runtime, do not substitute a looser execution path under the same label. Keep the slice status `blocked`, record the missing prerequisite, and either re-route only after re-planning or stop for user-visible follow-up.

Do not proceed to implementation until the execution-ready plan and slice table are visible.
Once they are visible, continue automatically unless the user explicitly requested
a human approval gate, a risky action requires approval, or a plan gap remains unresolved.

## Execution-ready plan requirements

The execution-ready plan must include:

- goal and user value
- upstream source-of-truth artifacts and paths
- locked decisions and open-question carryover from spec, TDR, ADR, design, or research docs
- non-goals and constraints
- domain language and DDD-style responsibility boundaries
- architecture and module boundaries
- pre-refactor and file/module split plan so the implementation does not grow one giant file
- source skills or tools to use
- Oh My execution-mode mapping: `ralph` for persistence and `tdd` for strict slices, or their current-runtime equivalents
- gstack gate mapping: concrete names for `gstack-review`, `gstack-qa-only`/`gstack-browse`, `gstack-qa`, `gstack-context-save` and `gstack-context-restore`, and `gstack-health`, or their current-runtime equivalents
- code construction router: current phase, source skill to read, dependency/context/contract notes, and slice coding sequence
- risks and mitigation
- test and validation strategy
- documentation and worklog targets
- execution readiness status

If any of these are unknown, mark the gap explicitly instead of pretending the plan is complete.

## Planning loop

1. Clarify the goal, user value, constraints, and references.
2. Map the Planner, Critics, and Synthesizer roles.
   Prefer real critic agents, helper sessions, or external critique tools when safely available.
3. Draft the implementation plan through the Planner role.
4. Critique the plan through the Critics role.
5. If real critic agents were started, wait for them or record a real failure/timeout fallback.
6. Synthesize the execution-ready plan, including resolved tradeoffs and remaining gaps.
7. Apply the code construction router from `mansu-operating-model/references/CODE_CONSTRUCTION_ORDER.md`: detect the current construction phase, read the relevant source skill when needed, and extract phase-specific actions.
8. Split the work into vertical slices by feature, behavior, or user flow.
9. Assign each slice a mode: `lite`, `strict`, or `blocked`.
10. Record the role mapping, critic status, execution-ready plan, slice table, and mode decisions in `PLAN.md`.
11. Start execution automatically after the plan gate passes; pause only for explicit approval gates, risky actions, or unresolved blockers.
12. Continue the sequential slice loop until every unblocked slice is closed.
13. Run final closeout verification and commit accounting.

## Dispatch rules

Choose `mansu-tdd-strict` when a slice includes:

- data model, persistence, or migration changes
- auth, permission, security, payment, or privacy risk
- API contract or cross-module behavior changes
- complex state management
- high regression risk or repeated bug history
- a meaningful failing RED test that would improve confidence

Choose `mansu-tdd-lite` when a slice includes:

- UI polish or presentational work
- documentation, README, or copy changes
- configuration, scaffolding, or repository housekeeping
- small contained refactors
- manual, visual, browser, type, or focused validation that is more natural than a forced RED test

Prefer mixed routing when a single feature has different risk levels by slice.

## Slice table

Each planned slice should include:

- slice name
- upstream artifact or decision this slice implements
- user-visible or behavior-visible outcome
- completion conditions
- impact files
- risks
- validation path
- Oh My execution mode: `ralph` persistence plus `tdd` only when strict RED/GREEN/REFACTOR is selected
- gstack gate path: which named gstack skills or current-runtime equivalents close this slice, for example `gstack-review -> gstack-qa-only or gstack-qa -> gstack-context-save -> commit`; do not accept builder self-review as gate evidence
- mode: `lite`, `strict`, or `blocked`
- why this mode
- delegated skill: `mansu-tdd-lite` or `mansu-tdd-strict`
- construction router notes: current phase, source skill read or skipped, dependency, context to load, contract to lock, and safe-default/rollback concern
- pre-refactor notes: responsibility boundary, files/modules to split, and what must not be dumped into a giant file
- close criteria
- worklog note

## Execution handoff

For slices marked `lite`, execute with `mansu-tdd-lite`.

For slices marked `strict`, execute with `mansu-tdd-strict`.

For slices marked `blocked`, do not implement that slice. Record the blocker,
owner/decision needed, and whether later slices depend on it. Continue to later
independent unblocked slices only when dependency order and the execution-ready
plan remain valid; otherwise stop and report the blocking decision.

After each delegated slice returns, this skill must reconcile the result back
into the whole plan: update slice status, evidence, worklog note, commit status,
and the next starting point before dispatching the next slice.

## Sequential slice gate

Execute slices in order unless the user explicitly approves a different dependency-free order.

A slice is fully closed only when:

- its delegated skill's close criteria are satisfied
- validation is complete
- review, QA, and checkpoint are complete
- `PLAN.md` reflects the current status and next starting point
- `개발일지.md` or the project worklog is updated when used
- commit status is resolved: strict slices have a slice commit, while lite slices
  have a commit or explicit no-commit reason; strict no-commit exceptions require
  a user/project policy override and remain `commit-deferred` until final commit
  accounting resolves them

Do not start slice N+1 while slice N is open, ambiguous, blocked without a recorded decision,
or missing review/QA/checkpoint evidence.

Ralph-style persistence means retrying or re-routing reasonable failures inside
the same slice before giving up: fix validation failures, re-run the gate, update
the plan, and only stop when the issue is truly blocked, unsafe, out of scope, or
requires the user's decision.

## No-skip completion checklist

Do not claim the Mansu TDD Total workflow is complete until this checklist is
filled. Missing evidence means the work is still open, even if the code appears
to work.

- `[NS-PLAN-ROLES]` `PLAN.md` contains the Planner / Critics / Synthesizer role mapping.
- `[NS-REAL-CRITICS]` If real critic agents were used, their names, responsibilities, and outcomes
  are recorded.
- `[NS-CRITIC-FALLBACK]` If real critic agents were not used for non-trivial work, the fallback reason
  is recorded.
- `[NS-PLAN-SLICES]` `PLAN.md` contains an execution-ready plan and a slice table.
- `[NS-SLICE-CARDS]` Every slice has mode, rationale, validation path, Oh My execution mode, gstack
  gate path, close criteria, and worklog note.
- `[NS-SLICE-STATUS]` Every unblocked slice is either closed or has a recorded blocker.
- `[NS-VALIDATION]` Every closed slice has validation evidence.
- `[NS-GATES]` Every closed slice has review, QA, checkpoint/state handoff, and commit status.
- `[NS-STRICT-COMMIT]` Strict slices have per-slice commit evidence, or an explicit policy override is
  recorded as `commit-deferred` and resolved during final commit accounting.
- `[NS-GATE-EXCEPTIONS]` Every skipped or replaced gate has a reason and an equivalent evidence path.
- `[NS-NEXT-POINT]` `PLAN.md` shows the current status and next starting point.
- `[NS-WORKLOG]` `개발일지.md` or the project worklog records completed work when the project uses one.
- `[NS-FINAL-BUILD]` Final project-level build/test/type/lint or the project equivalent has run, or
  the reason it could not run is recorded.
- `[NS-FINAL-QA]` Final QA/browser verification has run when user-visible behavior changed, or
  the reason it could not run is recorded.
- `[NS-FINAL-REVIEW]` Final diff review or equivalent project review has run when code changed.
- `[NS-FINAL-HEALTH]` Final `gstack-health` or equivalent project health check has run when available,
  or the reason it could not run is recorded.
- `[NS-RISKS]` Remaining risks, unverified checks, and follow-up items are listed.

The final response must include a compact checklist summary. If any required
item is missing, say the workflow is not fully complete yet and name the exact
open item instead of presenting the work as finished.

Keep the `NS-*` identifiers stable so validators can track the workflow contract
even when the explanatory wording changes.

## Mode-change rules

- Escalate from lite to strict if validation reveals hidden behavior risk, architecture churn, or a natural failing RED test.
- Downgrade from strict to lite only before implementation starts and only with a written rationale in `PLAN.md`.
- If a slice expands beyond its completion conditions, stop and re-plan that slice before continuing.
- If the plan keeps changing during execution, return to this skill and re-dispatch the remaining slices.

## Closeout

When all slices are complete:

- run the project-level build/test/type/lint suite that is relevant to the repo
- run final QA or browser verification when user-visible behavior changed
- run a final diff review or equivalent project review gate when code changed
- keep only active follow-up items in `PLAN.md`
- move completed multi-slice detail into `개발일지.md` or the project worklog
- include the final slice modes and validation results in the worklog
- create a final release/docs commit only when final docs, version, changelog, or deferred-commit policy requires it; otherwise record that per-slice commits already cover the code changes
- if per-slice commits were skipped or deferred, create the final implementation commit after final verification unless the user or project policy forbids it
- report what was verified, what could not be verified, remaining risks, and any follow-up checks needed
- avoid leaving the same completed work fully expanded in both `PLAN.md` and `개발일지.md`
