## Active Follow-up

- Add `mansu-operating-model` as the canonical doctrine skill for project operating rules.
- Add project-document templates for `AGENTS.md` and `CODING_RULES.md` under the doctrine skill.
- Add doctrine/document validators and wire them into the top-level validation flow.
- Remaining follow-up after this slice:
  - decide whether a future validator should inspect filled-in project `AGENTS.md` / `CODING_RULES.md` examples in a fixture directory
  - decide whether `mansu-start` should proactively recommend `mansu-operating-model` when setting up a new project
  - review `mansu-web-verify` and any remaining docs for older runtime mental models

## Ready for Commit

- Added `mansu-operating-model` as the canonical doctrine and template source.
- Added `validate_mansu_operating_model.sh` and `validate_mansu_doc_system.sh`.
- Wired doctrine/document checks into `scripts/validate_mansu_skills.sh`.
- Updated README and philosophy docs to explain the doctrine/router/local-manual structure.
