---
name: mansu-verify
description: Prove behavior with tests, runtime/browser checks, QA evidence, and security or performance checks when relevant.
---

# Mansu Verify

Use this skill when behavior must be proven before review, ship, or a claim of
completion.

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

## Outputs

- tests or runtime checks run
- QA evidence and pass/fail result
- untested risk
- fixes required or route to `mansu-review`, `mansu-debug`, or `mansu-ship`
