---
name: mansu-operating-model
description: Canonical operating doctrine for Mansu-based software delivery. Use for project rules, `AGENTS.md`, `CODING_RULES.md`, role separation, and evidence gates.
---

# Mansu Operating Model

Mansu is not a prompt pack.

Mansu is an operating doctrine for software delivery.

It exists to keep software work moving through explicit stages of thinking,
planning, execution, review, verification, and ship judgment instead of collapsing
into a single unexamined implementation burst.

Mansu is runtime-target-first. Specific binaries, hosts, model vendors, and path
conventions may change. The delivery discipline does not.

## Purpose

Use this skill to define or audit how a project should run software work.

This skill owns the universal doctrine:

- plan before non-trivial execution
- keep planning, building, review, QA, and ship judgment distinct
- route work by task character rather than tool fashion
- understand source skill families deeply enough to compose them intentionally
- check the source skill catalog before inventing a new workflow
- use the document creation order before large design/spec/planning work
- use the code construction order before large implementation bursts
- preserve strictness when strictness is declared
- accumulate learnings across tasks
- make ship claims depend on evidence

This skill does not store project-local command trivia. Project-specific commands,
paths, dangerous surfaces, and runtime choices belong in `CODING_RULES.md`.

## Core doctrine

The non-negotiables are:

- Non-trivial work starts with planning.
- Planning and execution are separate phases.
- Code creation is not evidence of correctness.
- Unknown failures are handled root-cause-first.
- Declared strictness must be operationally true.
- Harness details are implementation details.
- Learnings must compound.
- Equivalent gates must be separately invoked, evidenced, and distinguishable from implementation.

Read `references/DOCTRINE.md` when you need the full doctrine text, when auditing
a project operating system, or when a conflict cannot be resolved from this
summary alone.

## Work classes

Classify work before choosing the operating intensity.

- `Quick`: narrow, obvious, low-risk work with direct validation.
- `Standard`: meaningful behavior, multi-file, or module-level work requiring an explicit plan, distinct review, and validation evidence.
- `Heavy`: architecture, high-risk, user-flow, security, deployment, schema, or broad staged work requiring critique, vertical slices, checkpoint control, distinct review, distinct QA, commit/no-commit accounting, worklog update, and ship-or-hold judgment.

Do not default downward when classification is unclear.

## Delivery spine

Mansu follows this spine:

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

When the plan is execution-ready, Mansu continues automatically unless the user
explicitly requested a human approval gate, the next action is risky, or a blocker
remains unresolved.

## Role model

Use distinct logical roles even when one runtime performs several roles
sequentially.

- Operator: interprets goals, scope, and escalation boundaries.
- Planner: makes the plan executable.
- Critic: challenges the plan and rejects weak verification.
- Builder: implements execution-ready slices within scope.
- Reviewer: checks correctness, coupling, risk, and plan compliance.
- QA: verifies runtime behavior and user/system outcomes.
- Checkpoint: preserves milestone state and next entry point.
- Shipper: makes the final release-readiness judgment.

Implementation is not review. Review is not QA. QA is not ship approval.

## Routing rules

Route by task character:

- New scoped implementation: plan, slice if needed, build, review, validate.
- Project design / TDR work: combine problem discovery, reference research, product, design, engineering, DX, and source-skill review before phase-level planning.
- Unclear failure or regression: investigate before fixing.
- High-assurance or strict delivery: verify gates first; block if strict prerequisites are missing.
- Browser or runtime behavior claim: verify behavior directly and separate report-only from fix-approved modes.
- Work that overlaps strong Oh My, gstack, or public source skills: read the source skill catalog and delegate specialist execution when it is stronger.
- Project operating docs: use this skill and the templates in `references/`.

## Strict mode policy

Strict mode is a delivery contract.

If required gates, review structure, or validation surfaces are unavailable,
strict mode is blocked. A fallback may be proposed, but it must be labeled
fallback, not strict.

## Evidence and ship readiness

A task is not ready to ship unless:

- agreed scope is complete
- review status is known
- validation evidence exists
- QA status is known where applicable
- unresolved risk is named or explicitly accepted
- the completion claim matches reality

Merged status and shipped status are not assumed to be equivalent.

## Document authority

Project documents specialize the doctrine; they must not weaken it.

Authority works by subject:

- Explicit user instruction controls the requested outcome and immediate constraints unless unsafe or impossible.
- Project `CODING_RULES.md` controls project-specific commands, paths, runtimes, validation commands, and dangerous surfaces.
- Project `AGENTS.md` controls local routing and entry instructions.
- Mansu canonical doctrine controls universal workflow gates, role separation, strictness, evidence, and ship-readiness rules.

If a local document appears to contradict a non-negotiable Mansu doctrine rule,
do not silently follow the weaker rule. Report the conflict, use the safer
interpretation, and ask only if the choice has real consequences.

## Document ownership map

Keep Mansu documents MECE: each document owns one layer and links to other
layers instead of copying their details.

| Document | Owns | Must not own |
| --- | --- | --- |
| `README.md` / `README.ko.md` | public entry, install path, quick start, top-level skill list, links to canonical docs | full doctrine, source capability maps, document matrices, local project commands |
| `MANSU_PHILOSOPHY.md` | why Mansu exists, orchestration philosophy, stable stack model, source-fluency principle | operational route tables, artifact matrices, validator contracts |
| `mansu-operating-model/SKILL.md` | canonical doctrine hub, authority order, work classes, role separation, evidence, ship readiness, reference map | source-family details, project-local commands, long artifact matrices |
| `references/AGENTS.md` | project-local first-hop router and entry instructions | source capability details, validation commands, dangerous path details |
| `references/CODING_RULES.md` | project-local runtime, commands, paths, validation, dangerous surfaces, ship checks | universal Mansu doctrine or source-family catalogs |
| `references/SOURCE_SKILL_CATALOG.md` | source-family map, freshness policy, capability maps, composition recipes | project-local commands or full document matrix |
| `references/DOCUMENT_CREATION_ORDER.md` | artifact router, document paths, creation order, verification order, handoff requirements | source-family capability maps or implementation sequence details |
| `references/CODE_CONSTRUCTION_ORDER.md` | coding phase detection, construction order, dependency slicing, contracts, safe defaults | project kickoff doctrine or document matrix |
| `mansu-project-start/SKILL.md` | executable Zero-to-PLAN workflow, minimum gate, route selection, handoff report | full source catalog, full document matrix, slice implementation |
| `docs/mansu-manual.html` | human-facing visual summary, lightweight route map, skill catalog UI | canonical source truth or validator-only policy |

When a detail belongs elsewhere, link to the owner and summarize only the routing
decision needed in the current document.

## Reference map

- `references/DOCTRINE.md`: full doctrine text for classification, delivery spine, role model, orchestration, review, QA, debugging, strictness, evidence, authority, and anti-patterns.
- `references/SOURCE_SKILL_CATALOG.md`: source skill map for gstack, Oh My / OMO / OMC style skills, and Mansu composition recipes.
- `references/SOURCE_SKILL_LOCK.json`: machine-readable source-family snapshot for source freshness evidence.
- `references/DOCUMENT_CREATION_ORDER.md`: document router for idea, design doc, research, spec, TDR, UI design, ADR, PLAN, checkpoint, worklog, verification, and release artifacts.
- `references/CODE_CONSTRUCTION_ORDER.md`: coding-order reference for dependency graphs, context packing, contracts, vertical slices, safe defaults, and rollback-friendly implementation.
- `references/AGENTS.md`: project router template that points contributors toward Mansu doctrine and local rules.
- `references/CODING_RULES.md`: project-local operating manual template for runtime choices, commands, validation, dangerous surfaces, and ship criteria.

Load only the reference needed for the current task.

## Project document templates

Use `references/AGENTS.md` and `references/CODING_RULES.md` when creating or
upgrading a project's router and local operating manual.

`AGENTS.md` should stay short and route to doctrine. `CODING_RULES.md` should
localize doctrine into runnable project facts.

## Writing rules for derived documents

Prefer enforceable operating language:

- must
- requires
- blocks
- do not
- only when
- explicit user approval required
- exit condition

Avoid vague doctrine:

- maybe
- try to
- if possible
- appropriately
- usually fine
- flexible depending on feel

## Final principle

Mansu exists to run software work as a disciplined delivery system.

Speed is welcome. Undisciplined speed is not.
