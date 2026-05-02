## Active Follow-up

- Land the multiagent review follow-up on `main`.
- After commit, sync the changed `mansu-*` folders into the active runtime skill directory.
- Future follow-up: exercise `mansu-project-start` on a real greenfield project and
  `mansu-ship-release` on a real release to tune report shape.

## Ready for Commit

- Added `mansu-operating-model/references/CODE_CONSTRUCTION_ORDER.md` as a dynamic construction router.
- Added `mansu-operating-model/references/DOCUMENT_CREATION_ORDER.md` as the document creation router.
- Added `mansu-operating-model/references/SOURCE_SKILL_LOCK.json` as a source freshness snapshot.
- Added `mansu-project-start` as the zero-to-PLAN project kickoff route.
- Added `mansu-source-curator` as the internal source/reference maintenance route.
- Added `mansu-ship-release` as the release readiness and ship/hold route.
- Added `addyosmani/agent-skills` as a third source family in `SOURCE_SKILL_CATALOG.md`.
- Updated `mansu-tdd-total`, `mansu-tdd-lite`, and `mansu-tdd-strict` to detect current construction phase and route to source skills instead of hardcoding one order.
- Updated `mansu-start` to include addyosmani/agent-skills in source freshness checks and to sync runtime skills only after source curation and validation pass.
- Added project-level gate mapping and learning closeout guidance to `CODING_RULES.md`.
- Updated README, philosophy, source catalog, and validators to preserve the new zero-to-release routes.
