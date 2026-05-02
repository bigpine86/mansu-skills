---
name: mansu-ship-release
description: Mansu release and ship-readiness workflow. Use after implementation slices are complete, when deciding whether work is ship-ready, preparing commits/PRs, release notes, docs, deployment, canary checks, rollback notes, retro, and learning capture; or when distinguishing implemented, reviewed, QA-verified, ship-ready, merged, deployed, and monitored states.
---

# Mansu Ship Release

Use this skill after implementation work is complete enough to judge.

This skill does not make code correct by optimism. It turns completed work into a
ship-or-hold decision with evidence, docs, release path, and learning.

## Core promise

- Distinguish implemented, reviewed, QA-verified, ship-ready, merged, deployed,
  and monitored.
- Run final health, review, validation, QA, docs, and risk gates before claiming
  ship readiness.
- Use source ship/deploy/learn skills instead of reimplementing them.
- Record what was verified, what was not verified, remaining risk, rollback
  notes, and follow-up.

## Modes

- `ship-check`: report readiness without committing, pushing, or deploying.
- `commit-pr`: prepare final commit and PR after readiness gates pass.
- `release-docs`: update README, changelog, architecture docs, ADRs, or release notes.
- `deploy`: land, deploy, and verify production only when explicitly requested.
- `post-deploy`: canary/monitoring after deploy.
- `hold`: stop and report blockers.

Default to `ship-check` unless the user explicitly asks to commit, push, PR,
merge, deploy, or release.

## Source skills to consider

| Need | Source route |
| --- | --- |
| Final quality dashboard | `gstack-health` |
| Diff/risk review | `gstack-review` |
| Browser/user-flow evidence | `mansu-web-verify`, `gstack-qa-only`, `gstack-browse` |
| Security | `gstack-cso`, addyosmani `security-and-hardening` |
| Performance | `gstack-benchmark`, addyosmani `performance-optimization` |
| Commit/PR/version/changelog | `gstack-ship`, addyosmani `git-workflow-and-versioning` |
| Deploy/canary | `gstack-land-and-deploy`, `gstack-canary`, addyosmani `ci-cd-and-automation` |
| Docs/release notes | `gstack-document-release`, addyosmani `documentation-and-adrs`, `shipping-and-launch` |
| Retro/learning | `gstack-retro`, `gstack-learn` |

## Ship gate

Before `ship-ready`, confirm:

- agreed scope is complete
- active `PLAN.md` has no open slice blockers
- review status is known
- validation commands ran or explicit skip reasons are recorded
- QA status is known where applicable
- docs/release notes are current for user-facing or architectural changes
- unresolved risks are named and accepted or block ship
- rollback or recovery path is known for risky changes
- worklog and learning closeout are updated

If any gate is missing, use `hold` unless the user explicitly accepts the risk.

## Workflow

1. Read `PLAN.md`, worklog, recent diff, and project `CODING_RULES.md`.
2. Map the project gates: health, review, QA, security/performance if relevant,
   docs, commit/PR, deploy/canary, learning.
3. Run the relevant final validation and review gates.
4. Update docs and release notes when behavior, architecture, setup, or user
   flows changed.
5. Decide terminal state: `implemented`, `reviewed`, `QA-verified`,
   `ship-ready`, `held`, `merged`, `deployed`, or `monitored`.
6. If commit/PR/deploy was requested and gates pass, route to the source skill
   that owns that execution.
7. Write retro/learning notes and move completed detail out of active `PLAN.md`.

## Learning closeout

Every release decision should decide where the lesson belongs:

- Worklog: what happened and why
- `CODING_RULES.md`: repeated project rule or command
- ADR: durable architecture choice
- Tests: regression or invariant discovered
- Source catalog: reusable source-skill routing insight
- Release docs: user-facing change, migration, rollback, or known limitation

Do not bury durable lessons only in the final chat message.

## Final report

```text
MANSU SHIP RELEASE REPORT
Mode:
Scope:
Health:
Review:
Validation:
QA:
Security:
Performance:
Docs/release notes:
Commit/PR:
Deploy/canary:
Rollback:
Learning closeout:
Terminal state:
Remaining risks:
Next action:
```
