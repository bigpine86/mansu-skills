---
name: mansu-ship
description: Decide ship or hold, then coordinate release notes, commit/push/PR/deploy/canary, and learning handoff through source ship skills.
---

# Mansu Ship

Use this skill when implementation has been verified and reviewed enough to make
a release decision.

If verification evidence or review/risk notes are missing, do not make a
ship/hold claim yet; route back to `mansu-verify` or `mansu-review` and record
which gate is missing.

## Required references

- `mansu-operating-model/references/SOURCE_SKILL_COMPOSITION.md`
- `mansu-operating-model/references/CODE_CONSTRUCTION_ORDER.md`

## Source skill route

- Default to `mansu-ship-release` for Mansu release readiness and ship/hold
  judgment.
- Use addyosmani `git-workflow-and-versioning`, `ci-cd-and-automation`,
  `documentation-and-adrs`, and `shipping-and-launch`.
- Use gstack `ship`, `document-release`, `land-and-deploy`, `canary`, `retro`,
  and `learn` for release, deploy, monitoring, and learning closeout.
- Use Ouroboros `publish` and `status` when Seed/team publishing or
  Ouroboros-run status is involved.

## Outputs

- ship/hold decision
- missing evidence or release blockers
- changelog/docs/PR/deploy/canary actions when approved
- learning closeout and next maintenance route

## Final guidance

End the response with a clear ship status.

- If shipping is approved and completed, say the development process is complete
  for this release and name any follow-up monitoring or learning route.
- If shipping is held, name the missing gate and route back to `mansu-verify`,
  `mansu-review`, `mansu-build`, or `mansu-debug`.
- Do not leave the final state ambiguous.
