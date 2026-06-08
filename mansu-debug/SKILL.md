---
name: mansu-debug
description: Special root-cause route for unknown failures, regressions, stack traces, broken behavior, or review findings that need diagnosis before fixing.
---

# Mansu Debug

Use this skill when something is broken and the root cause is not proven.

Debug can interrupt any phase. Do not patch first and explain later.

## Required references

- `mansu-operating-model/references/SOURCE_SKILL_COMPOSITION.md`
- `mansu-operating-model/references/CODE_CONSTRUCTION_ORDER.md`

## Source skill route

- Default to `mansu-debug-rootcause` for root cause first workflow.
- Use OMO `debugging` as the reproduce, isolate, hypothesize, test, fix, verify
  habit when available.
- Use addyosmani `debugging-and-error-recovery` and
  `doubt-driven-development`.
- Use gstack `investigate`, `browse`, and `qa-only` for independent proof and
  regression evidence.

## Outputs

- reproduction path
- hypotheses tested
- proven root cause
- minimal fix route or explicit no-fix report
- regression proof and handoff back to `mansu-build`, `mansu-verify`, or
  `mansu-review`
