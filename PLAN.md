## Mansu Phase Skill Consolidation Plan

Mansu의 실제 개발 생애주기는 addyosmani/agent-skills의 큰 흐름을 따른다.

`Define -> Plan -> Build -> Verify -> Review -> Ship`

`mansu-debug` remains a public special-purpose interrupt route, not a normal
lifecycle phase.

사용자가 기억하고 호출해야 하는 public lifecycle route는 이 흐름에 맞춰
번호가 붙은 6개로 줄인다. 다만 실제 public surface는 entry/setup/debug를
포함한다:
`mansu-help`, `mansu-setup`, `mansu-1define`, `mansu-2plan`,
`mansu-3build`, `mansu-4verify`, `mansu-5review`, `mansu-debug`,
`mansu-6ship`.
기존의 세부 스킬은 없애기보다 각 phase skill 안에서 쓰는 내부 route 또는
호환 alias로 정리한다. Mansu의 목적은 스킬을 많이 외우게 하는 것이 아니라,
현재 개발 단계에 맞는 좋은 외부/source skill을 제대로 오케스트레이트하는 것이다.

## Target User-Facing Skills

- `mansu-1define`: 제품 목표, 요구사항, 초기 범위, 성공 기준을 잡는다.
- `mansu-2plan`: 스펙, 아키텍처, 디자인 방향, 구현 순서, phase roadmap을 만든다.
  디자인이 필요한 제품/앱/웹 작업에서는 design source skill route를 반드시 포함한다.
- `mansu-3build`: 구현을 진행한다. TDD slice, source skill 실행, checkpoint를 담당한다.
- `mansu-4verify`: 테스트, 브라우저 검증, QA 증거, 회귀 확인을 담당한다.
- `mansu-5review`: 코드 리뷰, 설계 리뷰, 문제 원인 분석, 수정/개선 loop를 담당한다.
- `mansu-6ship`: 릴리스 gate, 문서, 공유, 배포/보류 판단을 담당한다.
- `mansu-debug`: 원인 모를 실패, 회귀, 런타임 문제를 phase와 별개로 root-cause-first로 처리한다.

Admin/maintenance skill은 별도로 둔다.

- `mansu-help`: 현재 상태를 보고 위 6개 phase 중 다음 route를 안내한다.
- `mansu-setup`: Codex/OpenCode/Claude Code/Hermes runtime에 Mansu와 source skill을 설치/동기화한다.
- `mansu-manual`: 로컬 HTML 매뉴얼을 여는 admin/help surface다. 일반 lifecycle 메뉴에서는 보조로 둔다.
- `mansu-source-curator`: source skill 생태계 변화가 있을 때 Mansu의 내부 지도를 갱신하는 hidden/internal maintenance route다.

## Current Skill Mapping

| Current skill | New role |
| --- | --- |
| `mansu-project-start` | `mansu-1define`의 compatibility alias. backing implementation은 `mansu-define`이다. 실제 시작은 Ouroboros interview/Seed/Ledger를 먼저 사용한다. |
| `mansu-operating-model` | `mansu-2plan`의 내부 reference/runtime model. 직접 호출보다 plan phase가 사용한다. |
| `mansu-tdd-total` | `mansu-3build`의 기본 implementation route. backing implementation은 `mansu-build`이다. 필요하면 lite/strict mode를 내부 선택한다. |
| `mansu-tdd-lite` | `mansu-3build` 내부 fast mode. |
| `mansu-tdd-strict` | `mansu-3build` 내부 strict mode. |
| `mansu-web-verify` | `mansu-4verify`의 브라우저/프론트 검증 route. backing implementation은 `mansu-verify`이다. |
| `mansu-debug-rootcause` | `mansu-debug`의 호환 alias. Review 중 발견된 결함도 원인 불명일 때는 이 route로 점프한다. |
| `mansu-ship-release` | `mansu-6ship`의 호환 alias 또는 내부 release route. backing implementation은 `mansu-ship`이다. |
| `mansu-setting` | `mansu-setup` 호환 alias. 유지하되 새 문서에서는 숨긴다. |

## Plan Phase Internal Order

`mansu-2plan`은 `Design`을 별도 최상위 phase로 분리하지 않는다.
대신 Plan phase 안의 필수 gate로 둔다.

`Feature Priority / MVP Cut -> Project Phase Roadmap -> Phase Plan -> Slice`

- Feature Priority / MVP Cut: Define에서 나온 후보 기능과 우선순위 신호를 MVP/later로 나눈다.
- Project Phase Roadmap: 큰 phase, phase 순서, phase별 exit criteria를 정한다.
- Phase Plan: 현재 phase 하나의 접근, 의존성, 검증 기준을 자세히 잡는다.
- Slice: `mansu-3build`가 실행할 vertical slice와 acceptance criteria, 영향 파일, 검증 명령을 정한다.

## Phase Internal Orders And Source Skill Mapping

각 phase skill은 Mansu가 직접 craft를 수행하는 스킬이 아니다.
Mansu는 phase와 gate를 잡고, 실제 craft는 Ouroboros, addyosmani,
gstack, Open Design, VoltAgent/awesome-design-md, 그리고 필요한 OMO/OMC
execution-mode source skill로 보낸다. LazyCodex는 이 표의 source family가
아니라 Codex-side OMO readiness로만 다룬다.

| Phase | Internal order | Primary source skills |
| --- | --- | --- |
| `mansu-1define` | Idea intake -> Ouroboros interview/PM/Seed/Ledger or brownfield -> Requirements -> Acceptance criteria -> Source-of-truth seed -> design intent seed/handoff when UI or product design matters | Backed by `mansu-define`; Ouroboros `interview`, `pm`, `seed`, `brownfield`; addyosmani `interview-me`, `idea-refine`, `spec-driven-development`; gstack `office-hours`, `plan-ceo-review`, `gstack-design-consultation` as post-Ouroboros design-context source capability |
| `mansu-2plan` | Consume Define handoff -> Requirements/Spec -> Feature Priority/MVP Cut -> Project Phase Roadmap -> active Phase Plan -> Slice table handoff | Backed by `mansu-plan`; addyosmani `spec-driven-development`, `planning-and-task-breakdown`, `api-and-interface-design`, `source-driven-development`; gstack `autoplan`, `plan-ceo-review`, `plan-eng-review`, `plan-devex-review`; explicit OMO `ulw-plan` only when the user literally invokes it; design route below |
| `mansu-2plan` design gate | Design intent seed -> Reference discovery -> `DESIGN.md` creation/refinement -> Design system/artifact -> Variant exploration -> Plan-stage design review -> Implementation handoff | Backed by `mansu-plan`; OMO research/deepsearch when available; Open Design for callable design artifacts; VoltAgent/awesome-design-md for `DESIGN.md` grammar; gstack `design-consultation`, `design-shotgun`, `plan-design-review`, `design-html`; addyosmani `frontend-ui-engineering` |
| `mansu-3build` | Context pack -> Contract/source verification -> Slice plan -> Implement -> Local validation -> Checkpoint | Backed by `mansu-build`; `mansu-tdd-total` as the internal build engine; addyosmani `context-engineering`, `source-driven-development`, `incremental-implementation`, `test-driven-development`, `frontend-ui-engineering`; gstack `guard`, `careful`, `checkpoint` |
| `mansu-4verify` | Test evidence -> Runtime/browser evidence -> QA report -> Security/perf checks when relevant -> Verification closeout | Backed by `mansu-verify`; addyosmani `test-driven-development`, `browser-testing-with-devtools`, `security-and-hardening`, `performance-optimization`; gstack `qa-only`, `qa`, `browse`, `health`, `cso`, `benchmark`; Ouroboros `qa`, `evaluate`; OMO `review-work` QA lane |
| `mansu-5review` | Diff review -> Architecture/design/security critique -> AI-slop/simplification pass -> Root-cause loop for findings -> Re-verify | Backed by `mansu-review`; addyosmani `code-review-and-quality`, `code-simplification`, `debugging-and-error-recovery`, `doubt-driven-development`; gstack `review`, `plan-eng-review`, `plan-design-review`, `design-review`, `investigate`, `cso`; OMO `review-work`, `remove-ai-slops`, `debugging`, `comment-checker` |
| `mansu-6ship` | Release readiness -> Version/changelog/docs -> Commit/push/PR/deploy decision -> Canary/monitoring -> Learning handoff | Backed by `mansu-ship`; addyosmani `git-workflow-and-versioning`, `ci-cd-and-automation`, `documentation-and-adrs`, `shipping-and-launch`; gstack `ship`, `document-release`, `landing-report`, `setup-deploy`, `land-and-deploy`, `canary`, `retro`, `learn`; Ouroboros `publish`, `status` |
| `mansu-debug` | Reproduce -> Observe runtime truth -> Form competing hypotheses -> Isolate root cause -> Lock regression proof -> Minimal fix -> Verify | OMO `debugging`; gstack `investigate`; addyosmani `debugging-and-error-recovery`; Ouroboros `unstuck` only when the investigation is stuck |

## Metis Gaps Addressed

- Public surface is now defined as six lifecycle skills plus `mansu-help`,
  `mansu-setup`, and `mansu-debug`.
- `mansu-manual` remains an admin/help surface; `mansu-source-curator` remains
  hidden/internal maintenance.
- LazyCodex is explicitly excluded from source-skill composition and belongs only
  to Codex-side OMO readiness under `mansu-setup`.
- OMO/OMC can still appear as execution-mode source skills, but LazyCodex adapter
  details must not appear in phase source mapping.
- Old names stay as actual callable compatibility skill folders through the
  first migration. They must be thin wrappers or internal routes, not duplicate
  implementations.
- The migration must keep old aliases working until new phase validators and
  installed-copy comparison pass.
- Phase migration must be Mansu-local. Do not update upstream source repos while
  editing phase routing unless running an explicit `mansu-setup update` or
  approved source-curator refresh.

## Source Skill Composition Implementation

Mansu should not copy full source workflows into every phase skill.
The implementation should split the knowledge into three layers:

1. `SOURCE_SKILL_CATALOG.md` stays the source-family encyclopedia.
   It records what OMC/OMO, Ouroboros, Open Design, VoltAgent/awesome-design-md,
   gstack, and addyosmani are good at.
2. Add `mansu-operating-model/references/SOURCE_SKILL_COMPOSITION.md`.
   This new reference should record the "similar but different" comparisons and
   the recommended combinations below.
3. Each user-facing `mansu-*` skill keeps only the short phase-specific routing
   rules and links to the exact composition section it needs.

The composition reference should include these comparison groups:

| Similar skills | Difference | Mansu routing rule |
| --- | --- | --- |
| addyosmani `interview-me` vs Ouroboros `interview` vs gstack `office-hours` | `interview-me` extracts narrow clarifications; Ouroboros creates durable Seed/Ledger/project definition; gstack tests product demand and wedge | Start with public `mansu-1define` and use Ouroboros first for new/fuzzy products when available. Use `interview-me` only as supporting clarification inside or after that definition route. If product value is questionable, add gstack `office-hours`. |
| addyosmani `spec-driven-development` vs gstack `autoplan` vs explicit OMO planning | addyosmani writes the spec and engineering phase discipline; gstack critiques and synthesizes the plan from specialist roles; OMO `ulw-plan` is an external planning artifact only when the user literally invokes it | Draft Mansu plans with addyosmani routes, then send the plan through gstack reviewers before Build. If explicit OMO planning was invoked, reconcile that artifact with Mansu gates instead of making it the default route. |
| Open Design vs VoltAgent/awesome-design-md vs gstack design skills vs OMO `frontend-ui-ux` | Open Design creates visible artifacts; design-md gives `DESIGN.md` grammar; gstack explores/critiques design and `gstack-design-consultation` may create or contribute to `DESIGN.md`; OMO implements refined UI | Define records design intent seed after Ouroboros. For UI, public `mansu-2plan` consumes that handoff and owns `DESIGN.md`, design artifacts, design direction, and roadmap before Build. |
| Codex-side OMO readiness vs source skills | LazyCodex/OMO is the Codex-side route for Oh My execution patterns; addyosmani, Ouroboros, gstack, Open Design, and design-md are the source skill families Mansu composes | Do not present LazyCodex as a Mansu source skill family. Keep it in `mansu-setup` runtime readiness and let phase skills focus on source-skill orchestration. |
| Verify vs Review source skills | Verify proves behavior; Review judges quality, safety, maintainability, and decision risk | Keep them as separate evidence gates, but execute them as a continuous `mansu-4verify -> mansu-5review` public sequence by default when verification passes. Do not count self-review as QA. |
| Debug skills vs Review skills | Debug is for unknown cause; Review is for evaluating a known artifact or diff | If cause is unknown, jump to `mansu-debug` even if the current phase is Build, Verify, Review, or Ship. |

Initial recommended composition routes:

- Fuzzy new product: public `mansu-1define` -> Ouroboros `interview`/`pm`/`seed`/`brownfield` first when available -> addyosmani `interview-me` or gstack `office-hours` only as supporting clarification -> public `mansu-2plan`.
- Clear new project: Ouroboros `interview`/`seed` -> addyosmani `spec-driven-development` -> gstack focused plan review.
- Complex implementation: addyosmani `planning-and-task-breakdown` -> gstack `autoplan` -> `mansu-3build` with `mansu-tdd-total` as backing engine.
- User-facing UI: Define records design intent seed after Ouroboros -> public `mansu-2plan` consumes the handoff -> research/deepsearch when needed -> Open Design or gstack `design-shotgun`/`design-consultation` -> Plan-owned design-md-shaped `DESIGN.md` and design artifacts -> gstack `plan-design-review`.
- Unknown bug: OMO `debugging` -> gstack `investigate` -> regression proof -> minimal fix -> `mansu-4verify`.
- Ship candidate: `mansu-4verify` evidence -> `mansu-5review` evidence -> gstack `ship`/`document-release` -> `mansu-6ship` verdict.

## Source Skill Responsibilities

- Define: Ouroboros PM/interview/Seed/Ledger가 초기 목표와 문제 정의를 이끌고, user-facing UI/product scope에서는 post-Ouroboros design intent seed/handoff만 기록한다.
- Plan: addyosmani define/plan/build phase skill을 큰 지도 삼고, Mansu가 Define handoff를 스펙, 아키텍처, `DESIGN.md`, design artifacts, design direction, phase roadmap으로 변환한다.
- Design planning: `mansu-2plan` 안의 필수 route다. Oh My/OMO research/deepsearch로 reference를 찾고, gstack design consultation/shotgun으로 여러 방향을 만든 뒤, gstack plan-design-review/design-review로 계획 단계에서 비평한다.
- Build: `mansu-3build`는 backing implementation `mansu-build`와 기존 `mansu-tdd-total`을 계승하고, 구현 discipline은 addyosmani/gstack source skill 조합으로 잡는다. LazyCodex는 source skill family가 아니라 `mansu-setup`의 Codex-side OMO readiness로만 다룬다.
- Verify: gstack QA/browser/review 계열이 독립 검증과 증거 수집을 담당한다.
- Review: gstack review, gstack plan review, root-cause route로 수정/개선 loop를 닫는다.
- Ship: gstack ship/document-release/land-and-deploy 계열을 release gate와 공유 판단에 사용한다.

## Decision-Complete Implementation Plan

This section is the implementation plan for turning the discussion above into
the actual Mansu skill suite. It is intentionally more concrete than the
strategy sections above.

### Core Decisions

- Public lifecycle remains `Define -> Plan -> Build -> Verify -> Review -> Ship`.
- `mansu-debug` remains a public special-purpose interrupt route for unknown
  failures, not a normal lifecycle phase.
- `mansu-debug` is a special root-cause route outside the lifecycle, not a
  seventh normal phase.
- LazyCodex is not a Mansu source skill family. It belongs to `mansu-setup`
  runtime readiness for Codex transport only.
- `mansu-3build` should preserve the existing `mansu-tdd-total` behavior rather
  than rewrite it.
- Existing skill names stay as compatibility aliases during migration.
- Every phase skill must name which source skills it delegates to and what
  evidence it expects back.

### Target Skill Responsibilities

| Skill | Reads first | Main job | Required output |
| --- | --- | --- | --- |
| `mansu-help` | repo files, existing `PLAN.md`, `AGENTS.md`, `CODING_RULES.md`, README, worklog when present | infer project purpose/current state, confirm with the user, recommend the next Mansu route | current-state summary, phase guess, recommended route, next-step confirmation |
| `mansu-setup` | `SOURCE_SKILL_LOCK.json`, `SOURCE_SKILL_CATALOG.md`, source repos, runtime config | update/check Mansu and source ecosystem, then route drift to `mansu-source-curator` | Green/Yellow/Red source report, versions, skipped checks, next safe action |
| `mansu-1define` | `SOURCE_SKILL_COMPOSITION.md`, Ouroboros skills, addyosmani interview/spec skills, gstack office-hours/design-consultation as source capability; backing implementation `mansu-define` | interview and define purpose, user, problem, success criteria, constraints, source of truth, plus design intent seed/handoff after Ouroboros when UI/product design matters | `AGENTS.md`, `CODING_RULES.md`, project brief/spec, Ouroboros Seed/Ledger reference when available, design intent seed/handoff |
| `mansu-2plan` | define outputs including design intent seed/handoff, `DOCUMENT_CREATION_ORDER.md`, `CODE_CONSTRUCTION_ORDER.md`, design route docs; backing implementation `mansu-plan` | produce full project phase map, `DESIGN.md` creation/refinement, design artifacts/direction, and current phase implementation plan | requirements/spec, architecture notes, `DESIGN.md` or no-design-needed reason, design artifacts, design direction, implementation roadmap, phase-level `PLAN.md` |
| `mansu-3build` | current phase `PLAN.md`, `mansu-tdd-total`, source composition rules; backing implementation `mansu-build` | execute the current phase through TDD slices | updated slice table, validation evidence, checkpoint/worklog/commit status |
| `mansu-4verify` | changed surface, tests, runtime/browser paths, QA source skills; backing implementation `mansu-verify` | prove behavior with tests, browser/runtime evidence, QA/security/perf checks when relevant; when verification passes, continue directly into `mansu-5review` by default | verification report, pass/fail evidence, untested risk, review handoff result |
| `mansu-5review` | diff, plan, verification report, review source skills; backing implementation `mansu-review` | judge quality, maintainability, security, design, and decision risk | review findings, required fixes, reverify route |
| `mansu-debug` | failing behavior, logs, repro path, debug source skills | find root cause before fixing | repro, hypotheses, root cause, regression proof, minimal fix handoff |
| `mansu-6ship` | verify/review evidence, release docs, git/deploy state; backing implementation `mansu-ship` | decide ship/hold and prepare release/deploy/learning handoff | ship/hold verdict, release notes, PR/deploy/canary/learning evidence |

### Required Files Per New Skill

Each new public skill directory must include:

- `SKILL.md`: short frontmatter description, routing promise, source-skill
  delegation rules, evidence/exit criteria, and safety notes.
- `agents/openai.yaml`: display name, short description, and default prompt.
- Validator coverage: either a dedicated `scripts/validate_mansu_<phase>.sh` or
  an explicit section in `scripts/validate_mansu_phase_skills.sh`.
- README/README.ko/manual/help route entry in the same migration slice.

Alias skill directories must remain in the repo during the first migration:

- `mansu-project-start` routes to numbered `mansu-1define`; backing implementation `mansu-define`.
- `mansu-tdd-total` remains the implementation engine under numbered `mansu-3build`; backing implementation `mansu-build`.
- `mansu-web-verify` routes to numbered `mansu-4verify`; backing implementation `mansu-verify`.
- `mansu-debug-rootcause` routes to `mansu-debug`.
- `mansu-ship-release` routes to numbered `mansu-6ship`; backing implementation `mansu-ship`.
- `mansu-setting` remains the `mansu-setup` alias.

Public docs should recommend the new names first. Alias docs should say
"compatibility alias" and preserve user intent when handing off.

### Execution Waves

Wave 1: Source Composition Reference

- Add `mansu-operating-model/references/SOURCE_SKILL_COMPOSITION.md`.
- Move the comparison logic out of `PLAN.md` into that reference:
  interview, spec/plan, design, build transport vs source skills, verify/review,
  debug/review, and ship.
- Link it from `SOURCE_SKILL_CATALOG.md`, `CODE_CONSTRUCTION_ORDER.md`, and
  future phase skills.
- Validator: add a source-composition validator that checks the reference exists,
  mentions LazyCodex only as Codex-side OMO readiness, and preserves the key comparison
  pairs.
- Also update `CODE_CONSTRUCTION_ORDER.md` so its Build row no longer presents
  LazyCodex as a phase source route. It may point to setup/runtime readiness
  instead.

Wave 2: Public Phase Skill Shells

- Add `mansu-1define`, `mansu-2plan`, `mansu-3build`, `mansu-4verify`,
  `mansu-5review`, `mansu-debug`, and `mansu-6ship` as user-facing entry skills.
- Keep the current skills as compatibility aliases or internal routes:
  `mansu-project-start -> mansu-1define` with backing implementation `mansu-define`,
  `mansu-tdd-total -> mansu-3build` with backing implementation `mansu-build`,
  `mansu-web-verify -> mansu-4verify` with backing implementation `mansu-verify`,
  `mansu-debug-rootcause -> mansu-debug`,
  `mansu-ship-release -> mansu-6ship` with backing implementation `mansu-ship`.
- Each new skill must be thin: route, gate, delegate, collect evidence.
  It must not clone the full source workflow.

Wave 3: `mansu-help` And `mansu-setup`

- Update `mansu-help` to inspect the project before recommending a route.
  It should state the inferred project purpose/current work, ask for confirmation
  only when needed, map the state to the lifecycle, and offer the next skill.
- Update `mansu-setup` so source ecosystem refresh includes source-check,
  source-lock update, source-catalog/composition drift detection, validators,
  and installed-copy sync. `mansu-source-curator` remains the mutation route for
  Mansu references.
- Move LazyCodex wording from source-skill composition into runtime adapter
  readiness only.
- Add a route-selection validator that fails if `mansu-help` recommends old
  internal names before the new public phase names.

Wave 4: Public Documentation

- Update README/README.ko to show six lifecycle skills plus `mansu-debug`, with
  admin skills separated.
- Keep the Korean wording natural: Mansu is an orchestrator that uses external
  skills; it is not a project that invents new coding skills.

Wave 5: BDD And Validators

- Add BDD checks for:
  `mansu-help` project-state inference,
  `mansu-setup` source refresh,
  `mansu-1define` interview/source-of-truth outputs,
  `mansu-2plan` phase roadmap and design gate,
  `mansu-3build` delegating to `mansu-tdd-total`,
  `mansu-debug` emergency jump,
  and LazyCodex not appearing as a source skill family.
- Add `scripts/validate_mansu_phase_routes.sh` for route fixtures and
  `scripts/validate_mansu_source_composition.sh` for source-family distinctions.
- Run the full validator set and installed-copy comparison before final sync:
  `./scripts/validate_mansu_skills.sh`,
  `git diff --check`,
  and `MANSU_COMPARE_INSTALLED=1 ./scripts/validate_mansu_installed_copies.sh /Users/hansol/.codex/skills`.

Wave 6: Manual Finalization

- Update `mansu-manual/SKILL.md`, `mansu-manual/agents/openai.yaml`, and
  `docs/mansu-manual.html` only after phase skills, aliases, source composition,
  README/README.ko, and validators are stable.
- The manual must reflect the final implemented surface, not the intended
  intermediate migration state: six lifecycle skills, `mansu-debug`, admin/help
  surfaces, alias policy, source family map, and LazyCodex as Codex-side OMO readiness
  readiness only.
- Re-run `scripts/validate_mansu_manual.sh` after the HTML update, then re-run
  the full validator suite and installed-copy comparison.
- If manual validation fails, fix the manual or validator together before the
  final runtime sync.

Rollback rule:

- If new phase skill validation or installed-copy comparison fails, do not remove
  old alias folders and do not sync broken phase skills into runtime copies.
  Keep the previous alias routes active, fix validators/docs first, then retry.

### Acceptance Criteria

- `PLAN.md` names all target skills and their outputs.
- `SOURCE_SKILL_COMPOSITION.md` is the single home for similar-skill comparison.
- `CODE_CONSTRUCTION_ORDER.md` and `SOURCE_SKILL_CATALOG.md` link to the
  composition reference instead of duplicating every comparison.
- `mansu-help` routes to phase skills, not the old internal names, while still
  accepting compatibility aliases.
- `mansu-setup` treats LazyCodex as Codex-side OMO readiness, not source craft.
- `mansu-3build` preserves `mansu-tdd-total` as the default build route.
- Validators fail if the six lifecycle skills, `mansu-debug`, or the LazyCodex
  transport/source distinction drift.
- `mansu-manual` is updated last and matches the final implemented skill surface,
  source composition map, alias policy, and Codex-side OMO distinction.

### QA Scenarios For The Migration

```text
Scenario: New fuzzy product
  Tool: bash
  Steps: run the help/route BDD fixture for a vague app idea.
  Expected: recommends mansu-1define; mentions interview/source-of-truth before planning.
  Evidence: validator output under scripts/validate_mansu_phase_routes.sh.

Scenario: Existing phase plan ready to build
  Tool: bash
  Steps: run the build route fixture with a valid phase PLAN.md.
  Expected: recommends mansu-3build and delegates to mansu-tdd-total.
  Evidence: validator output under scripts/validate_mansu_phase_routes.sh.

Scenario: Unknown runtime failure
  Tool: bash
  Steps: run the debug route fixture with stack trace/failing behavior text.
  Expected: recommends mansu-debug and root-cause-first flow, not review or ship.
  Evidence: validator output under scripts/validate_mansu_phase_routes.sh.

Scenario: Source refresh
  Tool: bash
  Steps: run source-lock/source-catalog validators after setup/source-curator updates.
  Expected: source state is current; LazyCodex appears only as Codex-side OMO readiness.
  Evidence: ./scripts/validate_mansu_source_lock.sh and source-composition validator output.
```

## Migration Steps

1. Add the six numbered public phase skills: `mansu-1define`, `mansu-2plan`, `mansu-3build`, `mansu-4verify`, `mansu-5review`, `mansu-6ship`; keep the unnumbered lifecycle names only as compatibility/backing implementations.
2. Add `mansu-debug` as the special root-cause route and keep `mansu-debug-rootcause` as compatibility alias.
3. Add `SOURCE_SKILL_COMPOSITION.md` with source skill comparison, composition routes, and phase-specific selection rules.
4. Keep current skills as compatibility aliases or internal routes during the first migration.
5. Update `mansu-help` so ordinary users see the six phase skills plus `mansu-debug`.
6. Update README, README.ko, source catalog, and code construction router so the public model is the six-phase lifecycle plus debug exception.
7. Add validators that fail when phase skills, source composition rules, mappings, or lifecycle wording drift.
8. Update `mansu-manual` and `docs/mansu-manual.html` last, after implementation and validators stabilize.
9. Sync the installed Codex skill directory and compare installed copies.
10. Exercise BDD scenarios against the expected route selection.

## BDD Acceptance Scenarios

- Given a new product idea, when the user says `mansu define` or `mansu project start`, then public `mansu-1define` uses Ouroboros interview/Seed/Ledger before writing Mansu planning docs.
- Given an existing idea with unclear design direction, when the user asks to plan, then `mansu-2plan` routes design discovery through Oh My/OMO research and gstack design skills instead of asking ad hoc design questions itself.
- Given a user-facing app or website, when `mansu-2plan` writes the implementation roadmap, then the plan includes design reference discovery, design direction candidates, and plan-stage design review evidence.
- Given an approved plan, when the user asks to build, then Mansu uses `mansu-3build`, delegates to `mansu-tdd-total`, and records the source skills and validation gates used for the current slice.
- Given completed implementation, when the user asks to verify, then Mansu runs tests/browser/QA evidence through `mansu-4verify`.
- Given failed verification or unclear quality, when the user asks for review, then Mansu enters `Review -> Build -> Verify` improvement loop.
- Given verified work, when the user asks to ship, then Mansu uses `mansu-6ship` as a release gate and clearly returns ship/hold evidence.

## Active Follow-up

- Implement the six phase skills and compatibility mapping.
- Keep the detailed coding-flow vocabulary as an internal classification layer:
  `기획 -> 요구사항 정리 -> 스펙 작성 -> 구현 계획 -> 코딩 -> 테스트 -> QA -> 수정/개선 -> 배포/공유`.
- Continue using the canonical lifecycle as the public phase model:
  `Define -> Plan -> Build -> Verify -> Review -> Ship`.
- After implementation, sync changed `mansu-*` folders into the active runtime skill directory.
- Future follow-up: exercise `mansu-1define` on a real greenfield project and
  `mansu-6ship` on a real release to tune report shape.

## Ready for Commit

- Added `mansu-operating-model/references/CODE_CONSTRUCTION_ORDER.md` as a dynamic construction router.
- Added `mansu-operating-model/references/DOCUMENT_CREATION_ORDER.md` as the document creation router.
- Added `mansu-operating-model/references/SOURCE_SKILL_LOCK.json` as a source freshness snapshot.
- Kept `mansu-project-start` as the legacy compatibility alias to public
  `mansu-1define` for older kickoff prompts.
- Added `mansu-source-curator` as the internal source/reference maintenance route.
- Added `mansu-ship-release` as the release readiness and ship/hold route.
- Added `addyosmani/agent-skills` as a third source family in `SOURCE_SKILL_CATALOG.md`.
- Updated `mansu-tdd-total`, `mansu-tdd-lite`, and `mansu-tdd-strict` to detect current construction phase and route to source skills instead of hardcoding one order.
- Updated `mansu-setup` to include addyosmani/agent-skills in source freshness checks and to sync runtime skills only after source curation and validation pass.
- Updated `mansu-setup` to prepare Ouroboros, gstack, and the matching Oh My adapter, while leaving actual Ouroboros project-definition work to public `mansu-1define`.
- Updated public `mansu-1define`, with `mansu-project-start` kept as a compatibility alias, to use Ouroboros Seed/Ledger/PM artifacts as upstream project-definition evidence when useful.
- Updated `mansu-source-curator`, `SOURCE_SKILL_CATALOG.md`, and `SOURCE_SKILL_LOCK.json` so Ouroboros is tracked as an active source family.
- Added project-level gate mapping and learning closeout guidance to `CODING_RULES.md`.
- Updated README, philosophy, source catalog, and validators to preserve the new zero-to-release routes.
