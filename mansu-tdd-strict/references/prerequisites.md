# Prerequisites

This skill is for a **current Mansu-compatible agent runtime with callable or independently recorded gates**. Treat these as hard prerequisites for the execution loop.

## Required environment

- A current Mansu-compatible agent runtime such as Hermes or OpenCode
- Multi-agent support or explicit single-runtime role separation with independently recorded gate evidence
- `git`
- A repository with write access

## Required gate tools

- review gate support through one of:
  - callable review gate command or skill in the current runtime
  - a project-standard review workflow that is explicitly invocable as a gate
- QA gate support through one of:
  - callable QA gate command or skill in the current runtime
  - a project-standard QA workflow that is explicitly invocable as a gate
- checkpoint gate support through one of:
  - callable checkpoint gate command or skill in the current runtime
  - a project-standard checkpoint workflow that is explicitly invocable as a gate

Gate-equivalent minimum:

- separately invoked from implementation
- produces status/evidence
- distinguishable from the builder's self-summary
- recorded in the plan, checkpoint, or worklog

## Required documents

- Active plan document:
  - use the existing project convention if one already exists
  - prefer `PLAN.md` in the repository root
  - accept `Plan.md` if that is the project’s established plan filename
- Completed work log:
  - prefer `doc/개발일지.md` when `doc/` exists
  - otherwise use `개발일지.md` in the repository root

## Minimum preflight checks

Confirm all of the following before planning or coding:

- `command -v git`
- review gate is actually callable in this environment
- QA gate is actually callable in this environment
- checkpoint gate is actually callable in this environment
- multi-agent orchestration is available, or single-runtime role separation with independent gate evidence is available
- `PLAN.md` exists or can be created
- `개발일지.md` path exists or can be created

## Hard-fail rule

If current-runtime orchestration, independent role separation, or any required gate is missing:

- stop before implementation
- report the exact missing prerequisite
- tell the user that the prerequisite must be installed or enabled first
- do not imitate the missing gate manually
