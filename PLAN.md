## Active Follow-up

- Hermes/OpenCode port baseline is now in place on branch `refactor/hermes-opencode-port`.
- Reference documents:
  - `docs/plans/2026-05-02-hermes-opencode-port-plan.md`
  - `docs/runtime-target-matrix.md`
- Remaining high-value follow-up:
  - add a broader runtime-readiness validator that checks stale path/tool-name drift across the suite
  - review `mansu-web-verify` and any remaining docs for older runtime mental models
  - decide whether Hermes should eventually use a fully fixed canonical skill-target path instead of host-detected wording

## Ready for Commit

- Ported and validated in current-runtime terms:
  - `README.md`
  - `mansu-start`
  - `mansu-debug-rootcause`
  - `mansu-tdd-total`
  - `mansu-tdd-strict`
- Validators updated to reject the worst stale terminology regressions in the touched areas.
