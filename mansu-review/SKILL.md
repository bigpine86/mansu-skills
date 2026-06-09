---
name: mansu-review
description: Judge quality, maintainability, safety, design, architecture, and decision risk after behavior has been verified.
---

# Mansu Review

Use this skill when the implementation is ready for quality judgment.

Review judges quality. Review is not QA, and it should not claim behavior works
without verification evidence.

## Required references

- `mansu-operating-model/references/SOURCE_SKILL_COMPOSITION.md`
- `mansu-operating-model/references/CODE_CONSTRUCTION_ORDER.md`

## Source skill route

- Use addyosmani `code-review-and-quality`, `code-simplification`,
  `debugging-and-error-recovery`, and `doubt-driven-development`.
- Use gstack `review`, `plan-eng-review`, `plan-design-review`,
  `design-review`, `investigate`, and `cso` for specialist critique.
- Use OMO `review-work`, `remove-ai-slops`, `debugging`, and
  `comment-checker` when those execution habits fit the diff.

## Outputs

- findings ordered by severity
- architectural, design, security, maintainability, and decision risks
- required fixes or route to `mansu-debug`
- re-verification needed before ship

## Final guidance

End the response by saying what should happen next.

- If Review passes and Verify evidence exists, tell the user the next step is
  `mansu-ship`.
- If Review finds required fixes with a clear path, route back to `mansu-build`
  and then `mansu-verify`.
- If Review finds an unknown-cause problem, route to `mansu-debug`.
- Do not claim ship-ready when required fixes or re-verification remain.
