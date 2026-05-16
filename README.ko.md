# Mansu Skills

> 좋은 스킬을 모아, 초보자도 에이전틱 코딩을 끝까지 굴릴 수 있게 만드는 작업 흐름

[English](./README.md) | 한국어

에이전틱 코딩은 프롬프트를 많이 외우는 일이 아닙니다.
지금 상황에서 어떤 검증된 스킬을 꺼내고, 어디까지 맡기고, 결과를 어떻게 확인할지 아는 일에 가깝습니다.

Mansu는 전세계의 좋은 agent skill을 다시 만들려고 하지 않습니다.
이미 잘 만든 스킬을 읽고, 검증하고, 필요한 순간에 조합합니다.
그래서 초보자도 "무언가 만들고 싶다"는 생각에서 출발해 기획, 구현, QA, 릴리스, 학습 기록까지 증거를 남기며 갈 수 있게 돕습니다.

좋은 원천 스킬(source skill)이 늘어날수록 Mansu도 더 좋아집니다.
`mansu-setting source-check`가 원천 생태계를 먼저 확인하고, drift가 확인되고 승인된 뒤에만 `mansu-source-curator`가 Mansu 내부 지도를 고칩니다.
이 방식으로 더 나은 프로젝트 시작, 계획, 코딩, 디자인, QA, 디버그, 릴리스 방식을 계속 흡수하되, 사용자가 원치 않는 변경은 하지 않습니다.

설치하고, `mansu-help`라고 말하세요.
Mansu가 지금 상황에 맞는 길을 고르고, 끝에는 증거가 남습니다.

## Mansu는 무엇인가

Mansu는 agentic coding을 위한 스킬 오케스트레이터입니다.

Mansu의 믿음은 단순합니다.

> 최고의 자동화는 모든 것을 직접 만드는 데서 오지 않습니다.
> 이미 잘 만든 전세계의 스킬을 읽고, 검증하고, 상황에 맞게 조합할 때 나옵니다.

Mansu는 초보자가 숙련된 에이전틱 코더처럼 일하도록 돕습니다.

- 코딩 전에 프로젝트의 목적과 범위를 정합니다.
- 추측으로 시작하지 않고 실제 레퍼런스를 조사합니다.
- 현재 phase에 맞는 source skill을 고릅니다.
- 큰 작업을 vertical slice로 나눕니다.
- strict TDD는 효과가 있을 때만 씁니다.
- review, QA, 브라우저 검증, 보안, 성능, release gate로 결과를 확인합니다.
- `PLAN.md`, 개발일지, 문서, 검증 증거를 남깁니다.

Mansu는 원천 스킬이 이미 잘하는 일에는 얇게 붙습니다.
대신 초보자와 에이전트가 자주 놓치는 계획, 범위, 안전선, 검증, 원천 스킬 최신성, 완료 증거에는 엄격합니다.

## 빠른 시작

Last verified: 2026-05-10

Canonical branch: `main`

### 처음 설치

처음에는 `mansu-setting`만 먼저 복사합니다.
그다음 `mansu-setting`이 나머지 설치와 동기화를 맡습니다.

`mansu-setting`은 runtime target(Hermes, OpenCode, Codex, Claude Code), host, OS를 확인하고,
맞는 skill directory를 고릅니다.
그 뒤 Ouroboros, gstack, 현재 runtime에 맞는 Oh My adapter를 설치하거나 업데이트하고,
adapter compatibility도 확인합니다.

```bash
git clone https://github.com/bigpine86/mansu-skills.git
cd mansu-skills

# 예시: Hermes + tmux + OpenCode runtime에서 OpenCode global skill path 사용
mkdir -p "$HOME/.config/opencode/skills/mansu-setting"
cp -R mansu-setting/. "$HOME/.config/opencode/skills/mansu-setting"/
```

프로젝트 안에서만 OpenCode용으로 쓰고 싶다면 `.opencode/skills/mansu-setting`에 같은 방식으로 복사합니다.
다른 runtime target을 쓴다면 그 runtime의 local/global skill directory에 맞춰 복사합니다.

그다음 사용하는 agent runtime에서 이렇게 요청합니다.

```text
Use $mansu-setting install from this repo. Detect my runtime target, host, and OS, install/update Ouroboros, gstack, and the matching Oh My adapter when needed, then choose paths and run compatibility checks.
```

### 설치 후

먼저 이것만 실행하면 됩니다.

```text
mansu-help
```

Mansu가 현재 상황을 보고 다음 스킬을 안내합니다.

- `mansu-setting`: 설치, 업데이트, runtime setup
- `mansu-project-start`: 새 제품, 앱, 레포, 큰 기능군 시작
- `mansu-tdd-total`: 기능 구현과 리팩토링
- `mansu-debug-rootcause`: 버그 원인 분석과 수정
- `mansu-web-verify`: 실제 사용자 관점의 웹 검증
- `mansu-ship-release`: release readiness 판단

업데이트하기 전에는 먼저 읽기 전용으로 확인합니다.

```text
Use $mansu-setting source-check. Ouroboros, gstack, Oh My / OMO / OMC, addyosmani/agent-skills, VoltAgent/awesome-design-md가 Mansu 라우팅과 아직 맞는지 확인해줘. 설치, 업데이트, sync, 파일 수정은 하지 말고 Green/Yellow/Red 상태와 승인 필요한 다음 행동만 알려줘.
```

업데이트하기로 결정했다면 이렇게 요청합니다.

```text
Use $mansu-setting update. Update Mansu, install/update Ouroboros, gstack, and the matching Oh My adapter when needed, sync Mansu skills, check Ouroboros, gstack, Oh My / OMO / OMC, addyosmani/agent-skills, and VoltAgent/awesome-design-md source freshness, and report adapter compatibility with any blocked install steps.
```

### 에이전트에게 줄 기본 지시

```text
If Mansu is not installed or may be stale, run mansu-setting first.
Read MANSU_PHILOSOPHY.md first.
Then choose the correct mansu-* skill for the task.
Do not invent a new workflow before checking the source skill map.
```

## 왜 필요한가

AI 코딩은 점점 빨라지고 있습니다.
문제는, 코드가 만들어지는 속도가 계획과 아키텍처, 범위, 리스크, 품질을 판단하는 속도보다 빨라질 수 있다는 점입니다.

좋은 에이전틱 워크플로우는 이미 여러 곳에 흩어져 있습니다.

- `addyosmani/agent-skills`: define, plan, build, verify, review, ship 생애주기
- Ouroboros: 초기 프로젝트 정의, memory, Seed, Ledger, 장기 방향
- Oh My / OMO / OMC: research, ultrawork, ralph, TDD, debug 같은 실행 모드
- gstack: CEO, design, engineering, QA, security, performance, ship, deploy, learn 같은 전문가 역할과 gate
- VoltAgent/awesome-design-md: `DESIGN.md`와 design handoff의 참고 구조

Mansu는 이들을 대체하지 않습니다.
Mansu는 지금 무엇을 써야 하는지 고르고, 각 도구의 산출물을 이어 붙이고, 끝까지 검증하게 만듭니다.

Mansu가 직접 책임지는 일은 아래입니다.

- 계획
- 안전선
- 역할 분리
- 라우팅
- 검증
- 체크포인트
- 개발일지와 학습 기록
- 최종 책임

전문 실행은 가능한 한 더 잘 맞는 source skill에 맡깁니다.
source skill 목록과 조합법은 `mansu-operating-model/references/SOURCE_SKILL_CATALOG.md`에서 관리합니다.
`mansu-setting`은 Ouroboros, gstack, Oh My / OMO / OMC, addyosmani/agent-skills, VoltAgent/awesome-design-md source freshness를 계속 확인합니다.

Mansu가 좋아지는 방식은 단순합니다.

- 좋은 source skill을 찾습니다.
- 그 스킬의 철학, gate, 산출물을 읽습니다.
- Mansu가 어설프게 복제하지 않고 가장 잘 맞는 source로 라우팅합니다.
- `mansu-*` 안에는 꼭 필요한 guardrail만 남깁니다.
- 더 좋은 스킬과 새로운 패턴이 나오면 source map을 갱신합니다.

전체 개발 흐름은 addyosmani/agent-skills의 Define -> Plan -> Build -> Verify -> Review -> Ship phase를 큰 지도로 삼습니다.
다만 Mansu는 이 순서를 기계적으로 복사하지 않고, 현재 단계와 위험도에 맞춰 필요한 source skill을 고릅니다.
실제 코딩 순서는 하드코딩하지 않습니다.
`mansu-operating-model/references/CODE_CONSTRUCTION_ORDER.md`가 현재 개발 phase를 판단하고,
필요한 addyosmani/agent-skills phase skill과 gstack, Oh My, Ouroboros 보조 route로 연결합니다.

디자인 작업은 VoltAgent/awesome-design-md를 `DESIGN.md` 참고 원천으로 삼습니다.
그다음 프로젝트 고유의 분위기, 토큰, 컴포넌트, 반응형 규칙으로 바꾸고 gstack 디자인/QA gate로 검증합니다.

## 큰 그림

Mansu는 하나의 만능 스킬이 아니라 프로젝트 운영 레이어입니다.

```text
Lifecycle phase spine
= addyosmani/agent-skills, or a source route verified by mansu-source-curator: Define -> Plan -> Build -> Verify -> Review -> Ship

Project definition / memory source
= Ouroboros, or a source route verified by mansu-source-curator: purpose, Seed, Ledger, spec, long-horizon direction

Design reference source
= VoltAgent/awesome-design-md, or a design reference verified by mansu-source-curator: DESIGN.md structure, visual atmosphere, tokens, components, responsive behavior

Mansu
= orchestrator, judge, router, doctrine, gates, final accountability

Execution-mode source
= Oh My / OMO / OMC, or a source route verified by mansu-source-curator: research, ultrawork, ralph, tdd, debug inside a phase

Specialist team source
= gstack, or a source route verified by mansu-source-curator: CEO, design, eng, QA, CSO, benchmark, ship

Implementation actor
= Codex or the active coding agent: edits files, runs tests, integrates, commits
```

이 이름들은 대표 route이지 고정 의존성이 아닙니다.
다만 대체 source route는 `mansu-source-curator`가 실제 원천, 버전, 역할, 산출물을 확인하고
`SOURCE_SKILL_LOCK.json`과 `SOURCE_SKILL_CATALOG.md`에 기록한 뒤에만 Mansu routing 근거로 씁니다.

Mansu의 canonical doctrine은 `mansu-operating-model`이 맡습니다.
프로젝트별 `AGENTS.md`는 그 doctrine으로 에이전트를 라우팅하는 계약 문서입니다.
프로젝트별 `CODING_RULES.md`는 실제 runtime, 검증, ship 기준을 적는 로컬 운영 매뉴얼입니다.

프로젝트 로드맵과 phase order는 spec, TDR, design 문서에 둡니다.
큰 기능 순서를 먼저 정하고, 그다음 현재 phase의 `PLAN.md`를 만듭니다.
`PLAN.md`는 현재 phase의 active execution plan입니다.

## 핵심 철학

좋은 Mansu skill은 얇을 수 있는 곳에서는 얇고, 엄격해야 하는 곳에서는 엄격합니다.

- 얇게 둘 것: source별 세부 사용법, 긴 체크리스트, 전문 실행 루틴
- 엄격하게 잡을 것: 계획, 안전선, scope boundary, 증거, 검증, 완료 조건

중요한 작업에서 Mansu planning은 multi-role critique loop입니다.
Planner가 계획을 만들고, Critics가 비평하고, Synthesizer가 하나의 실행 가능한 계획으로 합칩니다.
그 뒤 explicit approval gate, 위험한 행동, unresolved blocker가 없다면 slice는 자동으로 진행됩니다.

실제 critic agent를 시작했다면 그 피드백은 선택 사항이 아닙니다.
기다리거나, timeout/failure를 기록하고, 고위험 질문은 blocker로 남겨야 합니다.

Slice는 기본적으로 순차 진행입니다.
slice N+1은 slice N이 validation, review, QA, checkpoint, log, commit 또는 no-commit 기록까지 닫힌 뒤 시작합니다.

자세한 기준은 [MANSU_PHILOSOPHY.md](./MANSU_PHILOSOPHY.md)를 봅니다.

## Skills

| Skill | 언제 쓰나 | 핵심 |
| --- | --- | --- |
| `mansu-help` | 초보자이거나 지금 무엇을 해야 할지 모를 때 | 다음 route 추천 |
| `mansu-manual` | HTML 매뉴얼을 보고 싶을 때 | 시각 매뉴얼 |
| `mansu-setting` | 설치, 읽기 전용 source health check, 업데이트, runtime 감지, source tool setup, skill sync, repair, adapter compatibility가 필요할 때 | bootstrap/check/update gate |
| `mansu-source-curator` | drift가 확인되어 Mansu reference, validator, manual, worklog를 갱신해야 할 때 | 내부 source-reference maintenance |
| `mansu-project-start` | 새 제품, 앱, 레포, 큰 기능군을 idea/research/spec/TDR/UI 방향에서 project roadmap/phase order와 현재 phase `PLAN.md`까지 가져가고, Zero-to-PLAN minimum gate를 답해야 할 때 | zero-to-PLAN kickoff |
| `mansu-operating-model` | 프로젝트 행동양식, role separation, evidence rule, `AGENTS.md`, `CODING_RULES.md`를 정할 때 | canonical doctrine |
| `mansu-tdd-total` | 기능/리팩토링을 계획하고 slice별 실행 모드를 고를 때 | planning dispatcher |
| `mansu-tdd-strict` | 위험한 slice에 의미 있는 RED test가 필요할 때 | strict TDD loop |
| `mansu-tdd-lite` | 계획, review, QA, checkpoint는 필요하지만 RED test가 인위적일 때 | relaxed RED, not quality |
| `mansu-debug-rootcause` | 버그를 재현, 격리, 원인 증명, 최소 수정, 회귀 검증할 때 | root-cause debugger |
| `mansu-web-verify` | 웹을 실제 사용자처럼 눌러 검증할 때 | web verification |
| `mansu-ship-release` | ship/hold 판단, PR, release docs, deploy/canary, learning closeout이 필요할 때 | release readiness |

## 상황별 선택

- 새롭거나 헷갈림: `mansu-help`
- 시각 매뉴얼: `mansu-manual` 또는 [docs/mansu-manual.html](./docs/mansu-manual.html)
- 설치, 읽기 전용 source health check, 업데이트, runtime 감지, skill sync, adapter compatibility: `mansu-setting`
- drift 확인 후 내부 source catalog/manual/validator 유지보수: `mansu-source-curator`
- 새 프로젝트 또는 큰 기능군: `mansu-project-start`
- project doctrine, `AGENTS.md`, `CODING_RULES.md`: `mansu-operating-model`
- 기능/리팩토링 구현: `mansu-tdd-total`
- 위험하고 RED test가 유용한 slice: `mansu-tdd-strict`
- RED가 인위적인 낮은 위험 slice: `mansu-tdd-lite`
- 버그, 회귀, stack trace, "왜 깨졌지?": `mansu-debug-rootcause`
- 실제 사용자 관점 웹 검증: `mansu-web-verify`
- ship-ready, PR, release docs, deploy/canary, learning closeout: `mansu-ship-release`

## 신뢰와 검증

Mansu를 처음 쓰기 위해 이 섹션을 실행할 필요는 없습니다.
repo 구조를 확인하고 싶거나, 스킬을 수정하기 전에 검증하고 싶을 때 쓰면 됩니다.

```bash
scripts/validate_mansu_skills.sh
```

기대 결과: 모든 Mansu 구조 validator가 통과합니다.
이 suite는 skill frontmatter, manual/catalog 일관성, source-lock reference,
runtime-readiness 문구, TDD/debug/web/ship workflow, installed-copy validation hook을 확인합니다.

세부 검증은 [scripts](./scripts)에 있습니다.
예를 들면 `scripts/validate_mansu_help.sh`, `scripts/validate_mansu_manual.sh`,
`scripts/validate_mansu_operating_model.sh`, `scripts/validate_mansu_installed_copies.sh`가 있습니다.

## Repo Map

- [README.md](./README.md): 영어 README
- [MANSU_PHILOSOPHY.md](./MANSU_PHILOSOPHY.md): Mansu 공통 철학
- [mansu-operating-model](./mansu-operating-model/SKILL.md): canonical doctrine + `AGENTS.md` / `CODING_RULES.md` templates
- [SOURCE_SKILL_CATALOG.md](./mansu-operating-model/references/SOURCE_SKILL_CATALOG.md): source skill map과 조합법
- [SOURCE_SKILL_LOCK.json](./mansu-operating-model/references/SOURCE_SKILL_LOCK.json): source-family freshness snapshot과 evidence
- [DOCUMENT_CREATION_ORDER.md](./mansu-operating-model/references/DOCUMENT_CREATION_ORDER.md): 문서 생성 router
- [CODE_CONSTRUCTION_ORDER.md](./mansu-operating-model/references/CODE_CONSTRUCTION_ORDER.md): 현재 phase 감지와 coding-order source skill 라우팅
- [PLAN.md](./PLAN.md): 현재 phase의 active execution plan. 전체 프로젝트 로드맵과 큰 기능 순서는 spec/TDR/design 문서에 둡니다.
- [개발일지.md](./개발일지.md): 시간순 작업 기록
- [mansu-help](./mansu-help/SKILL.md): route helper
- [mansu-manual](./mansu-manual/SKILL.md): 정적 HTML 매뉴얼 안내
- [mansu-manual.html](./docs/mansu-manual.html): 시각 매뉴얼
- [mansu-setting](./mansu-setting/SKILL.md): 설치/업데이트/복구 진입점
- [mansu-source-curator](./mansu-source-curator/SKILL.md): 내부 source-reference 유지보수
- [mansu-project-start](./mansu-project-start/SKILL.md): zero-to-PLAN kickoff
- [mansu-tdd-total](./mansu-tdd-total/SKILL.md): TDD 시리즈 진입점
- [mansu-tdd-strict](./mansu-tdd-strict/SKILL.md): strict TDD 실행
- [mansu-tdd-lite](./mansu-tdd-lite/SKILL.md): lite 실행
- [mansu-debug-rootcause](./mansu-debug-rootcause/SKILL.md): root-cause 디버그
- [mansu-web-verify](./mansu-web-verify/SKILL.md): 웹 검증 오케스트레이터
- [mansu-ship-release](./mansu-ship-release/SKILL.md): release readiness와 ship/hold 판단
- [scripts](./scripts): 구조 검증 스크립트

## 사용 기준

- Mansu는 기획, source skill 라우팅, 구현 규율, 검증이 함께 필요한 작업에서 가장 잘 맞습니다.
- 작은 오탈자나 단순 수정은 바로 고치면 됩니다.
- 제품, 아키텍처, UI, 디버그, 출하 작업에서는 상황에 맞는 Mansu route를 쓰면 좋습니다.
- 중요한 작업 전에 로컬 스킬이 오래됐다고 느껴지면 `mansu-setting`으로 먼저 정리합니다.
- `mansu-*`는 좋은 도구를 대체하지 않습니다. 좋은 도구들을 하나의 안전한 agentic coding 흐름으로 조합합니다.

## Status

active

## License

TBD
