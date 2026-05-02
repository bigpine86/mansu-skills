# Mansu Doctrine Reference

## Contents

- Purpose
- Core Doctrine
- Work Classification
- Delivery Spine
- Role Model
- Orchestration Model
- Routing Rules
- Planning Doctrine
- Review Doctrine
- QA Doctrine
- Debugging Doctrine
- Strict Mode Policy
- Evidence And Ship Readiness
- Anti-Patterns
- Document Authority
- Writing Rules

## Purpose

Mansu defines how software work should be run when the goal is to deliver changes
that are correct, reviewable, testable, operationally understandable, and honest
about residual risk.

Mansu exists to:

- require planning before non-trivial execution
- keep planning, building, review, and QA logically distinct
- route work by task character rather than tool fashion
- preserve strictness when strictness is declared
- accumulate learnings across tasks
- make ship claims depend on evidence

Mansu does not exist to:

- store project-local command trivia
- encode temporary notes
- bind the workflow to one provider or one agent brand
- replace product or business judgment

## Core Doctrine

### Non-trivial work starts with planning

If the work is not trivial, implementation does not begin immediately.

A valid non-trivial plan defines objective, scope boundaries, likely change
surfaces, key risks, validation path, and completion criteria.

### Planning and execution are separate phases

Planning, implementation, review, QA, and ship judgment are distinct phases.

A single runtime may perform multiple phases sequentially. That does not erase
the phase boundaries.

### Code creation is not evidence of correctness

Implementation does not validate itself.

For any work above quick level, correctness claims require a distinct review
pass and validation evidence appropriate to the task.

### Unknown failures are handled root-cause-first

When the cause of failure is unclear, investigation comes before fix attempts.

Mansu rejects speculative fix stacking as the default debugging method.

### Declared strictness must be operationally true

If work is declared strict, the required prerequisites and gates must actually
run.

If strict prerequisites are missing, strict mode is blocked.

A fallback path may be proposed, but it must be labeled fallback, not strict.

### Harness details are implementation details

Binary names, model names, plugin wiring, and host conventions belong to the
harness layer.

They may shape execution mechanics. They do not redefine the doctrine.

### Learnings must compound

Meaningful work should leave behind reusable understanding: conventions,
gotchas, failure modes, validation lessons, important commands, and
architectural warnings.

Repeated work without retained learning is an operating failure.

Learning closeout should choose the right artifact: worklog for history,
project rules for repeated operating lessons, ADRs for durable decisions, tests
for regressions, docs for user-facing changes, and source catalog updates for
reusable orchestration insights.

## Work Classification

Work classification determines orchestration intensity, gate requirements,
planning gate burden, and verification expectations.

It is not a cosmetic label.

### Quick

Quick work is allowed only when all of the following are true:

- scope is narrow
- approach is obvious
- rollback is simple
- shared behavior risk is low
- user-facing risk is low
- ambiguity is low

Quick work may use light planning, direct implementation, and lightweight
self-check or review.

Quick work does not waive correctness. It only reduces ceremony.

### Standard

Standard work applies when any of the following are true:

- multiple files are likely to change
- behavior changes meaningfully
- reasoning across modules is required
- debugging requires real investigation
- test impact is non-trivial
- product intent needs interpretation
- regression risk is moderate

Standard work requires an explicit plan, explicit implementation path, distinct
review, and validation evidence before completion claim.

### Heavy

Heavy work applies when any of the following are true:

- architecture is materially affected
- shared core behavior changes
- release risk is high
- failure cost is high
- user-facing flow changes materially
- migrations, schema, auth, permissions, billing, deployment, or security surfaces are involved
- the work requires slicing and milestone control

Heavy work requires explicit planning, critique, execution-ready decision before
build, vertical slicing, checkpoint control, distinct review, distinct QA,
commit or explicit no-commit reason, worklog update, and explicit ship-or-hold
judgment.

## Delivery Spine

Mansu follows this delivery spine:

**Think -> Plan -> Build -> Review -> Test -> Ship -> Reflect**

Operationally:

1. intake
2. classify
3. plan
4. critique
5. decide execution readiness
6. slice
7. build
8. review
9. QA
10. checkpoint / commit-or-record-no-commit
11. ship or hold
12. retro / learn

This spine is mandatory for heavy work, expected for standard work, and
compressible only for quick work.

When the plan is execution-ready, Mansu continues automatically unless the user
explicitly requested a human approval gate, the next action is risky, or a
blocker remains unresolved.

## Role Model

Mansu requires logical role separation.

A single person or runtime may perform multiple roles sequentially. The roles
must still remain conceptually distinct.

- Operator: interprets goals, holds scope and intent, chooses orchestration intensity, and decides when human approval is actually required.
- Planner: produces the executable plan and makes constraints, risks, and validation explicit.
- Critic: challenges the plan, surfaces blind spots, and rejects fuzzy scope or weak verification.
- Builder: implements execution-ready slices, stays within scope, and surfaces unexpected expansion.
- Reviewer: checks correctness, plan compliance, coupling, maintainability, and whether done is defensible.
- QA: verifies runtime behavior and user-facing or system-facing outcomes.
- Checkpoint: controls milestone quality and preserves the next entry point.
- Shipper: makes the final release-readiness judgment and distinguishes merged from shipped.

Implementation is not review. Review is not QA. QA is not ship approval.

## Orchestration Model

Mansu assumes orchestration-first delivery for non-trivial work.

Orchestration exists to increase leverage without dissolving accountability.

Meaningful work should move through explicit role passes rather than one
uninterrupted generation pass.

Mansu must be source-fluent before it is creative. It should understand the
strongest available gstack, Oh My / OMO / OMC, and public engineering skills well
enough to combine them intentionally, while preserving their original discipline
and Mansu's own evidence gates.

Parallel work is allowed only when file overlap is low, dependency order is
clear, runtime or test conflicts are manageable, and rollback remains
understandable.

Prefer pipeline parallelism before multi-builder parallelism. It is usually
better to overlap planning support, research, review preparation, or QA setup
than to run multiple builders into the same shared surface.

## Routing Rules

Route by task character.

### New scoped implementation

Expected behavior:

- classify first
- plan before build unless clearly quick
- slice if standard or heavy
- route through review before completion claim

### Unclear failure or regression

Expected behavior:

- investigate before fixing
- trace root cause
- avoid speculative patch stacking
- report unresolved uncertainty explicitly

### High-assurance or strict delivery

Expected behavior:

- verify prerequisites
- enforce distinct gates
- block if strict prerequisites are missing

### Browser or runtime behavior verification

Expected behavior:

- verify behavior directly
- distinguish report-only from fix-approved modes
- feed findings back into build or review as needed

## Planning Doctrine

A plan is strong when it makes implementation straightforward without forcing
the builder to invent core decisions mid-flight.

A weak plan leaves scope implicit, lacks a validation path, hides edge cases in
vague language, assumes unstated business logic, or fails to identify where the
real difficulty lives.

For heavy work, plan critique should normally occur before build begins.

Once build begins, scope changes must be surfaced explicitly rather than
silently absorbed.

## Review Doctrine

Review is mandatory whenever work exceeds quick level.

Review checks plan compliance, correctness, maintainability and coupling,
adequacy of validation, hidden scope expansion, and honesty of the completion
claim.

Review may approve, reject, or hold. It must not be reduced to style commentary.

Code existence is not completion.

An equivalent review gate is valid only when it is separately invoked, produces
status or evidence, and is distinguishable from the builder's self-summary.

## QA Doctrine

QA verifies runtime truth.

QA checks whether the intended path works, whether delivered behavior matches
the claim, whether error states are understandable where relevant, and whether
realistic use breaks the flow.

QA may be lightweight for quick work. QA must be explicit for heavy work.

An equivalent QA gate is valid only when it is separately invoked, produces
status or evidence, and verifies behavior rather than restating implementation.

## Debugging Doctrine

Debugging is an investigation discipline.

Iron law:

- No root-cause claim without evidence.
- No confidence claim without verification.

Forbidden default behavior:

- stacking guessed fixes blindly
- declaring success because the symptom disappeared once
- confusing correlation with explanation
- patching around uncertainty without naming it

Required path when cause is unclear:

1. define the failure precisely
2. identify plausible failure surfaces
3. gather evidence
4. test hypotheses
5. identify the most defensible cause
6. apply the narrowest correct fix
7. verify intended behavior and regression surface

If certainty remains incomplete, report that explicitly.

## Strict Mode Policy

Strict mode is a delivery contract.

If required gates, review structure, or validation surfaces are unavailable,
strict mode is blocked.

It is forbidden to skip required gates and still call the result strict, merge
review and QA into one casual pass while claiming strictness, or replace
unavailable strict checks with loose approximations without relabeling the mode.

If strict mode cannot proceed:

- state that strict mode is blocked
- name the missing prerequisites
- propose fallback options separately if useful
- label fallback as fallback

## Evidence And Ship Readiness

Evidence may include tests, runtime output, browser verification, screenshots,
logs, diff review, and reproduction steps.

A task must not be called ready to ship unless:

- agreed scope is complete
- review status is known
- validation evidence exists
- QA status is known where applicable
- unresolved risk is addressed or explicitly accepted
- the completion claim matches reality

Looks done is not a ship criterion. Code was written is not a ship criterion.

Merged status and shipped status are not assumed to be equivalent.

## Anti-Patterns

The following are anti-patterns under Mansu:

- implementing non-trivial work before planning
- claiming completion before required review or validation
- collapsing builder, reviewer, and QA into one unexamined pass
- parallelizing conflicting work on shared files without coordination
- silently expanding scope during build
- treating harness-specific assumptions as universal doctrine
- calling work strict when strict prerequisites did not run
- using symptom suppression as a substitute for root-cause understanding
- replacing evidence with confidence language
- preserving process theater without real gate integrity

## Document Authority

Project documents specialize the doctrine; they must not weaken it.

Authority works by subject:

- explicit user instruction controls the requested outcome and immediate constraints unless unsafe or impossible
- project `CODING_RULES.md` controls project-specific commands, paths, runtimes, validation commands, and dangerous surfaces
- project `AGENTS.md` controls local routing and entry instructions
- Mansu canonical doctrine controls universal workflow gates, role separation, strictness, evidence, and ship-readiness rules

If a local document appears to contradict a non-negotiable Mansu doctrine rule,
do not silently follow the weaker rule. Report the conflict, use the safer
interpretation, and ask only if the choice has real consequences.

## Writing Rules

Derived documents should be written as enforceable operating text.

Prefer: must, requires, blocks, do not, only when, explicit user approval
required, exit condition.

Avoid: maybe, try to, if possible, appropriately, usually fine, flexible
depending on feel.

Operational doctrine should minimize interpretive ambiguity.
