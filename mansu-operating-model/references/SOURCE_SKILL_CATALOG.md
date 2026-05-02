# Mansu Source Skill Catalog

This catalog records the source skills Mansu should know before inventing a new
workflow.

Mansu does not compete with strong specialist skills. Mansu classifies the work,
sets the discipline, and routes to the right source skill at the right moment.

Last local snapshot: 2026-05-03.

Machine-readable freshness evidence lives in `SOURCE_SKILL_LOCK.json`. Treat that
file as the source-family snapshot for paths, versions, commits, inventory, and
evidence commands. This catalog explains routing meaning; the lock file records
what was actually checked.

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

## Source Mastery Rule

Mansu should know the source skill families well enough to compose them without
flattening them.

- Use gstack as the specialist team: CEO, design, engineering, DX, browser QA,
  security, performance, ship, deploy, and learning gates.
- Use Oh My / OMO / OMC as execution-mode language: autopilot, ultrawork,
  ralph, TDD, debug, research, build-fix, and lightweight orchestration habits.
- Use addyosmani/agent-skills as the senior-engineering sequence: idea/spec,
  task breakdown, context packing, source-driven coding, incremental
  implementation, TDD, review, simplification, hardening, docs, and ship.
- Compose creatively only after the basic gates are explicit: intent, scope,
  research source, architecture, slice boundary, validation, review, QA,
  checkpoint, and learning.
- Prefer the original source skill when it is stronger. Mansu's job is to choose,
  sequence, and hold accountability.

## Freshness Policy

Mansu must keep watching the upstream source families that shape this suite:

- gstack specialist skills
- Oh My / OMO / OMC style execution-mode skills
- addyosmani/agent-skills production engineering workflow skills

Whenever `mansu-start check`, `mansu-start update`, or serious project bootstrap
runs, include a source freshness check:

1. Check whether the installed gstack repo or `gstack-*` skill set changed.
2. Check whether the installed Oh My / OMO / OMC adapter or source skill set changed.
3. Check whether `addyosmani/agent-skills` changed when it is installed or referenced.
4. Compare notable added, removed, or renamed skills against this catalog.
5. If source skills changed in a way that affects routing, read the original
   `SKILL.md` and update this catalog before relying on stale assumptions.
6. Record the source freshness result in the final report and worklog.

Missing source tooling is not automatically fatal. Report what was unavailable,
continue with the safe Mansu path, and block only when the requested workflow
depends on the missing source.

## Layer Model

| Layer | Owns | Does not own |
| --- | --- | --- |
| Mansu | doctrine, classification, strictness, routing, evidence, checkpoint, worklog, final ship judgment | specialist craft implementation when a stronger source skill exists |
| gstack | role-based specialist gates, browser QA, design exploration, security, performance, ship/ops, learning | Mansu-specific doctrine or personal operating rules |
| Oh My / OMO / OMC | execution modes, parallel work patterns, persistence, TDD/debug/research habits, lightweight orchestration language | final Mansu policy, project-specific evidence gates |
| addyosmani/agent-skills | senior-engineering SDLC sequence, spec-first planning, task breakdown, context packing, incremental implementation, source-driven coding | Mansu-specific strictness, project-local routing, runtime adapters |

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
| Learning | `gstack-context-save`, `gstack-context-restore`, `gstack-retro`, `gstack-learn`; `gstack-checkpoint` only when the installed runtime still exposes it as the checkpoint-family gate | state handoff, session resume, retro, reusable lessons |
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

## addyosmani/agent-skills Capability Map

Use addyosmani-style skills as the coding-order and engineering-lifecycle
reference, especially when Mansu knows which slice to build but needs sharper
rules for how to build it.

| Capability | Source skills | Route when |
| --- | --- | --- |
| Idea and spec | `idea-refine`, `spec-driven-development` | vague request, new feature, unclear acceptance criteria |
| Task ordering | `planning-and-task-breakdown` | plan must become dependency-ordered, verifiable tasks |
| Context loading | `context-engineering` | session drift, unfamiliar module, or task-specific context is needed |
| Current docs | `source-driven-development` | framework/library behavior depends on current official docs |
| Incremental coding | `incremental-implementation` | multi-file change, temptation to code too much before testing |
| Behavior proof | `test-driven-development` | logic, bug fix, or behavior change benefits from RED/GREEN/REFACTOR |
| UI implementation | `frontend-ui-engineering` | user-facing UI needs component, accessibility, responsive discipline |
| API/interface design | `api-and-interface-design` | public or cross-module boundary must be stable and explicit |
| Runtime verification | `browser-testing-with-devtools`, `debugging-and-error-recovery` | browser behavior, runtime state, or broken behavior needs evidence |
| Quality gates | `code-review-and-quality`, `code-simplification`, `security-and-hardening`, `performance-optimization` | implementation needs review, simplification, security, or performance work beyond compile/test success |
| Ship lifecycle | `git-workflow-and-versioning`, `ci-cd-and-automation`, `deprecation-and-migration`, `documentation-and-adrs`, `shipping-and-launch` | commits, CI, deprecation, migration, docs, ADRs, launch, rollback need discipline |

## Mansu Composition Recipes

### New Project / Zero-To-PLAN

Use `mansu-project-start` when the work starts from an idea, new repo, major
product direction, architecture choice, UI system, or TDR-level ambiguity.

The route is:

1. Define purpose, user, current workaround, desired outcome, non-goals, and
   success signal.
2. Research references using evidence-ranked sources: official/current docs and
   source files first for technical truth; GitHub, Reddit, and Threads for
   adoption, pain, taste, and implementation signals with dates recorded.
3. Analyze relevant projects at code and architecture level when they influence
   stack, domain model, UI, or delivery sequence.
4. Create the needed documents through `DOCUMENT_CREATION_ORDER.md`: operating
   docs, idea/spec, research notes, TDR/architecture, UI design, ADRs, then
   phase-level `PLAN.md`.
5. Verify with `gstack-autoplan` and focused `gstack-plan-*` reviewers.
6. Hand off to `mansu-tdd-total` only after the current phase has ordered slices,
   gate mapping, validation path, upstream artifacts, and open blockers recorded.

### Source Refresh And Reference Curation

Use `mansu-source-curator` when the issue is not feature delivery, but keeping
Mansu's knowledge of gstack, Oh My / OMO / OMC, addyosmani/agent-skills, or
runtime adapters current.

This is an internal maintenance route:

1. Start with `mansu-start source-check` for runtime, adapter, and source-family status.
2. If the user asked for updates, let `mansu-source-curator` run the safe update path.
3. Re-read changed source skill files or GitHub source data before editing Mansu references.
4. Update this catalog, `SOURCE_SKILL_LOCK.json`, `DOCUMENT_CREATION_ORDER.md`,
   `CODE_CONSTRUCTION_ORDER.md`, affected `mansu-*` skills, validators, and
   worklog together.
5. Run `scripts/validate_mansu_skills.sh` and `git diff --check`.
6. Sync installed local Mansu skills only after validation passes.

Do not use this route to copy whole source workflows into Mansu. The curator
keeps routing knowledge fresh; source skills still own specialist execution.

### Project Design / TDR / Blueprint Layer

Use this before `PLAN.md` when the work is a new product, major feature family,
architecture direction, UI system, or technically ambiguous project.

Read `DOCUMENT_CREATION_ORDER.md` for the exact document sequence, source skill
to use for each artifact, and verification skill to use before handoff.

No source family requires a file literally named `PROJECT_BLUEPRINT.md`. That name
is a possible Mansu-normalized artifact, not an upstream standard. Prefer the
project's existing convention when it exists.

Source artifact conventions:

- gstack `office-hours` writes a design document under `~/.gstack/projects/{slug}/`.
- gstack `plan-ceo-review` can promote a strong vision to `docs/designs/{FEATURE}.md`.
- gstack `autoplan` reviews a rough plan through CEO, design, engineering, and DX
  phases, then appends review status to the active plan file.
- Oh My-style `planner` writes to `.codex/plans/{project-name}.md`; `ralplan`
  produces an iterative draft / critique / refined plan artifact.
- addyosmani `idea-refine` writes an idea one-pager to `docs/ideas/{idea-name}.md`
  when confirmed.
- addyosmani `spec-driven-development` expects a committed spec as the shared
  source of truth before implementation.
- addyosmani `planning-and-task-breakdown` produces an `Implementation Plan`.
- addyosmani `documentation-and-adrs` stores ADRs in `docs/decisions/`.

Mansu may consolidate those outputs into a blueprint/TDR layer when that helps,
but it must not pretend the upstream tools all use the same filename.

1. Define the project intent with `gstack-office-hours` and, when useful,
   addyosmani `idea-refine` or `spec-driven-development`.
2. Run source-aware research with Oh My `research` / `deepsearch` patterns and
   addyosmani `source-driven-development`; include GitHub, Reddit, Threads, and
   official docs when freshness matters.
3. Draft or update the design/spec/blueprint layer: product shape, feature groups, domain model,
   architecture, data/API boundaries, technology stack, secret/API-key handling,
   UI/UX direction, build strategy, phase roadmap, risks, and non-goals.
4. Review that layer with `gstack-autoplan` so CEO, design, engineering, and
   DX perspectives all pass over it.
5. Deepen weak areas with focused `gstack-plan-ceo-review`,
   `gstack-plan-design-review`, `gstack-plan-eng-review`, or
   `gstack-plan-devex-review`.
6. Record major irreversible or architectural choices as ADR-style notes when
   `documentation-and-adrs` applies.
7. Only then derive the current phase's `PLAN.md` and vertical slice table.

### Feature Or Refactor

1. Mansu classifies `Quick / Standard / Heavy`.
2. For non-trivial work, use `mansu-tdd-total`.
3. Use `CODE_CONSTRUCTION_ORDER.md` to decide dependency graph, context pack,
   contract-first boundaries, and slice coding order.
4. Planning may route through `gstack-office-hours`, `gstack-autoplan`, and
   focused `gstack-plan-*` reviewers.
5. Slice execution dispatches to `mansu-tdd-lite` or `mansu-tdd-strict`.
6. Each slice closes with review, validation, checkpoint, worklog, and commit or
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

Use `mansu-ship-release` when implementation is complete enough to judge.

1. Use `gstack-health` before ship judgment.
2. Use `gstack-review` for diff risk.
3. Use `mansu-web-verify`, `gstack-qa-only`, or project QA for runtime/user-flow evidence.
4. Use `gstack-cso` or `gstack-benchmark` when security or performance risk is part of the claim.
5. Use `gstack-ship` for PR/commit/push workflows when appropriate.
6. Use `gstack-land-and-deploy` and `gstack-canary` for actual deployment.
7. Use `gstack-document-release`, `gstack-retro`, and `gstack-learn` so the
   project improves after the task ends.
8. Record learning closeout target: worklog, `CODING_RULES.md`, ADR, tests,
   docs/release notes, or source catalog.

## Anti-Patterns

- Do not clone gstack's specialist skills into Mansu just to rename them.
- Do not run Oh My parallel modes when slices have sequential dependencies.
- Do not use `gstack-qa` to bypass root-cause-first debugging.
- Do not claim strict mode if real gates were skipped.
- Do not let the source catalog override explicit project `CODING_RULES.md`
  commands or safety boundaries.
- Do not trust this catalog blindly when a source skill was recently updated;
  read the original skill.
