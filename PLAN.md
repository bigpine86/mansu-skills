## Active Follow-up

- `MANSU_PHILOSOPHY.md` now records the shared Mansu principle: do not reinvent strong workflows; plan, protect, route, verify, and record while delegating specialized craft to the best source skill.
- `mansu-debug-rootcause` now follows the same pattern with a source skill map and Mansu-owned boundary.
- `mansu-web-verify` is now framed as a thin orchestrator: Mansu owns the plan, safety boundary, evidence, routing, and report, while specialized browser/QA/performance/security/canary/E2E work is delegated to gstack or Oh My source skills when appropriate.
- `README.md` now gives the repo a clear entry point, install path, routing guide, source skill policy, and validation commands.
- Next useful follow-up is to decide whether this repository should be pushed as `main` or kept on the current local branch for review.
- If the repo becomes canonical, add a simple sync/install workflow so repo changes and installed skills do not drift.
- Future Mansu skill families to consider:
  - `mansu-research-deep`
  - `mansu-design-system`
  - `mansu-ship-release`
  - `mansu-spike-lite`
  - possibly split debug routes later if `doctor`, `build-fix`, `benchmark`, or `trace` branches become large enough
