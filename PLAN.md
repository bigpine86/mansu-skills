## Active Follow-up

- Runtime-readiness validator follow-up is active on branch `feat/runtime-readiness-validator`.
- Reference documents:
  - `docs/runtime-target-matrix.md`
  - `docs/plans/2026-05-02-next-pr-scope.md`
- Remaining high-value follow-up after this validator slice:
  - review `mansu-web-verify` and any remaining docs for older runtime mental models
  - decide whether Hermes should eventually use a fully fixed canonical skill-target path instead of host-detected wording
  - consider whether the runtime-readiness validator should grow beyond high-signal pattern checks into broader suite coverage

## Ready for Commit

- Added a suite-level runtime-readiness validator and wired it into the top-level validation flow.
- README validation section now exposes the new validator alongside the existing skill checks.
