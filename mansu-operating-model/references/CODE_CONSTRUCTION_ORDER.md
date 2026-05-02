# Mansu Code Construction Router

This reference does not freeze one universal coding sequence.

It helps Mansu decide which construction phase the current work is in, which
source skill should be read, and what execution gates must remain true.

Primary source family: `addyosmani/agent-skills`.

Relevant source skills:

- `using-agent-skills`
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
a router and invariant layer, not a substitute for the source skill.

## Phase Detection

Before coding, decide the current phase from evidence:

| Evidence | Current phase | Read source skill |
| --- | --- | --- |
| Goal is vague or user is still exploring | Idea/spec definition | `idea-refine`, `spec-driven-development` |
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
