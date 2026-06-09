---
name: mansu-verify
description: Prove behavior with tests, runtime/browser checks, QA evidence, and security or performance checks when relevant.
---

# Mansu Verify

Use this skill when behavior must be proven before review, ship, or a claim of
completion. When verification passes, continue directly into `mansu-review`
unless the user explicitly stops, defers review, or verification found blocking
failures.

Verify proves behavior. It is not the same as Review, and it is not a substitute
for root-cause debugging when the cause is unknown.

## Required references

- `mansu-operating-model/references/SOURCE_SKILL_COMPOSITION.md`
- `mansu-operating-model/references/CODE_CONSTRUCTION_ORDER.md`

## Source skill route

- Use addyosmani `test-driven-development`, `browser-testing-with-devtools`,
  `security-and-hardening`, and `performance-optimization` to choose the right
  evidence type.
- Use gstack `qa-only`, `qa`, `browse`, `health`, `cso`, and `benchmark` for
  independent QA evidence.
- Use Ouroboros `qa` or `evaluate` when Ouroboros-produced artifacts or runs
  need judgment.
- Use `mansu-web-verify` as the compatibility route for web/browser verification.

## Review handoff

- Keep Verify and Review as separate gates because they produce different
  evidence: Verify proves behavior; Review judges quality and risk.
- In normal execution, treat `mansu-verify -> mansu-review` as one continuous
  gate sequence.
- If verification passes, run `mansu-review` next by default.
- Do not enter `mansu-review` when verification fails, when required evidence is
  missing, or when the user explicitly asks to stop before review.
- If the cause of a verification failure is unknown, route to `mansu-debug`
  before any review or fix claim.

## Outputs

- tests or runtime checks run
- QA evidence and pass/fail result
- untested risk
- review handoff result: `mansu-review` completed, explicitly deferred, or
  blocked with reason
- fixes required or route to `mansu-debug`, `mansu-review`, or `mansu-ship`

## Final guidance

End the response by saying what happened to the Review handoff.

- If Verify passed, continue into `mansu-review` by default and report that
  Review was run or is the immediate next step.
- If Verify failed, tell the user not to review yet; route to `mansu-debug` when
  the cause is unknown, or back to `mansu-build` when the fix is clear.
- Do not suggest `mansu-ship` until Review evidence exists.
