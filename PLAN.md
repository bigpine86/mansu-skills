## Active Follow-up

- Land the multiagent review follow-up on `main`.
- After commit, sync the changed `mansu-*` folders into the active runtime skill directory.
- Future follow-up: exercise `mansu-project-start` on a real greenfield project and
  `mansu-ship-release` on a real release to tune report shape.
- Confirm the new Ouroboros route in a real project: `mansu-setting` prepares
  Ouroboros/OMO/gstack, then `mansu-project-start` uses Ouroboros PM/interview/Seed
  artifacts before converting them into Mansu docs and phase `PLAN.md`.

## Ready for Commit

- Added `mansu-operating-model/references/CODE_CONSTRUCTION_ORDER.md` as a dynamic construction router.
- Added `mansu-operating-model/references/DOCUMENT_CREATION_ORDER.md` as the document creation router.
- Added `mansu-operating-model/references/SOURCE_SKILL_LOCK.json` as a source freshness snapshot.
- Added `mansu-project-start` as the zero-to-PLAN project kickoff route.
- Added `mansu-source-curator` as the internal source/reference maintenance route.
- Added `mansu-ship-release` as the release readiness and ship/hold route.
- Added `addyosmani/agent-skills` as a third source family in `SOURCE_SKILL_CATALOG.md`.
- Updated `mansu-tdd-total`, `mansu-tdd-lite`, and `mansu-tdd-strict` to detect current construction phase and route to source skills instead of hardcoding one order.
- Updated `mansu-setting` to include addyosmani/agent-skills in source freshness checks and to sync runtime skills only after source curation and validation pass.
- Updated `mansu-setting` to prepare Ouroboros, gstack, and the matching Oh My adapter, while leaving actual Ouroboros project-definition work to `mansu-project-start`.
- Updated `mansu-project-start` to use Ouroboros Seed/Ledger/PM artifacts as upstream project-definition evidence when useful.
- Updated `mansu-source-curator`, `SOURCE_SKILL_CATALOG.md`, and `SOURCE_SKILL_LOCK.json` so Ouroboros is tracked as an active source family.
- Added project-level gate mapping and learning closeout guidance to `CODING_RULES.md`.
- Updated README, philosophy, source catalog, and validators to preserve the new zero-to-release routes.
