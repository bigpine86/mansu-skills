# Prerequisites

This skill is for an **Oh My XX + gstack** environment. Treat these as hard prerequisites for the execution loop.

## Required environment

- An Oh My XX orchestration environment such as `Oh My Codex`
- Multi-agent support
- `git`
- A repository with write access

## Required gate tools

- review gate support through one of:
  - callable `gstack-review`
  - equivalent Codex/gstack review skill or workflow
- QA gate support through one of:
  - callable `gstack-qa`
  - equivalent Codex/gstack QA skill or workflow
- checkpoint gate support through one of:
  - callable `gstack-checkpoint`
  - equivalent Codex/gstack checkpoint skill or workflow

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
- multi-agent orchestration is available
- `PLAN.md` exists or can be created
- `개발일지.md` path exists or can be created

## Hard-fail rule

If Oh My XX orchestration, multi-agent support, or any required gate is missing:

- stop before implementation
- report the exact missing prerequisite
- tell the user that the prerequisite must be installed or enabled first
- do not imitate the missing gate manually
