## Active Follow-up

- `mansu-tdd-total` planning is now strengthened: Planner, Critics, and Synthesizer roles must be mapped, and implementation cannot start until the accepted plan and slice table are visible.
- Sequential slice execution is now explicit: slice N+1 cannot start until slice N is fully closed with validation, review, QA, checkpoint, plan/worklog updates, and commit or no-commit reason.
- `main` is now the canonical branch target for finished Mansu skill changes.
- `MANSU_PHILOSOPHY.md` now records the shared Mansu principle: do not reinvent strong workflows; plan, protect, route, verify, and record while delegating specialized craft to the best source skill.
- `mansu-debug-rootcause` now follows the same pattern with a source skill map and Mansu-owned boundary.
- `mansu-web-verify` is now framed as a thin orchestrator: Mansu owns the plan, safety boundary, evidence, routing, and report, while specialized browser/QA/performance/security/canary/E2E work is delegated to gstack or Oh My source skills when appropriate.
- `README.md` now gives the repo a clear entry point, install path, routing guide, source skill policy, and validation commands.
- If the repo becomes canonical, add a simple sync/install workflow so repo changes and installed skills do not drift.
- Future Mansu skill families to consider:
  - `mansu-research-deep`
  - `mansu-design-system`
  - `mansu-ship-release`
  - `mansu-spike-lite`
  - possibly split debug routes later if `doctor`, `build-fix`, `benchmark`, or `trace` branches become large enough
