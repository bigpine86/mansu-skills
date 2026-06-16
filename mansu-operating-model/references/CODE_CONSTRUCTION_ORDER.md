# Mansu Code Construction Router

This reference does not freeze one universal coding sequence.

It helps Mansu decide which construction phase the current work is in, which
source skill should be read, and what execution gates must remain true.

This reference owns the phase loop and the Build/Plan handoff for coding work.
It does not own document lifecycle, artifact handoff policy, or source-skill
pairing decisions; use `DOCUMENT_CREATION_ORDER.md` and
`SOURCE_SKILL_COMPOSITION.md` for those. Phase `SKILL.md` files own immediate
action rules and call this reference only when the current task needs coding
phase detection, slice order, or construction-loop invariants.

Primary source family: `addyosmani/agent-skills`.

Mansu reads the addyosmani lifecycle as the broad phase spine:

```text
Define -> Plan -> Build -> Verify -> Review -> Ship
```

`mansu-debug` is a public special-purpose interrupt route for unknown failures,
not a normal lifecycle phase.

For user-facing Korean planning and progress reports, Mansu also keeps a more
granular product-development flow:

```text
기획 -> 요구사항 정리 -> 스펙 작성 -> 구현 계획 -> 코딩 -> 테스트 -> QA -> 수정/개선 -> 배포/공유
```

These are not competing sequences. The addyosmani spine is the source-skill
phase map; the Korean flow is the detailed coding-flow vocabulary Mansu uses to
classify where the work is, explain progress, and decide the next gate.

| Korean detailed flow | addyosmani phase | Mansu interpretation |
| --- | --- | --- |
| 기획 | Define | clarify purpose, user, problem, non-goals, and success signal |
| 요구사항 정리 | Define | lock requirements, acceptance criteria, scope, and constraints |
| 스펙 작성 | Define -> Plan | turn requirements into spec/TDR/design/source-of-truth artifacts |
| 구현 계획 | Plan | create phase roadmap, active phase `PLAN.md`, ordered slices, and gates |
| 코딩 | Build | implement the current slice through the selected source skill and Mansu TDD mode |
| 테스트 | Verify | prove behavior with focused tests or other slice-level validation |
| QA | Verify -> Review | check real usage, browser/runtime behavior, regressions, and evidence quality; when Verify passes, continue into Review by default |
| 수정/개선 | Review -> Build -> Verify | resolve findings, refactor safely, then re-verify before widening scope |
| 배포/공유 | Ship | prepare release docs, PR/commit/push/deploy/canary, and learning handoff |

Treat `수정/개선` as a loop, not a one-time final cleanup:

```text
Build -> Verify -> Review -> Build -> Verify -> Review -> Ship
```

Relevant source skills:

- `using-agent-skills`
- `interview-me`
- `idea-refine`
- `spec-driven-development`
- `planning-and-task-breakdown`
- `context-engineering`
- `source-driven-development`
- `incremental-implementation`
- `test-driven-development`
- `frontend-ui-engineering`
- `api-and-interface-design`
- `browser-testing-with-devtools`
- `debugging-and-error-recovery`
- `doubt-driven-development`
- `code-review-and-quality`
- `code-simplification`
- `security-and-hardening`
- `performance-optimization`
- `git-workflow-and-versioning`
- `ci-cd-and-automation`
- `deprecation-and-migration`
- `documentation-and-adrs`
- `shipping-and-launch`

Read the original source skill when the task enters that phase. This document is
a router and invariant layer, not a substitute for the source skill. When source
skills overlap, use `SOURCE_SKILL_COMPOSITION.md` to choose the composition.

## Canonical Phase Orders

Mansu exposes six normal phase skills plus the `mansu-debug` interrupt route.
Each phase has an internal order and source
skill route. The phase skill owns orchestration, gates, and evidence; source
skills own specialized execution.

| Mansu phase | Internal order | Source route |
| --- | --- | --- |
| Define | Idea intake -> User/problem interview -> Requirements -> Acceptance criteria -> Source-of-truth seed | Ouroboros `interview`, `pm`, `seed`, `brownfield`; addyosmani `interview-me`, `idea-refine`, `spec-driven-development`; gstack `office-hours`, `plan-ceo-review` |
| Plan | Requirements/Spec -> Architecture -> Design Direction -> Implementation Roadmap | addyosmani `spec-driven-development`, `planning-and-task-breakdown`, `api-and-interface-design`, `source-driven-development`; OMO `ulw-plan`; gstack `autoplan`, `plan-ceo-review`, `plan-eng-review`, `plan-devex-review` |
| Plan design gate | Reference discovery -> Design system/artifact -> Variant exploration -> Plan-stage design review -> Implementation handoff | OMO research/deepsearch when available; Open Design for callable artifacts; VoltAgent/awesome-design-md for `DESIGN.md`; gstack `design-consultation`, `design-shotgun`, `plan-design-review`, `design-html`; addyosmani `frontend-ui-engineering` |
| Build | Context pack -> Contract/source verification -> Slice plan -> Implement -> Local validation -> Checkpoint | `mansu-tdd-total` as the internal build engine under `mansu-build`; OMO `start-work`, `programming`, `ulw-loop`, `lsp` as execution habits; addyosmani `context-engineering`, `source-driven-development`, `incremental-implementation`, `test-driven-development`; gstack `guard`, `careful`, `checkpoint` |
| Verify | Test evidence -> Runtime/browser evidence -> QA report -> Security/perf checks when relevant -> Review handoff | addyosmani `test-driven-development`, `browser-testing-with-devtools`, `security-and-hardening`, `performance-optimization`; gstack `qa-only`, `qa`, `browse`, `health`, `cso`, `benchmark`; Ouroboros `qa`, `evaluate`; OMO `review-work` |
| Review | Diff review -> Architecture/design/security critique -> AI-slop/simplification pass -> Root-cause loop for findings -> Re-verify | addyosmani `code-review-and-quality`, `code-simplification`, `debugging-and-error-recovery`, `doubt-driven-development`; gstack `review`, `plan-eng-review`, `plan-design-review`, `design-review`, `investigate`, `cso`; OMO `review-work`, `remove-ai-slops`, `debugging`, `comment-checker` |
| Debug | Reproduce -> Isolate -> Hypothesize -> Prove root cause -> Minimal fix -> Regression proof | `mansu-debug-rootcause`; OMO `debugging`; addyosmani `debugging-and-error-recovery`, `doubt-driven-development`; gstack `investigate`, `browse`, `qa-only` |
| Ship | Release readiness -> Version/changelog/docs -> Commit/push/PR/deploy decision -> Canary/monitoring -> Learning handoff | addyosmani `git-workflow-and-versioning`, `ci-cd-and-automation`, `documentation-and-adrs`, `shipping-and-launch`; gstack `ship`, `document-release`, `landing-report`, `setup-deploy`, `land-and-deploy`, `canary`, `retro`, `learn`; Ouroboros `publish`, `status` |

## Phase Detection

Before coding, decide the current phase from evidence:

| Evidence | Current phase | Read source skill |
| --- | --- | --- |
| Goal is vague, underspecified, or user is still exploring | Define | `interview-me`, `idea-refine`, `spec-driven-development`, Ouroboros `interview` |
| Acceptance criteria exist but implementation order is unclear | Planning/task breakdown | `planning-and-task-breakdown` |
| Agent lacks project patterns or touched files are unclear | Context setup | `context-engineering` |
| Framework/library/API behavior may be version-sensitive | Source-verified implementation | `source-driven-development` |
| Multi-file coding is about to start | Incremental implementation | `incremental-implementation` |
| Behavior can be naturally proved with tests | TDD | `test-driven-development` |
| UI is being built or changed | Frontend implementation | `frontend-ui-engineering` plus gstack design skills when useful |
| API, module boundary, or public contract is changing | Interface design | `api-and-interface-design` |
| Browser/runtime behavior must be observed | Runtime verification | `browser-testing-with-devtools` plus gstack browse/QA |
| Something is broken or unknown | Debugging | `debugging-and-error-recovery` plus `mansu-debug-rootcause` |
| Implementation is complete enough to inspect or simplify | Review/quality | `code-review-and-quality`, `code-simplification`, plus gstack review |
| Security or performance risk exists | Hardening/optimization | `security-and-hardening`, `performance-optimization`, plus gstack CSO/benchmark |
| CI/CD, release automation, migration, deprecation, docs, or launch is in scope | Ship/docs | `git-workflow-and-versioning`, `ci-cd-and-automation`, `deprecation-and-migration`, `documentation-and-adrs`, `shipping-and-launch` |

If the phase is ambiguous, read `using-agent-skills` first and classify the task.

Runtime readiness is resolved by `mansu-setup`. LazyCodex / OMO Codex plugin can
be the Codex-side route for Oh My execution patterns, but it is not a phase source route and
does not replace the source-skill composition in `SOURCE_SKILL_COMPOSITION.md`.

`PLAN.md` may supply the current phase goal and slice table, but it is not
canonical Mansu doctrine. Generated `.omo` plans may explain a task-local
strategy, but durable phase rules belong here or in the phase `SKILL.md` file.

## Router Loop

For each slice, run this loop:

1. Detect the current phase.
2. Read the relevant source skill if the phase is non-trivial or unfamiliar.
3. Extract only the phase-specific actions needed now.
4. Apply Mansu invariants.
5. Execute the slice.
6. Verify the phase exit criteria.
7. Update `PLAN.md`, checkpoint, worklog, and commit/no-commit status.
8. Re-detect the phase before continuing.

Do not assume the same source skill remains correct after the slice changes.

## Mansu Invariants

These rules stay true regardless of which source skill is active:

- Non-trivial work must have visible acceptance criteria.
- Implementation order must follow dependency and risk, not excitement.
- A slice should change one logical thing.
- Context must be selected for the current slice, not dumped wholesale.
- Contracts should be locked before dependent consumers when boundaries matter.
- Validation must run before widening scope.
- Review, QA, checkpoint, worklog, and commit/no-commit accounting still apply.
- The next slice starts only after the current slice is closed.

## Dynamic Construction Checklist

Use this checklist to shape the current slice after reading the source skill:

- `phase`: Which construction phase are we in now?
- `source skill read`: Which original skill informed this step?
- `dependency`: What must exist before this can work?
- `context pack`: Which files, tests, examples, and docs are relevant now?
- `contract`: Which type/API/schema/props/event boundary must be stable?
- `slice shape`: What is the smallest behavior or enabling contract to land?
- `validation`: How will this phase prove success?
- `safe default`: What stays disabled, additive, conservative, or reversible?
- `rollback`: How can this slice be reverted or isolated?

Record the result in the slice table when the work is non-trivial.

## Flexible Construction Patterns

Choose the pattern that matches the phase and risk.

### Vertical Slice

Use when one user-visible path can be built end-to-end.

### Contract-First Slice

Use when backend/frontend, modules, services, or agents share a boundary.

### Risk-First Slice

Use when one unknown can invalidate the plan.

### Refactor-First Slice

Use only when the existing shape blocks safe implementation.

### Source-Verified Slice

Use when current framework or library docs should control the code pattern.

### UI Evidence Slice

Use when rendered behavior, accessibility, responsive layout, or visual quality is
the real proof.

## File Growth Rule

Do not keep growing a giant file when a new responsibility boundary appears.

Split when one file now contains multiple responsibilities such as:

- domain logic plus UI rendering
- API transport plus business rules
- parsing plus persistence
- state management plus presentation
- test fixtures plus production helpers

Prefer small, named modules that match responsibilities from the plan and the
current source skill's guidance.

## Red Flags

- The agent starts coding without knowing the current phase.
- The construction order is copied from this document without reading the source
  skill for a non-trivial phase.
- A multi-file change skips `incremental-implementation`.
- Framework-specific code is written from memory when current docs matter.
- A slice grows past its phase exit criteria.
- A task title needs "and" but was not split.
- Build or tests are broken while moving to the next slice.
- `PLAN.md` says one thing while code does another.

## Exit Criteria

Before a coding slice is closed:

- the current phase was named
- the relevant source skill was read or explicitly skipped with a reason
- Mansu invariants held
- validation evidence exists
- the codebase is in a working state
- the next phase or next slice can start without reconstructing context from memory
