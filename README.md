# mansu-skills

AI 코딩이 빨라질수록, 좋은 스킬을 고르는 일보다 `어떻게 조합하고 끝까지 검증할지`가 더 중요해집니다.
Mansu는 좋은 Ouroboros, Oh My, gstack, 공개 스킬을 해부하고, 필요한 순간에 정확히 라우팅하는 개인 작업 운영체계입니다.
Install the skills. Pick the right Mansu route. Finish with evidence.

## Big Picture

Mansu는 하나의 만능 스킬이 아니라, 프로젝트 운영체계입니다.

```text
Lifecycle phase spine
= addyosmani/agent-skills or equivalent: Define -> Plan -> Build -> Verify -> Review -> Ship

Project definition / memory source
= Ouroboros or equivalent: purpose, Seed, Ledger, spec, long-horizon direction

Mansu
= orchestrator, judge, router, doctrine, gates, final accountability

Execution-mode source
= Oh My / OMO / OMC or equivalent: research, ultrawork, ralph, tdd, debug inside a phase

Specialist team source
= gstack or equivalent: CEO, design, eng, QA, CSO, benchmark, ship

Implementation actor
= Codex or the active coding agent: edits files, runs tests, integrates, commits
```

이 이름들은 대표 route이지 고정 의존성이 아닙니다. Mansu의 역할은 지금 순간에
어떤 source route를 쓸지 고르고, 중복 구현을 피하고, 산출물을 phase/slice/gate로
연결하는 것입니다.

## Quick Start
Last verified: 2026-05-03

Canonical branch: `main`

### For Humans

처음 설치할 때는 `mansu-setting`만 먼저 부트스트랩한 뒤, 그 스킬로 전체 설치를 맡깁니다.
`mansu-setting`은 먼저 runtime target(Hermes, OpenCode, Codex, Claude Code), host, OS를 감지해
맞는 skill directory를 고르고, Ouroboros, gstack, 현재 runtime에 맞는 Oh My adapter를 설치/업데이트한 뒤
adapter tooling을 compatibility check로 검증합니다.

```bash
git clone https://github.com/bigpine86/mansu-skills.git
cd mansu-skills

# Example: Hermes + tmux + OpenCode runtime using OpenCode's global skill path.
mkdir -p "$HOME/.config/opencode/skills/mansu-setting"
cp -R mansu-setting/. "$HOME/.config/opencode/skills/mansu-setting"/
```

프로젝트 전용 OpenCode 설치가 필요하면 `.opencode/skills/mansu-setting`에 같은 방식으로 복사합니다.
다른 runtime target이면 해당 local/global skill directory에 맞춰 복사합니다.

그 다음 agent runtime에서:

```text
Use $mansu-setting install from this repo. Detect my runtime target, host, and OS, install/update Ouroboros, gstack, and the matching Oh My adapter when needed, then choose paths and run compatibility checks.
```

업데이트할 때는:

```text
Use $mansu-setting update. Update Mansu, install/update Ouroboros, gstack, and the matching Oh My adapter when needed, sync Mansu skills, check Ouroboros, gstack, Oh My / OMO / OMC, and addyosmani/agent-skills source freshness, and report adapter compatibility with any blocked install steps.
```

### For Agents

```text
If Mansu is not installed or may be stale, run mansu-setting first.
Read MANSU_PHILOSOPHY.md first.
Then choose the correct mansu-* skill for the task.
Do not invent a new workflow before checking the source skill map.
```

## Why This Exists

Mansu는 모든 것을 직접 발명하지 않습니다.
이미 잘 만든 스킬과 도구를 먼저 읽고, 그 안에 담긴 철학과 게이트를 존중합니다.

Mansu의 canonical doctrine은 `mansu-operating-model`이 맡습니다.
프로젝트별 `AGENTS.md`는 그 doctrine으로 라우팅하는 계약 문서이고,
프로젝트별 `CODING_RULES.md`는 실제 runtime/검증/ship 기준을 적는 로컬 운영 매뉴얼입니다.

Mansu가 직접 책임지는 것은 아래입니다.

- 계획
- 안전선
- 역할 분리
- 라우팅
- 검증
- 체크포인트
- 개발일지와 학습 기록
- 최종 책임

전문 실행은 가능한 한 더 잘 맞는 source skill에 맡깁니다.
그 source skill 목록과 조합법은 `mansu-operating-model/references/SOURCE_SKILL_CATALOG.md`에서 관리합니다.
`mansu-setting`은 Ouroboros, gstack, Oh My / OMO / OMC, addyosmani/agent-skills 계열 source skill이 바뀌었는지도 계속 확인해야 합니다.
전체 개발 흐름은 addyosmani/agent-skills의 Define → Plan → Build → Verify → Review → Ship phase를 큰 지도로 삼습니다. 다만 Mansu는 이 순서를 딱딱하게 복사하지 않고, 현재 단계와 위험도에 맞춰 필요한 source skill을 고릅니다.
실제 코딩 순서는 하드코딩하지 않고, `mansu-operating-model/references/CODE_CONSTRUCTION_ORDER.md`가 현재 개발 단계를 판단한 뒤 필요한 `addyosmani/agent-skills` phase skill과 gstack/Oh My/Ouroboros 보조 route로 라우팅합니다.

## Core Philosophy

Good Mansu skills are thin where they can be thin and strict where they must be strict.

- Thin: 도구별 세부 사용법, 긴 체크리스트, 전문 실행 루틴
- Strict: 계획, 안전선, scope boundary, 증거, 검증, 완료 조건

For non-trivial work, Mansu planning is a multi-role critique loop:
Planner drafts, Critics challenge, Synthesizer produces one execution-ready plan,
and then slices are dispatched automatically unless an explicit approval gate, risky
action, or unresolved blocker requires a pause.

If real critic agents are started, their feedback is not optional: wait for it, or
record the timeout/failure and preserve unresolved high-risk questions as blockers.

Slices are sequential by default: slice N+1 does not start until slice N is validated,
reviewed, QA'd, checkpointed, logged, and committed or explicitly recorded as not committed.

자세한 기준은 [MANSU_PHILOSOPHY.md](./MANSU_PHILOSOPHY.md)를 봅니다.

## Skills

| Skill | Use when | Core idea |
| --- | --- | --- |
| `mansu-help` | 초보자이거나 지금 뭐부터 해야 할지 모르겠고, 현재 상황 진단과 다음 Mansu route 추천, 바로 쓸 프롬프트가 필요할 때 | beginner-friendly route helper |
| `mansu-manual` | 브라우저에서 볼 수 있는 초보자용 HTML 사용 설명서가 필요할 때. 정적 문서인 `docs/mansu-manual.html`을 보여준다 | beginner-friendly HTML manual |
| `mansu-setting` | Mansu를 시작하기 전 기본 세팅으로 runtime target/host/OS별 skill directory를 고르고, Ouroboros/gstack/현재 runtime의 Oh My adapter를 설치/업데이트하고, Mansu 스킬을 동기화/복구하며 adapter compatibility를 점검할 때 | runtime-target bootstrap, source-tool install, and update gate |
| `mansu-source-curator` | Ouroboros, gstack, Oh My / OMO / OMC, addyosmani/agent-skills 같은 원천 스킬이 바뀌었고 Mansu 레퍼런스/validator/worklog까지 다시 맞춰야 할 때 | hidden source-reference maintenance |
| `mansu-project-start` | 새 제품, 앱, 레포, 큰 기능군을 아이디어/리서치/spec/TDR/UI 방향, 프로젝트 로드맵/phase order, 현재 phase `PLAN.md`까지 끌고 갈 때. Mansu는 이 시점에 Ouroboros, gstack, Oh My, addyosmani 중 어떤 source route를 쓸지 고르고 산출물 변환, gate mapping, phase/slice handoff를 맡는다 | zero-to-PLAN kickoff |
| `mansu-operating-model` | 프로젝트의 개발 행동양식, role separation, strictness, evidence, 그리고 `AGENTS.md` / `CODING_RULES.md` 구조를 정할 때 | canonical doctrine and project-document templates |
| `mansu-tdd-total` | 기능/리팩토링 작업을 먼저 계획하고 slice별로 `lite`/`strict`를 나눌 때 | planning dispatcher |
| `mansu-tdd-strict` | RED 테스트가 의미 있고 위험도가 높은 slice를 엄격한 TDD로 진행할 때 | strict TDD slice loop |
| `mansu-tdd-lite` | 계획, slice, review, QA, checkpoint는 유지하되 RED 테스트를 강제하지 않을 때 | relaxed RED, not relaxed quality |
| `mansu-debug-rootcause` | 원인 모를 버그를 재현, 격리, 원인 증명, 최소 수정, 회귀 검증할 때 | root-cause-first debugger |
| `mansu-web-verify` | 웹앱을 실제 사용자처럼 눌러보고 기능/안정성/성능/반응형/기본 보안을 검증할 때 | web verification orchestrator |
| `mansu-ship-release` | 구현이 끝난 뒤 health/review/QA/docs/PR/deploy/canary/learning 기준으로 ship-ready인지 판단할 때 | release readiness gate |

## Recommended Routing

- 초보자이거나 지금 뭐부터 해야 할지 모르겠음:
  `mansu-help`
- HTML로 된 전체 사용 설명서를 보고 싶음:
  `mansu-manual` 또는 [docs/mansu-manual.html](./docs/mansu-manual.html)
- 처음 설치, 업데이트, 스킬 동기화, runtime target 감지, optional adapter compatibility 상태 확인:
  `mansu-setting`
- 원천 스킬 업데이트 후 `SOURCE_SKILL_CATALOG.md`, 문서/코드 순서 레퍼런스, validator, worklog까지 같이 갱신:
  `mansu-source-curator`
- 새 프로젝트 또는 큰 기능군을 아이디어에서 research/spec/TDR/UI 방향, 큰 기능 순서, phase `PLAN.md`까지 설계:
  `mansu-project-start`
- 프로젝트의 운영 doctrine, `AGENTS.md`, `CODING_RULES.md` 구조를 잡거나 drift를 점검:
  `mansu-operating-model`
- 새 기능 또는 리팩토링:
  `mansu-tdd-total`
- slice가 위험하고 RED 테스트가 도움이 됨:
  `mansu-tdd-strict`
- slice가 문서, UI polish, config, 작은 정리이고 RED 테스트가 인위적임:
  `mansu-tdd-lite`
- 버그, 회귀, stack trace, "왜 깨졌지?":
  `mansu-debug-rootcause`
- 웹페이지를 실제 사용자처럼 전체 점검:
  `mansu-web-verify`
- 구현 완료 후 ship-ready, PR, release docs, deploy/canary, learning closeout 판단:
  `mansu-ship-release`

## Source Skill Policy

새 `mansu-*` 스킬을 만들거나 확장하기 전에:

1. 관련 Ouroboros, Oh My, gstack, 공개 source skill을 먼저 찾습니다.
2. `mansu-operating-model/references/SOURCE_SKILL_CATALOG.md`에서 기존 조합법을 확인합니다.
3. 그 스킬의 목적, 게이트, 철학을 읽습니다.
4. Mansu가 맡을 경계와 source skill에 맡길 경계를 나눕니다.
5. 모든 작업에 필요한 필수 게이트만 Mansu 스킬에 짧게 내장합니다.
6. 깊은 실행은 source skill map으로 라우팅합니다.
7. 검증 결과와 배운 점을 `개발일지.md`에 남깁니다.

## Branch Policy

- `main` is the canonical branch.
- Non-`main` branches are temporary work branches.
- Finished skill changes should land on `main` before being treated as installed or shared.
- If local installed skills in the active runtime skill directory drift from this repo, sync from `main` first.

## Validation

```bash
scripts/validate_mansu_skills.sh
```

개별 검증:

```bash
scripts/validate_mansu_setting.sh
scripts/validate_mansu_help.sh
scripts/validate_mansu_manual.sh
scripts/validate_mansu_source_curator.sh
scripts/validate_mansu_source_lock.sh
scripts/validate_mansu_project_start.sh
scripts/validate_mansu_operating_model.sh
scripts/validate_mansu_doc_system.sh
scripts/validate_mansu_runtime_readiness.sh
scripts/validate_mansu_tdd_series.sh
scripts/validate_mansu_debug_rootcause.sh
scripts/validate_mansu_web_verify.sh
scripts/validate_mansu_ship_release.sh
```

## Repo Map

- [MANSU_PHILOSOPHY.md](./MANSU_PHILOSOPHY.md): Mansu 공통 철학
- [mansu-operating-model](./mansu-operating-model/SKILL.md): canonical doctrine + `AGENTS.md` / `CODING_RULES.md` templates
- [SOURCE_SKILL_CATALOG.md](./mansu-operating-model/references/SOURCE_SKILL_CATALOG.md): Ouroboros / gstack / Oh My / OMO / OMC source skill map and composition recipes
- [SOURCE_SKILL_LOCK.json](./mansu-operating-model/references/SOURCE_SKILL_LOCK.json): source-family freshness snapshot and evidence
- [DOCUMENT_CREATION_ORDER.md](./mansu-operating-model/references/DOCUMENT_CREATION_ORDER.md): which document to create, which source skill to use, and which verification skill to run
- [CODE_CONSTRUCTION_ORDER.md](./mansu-operating-model/references/CODE_CONSTRUCTION_ORDER.md): current phase detection and dynamic routing to coding-order source skills
- [PLAN.md](./PLAN.md): 현재 follow-up과 다음 작업
- [개발일지.md](./개발일지.md): 시간순 작업 기록
- [mansu-help](./mansu-help/SKILL.md): 초보자용 상황 진단과 다음 route 추천
- [mansu-manual](./mansu-manual/SKILL.md): 정적 HTML 매뉴얼 안내
- [mansu-manual.html](./docs/mansu-manual.html): 초보자용 HTML 사용 설명서
- [mansu-setting](./mansu-setting/SKILL.md): 설치/업데이트/복구 진입점
- [mansu-source-curator](./mansu-source-curator/SKILL.md): 원천 스킬 업데이트 후 Mansu 레퍼런스/validator/worklog를 맞추는 내부 관리 스킬
- [mansu-project-start](./mansu-project-start/SKILL.md): 새 프로젝트를 아이디어/리서치/spec/TDR에서 실행 가능한 PLAN으로 넘기는 진입점
- [mansu-tdd-total](./mansu-tdd-total/SKILL.md): TDD 시리즈 진입점
- [mansu-tdd-strict](./mansu-tdd-strict/SKILL.md): strict TDD 실행
- [mansu-tdd-lite](./mansu-tdd-lite/SKILL.md): lite 실행
- [mansu-debug-rootcause](./mansu-debug-rootcause/SKILL.md): root-cause 디버그
- [mansu-web-verify](./mansu-web-verify/SKILL.md): 웹 검증 오케스트레이터
- [mansu-ship-release](./mansu-ship-release/SKILL.md): release readiness와 ship/hold 판단
- [scripts](./scripts): 구조 검증 스크립트

## Limits

- 이 레포는 아직 초기 Mansu skill suite입니다.
- 모든 스킬이 모든 프로젝트에 맞지는 않습니다.
- source skill은 시간이 지나며 바뀔 수 있으므로, 중요한 작업 전에는 원본을 다시 확인합니다.
- `mansu-*`는 좋은 도구를 대체하는 브랜드가 아니라, 좋은 도구를 더 안전하게 조합하기 위한 운영 레이어입니다.

## Status

active

## License

TBD
