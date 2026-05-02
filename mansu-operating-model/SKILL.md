---
name: mansu-operating-model
description: Canonical operating doctrine for Mansu-based software delivery. Use when defining or reviewing how a project should plan, orchestrate, review, verify, and ship work; when writing or auditing project `AGENTS.md` or `CODING_RULES.md`; when deciding work class, role separation, strictness, or evidence standards; or when a Mansu flow is drifting into one-pass implementation without real gates.
---

# Mansu Operating Model

Mansu is not a prompt pack.

Mansu is an operating doctrine for software delivery.

It exists to ensure that software work moves through explicit stages of thinking, planning, execution, review, verification, and ship judgment instead of collapsing into a single unexamined implementation burst.

Mansu is runtime-target-first. Specific binaries, hosts, adapters, model vendors, and path conventions may change. The delivery discipline does not.

Mansu combines methodology-first delivery discipline with runtime-native orchestration. It preserves the planning and gate integrity of structured delivery systems while using specialized workers, role separation, and orchestration to increase execution leverage.

## Purpose

Mansu defines how software work should be run when the goal is to deliver changes that are:

- correct
- reviewable
- testable
- operationally understandable
- honest about residual risk

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

## Core doctrine

### 1. Non-trivial work starts with planning

If the work is not trivial, implementation does not begin immediately.

A valid non-trivial plan must define:

- objective
- scope boundaries
- likely files, modules, or surfaces
- key risks
- validation path
- completion criteria

### 2. Planning and execution are separate phases

Planning, implementation, review, QA, and ship judgment are distinct phases.

A single runtime may perform multiple phases sequentially. That does not erase the phase boundaries.

### 3. Code creation is not evidence of correctness

Implementation does not validate itself.

For any work above quick level, correctness claims require at least:

- a distinct review pass
- validation evidence appropriate to the task

### 4. Unknown failures are handled root-cause-first

When the cause of failure is unclear, investigation comes before fix attempts.

Mansu rejects speculative fix stacking as the default debugging method.

### 5. Declared strictness must be operationally true

If work is declared strict, the required prerequisites and gates must actually run.

If strict prerequisites are missing, strict mode is blocked.

A fallback path may be proposed, but it must be labeled fallback, not strict.

### 6. Harness details are implementation details

Adapter names, binary names, model names, and plugin wiring belong to the harness layer.

They may shape execution mechanics. They do not redefine the doctrine.

### 7. Learnings must compound

Meaningful work should leave behind reusable understanding:

- conventions
- gotchas
- failure modes
- validation lessons
- commands that matter
- architectural warnings

Repeated work without retained learning is an operating failure.

## Work classification

Work classification determines:

- orchestration intensity
- gate requirements
- approval burden
- verification expectations

It is not a cosmetic label.

### Quick

Quick work is allowed only when all of the following are true:

- scope is narrow
- approach is obvious
- rollback is simple
- shared behavior risk is low
- user-facing risk is low
- ambiguity is low

Quick work may use:

- light planning
- direct implementation
- lightweight self-check or review

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

Standard work requires:

- explicit plan
- explicit implementation path
- distinct review
- validation evidence before completion claim

### Heavy

Heavy work applies when any of the following are true:

- architecture is materially affected
- shared core behavior changes
- release risk is high
- failure cost is high
- user-facing flow changes materially
- migrations, schema, auth, permissions, billing, deployment, or security surfaces are involved
- the work requires slicing and milestone control

Heavy work requires:

- explicit planning
- critique
- approval before build
- vertical slicing
- checkpoint control
- distinct review
- distinct QA
- explicit ship-or-hold judgment

## Delivery spine

Mansu follows this delivery spine:

**Think → Plan → Build → Review → Test → Ship → Reflect**

Operationally, this becomes:

1. intake
2. classify
3. plan
4. critique
5. approve
6. slice
7. build
8. review
9. QA
10. ship or hold
11. retro

This spine is mandatory for heavy work, expected for standard work, and compressible only for quick work.

## Role model

Mansu requires logical role separation.

A single person or runtime may perform multiple roles sequentially. The roles must still remain conceptually distinct.

### Operator

Responsible for:

- interpreting goals
- holding scope and intent
- choosing orchestration intensity
- deciding approval boundaries

### Planner

Responsible for:

- producing the executable plan
- making constraints, risks, and validation explicit

### Critic

Responsible for:

- challenging the plan
- surfacing blind spots
- rejecting fuzzy scope or weak verification

### Builder

Responsible for:

- implementing approved slices
- staying within scope
- surfacing unexpected expansion

### Reviewer

Responsible for:

- checking correctness
- checking plan compliance
- checking coupling and maintainability
- deciding whether "done" is defensible

### QA

Responsible for:

- verifying runtime behavior
- checking user-facing or system-facing outcomes

### Checkpoint

Responsible for:

- controlling milestone quality in heavy work
- preventing long-run implementation drift

### Shipper

Responsible for:

- making the final release-readiness judgment
- distinguishing merged from shipped when needed

## Orchestration model

Mansu assumes orchestration-first delivery for non-trivial work.

Orchestration exists to increase leverage without dissolving accountability.

### Role-separated execution over monolithic execution

Meaningful work should move through explicit role passes rather than one uninterrupted generation pass.

### Parallelism is conditional

Parallel work is allowed only when:

- file overlap is low
- dependency order is clear
- runtime or test conflicts are manageable
- rollback remains understandable

### Prefer pipeline parallelism before multi-builder parallelism

It is usually better to overlap planning support, research, review preparation, or QA setup than to run multiple builders into the same shared surface.

### Route by task character

Work should be routed by role or task character, for example:

- quick change
- deep implementation
- architecture consultation
- codebase exploration
- documentation or OSS research
- visual verification
- writing or polish

The doctrine defines the role. The runtime chooses the concrete worker or model.

## Routing rules

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

## Planning doctrine

A plan is strong when it makes implementation straightforward without forcing the builder to invent core decisions mid-flight.

A weak plan:

- leaves scope implicit
- lacks a validation path
- hides edge cases in vague language
- assumes unstated business logic
- fails to identify where the real difficulty lives

For heavy work, plan critique should normally occur before build begins.

Once build begins, scope changes must be surfaced explicitly rather than silently absorbed.

## Review doctrine

Review is mandatory whenever work exceeds quick level.

Review checks:

- plan compliance
- correctness
- maintainability and coupling
- adequacy of validation
- hidden scope expansion
- honesty of the completion claim

Review may approve, reject, or hold. It must not be reduced to style commentary.

Code existence is not completion.

## QA doctrine

QA verifies runtime truth.

QA checks:

- whether the intended path works
- whether delivered behavior matches the claim
- whether error states are understandable where relevant
- whether realistic use breaks the flow

QA may be lightweight for quick work. QA must be explicit for heavy work.

## Debugging doctrine

Debugging is an investigation discipline.

### Iron law

- No root-cause claim without evidence.
- No confidence claim without verification.

### Forbidden default behavior

The following are forbidden as the primary debugging method:

- stacking guessed fixes blindly
- declaring success because the symptom disappeared once
- confusing correlation with explanation
- patching around uncertainty without naming it

### Required path

When cause is unclear:

1. define the failure precisely
2. identify plausible failure surfaces
3. gather evidence
4. test hypotheses
5. identify the most defensible cause
6. apply the narrowest correct fix
7. verify intended behavior and regression surface

If certainty remains incomplete, report that explicitly.

## Strict mode policy

Strict mode is a delivery contract.

### Required condition

If the required gates, review structure, or validation surfaces are unavailable, strict mode is blocked.

### Forbidden behavior

It is forbidden to:

- skip required gates and still call the result strict
- merge review and QA into one casual pass while claiming strictness
- replace unavailable strict checks with loose approximations without relabeling the mode

### Fallback handling

If strict mode cannot proceed:

- state that strict mode is blocked
- name the missing prerequisites
- propose fallback options separately if useful
- label fallback as fallback

## Evidence and ship readiness

Evidence may include:

- tests
- runtime output
- browser verification
- screenshots
- logs
- diff review
- reproduction steps

A task must not be called ready to ship unless:

- agreed scope is complete
- review status is known
- validation evidence exists
- QA status is known where applicable
- unresolved risk is addressed or explicitly accepted
- the completion claim matches reality

"Looks done" is not a ship criterion.
"Code was written" is not a ship criterion.

Merged status and shipped status are not assumed to be equivalent.

## Anti-patterns

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

## Document authority

### Canonical doctrine

The Mansu operating model defines:

- universal workflow expectations
- role separation
- routing logic
- strictness rules
- review and QA doctrine
- anti-patterns
- authority boundaries

### Project router documents

Project `AGENTS.md` files should:

- declare that the project follows Mansu doctrine
- route contributors into relevant Mansu skills or doctrine entries
- define project-level interpretation rules
- avoid duplicating the full doctrine text

### Project-local coding rules

Project `CODING_RULES.md` files should:

- localize the doctrine to actual runtime commands and project structure
- define project-specific thresholds, commands, paths, and dangerous surfaces
- not contradict canonical doctrine

### Conflict priority

When instructions conflict, follow this order:

1. explicit user instruction
2. project-local `CODING_RULES.md`
3. project `AGENTS.md`
4. Mansu canonical doctrine
5. generic examples or historical habits

No lower layer may silently override a higher layer.

## Project document templates

Use the local templates in `references/AGENTS.md` and `references/CODING_RULES.md` when creating or upgrading a project's router and local operating manual.

## Writing rules for derived documents

Derived documents should be written as enforceable operating text.

Prefer:

- must
- requires
- blocks
- do not
- only when
- approval required
- exit condition

Avoid:

- maybe
- try to
- if possible
- appropriately
- usually fine
- flexible depending on feel

Operational doctrine should minimize interpretive ambiguity.

## Final principle

Mansu exists to run software work as a disciplined delivery system.

The doctrine is working when:

- the right amount of planning happens before the right amount of execution
- role boundaries stay legible
- review and QA remain meaningful
- strictness remains honest
- runtime tools are used without becoming the religion
- the system gets sharper after each real task

Speed is welcome.
Undisciplined speed is not.
