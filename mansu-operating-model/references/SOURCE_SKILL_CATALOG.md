# Mansu Source Skill Catalog

This catalog records the source skills Mansu should know before inventing a new
workflow.

Mansu does not compete with strong specialist skills. Mansu classifies the work,
sets the discipline, and routes to the right source skill at the right moment.

Last local snapshot: 2026-05-02.

## Operating Rule

Before expanding a `mansu-*` skill or starting non-trivial work:

1. Classify the work with Mansu doctrine.
2. Check this catalog for source skills that already cover the craft.
3. Read the original `SKILL.md` when the task is high-risk, ambiguous, or the
   catalog summary is not enough.
4. Let Mansu own boundaries, gates, evidence, and final accountability.
5. Let source skills own specialized execution when they are stronger.
6. Record any new source-skill insight in the worklog.

Source skills can drift. Treat this catalog as a routing map, not a replacement
for the original skill files.

## Freshness Policy

Mansu must keep watching the two upstream source families that shape this suite:

- gstack specialist skills
- Oh My / OMO / OMC style execution-mode skills

Whenever `mansu-start check`, `mansu-start update`, or serious project bootstrap
runs, include a source freshness check:

1. Check whether the installed gstack repo or `gstack-*` skill set changed.
2. Check whether the installed Oh My / OMO / OMC adapter or source skill set changed.
3. Compare notable added, removed, or renamed skills against this catalog.
4. If source skills changed in a way that affects routing, read the original
   `SKILL.md` and update this catalog before relying on stale assumptions.
5. Record the source freshness result in the final report and worklog.

Missing source tooling is not automatically fatal. Report what was unavailable,
continue with the safe Mansu path, and block only when the requested workflow
depends on the missing source.

## Layer Model

| Layer | Owns | Does not own |
| --- | --- | --- |
| Mansu | doctrine, classification, strictness, routing, evidence, checkpoint, worklog, final ship judgment | specialist craft implementation when a stronger source skill exists |
| gstack | role-based specialist gates, browser QA, design exploration, security, performance, ship/ops, learning | Mansu-specific doctrine or personal operating rules |
| Oh My / OMO / OMC | execution modes, parallel work patterns, persistence, TDD/debug/research habits, lightweight orchestration language | final Mansu policy, project-specific evidence gates |

## gstack Capability Map

Use gstack as the specialist team and verification layer.

| Capability | Source skills | Route when |
| --- | --- | --- |
| Problem discovery | `gstack-office-hours` | idea, product wedge, demand reality, first design doc |
| Full plan review | `gstack-autoplan` | one-pass CEO/design/eng/DX plan gauntlet is useful |
| Product judgment | `gstack-plan-ceo-review` | scope, MVP, ambition, product risk need critique |
| Engineering plan | `gstack-plan-eng-review` | architecture, data flow, edge cases, test strategy matter |
| Design plan | `gstack-plan-design-review` | UI/UX decisions should be locked before build |
| DX plan | `gstack-plan-devex-review`, `gstack-devex-review` | API, CLI, SDK, docs, onboarding, or TTHW matter |
| Design system | `gstack-design-consultation` | new UI has no design source of truth |
| Design variants | `gstack-design-shotgun` | multiple visual directions, comparison board, structured feedback are needed |
| Design implementation | `gstack-design-html` | approved visual direction should become implementation-ready HTML/CSS |
| Visual QA | `gstack-design-review` | live UI needs hierarchy, spacing, AI-slop, responsive, interaction review |
| Browser evidence | `gstack-browse`, `gstack-open-gstack-browser`, `gstack-setup-browser-cookies` | real page behavior, screenshots, auth browser sessions, responsive checks |
| QA report | `gstack-qa-only` | user wants findings and evidence without code changes |
| QA fix loop | `gstack-qa` | user explicitly wants test-fix-verify on a web app |
| Code review | `gstack-review` | pre-landing diff review, correctness, side effects, trust boundaries |
| Debugging | `gstack-investigate` | unknown failure, regression, root-cause investigation |
| Safety scope | `gstack-guard`, `gstack-freeze`, `gstack-unfreeze`, `gstack-careful` | destructive risk, live system, or narrow edit boundary is needed |
| Health check | `gstack-health` | project quality score, tests, lint, typecheck, blockers |
| Performance | `gstack-benchmark` | load time, Core Web Vitals, bundle/resource regression |
| Security | `gstack-cso` | auth, permissions, secrets, supply chain, LLM boundary, OWASP/STRIDE |
| Ship | `gstack-ship`, `gstack-landing-report` | tests, review, version/changelog, commit/push/PR readiness |
| Deploy | `gstack-setup-deploy`, `gstack-land-and-deploy`, `gstack-canary` | deployment config, merge/deploy, post-deploy monitoring |
| Documentation | `gstack-document-release`, `gstack-make-pdf` | post-ship docs or polished PDF artifacts |
| Learning | `gstack-checkpoint`, `gstack-context-save`, `gstack-context-restore`, `gstack-retro`, `gstack-learn` | state handoff, session resume, retro, reusable lessons |
| Browser data work | `gstack-scrape`, `gstack-skillify` | read-only extraction or codifying a repeated browser scrape |
| Model/tool ops | `gstack-upgrade`, `gstack-benchmark-models`, `gstack-claude`, `gstack-pair-agent`, `gstack-setup-gbrain`, `gstack-plan-tune` | update, compare models, outside voice, pair agent, memory/profile tuning |

## Oh My / OMO / OMC Capability Map

Use Oh My-style skills as execution-mode vocabulary and lightweight workflow
patterns. Names may differ by runtime target; verify the installed skill path
with `mansu-start`.

| Capability | Source skills | Route when |
| --- | --- | --- |
| End-to-end build mode | `autopilot` | full user story or feature needs systematic plan-execute-verify |
| Large parallel work | `ultrawork`, `ultrapilot`, `team`, `swarm` | independent file/module slices can run in parallel without conflicts |
| Persistent completion | `ralph` | task must not stop at partial success and needs retry loops |
| Iterative plan critique | `ralplan`, `planner` | plan should be drafted, critiqued, refined, and consensus-checked |
| TDD habit | `tdd` | clear behavior can be locked with RED/GREEN/REFACTOR |
| Debug habit | `debug`, `trace` | reproduce, isolate, hypothesize, test, fix, verify, or inspect orchestration flow |
| Build failure repair | `build-fix`, `doctor` | compile, lint, install, configuration, or toolchain failure blocks work |
| Code review | `code-review`, `reviewer` | structured security/performance/correctness/maintainability review is needed |
| Quality sweep | `ultraqa`, `playwright` | broad regression, E2E, or repeatable browser tests are needed |
| Security audit | `security-review` | focused security checklist is enough or gstack CSO is unavailable |
| Research | `research`, `deepsearch`, `analyze` | external/technical research, codebase exploration, dependency/pattern analysis |
| Project setup | `deepinit`, `mcp-setup` | initialize tooling, standards, templates, or MCP integrations |
| Ship support | `release`, `git-master`, `pipeline` | versioning, changelog, branch workflow, CI/CD style steps |
| Memory/logging | `note`, `learner`, `hud`, `configure-notifications` | session notes, reusable patterns, progress HUD, completion notifications |
| Fast small work | `eco` | low-risk quick fix where full Mansu spine would be overkill |

## Mansu Composition Recipes

### Feature Or Refactor

1. Mansu classifies `Quick / Standard / Heavy`.
2. For non-trivial work, use `mansu-tdd-total`.
3. Planning may route through `gstack-office-hours`, `gstack-autoplan`, and
   focused `gstack-plan-*` reviewers.
4. Slice execution dispatches to `mansu-tdd-lite` or `mansu-tdd-strict`.
5. Each slice closes with review, validation, checkpoint, worklog, and commit or
   explicit no-commit reason.

### UI/UX Work

1. Use Mansu doctrine to define the product goal, user, and risk.
2. Use `gstack-plan-design-review` before implementation.
3. Use `gstack-design-shotgun` when multiple visual directions are valuable.
4. Use `gstack-design-html` only after a direction is approved or stable.
5. Use `gstack-design-review`, `gstack-browse`, and `gstack-qa-only` for rendered
   evidence before declaring the UI done.

### Bug Or Regression

1. Use `mansu-debug-rootcause`.
2. Borrow Oh My `debug` as the outer habit: reproduce, isolate, hypothesize,
   test, fix, verify.
3. Use `gstack-investigate` gates for root-cause proof, minimal fix, and fresh
   verification.
4. Use `gstack-browse` or `gstack-qa-only` for browser evidence before full
   `gstack-qa` fix loops.

### Web Verification

1. Use `mansu-web-verify` as the orchestrator.
2. Use `gstack-browse` for direct interaction and screenshots.
3. Use `gstack-qa-only` for report-only mode.
4. Use `gstack-qa` only when fixes are approved.
5. Add `gstack-benchmark`, `gstack-cso`, or `gstack-canary` when performance,
   security, or post-deploy risk is part of the claim.

### Ship And Learn

1. Use `gstack-health` before ship judgment.
2. Use `gstack-review` for diff risk.
3. Use `gstack-ship` for PR/commit/push workflows when appropriate.
4. Use `gstack-land-and-deploy` and `gstack-canary` for actual deployment.
5. Use `gstack-document-release`, `gstack-retro`, and `gstack-learn` so the
   project improves after the task ends.

## Anti-Patterns

- Do not clone gstack's specialist skills into Mansu just to rename them.
- Do not run Oh My parallel modes when slices have sequential dependencies.
- Do not use `gstack-qa` to bypass root-cause-first debugging.
- Do not claim strict mode if real gates were skipped.
- Do not let the source catalog override explicit project `CODING_RULES.md`
  commands or safety boundaries.
- Do not trust this catalog blindly when a source skill was recently updated;
  read the original skill.
