# Mansu Source Skill Catalog

This catalog records the source skills Mansu should know before inventing a new
workflow.

Mansu does not compete with strong specialist skills. Mansu classifies the work,
sets the discipline, and routes to the right source skill at the right moment.

Last local snapshot: 2026-05-16.

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

- Use addyosmani/agent-skills as the broad SDLC phase spine: idea/spec,
  planning, context, source-driven coding, incremental implementation, testing,
  review, simplification, hardening, docs, and launch.
- Use Ouroboros inside the early definition/spec phases when an idea must become
  a durable purpose, Seed/Ledger, project definition, or source-of-truth artifact
  before Mansu turns it into phases and slices.
- Use VoltAgent/awesome-design-md as the design reference family for `DESIGN.md`
  shape, visual atmosphere, tokens, component rules, responsive behavior, and
  agent prompt handoff.
- Use Open Design (`nexu-io/open-design`) as the callable agent-native design
  workflow route when it is installed or explicitly approved for setup. Mansu
  should route design artifact generation to Open Design instead of recreating
  its workflow.
- Use Oh My / OMO / OMC as execution-mode language inside a phase. For Codex,
  LazyCodex is the preferred thin distribution route for OmO when verified and
  healthy; OmO / oh-my-openagent remains the core harness source for discipline
  agents, parallel orchestration, model routing, skills, and hooks.
- Use gstack as the specialist team: CEO, design, engineering, DX, browser QA,
  security, performance, ship, deploy, and learning gates.
- Compose creatively only after the basic gates are explicit: intent, scope,
  research source, architecture, slice boundary, validation, review, QA,
  checkpoint, and learning.
- Prefer the original source skill when it is stronger. Mansu's job is to choose,
  sequence, and hold accountability.

## Freshness Policy

Mansu must keep watching the upstream source families that shape this suite:

- gstack specialist skills
- Ouroboros project-definition, Seed, Ledger, and runtime setup flows
- VoltAgent/awesome-design-md `DESIGN.md` reference collection
- Open Design agent-native design workflow and artifact generation route
- Oh My / OMO / OMC style execution-mode skills
- addyosmani/agent-skills production engineering workflow skills

Whenever source freshness is uncertain, run `mansu-setup source-check` first.
This is read-only: it checks the source ecosystem and reports whether changes
are needed, but it does not install, update, sync, or edit files.

Use `Check -> Decide -> Mutate`:

1. Check with `mansu-setup source-check`.
2. Decide whether the drift affects Mansu routing, gates, artifacts, validators,
   manual guidance, or worklogs.
3. Mutate only after explicit approval: use `mansu-setup update` for source
   tool updates, or `mansu-source-curator curate` for Mansu reference updates.

During the read-only source freshness check:

1. Check whether the installed Ouroboros CLI/package, setup status, or project-definition artifacts changed.
2. Check whether the installed gstack repo or `gstack-*` skill set changed.
3. Check whether the installed VoltAgent/awesome-design-md reference snapshot changed when UI/design work is in scope.
4. Check whether Open Design is installed or available, and whether its skills,
   design systems, visual directions, CLI lifecycle, or artifact/export contract
   changed.
5. Check whether the installed Oh My / OMO / OMC adapter or source skill set changed.
6. Check whether `addyosmani/agent-skills` changed when it is installed or referenced.
7. Compare notable added, removed, or renamed skills against this catalog.
8. If source skills changed in a way that affects routing, read the original
   `SKILL.md` and update this catalog before relying on stale assumptions.
9. Record the source freshness result in the final report and worklog.

Missing source tooling is not automatically fatal. Report what was unavailable,
continue with the safe Mansu path, and block only when the requested workflow
depends on the missing source.

## Layer Model

| Layer | Owns | Does not own |
| --- | --- | --- |
| Lifecycle phase spine | broad SDLC phases: define, plan, build, verify, review, harden, document, ship | Mansu-specific strictness, project-local routing, runtime adapters |
| Project definition / memory source | durable project purpose, Seed/Ledger/spec artifacts, long-horizon direction, continuity | Mansu-specific gate ownership, source selection, final accountability |
| Design workflow source | callable design artifact workflow, Turn-1 discovery, visual direction selection, preview/export loop | Mansu-specific routing, final product decision, post-artifact verification |
| Design reference source | reusable `DESIGN.md` structures, brand/taste references, design token grammar, agent prompt handoff | project-specific product decisions, final UI approval, rendered QA |
| Mansu | doctrine, classification, strictness, routing, evidence, checkpoint, worklog, final ship judgment | specialist craft implementation when a stronger source skill exists |
| Ouroboros | project-definition interview, PM/Seed/Ledger artifacts, early acceptance criteria, spec source of truth | Mansu-specific routing, source comparison, role critique, slice gates, final implementation discipline |
| gstack | role-based specialist gates, browser QA, design exploration, security, performance, ship/ops, learning | Mansu-specific doctrine or personal operating rules |
| Oh My / OMO / OMC | execution modes, parallel work patterns, persistence, TDD/debug/research habits, lightweight orchestration language; for Codex, LazyCodex / OMO Codex plugin is the highest-priority route when installed and healthy | Mansu keeps routing/evidence/final judgment; Ouroboros keeps early definition; gstack keeps independent validation; design sources keep design artifacts and references |
| addyosmani/agent-skills | senior-engineering SDLC sequence and phase skills across define, plan, build, verify, review, and ship | Mansu-specific strictness, project-local routing, runtime adapters |
| Implementation actor | file edits, tests, integration, commits, concrete code changes | replacing Mansu's planning/routing/evidence responsibility |

Representative mapping:

- Lifecycle phase spine: addyosmani/agent-skills or source-curator-verified substitute.
- Project definition / memory source: Ouroboros or source-curator-verified substitute.
- Design reference source: VoltAgent/awesome-design-md or source-curator-verified substitute.
- Design workflow source: Open Design or source-curator-verified substitute.
- Execution-mode source: Oh My / OMO / OMC or source-curator-verified substitute; prefer LazyCodex / OMO Codex plugin inside this family for Codex runtimes when available.
- Specialist team source: gstack or source-curator-verified substitute.
- Implementation actor: Codex or the active coding agent.

## Source Philosophy Checksums

Before Mansu composes source skills, preserve each family in its native role:

- addyosmani/agent-skills: phase map and engineering discipline; do not turn it
  into a fixed universal script when the current task needs a smaller route.
- Ouroboros: definition, Seed/Ledger, and continuity; do not reduce it to a
  generic planning prompt or let it execute autonomously unless the user asked.
- VoltAgent/awesome-design-md: `DESIGN.md` reference grammar and taste library;
  do not copy a brand blindly or treat a reference file as the product's final
  visual identity.
- Open Design: design artifact workflow; do not clone its prompt stack into
  Mansu. When it is installed or approved, let Open Design run the design
  artifact loop and let Mansu handle route choice, input framing, handoff, and
  verification.
- Oh My / OMO / OMC: execution mode and persistence language; for Codex,
  prefer LazyCodex / OMO Codex plugin over legacy `omx` when installed and
  healthy, but do not use parallelism when slices have sequential dependencies
  or shared write scope.
- gstack: independent specialist gates; do not treat builder self-review as a
  substitute for review, QA, security, performance, or ship gates.
- Codex / active agent: implementation actor; do not let implementation replace
  Mansu's route decision, evidence, or final ship/hold judgment.

## Ouroboros Capability Map

Use Ouroboros before implementation when the raw idea still needs to become a
project definition that Mansu can critique and slice.

| Capability | Source route | Route when |
| --- | --- | --- |
| Setup/help | `setup`, `welcome`, `help`, `update` | Ouroboros readiness, runtime setup, or version is unclear |
| Brownfield scan | `brownfield` | an existing repo should answer factual/codebase questions before the user is asked |
| Project interview | `ouroboros init start` / `ouroboros-interview` | purpose, user, constraints, and acceptance criteria are still fuzzy |
| PM / PRD definition | `pm` | product requirements or PM-style project definition is the needed artifact |
| Seed / source-of-truth creation | `seed` or `auto --skip-run` | the project needs a durable definition before spec/TDR/PLAN |
| Ledger / session continuity | Ouroboros Ledger/session artifacts | decisions and unanswered questions must survive across sessions |
| Runtime integration | `ouroboros setup --runtime <target>` | Mansu-setup prepares the host before project-start uses Ouroboros |
| Execution from Seed | `run` | user explicitly wants Ouroboros to execute a Seed after Mansu has mapped gates/risks into PLAN |
| Execution verdict | `evaluate`, `qa` | an Ouroboros execution or artifact needs independent quality evidence |
| Stuck recovery | `unstuck` | the project is looping, blocked, or needs lateral alternatives |
| Session resume/status | `status`, `resume-session`, `cancel` | an existing Ouroboros session must be inspected, resumed, or stopped |
| Autonomous continuation | `evolve`, `ralph`, non-`--skip-run` `auto` | only when the user explicitly wants Ouroboros to continue beyond definition; otherwise Mansu translates the output into phases and slices first |
| Team publishing | `publish` | a Seed should become GitHub Issues after Mansu confirms boundaries |

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

## VoltAgent/awesome-design-md Capability Map

Use VoltAgent/awesome-design-md as a design reference family, not as a runtime
skill. It gives Mansu a strong `DESIGN.md` grammar for UI work before gstack
design exploration or implementation starts.

Inspect multiple reference `DESIGN.md` files, extract transferable principles,
and record the source date/commit. Do not copy a public brand identity blindly.
The output should become the project's own `DESIGN.md` or UI design artifact.

| Capability | Reference shape | Route when |
| --- | --- | --- |
| `DESIGN.md` format | project-readable design source of truth for agents | a UI project needs a durable design artifact before implementation |
| Visual Theme & Atmosphere | mood, density, product feel, design philosophy | the UI has no visual north star or feels generic |
| Color Palette & Roles | semantic color names, hex values, functional usage | colors are arbitrary or not tied to product meaning |
| Typography Rules | font families, hierarchy table, weights, line height, letter spacing | type hierarchy is weak or default-looking |
| Component Stylings | buttons, cards, inputs, navigation, states | UI components need consistent shape and interaction states |
| Layout Principles | spacing scale, grid, whitespace philosophy | pages feel inconsistent, cramped, or boilerplate |
| Depth & Elevation | shadow system, surface hierarchy, borders | cards/surfaces feel flat, noisy, or AI-generated |
| Do's and Don'ts | guardrails, anti-patterns, brand boundaries | preventing visual drift or AI slop matters |
| Responsive Behavior | breakpoints, touch targets, collapsing strategy | mobile/tablet behavior matters |
| Agent Prompt Guide | quick tokens and implementation prompts | handoff to coding/design agents needs specificity |

## Open Design Capability Map

Use Open Design (`nexu-io/open-design`) as a callable design-artifact source
route when it is installed or explicitly approved for setup. Mansu should not
recreate Open Design's workflow. Mansu should prepare context, choose the route,
let Open Design run its CLI/daemon workflow, then connect the output to
`DESIGN.md`, design docs, `PLAN.md`, and verification gates.

Open Design is a callable design-artifact source route.
Open Design provides artifact-first rendering before implementation handoff.

Open Design is different from VoltAgent/awesome-design-md:

- Open Design owns the design workflow and artifact loop.
- VoltAgent/awesome-design-md owns `DESIGN.md` reference systems and schema.
- gstack owns independent design critique, browser evidence, and visual QA.
- Mansu owns source choice, CLI execution approval, handoff, and final evidence.

During `mansu-project-start`, user-facing UI must pass through a design route
selection before phase roadmap planning. Mansu should not substitute its own
design questionnaire for these routes. Use design/taste research when direction
is unclear, Open Design when artifact generation is needed and available,
VoltAgent/awesome-design-md for `DESIGN.md` structure, and gstack design skills
for exploration and critique.

Default design route stack:

1. For a greenfield UI with no design system or `DESIGN.md`, use
   `gstack-design-consultation` as the default design-system route. It
   understands the product, researches the landscape when needed, proposes the
   design system, and creates `DESIGN.md`.
2. When taste, market position, competitors, or live product references are
   genuinely unclear, use Oh My / OMO `research` or `deepsearch` before or
   inside the consultation.
3. Use addyosmani `source-driven-development` when source projects, official UI
   examples, implementation patterns, or reusable frontend architecture should
   shape the design direction.
4. Use `gstack-design-shotgun` when multiple visible candidate directions should
   be compared before choosing.
5. Use `gstack-plan-design-review` to critique the chosen direction before
   roadmap lock.
6. Use Open Design for visible artifacts/prototypes when needed and
   installed/approved.
7. Use VoltAgent/awesome-design-md as the `DESIGN.md` reference grammar for a
   durable UI system.

Recommended combinations:

- Greenfield app with no design system: `gstack-design-consultation` ->
  `gstack-plan-design-review` -> phase roadmap.
- Ambiguous market/taste: Oh My / OMO `research` or `deepsearch` ->
  addyosmani `source-driven-development` when source examples matter ->
  `gstack-design-consultation` -> `gstack-plan-design-review`.
- Need visible options before choosing: `gstack-design-shotgun` ->
  `gstack-design-consultation` -> `gstack-plan-design-review`.
- Need prototype/artifact before implementation: Open Design ->
  `gstack-plan-design-review` -> `DESIGN.md` or design doc handoff.
- Existing UI or existing plan: `gstack-plan-design-review` first; after
  implementation, use `gstack-design-review`, `gstack-browse`, or
  `gstack-qa-only`.

| Capability | Source shape | Route when |
| --- | --- | --- |
| Install / lifecycle | `git clone`, package install, `pnpm tools-dev` or current Open Design lifecycle command | Open Design is missing and the user approved Mansu to install or update it |
| Agent detection | local daemon detects existing coding-agent CLIs | design should use the user's installed agent instead of a bundled model |
| Turn-1 discovery | interactive question form before pixels | brief, audience, tone, brand context, or scale is still ambiguous |
| Visual direction picker | curated visual schools with deterministic palette/font choices | no brand guide exists or the UI direction is too vague |
| Design systems | `DESIGN.md` systems and product-system library | artifact should follow a concrete design system rather than freestyle styling |
| Artifact-first loop | generated artifact rendered in sandboxed preview | user needs visible prototype/deck/mobile/dashboard evidence before implementation |
| Built-in skills | prototype/deck/design/marketing/work-product skills | Open Design has a closer skill than Mansu/gstack for the requested artifact |
| Anti-AI-slop gate | five-dimensional critique and P0/P1/P2 checklists | design output must pass taste, hierarchy, specificity, restraint, and execution gates |
| Export handoff | HTML/PDF/PPTX/ZIP/Markdown or current supported exports | artifact needs to become a shareable design handoff or implementation input |

## Oh My / OMO / OMC Capability Map

Use Oh My-style skills as execution-mode vocabulary and lightweight workflow
patterns. Names may differ by runtime target; verify the installed skill path
with `mansu-setup`.

For Codex runtimes, treat LazyCodex / OMO Codex plugin (`omo@sisyphuslabs`,
plugin name `omo`) as the highest-priority execution transport inside the Oh
My / OMO / OMC family when it is installed, enabled, and its hooks/MCP
entrypoints are healthy. OmO / oh-my-openagent is the core harness source;
LazyCodex is the Codex-facing thin distribution. Legacy `omx` remains a
fallback compatibility route. In this source-family split, LazyCodex / OMO
drives Codex execution; Mansu owns routing, evidence, checkpoints, and final
ship/hold judgment; Ouroboros shapes early goals, Seed, Ledger, and long-horizon
direction, with Ouroboros execution opt-in only; gstack provides independent
review, QA, design critique, security, performance, ship, and learning gates;
Open Design creates design artifacts; VoltAgent/awesome-design-md provides
`DESIGN.md` reference grammar.

| Capability | Source skills | Route when |
| --- | --- | --- |
| Codex OMO execution backbone | LazyCodex / OMO Codex plugin: `ultrawork`, `ultragoal`, `rules`, `lsp`, `comment-checker`, `ai-slop-remover`, `programming`, `debugging`, `frontend-ui-ux`, `refactor`, `review-work` | Codex runtime has `omo@sisyphuslabs` installed and enabled; use before legacy `omx` for Oh My execution modes |
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

Use addyosmani-style skills as the broad development lifecycle and coding-order
reference. The phase spine is Define -> Plan -> Build -> Verify -> Review ->
Ship, but Mansu still chooses the smallest safe route for the current work.

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
   This must satisfy the Zero-to-PLAN minimum gate: purpose, user/problem,
   evidence, assumptions, direction, order, and execution bridge.
2. Use the addyosmani lifecycle as the phase map: define/spec first, then plan,
   build, verify, review, and ship only when the previous phase has enough
   evidence.
3. If the project is new or still fuzzy, check `ooo` / `ouroboros` before
   Mansu drafts its own project questions. When available, use Ouroboros
   init/interview/PM/Seed/Ledger route first to create upstream definition artifacts.
   If skipped, record the explicit skipped reason and label any Mansu-only
   kickoff as fallback.
4. Research references using evidence-ranked sources: official/current docs and
   source files first for technical truth; GitHub, Reddit, and Threads for
   adoption, pain, taste, and implementation signals with dates recorded.
5. Analyze relevant projects at code and architecture level when they influence
   stack, domain model, UI, or delivery sequence.
6. Create the needed documents through `DOCUMENT_CREATION_ORDER.md`: operating
   docs, idea/spec, research notes, TDR/architecture, UI design, ADRs, a
   repo-visible phase roadmap, then the active phase-level `PLAN.md`.
   Expand only when risk or ambiguity asks for it; otherwise leave a small,
   repo-visible artifact and record why larger documents were skipped.
7. Verify with `gstack-autoplan` and focused `gstack-plan-*` reviewers.
8. Hand off to `mansu-tdd-total` only after the roadmap artifact, ordered phase
   list, exactly one active phase, current phase ordered slices, gate mapping,
   validation path, upstream artifacts, and open blockers are recorded.

### Source Refresh And Reference Curation

Use `mansu-source-curator` when the issue is not feature delivery, but keeping
Mansu's knowledge of Ouroboros, gstack, Oh My / OMO / OMC,
addyosmani/agent-skills, VoltAgent/awesome-design-md, Open Design, or runtime adapters current.

This is an internal maintenance route:

1. Start with `mansu-setup source-check` for runtime, adapter, and source-family status.
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

1. Start from the addyosmani lifecycle phase map. Use `idea-refine` and
   `spec-driven-development` to decide whether the work is still in Define, is
   ready for Plan, or needs more source context before Build.
2. Use Ouroboros `init start` / `interview`, `pm`, `seed`, or `brownfield` when the early
   definition phase needs durable purpose, Seed/Ledger continuity, or existing
   repo understanding.
3. Shape product intent with `gstack-office-hours` when demand, wedge, MVP, or
   scope needs founder-style pressure testing.
4. Run source-aware research with Oh My `research` / `deepsearch` patterns and
   addyosmani `source-driven-development`; include GitHub, Reddit, Threads, and
   official docs when freshness matters.
5. Draft or update the design/spec/blueprint layer: product shape, feature groups, domain model,
   architecture, data/API boundaries, technology stack, secret/API-key handling,
   UI/UX direction, build strategy, phase roadmap, risks, and non-goals.
6. Review that layer with `gstack-autoplan` so CEO, design, engineering, and
   DX perspectives all pass over it.
7. Deepen weak areas with focused `gstack-plan-ceo-review`,
   `gstack-plan-design-review`, `gstack-plan-eng-review`, or
   `gstack-plan-devex-review`.
8. Record major irreversible or architectural choices as ADR-style notes when
   `documentation-and-adrs` applies.
9. Only then derive the current phase's `PLAN.md` and vertical slice table.
   If no phase roadmap exists, stop before `mansu-tdd-total` and return to
   `mansu-project-start`.

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
2. If source/tool readiness is unclear, run `mansu-setup source-check` before
   choosing Open Design, VoltAgent/awesome-design-md, or gstack design routes.
3. If the UI belongs to an existing repo or page, gather brownfield/context
   facts first with Ouroboros `brownfield` or addyosmani `context-engineering`.
4. When the design 고민 is about market, taste, competitors, positioning, or
   current UI patterns, run reference/taste research with Oh My `research` /
   `deepsearch` and addyosmani `source-driven-development` before artifact
   generation.
5. If Open Design is installed or the user approved setup, prefer routing design
   artifact generation to Open Design instead of recreating its workflow inside
   Mansu. Mansu runs the needed CLI commands, records the Open Design skill,
   design system, preview/export path, and keeps the result as evidence.
6. If the project has no current design source, inspect VoltAgent/awesome-design-md
   references and create or update `DESIGN.md` with visual atmosphere, color
   roles, typography, component rules, layout, elevation, do/don't guardrails,
   responsive behavior, and agent prompt handoff.
7. Use `gstack-plan-design-review` before implementation.
8. Use `gstack-design-consultation` or `gstack-design-shotgun` when Open Design
   is unavailable, when visual alternatives are needed, or when Mansu needs
   independent critique outside the Open Design artifact loop.
9. Use addyosmani `frontend-ui-engineering` and `planning-and-task-breakdown`
   to turn the approved design direction into implementation-ready phase/slice
   work.
10. Use `gstack-design-html` only after a direction is approved or stable and
   Open Design has not already produced an implementation-ready artifact.
11. Use `gstack-design-review`, `gstack-browse`, and `gstack-qa-only` for rendered
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
