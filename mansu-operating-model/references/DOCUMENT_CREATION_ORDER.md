# Mansu Document Creation Router

This reference explains which planning documents to create, in what order, which
source skills should produce them, and which source skills should verify them.

For design work, Open Design is a callable design-artifact source route when it
is installed or explicitly approved for setup. Mansu runs the needed CLI
commands and records the artifact evidence; the user should not have to copy
commands manually.

For `DESIGN.md`, VoltAgent/awesome-design-md is a reference-only source. It helps
shape the document; it is not an executable producer skill.

It does not force every project to create every document. The right document set
depends on risk, ambiguity, UI surface, architecture weight, and whether the work
is a new project, a feature, a bug, or a release.

This reference owns document lifecycle and artifact handoff. It does not own the
coding phase loop, Build/Plan execution handoff, or source-skill pairing rules;
use `CODE_CONSTRUCTION_ORDER.md` and `SOURCE_SKILL_COMPOSITION.md` for those.
Phase `SKILL.md` files own immediate action rules and should point here only
when durable document routing, verification order, or handoff detail is needed.

## Core Rule

Use documents to reduce ambiguity before code, not to create ceremony.

For non-trivial work, Mansu should know:

- which artifact is the current source of truth
- which skill produced it
- which independent role or skill verified it
- which document comes next
- what must be updated when reality changes

If a project already has a naming convention, follow that convention. If not,
prefer the source skill's native convention before inventing a new filename.

## Locator Reference Map

Use this reference when a document location is unclear.

Before creating or using a planning document, search the known locations below,
then choose the project convention if one is already established. If nothing
current exists, the suggested fallback path gives Mansu a consistent place to
start.

| Artifact | Search first | Suggested fallback when missing |
| --- | --- | --- |
| Agent router | `AGENTS.md`, `CLAUDE.md`, `.agents/` docs | `AGENTS.md` |
| Local coding rules | `CODING_RULES.md`, `CLAUDE.md`, `CONTRIBUTING.md` | `CODING_RULES.md` |
| Idea one-pager | `docs/ideas/*.md`, `.codex/plans/*.md` | `docs/ideas/{idea-slug}.md` |
| gstack design doc | `docs/designs/*.md`, `~/.gstack/projects/{slug}/*-design-*.md` | `docs/designs/{feature-slug}.md` when repo-visible |
| Research notes | `docs/research/*.md`, `.codex/plans/*.md` | `docs/research/{topic-slug}.md` |
| Spec | `docs/specs/*.md`, `docs/designs/*.md`, `.codex/plans/*.md` | `docs/specs/{feature-slug}.md` |
| Project design / TDR | `docs/technical/*.md`, `docs/designs/*.md`, `docs/specs/*.md` | `docs/technical/{feature-slug}.md` |
| UI design | `DESIGN.md`, `docs/design/*.md`, `docs/designs/*.md` | `DESIGN.md` for project-wide design or `docs/design/{feature-slug}.md` for feature UI |
| ADR | `docs/decisions/*.md`, `docs/adr/*.md`, `adr/*.md` | `docs/decisions/ADR-001-{decision-slug}.md` |
| Active implementation plan | `PLAN.md`, `Plan.md`, `.codex/plans/*.md` | `PLAN.md` |
| Archived implementation plan | `docs/plans/*.md`, `.codex/plans/*.md` | `docs/plans/{YYYY-MM-DD}-{feature-slug}.md` |
| Worklog | `개발일지.md`, `WORKLOG.md`, `docs/worklog/*.md` | `개발일지.md` if Korean project, otherwise `WORKLOG.md` |
| Verification report | `docs/reports/*.md`, `docs/qa/*.md`, `PLAN.md` closeout | `docs/reports/{YYYY-MM-DD}-{feature-slug}-verification.md` |
| Release docs | `CHANGELOG.md`, `README.md`, `docs/releases/*.md` | `CHANGELOG.md` plus `docs/releases/{version-or-date}.md` when needed |

If a source skill writes to a local-only location such as `~/.gstack/projects/`,
that is acceptable for exploration. Before implementation depends on it, prefer
promoting it into the repo or writing a repo-visible handoff that links the local
artifact path and summarizes the decisions.

Handoffs should name the exact path of the next artifact when the path is known.
If the path is not known yet, record the search locations checked and the
suggested fallback path. "Follow project convention" by itself is not enough for
future agents to resume smoothly.

Generated plans under `.omo/` or other runtime work directories may be useful
task evidence, but they are not canonical doctrine. Promote durable decisions
into the owned project artifact, such as a spec, TDR, ADR, worklog, release doc,
or active `PLAN.md`, before treating them as handoff truth.

`.omo/*` is generated planning/evidence state, not a normal runtime source of
truth and not public documentation. When a giant temporary plan is finished,
archive it in place unless the user explicitly approves deletion, and move only
the durable decisions into the canonical owner named by the document ownership
map. `.omo/plans/*.md` remains allowed as an explicit active plan location when
the user or runtime names that concrete plan path.

## Default Document Flow

Recommended order for a new or major project:

1. Operating docs: `AGENTS.md` and `CODING_RULES.md`
2. Idea one-pager or problem design
3. Reference research
4. Spec
5. Project design / TDR / architecture layer
6. UI/UX design document, when UI exists
7. ADRs for expensive or durable decisions
8. Phase-level `PLAN.md`
9. Slice checkpoints and worklog
10. Verification report, release notes, and learnings

Existing projects can enter the flow at the first missing or stale document.
Bug fixes usually enter through root-cause notes, regression tests, `PLAN.md`,
and worklog rather than the full design flow.

For a new project or major feature family, use `mansu-1define` and then
`mansu-2plan` as the public orchestrators over this document flow. The
unnumbered `mansu-define` and `mansu-plan` names are backing implementations
only. `mansu-project-start` remains a compatibility alias for that kickoff path.
The planning route should create only the needed artifacts, then hand off to
`mansu-3build`, whose backing implementation `mansu-build` uses
`mansu-tdd-total` as its phase-level build engine.

Large-grain feature order is decided before `PLAN.md`. For example, a web app may
need a roadmap that orders menu structure, data model/API contracts, login,
board, admin, UI system, deployment, and verification. That order belongs in the
spec/TDR/design layer. `PLAN.md` is created from that roadmap for the active
phase only. If no roadmap artifact names the ordered phase list and exactly one
active phase, do not enter numbered public `mansu-3build` or the backing
`mansu-build` / `mansu-tdd-total` path; return to `mansu-1define` /
`mansu-2plan`.

## Document Matrix

| Artifact | Use when | Create with | Verify with | Exit criteria |
| --- | --- | --- | --- | --- |
| `AGENTS.md` | A repo needs an agent router | `mansu-operating-model` templates | `mansu-operating-model`, local review | Routes to doctrine, local rules, and strict gates without duplicating everything |
| `CODING_RULES.md` | A repo needs runnable local rules | `mansu-operating-model` templates, `mansu-setup` checks | `gstack-health`, local commands, `mansu-operating-model` | Commands, runtimes, dangerous surfaces, validation, and ship criteria are concrete |
| Idea one-pager | The idea is still raw or too broad | addyosmani `idea-refine`, Oh My `planner` | `gstack-office-hours`, Oh My `ralplan` | User, problem, MVP, assumptions, not-doing list, and open questions are explicit |
| gstack design doc | The problem or wedge needs shaping | `gstack-office-hours` | `gstack-plan-ceo-review`, `gstack-autoplan` when plan exists | Problem, status quo, target user, constraints, approaches, recommended direction, and success criteria exist |
| Research notes | Tech, market, reference, or library choice depends on outside facts | Oh My `research` / `deepsearch`, addyosmani `source-driven-development` | `gstack-plan-eng-review`, `gstack-plan-design-review`, `gstack-plan-devex-review` depending on domain | Sources are named, freshness is checked, tradeoffs are compared, and recommendations are actionable |
| Spec | Requirements are ambiguous or the work crosses modules | addyosmani `spec-driven-development` | `gstack-autoplan`, focused `gstack-plan-*` review | Objective, stack, commands, project structure, code style, testing strategy, boundaries, success criteria, and open questions are written |
| Project design / TDR layer | Architecture, data, API, UI system, or phase order matters | `gstack-office-hours`, Oh My `planner`, addyosmani `spec-driven-development`, `api-and-interface-design` | `gstack-autoplan`, then focused `gstack-plan-ceo-review`, `gstack-plan-design-review`, `gstack-plan-eng-review`, `gstack-plan-devex-review` | Product shape, feature groups, domain model, architecture, data/API boundaries, tech stack, secret handling, UI direction, build strategy, roadmap, risks, and non-goals are clear |
| Design brief / visual research note | UI direction is unclear because market, taste, competitors, positioning, or current visual patterns are unknown | Oh My `research` / `deepsearch`, addyosmani `source-driven-development`, Threads/Reddit/GitHub/product references | `gstack-plan-design-review` or `gstack-plan-ceo-review` when taste/product direction is risky | References inspected, selected direction, rejected directions, taste/positioning lessons, and source evidence are clear enough to choose a design route |
| `DESIGN.md` or UI design doc | User-facing UI, visual system, or interaction model matters | Prefer Open Design when installed/approved for artifact generation; reference with VoltAgent/awesome-design-md; create/refine with `gstack-design-consultation`, `gstack-design-shotgun`, `gstack-plan-design-review`, addyosmani `frontend-ui-engineering` | `gstack-plan-design-review`, `gstack-design-review`, `gstack-browse`, `gstack-qa-only` | Visual atmosphere, color roles, typography, component rules, layout, depth/elevation, do/don't guardrails, responsive behavior, accessibility, agent prompt handoff, reference rationale, selected/rejected directions, and Open Design artifact/preview/export evidence are locked enough to implement |
| ADR | A decision will be expensive to reverse | addyosmani `documentation-and-adrs` | `gstack-plan-eng-review`, `gstack-cso` for security decisions, `gstack-benchmark` for performance decisions | Context, decision, alternatives, consequences, and status are recorded in `docs/decisions/` or the repo's ADR convention |
| `PLAN.md` | A current phase needs execution-ready slices | addyosmani `planning-and-task-breakdown`, numbered `mansu-2plan`, backing `mansu-build` / `mansu-tdd-total` under numbered `mansu-3build`, `CODE_CONSTRUCTION_ORDER.md` | `gstack-autoplan`, `gstack-plan-eng-review`, Metis/Momus-style critics, source-specific reviewers | Current phase goal, ordered vertical slices, acceptance criteria, impact files, validation, risks, mode decisions, and checkpoint rules are present |
| Slice checkpoint | A slice finishes or pauses | `mansu-tdd-lite`, `mansu-tdd-strict`, checkpoint-equivalent source skill | review gate, QA gate, validation commands | Done, remaining risk, next starting point, commit/no-commit status, and updated `PLAN.md` are recorded |
| Worklog / `개발일지.md` | Work has happened and should compound | `gstack-retro`, `gstack-learn`, Mansu checkpoint closeout | self-review against `PLAN.md`, source freshness notes | Historical decisions and actual flow are recorded without keeping completed detail active in `PLAN.md` |

For user-facing UI, choose the design source route before phase roadmap planning.
Do not let Mansu replace Open Design, VoltAgent/awesome-design-md, gstack design
skills, Oh My research, or addyosmani source-driven/frontend skills with a
Mansu-owned design questionnaire. If no design route is selected, block
implementation handoff and return to public `mansu-1define` or the
`mansu-project-start` compatibility alias.
| Verification report | Runtime behavior or user flow is claimed | `mansu-web-verify`, `gstack-browse`, `gstack-qa-only`, `gstack-benchmark`, `gstack-cso` | rerun relevant checks, screenshots, logs, security/perf evidence | What was tested, what passed, what failed, what was not tested, and remaining risk are explicit |
| Release docs | Work is ready to ship or has shipped | `gstack-document-release`, addyosmani `documentation-and-adrs`, `shipping-and-launch` | `gstack-health`, `gstack-review`, `gstack-ship`, `gstack-canary` when deployed | README, changelog, architecture notes, release risk, and rollback/next steps match reality |

## Verification Order

Document verification should follow the document's risk:

1. Product or scope risk: `gstack-plan-ceo-review`
2. UI/UX risk: `gstack-plan-design-review`, then rendered `gstack-design-review`
3. Architecture or data risk: `gstack-plan-eng-review`
4. Developer-facing risk: `gstack-plan-devex-review`
5. Security risk: `gstack-cso`
6. Performance risk: `gstack-benchmark`
7. Runtime/user-flow risk: `gstack-browse`, `gstack-qa-only`, or `mansu-web-verify`
8. Ship risk: `gstack-health`, `gstack-review`, `gstack-ship`, `gstack-canary`

Use `gstack-autoplan` when the document needs CEO, design, engineering, and DX
review as a single gauntlet.

Use Oh My `ralplan` or Mansu's Planner / Critic / Synthesizer roles when the
document needs iterative critique before it becomes execution-ready.

## How Documents Hand Off

Each document should end with a handoff section:

```markdown
## Handoff

- Source skills used:
- Verification skills used:
- Visual research used:
- Selected direction / rejected directions:
- Open Design artifact / preview / export:
- Decisions locked:
- Open questions:
- Next artifact:
- Do not implement until:
```

`Do not implement until` should list unresolved blockers, not create a mandatory
human approval gate. Mansu continues automatically once the plan is
execution-ready unless the user requested approval, the action is risky, or a
blocker remains unresolved.

## PLAN.md Boundary

`PLAN.md` is the active phase execution document, not the whole project memory.
It is not canonical Mansu doctrine, and generated `.omo` plans are not canonical
doctrine either. `.omo/plans/*.md` can be the active phase execution document
only when selected as a concrete plan path; otherwise `.omo` stays generated
archive/evidence state.

Use the project roadmap or TDR for the whole feature sequence. Use `PLAN.md` for
the phase currently being executed.

Before numbered public `mansu-3build` starts through the backing
`mansu-build` / `mansu-tdd-total` path, `PLAN.md` must name the active phase and
link to the roadmap or phase-order artifact it was derived from.

Put into `PLAN.md`:

- current phase goal
- active slice table
- current validation path
- current risks and blockers
- role/critic status
- checkpoint and next starting point

Do not keep fully completed history expanded in `PLAN.md`. Move completed flow,
decisions, and lessons into the worklog, release docs, ADRs, or design/spec docs.

Example:

- `docs/specs/app.md`: product requirements and feature groups.
- `docs/technical/app-tdr.md`: architecture, stack, data/API boundaries, and
  phase order such as login -> board -> admin -> deployment.
- `DESIGN.md`: navigation, screens, states, and visual direction.
- `PLAN.md`: current phase only, such as login slices.

## When To Skip Documents

Skip or compress a document when:

- the task is Quick and the acceptance criteria are obvious
- a stronger existing document is current and already covers the need
- the document would only restate code or another document
- a bug fix only needs reproduction, root cause, regression proof, and closeout

Do not skip because the agent is impatient. Skipping must be justified by task
class and risk.

## Red Flags

- `PLAN.md` tries to be the idea doc, spec, TDR, ADR, worklog, and release note.
- Implementation starts while the current source of truth is unclear.
- A TDR-like decision has no alternatives or consequences.
- UI implementation starts without UI state, responsive, and accessibility notes.
- Design artifact work manually reimplements Open Design when Open Design is
  installed or approved for setup.
- `DESIGN.md` only says "modern/minimal" without tokens, component states,
  responsive behavior, depth/elevation, or do/don't guardrails.
- External research has no source freshness or citation trail.
- ADRs are written after the decision is forgotten instead of when the tradeoff is live.
- Verification is claimed but no verification skill, command, screenshot, or test evidence is named.

## Exit Criteria

Before implementation starts on non-trivial work:

- the current source-of-truth document is named
- the source skills used to create it are named
- the verification skills or roles are named
- open blockers are either resolved or explicitly blocking
- the next artifact is `PLAN.md` with ordered slices, or a documented reason why no slice plan is needed
