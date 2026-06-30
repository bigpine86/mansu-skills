# Mansu AgenticDev

> AI 에이전트에게 소프트웨어 개발을 맡기기 위한 에이전틱 개발 스킬 모음

[English](./README.md) | 한국어

AI 에이전트가 소프트웨어를 자율적으로 개발하게 하려면 프롬프트만 잘 써서는 부족합니다.
어떤 스킬을 쓸지, 어디까지 맡길지, 결과를 어떻게 확인할지까지 정해져 있어야 합니다.

Mansu는 새로운 코딩 스킬을 개발하는 프로젝트가 아닙니다.
이미 검증된 스킬을 읽고 정리해서, 필요한 순간에 꺼내 쓸 수 있도록 엮는 프로젝트입니다.
초보자도 "무언가 만들고 싶다"는 생각에서 출발해 기획, 구현, QA, 릴리스, 학습 기록까지 증거를 남기며 갈 수 있게 하는 것이 목표입니다.

좋은 원천 스킬(source skill)이 늘어나면 Mansu도 함께 좋아집니다.
`mansu-9setup source-check`가 원천 생태계를 먼저 확인하고, 실제 변화가 확인되어 승인된 뒤에만 `mansu-source-curator`가 Mansu의 내부 지도를 고칩니다.
그래서 프로젝트 시작, 계획, 코딩, 디자인, QA, 디버그, 릴리스 방식은 계속 흡수하되 사용자가 원치 않는 변경은 하지 않습니다.

설치하고, `mansu-0help`라고 말하세요.
Mansu가 지금 상황에 맞는 길을 고르고, 마지막에는 증거가 남습니다.

## Mansu AgenticDev는 무엇인가

Mansu AgenticDev는 AI 에이전트와 함께 소프트웨어를 만들기 위한 개발 워크플로우입니다.

Mansu의 믿음은 단순합니다.

> 최고의 자동화는 모든 것을 직접 만드는 데서 오지 않습니다.
> 전 세계의 잘 만든 스킬을 읽고, 검증하고, 상황에 맞게 조합할 때 나옵니다.

Mansu는 초보자도 숙련된 개발자처럼 개발 흐름을 운영할 수 있게 돕습니다.

- 코딩 전에 프로젝트의 목적과 범위를 정합니다.
- 추측으로 시작하지 않고 실제 레퍼런스를 조사합니다.
- 현재 단계에 맞는 source skill을 고릅니다.
- 큰 작업을 vertical slice로 나눕니다.
- strict TDD는 효과가 있을 때만 씁니다.
- review, QA, 브라우저 검증, 보안, 성능, release gate로 결과를 확인합니다.
- `PLAN.md`, 개발일지, 문서, 검증 증거를 남깁니다.

원천 스킬이 이미 잘하는 일은 Mansu가 다시 만들지 않습니다.
대신 계획, 범위, 안전선, 검증, 원천 스킬 최신성, 완료 증거처럼 초보자와 에이전트가 자주 놓치는 지점을 고급 개발자들이 하는 것처럼 엄격히 가이드합니다.

## 빠른 시작

Last verified: 2026-05-16

Canonical branch: `main`

### 처음 설치

처음에는 주 진입점인 `mansu-9setup`과 호환 구현 폴더인 `mansu-setup`을 같이 복사합니다.
나머지 설치와 동기화는 `mansu-9setup`이 처리합니다.

`mansu-9setup`은 runtime target(Hermes, OpenCode, Codex, Claude Code), host, OS를 확인한 뒤 알맞은 skill directory를 고릅니다.
그다음 Mansu가 쓰는 외부 스킬과 도구를 준비하고, 현재 runtime에 맞게 연결합니다.

Mansu는 개발 단계를 혼자 새로 만들지 않고, 이미 검증된 외부 스킬을 단계별로 오케스트레이트합니다.

- 초기 아이디어와 프로젝트 정의는 Ouroboros의 Seed, Ledger, memory 흐름을 참고합니다.
- 전체 개발 프로세스는 Mansu의 Define -> Plan -> Build -> Verify -> Review -> Ship 흐름을 큰 지도로 삼습니다.
- `mansu-debug`는 정규 phase가 아니라 원인 불명 문제가 생겼을 때 어느 단계에서든 끼어드는 특수 route입니다.
- 리서치, 병렬 작업, TDD, 디버그 같은 실행 모드는 Oh My / OMO / OMC 계열 스킬을 참고합니다.
- CEO, 디자인, 엔지니어링, QA, 보안, 성능, 릴리스 판단은 gstack의 전문가 gate를 활용합니다.
- 디자인 산출물이 필요하면 Open Design과 VoltAgent/awesome-design-md를 참고 route로 삼습니다.
- 실제 구현은 Codex, Claude Code, OpenCode 같은 현재 coding agent가 맡고, Mansu는 계획과 검증 흐름을 잡습니다.

### 개발 프로세스

`Define -> Plan -> Build -> Verify -> Review -> Ship`

공개 lifecycle spine은 여섯 개의 독립된 numbered route로 고정합니다:
`mansu-1define -> mansu-2plan -> mansu-3build -> mansu-4verify -> mansu-5review -> mansu-6ship`.
`mansu-project-start` 같은 compatibility alias와 번호 없는 기존 이름은 이 공개 phase route를 대체하거나 합치거나 이름을 바꾸거나 숨기지 않습니다.

Define은 반드시 Ouroboros를 먼저 실행합니다. `mansu-1define`은 Ouroboros interview/PM/Seed 흐름으로 프로젝트 정의를 시작하고, Mansu가 자체 디자인 질문지를 만들지 않고 design intent seed만 남깁니다. 그 정의 안에서 UI, 사용자 화면, 사용자가 직접 보는 product surface가 드러나면 이어서 source skill 기반 디자인 문맥 인터뷰로 라우팅합니다. 기본 설치 route는 `gstack-design-consultation`이고, 여러 방향 비교가 필요할 때만 `gstack-design-shotgun`, 계획 비평이 필요할 때만 `gstack-plan-design-review`를 씁니다.
Codex에서는 `mcp__ouroboros.ouroboros_interview` MCP tool을 먼저 찾아서 씁니다.
필요하면 `mansu-9setup install` / `update` / `repair`가 backing `mansu-setup`을 통해
`ouroboros setup --runtime codex --mcp-mode auto --non-interactive`로 Codex MCP
연결을 준비합니다. Codex에서는 예전 `ooo interview` 명령이나 Claude adapter
명령이 필수 경로가 아닙니다.

Plan이 기능 우선순위와 디자인 산출물의 경계를 맡습니다. `mansu-2plan`은 Define의 handoff를 받아 기능 목록, MVP/later 구분, 우선순위 근거, `DESIGN.md`, design direction, implementation roadmap, 승인된 design artifact로 바꿉니다. Define은 의도, 증거, Plan으로 넘길 handoff만 기록합니다.
Plan 계층은 `Feature Priority / MVP Cut -> Project Phase Roadmap -> Phase Plan -> Slice`입니다. 우선순위가 MVP를 고르고, roadmap은 큰 phase와 exit criteria를 정하고, Phase Plan은 현재 phase 하나를 자세히 잡고, Slice는 Build가 실행하는 단위입니다.
Plan tier는 깊이를 정합니다. Quick Plan은 작고 위험 낮은 변경, Standard Plan은 일반 기능 작업, Heavy Plan은 새 앱이나 큰 기능군, 불명확한 아키텍처, 고위험 작업에 씁니다. Heavy Plan은 addyosmani planning/spec/API와 필요한 gstack critique를 조합합니다.
`mansu-2plan`은 대략적인 outline으로 완료되지 않습니다. 입력 근거, 기능 우선순위, 아키텍처/인터페이스 결정, 디자인/환경 계획, phase별 exit criteria, 현재 phase의 vertical slice와 검증 명령까지 있어야 Build로 넘깁니다.

| 단계 | 의미 | 설명 |
| --- | --- | --- |
| Define | 정의 | 무엇을 만들지 정하는 단계입니다. Ouroboros로 문제, 후보 기능, 범위, 우선순위 신호, 완료 기준을 먼저 정하고, UI/user-facing scope가 있으면 source skill 디자인 문맥 인터뷰와 design intent seed handoff를 남깁니다. |
| Plan | 계획 | 기능 우선순위와 MVP/later를 정한 뒤 Project Phase Roadmap, 현재 Phase Plan, Slice 순서를 만듭니다. Define handoff를 받아 `DESIGN.md`, design direction, 승인된 artifact, 구현 순서로 바꿉니다. |
| Build | 구현 | 계획한 내용을 실제로 만드는 단계입니다. 코드를 작성하고, 화면을 만들고, 데이터 저장이나 기능 동작을 구현합니다. |
| Verify | 검증 | 만든 기능이 의도한 대로 동작하는지 확인하는 단계입니다. 버튼, 입력값, 저장, 조회, 오류 상황 등을 직접 테스트합니다. 통과하면 기본적으로 Review로 이어집니다. |
| Review | 리뷰 | 결과물을 다시 점검하는 단계입니다. 코드가 너무 복잡하지 않은지, 빠진 요구사항은 없는지, 사용자가 불편할 부분은 없는지 확인합니다. |
| Ship | 배포 | 검증과 리뷰가 끝난 결과물을 실제 사용자가 쓸 수 있게 내보내는 단계입니다. 운영 환경에 반영하거나 릴리즈하고, 필요하면 사용 안내를 함께 제공합니다. |

```bash
git clone https://github.com/bigpine86/mansu-skills.git
cd mansu-skills

# 예시: Hermes + tmux + OpenCode runtime에서 OpenCode global skill path 사용
mkdir -p "$HOME/.config/opencode/skills/mansu-setup"
mkdir -p "$HOME/.config/opencode/skills/mansu-9setup"
cp -R mansu-setup/. "$HOME/.config/opencode/skills/mansu-setup"/
cp -R mansu-9setup/. "$HOME/.config/opencode/skills/mansu-9setup"/
```

Claude Code, Codex, OpenCode 어느 쪽이든 `mansu-9setup`으로 같은 방식의 설치와 동기화를 적용할 수 있습니다.

그다음 사용하는 agent runtime에 이렇게 요청합니다.

```text
Use $mansu-9setup install from this repo. Detect my runtime target, host, and OS, install/update Ouroboros, gstack, and the matching Oh My adapter when needed, then choose paths and run compatibility checks.
```

### 설치 후

먼저 이것만 실행하면 됩니다.

```text
mansu-0help
```

Mansu는 현재 개발 진행 상태를 보고 다음에 필요한 작업을 자율적으로 오케스트레이트합니다.

- `mansu-9setup`: 설치, 업데이트, runtime setup
- `mansu-1define`: 새 제품, 앱, 레포, 큰 기능군의 목적/후보 기능/우선순위 신호/요구사항/성공 기준 정의. Ouroboros를 먼저 실행하고, UI/user-facing scope가 있으면 Plan 전에 source skill 디자인 문맥 인터뷰로 라우팅
- `mansu-2plan`: Requirements/Spec, Feature Priority / MVP Cut, Project Phase Roadmap, Phase Plan, Slice, Architecture, `DESIGN.md`, Design Direction, Design Artifacts
- `mansu-3build`: `mansu-tdd-total`을 통한 기능 구현과 리팩토링
- `mansu-4verify`: BDD-style Given/When/Then, runtime/browser 확인, QA evidence
- `mansu-5review`: 품질, 구조, 디자인, 보안, decision risk 검토
- `mansu-debug`: 원인 불명 버그와 회귀 분석
- `mansu-6ship`: release readiness 판단

업데이트 전에는 먼저 읽기 전용으로 확인합니다.

```text
Use $mansu-9setup source-check. Ouroboros, gstack, Oh My / OMO / OMC, addyosmani/agent-skills, VoltAgent/awesome-design-md, Open Design이 Mansu 라우팅과 아직 맞는지 확인해줘. 설치, 업데이트, sync, 파일 수정은 하지 말고 Green/Yellow/Red 상태와 승인 필요한 다음 행동만 알려줘.
```

업데이트하기로 결정했다면 이렇게 요청합니다.

```text
Use $mansu-9setup update. Update Mansu, install/update Ouroboros, gstack, and the matching Oh My adapter when needed and approved, prepare Open Design only when UI/design artifact work needs it or I explicitly approve it, sync Mansu skills, check Ouroboros, gstack, Oh My / OMO / OMC, addyosmani/agent-skills, VoltAgent/awesome-design-md, and Open Design source freshness, and report adapter compatibility with any blocked install steps.
```

### 에이전트에게 줄 기본 지시

```text
If Mansu is not installed or may be stale, run mansu-9setup first.
Read MANSU_PHILOSOPHY.md first.
Then choose the correct mansu-* skill for the task.
Do not invent a new workflow before checking the source skill map.
```

## 왜 필요한가

AI 코딩은 점점 빨라지고 있습니다.
하지만 코드가 빨리 만들어진다고 해서 좋은 소프트웨어가 자동으로 나오지는 않습니다.
계획, 아키텍처, 범위, 리스크, 품질을 판단하는 속도가 따라오지 못하면 프로젝트는 쉽게 흔들립니다.
소프트웨어를 장기적으로 운영하고 유지보수할 수 있게 강건하게 만들려면 기획, 설계, 구현, 테스트, 디버그, 보안, 성능, 릴리스까지 여러 코딩 기술이 함께 필요합니다.

에이전트와 개발을 잘 굴리는 방법은 이미 여러 곳에 흩어져 있습니다.
- `addyosmani/agent-skills`: define, plan, build, verify, review, ship 개발 프로세스
- Ouroboros: 초기 프로젝트 정의, memory, Seed, Ledger, 장기 방향
- Oh My / OMO / OMC: research, ultrawork, ralph, TDD, debug 같은 실행 모드
- gstack: CEO, design, engineering, QA, security, performance, ship, deploy, learn 같은 전문가 역할과 gate
- Open Design: 설치 또는 승인된 경우 agent-native design artifact workflow
- VoltAgent/awesome-design-md: `DESIGN.md`와 design handoff의 참고 구조

Mansu는 이들을 대체하지 않습니다.
대신 지금 무엇을 써야 하는지 고르고, 각 도구의 산출물을 이어 붙이고, 끝까지 검증하게 만듭니다.

Mansu가 직접 책임지는 일은 다음과 같습니다.

- 계획
- 안전선
- 역할 분리
- 라우팅
- 검증
- 체크포인트
- 개발일지와 학습 기록
- 최종 책임

전문적인 실행은 가능한 한 더 잘 맞는 source skill에 맡깁니다.
source skill 목록은 `mansu-operating-model/references/SOURCE_SKILL_CATALOG.md`에서 관리합니다.
비슷한 source skill을 어떻게 조합할지는 `mansu-operating-model/references/SOURCE_SKILL_COMPOSITION.md`에서 관리합니다.
`mansu-9setup`은 backing `mansu-setup`을 통해 Ouroboros, gstack, Oh My / OMO / OMC, addyosmani/agent-skills, VoltAgent/awesome-design-md, Open Design이 여전히 최신 흐름과 맞는지도 계속 확인합니다.

Mansu가 좋아지는 방식은 단순합니다.

- 좋은 source skill을 찾습니다.
- 그 스킬의 철학, gate, 산출물을 읽습니다.
- 어설프게 복제하지 않고 가장 잘 맞는 source로 라우팅합니다.
- `mansu-*` 안에는 꼭 필요한 guardrail만 남깁니다.
- 더 좋은 스킬과 새로운 패턴이 나오면 source map을 갱신합니다.

전체 개발 흐름은 Mansu의 Define -> Plan -> Build -> Verify -> Review -> Ship phase를 큰 지도로 삼습니다.
`mansu-debug`는 정규 phase가 아니라 원인 불명 문제를 다루는 interrupt route입니다.
다만 Mansu는 이 순서를 기계적으로 따르지 않습니다. 현재 단계와 위험도에 맞춰 필요한 source skill을 고르고, 실제 코딩 순서를 오케스트레이트합니다.
`mansu-operating-model/references/CODE_CONSTRUCTION_ORDER.md`가 현재 개발 phase를 판단하고,
필요한 addyosmani/agent-skills phase skill과 gstack, Oh My, Ouroboros 보조 route로 연결합니다.

디자인 작업에서는 Open Design이 설치되어 있거나 사용 승인이 있으면 Open Design을 design artifact 생성 route로 우선 고려합니다.
Mansu가 Open Design CLI/lifecycle 명령을 직접 실행하고 산출물 증거를 기록합니다.
그다음 VoltAgent/awesome-design-md를 `DESIGN.md` 참고 원천으로 삼아 프로젝트 고유의 분위기, 토큰, 컴포넌트, 반응형 규칙을 뽑고 gstack 디자인/QA gate로 검증합니다.

LazyCodex는 Codex에서 OMO 실행 패턴을 쓸 때 확인하는 경로입니다. Mansu의 source skill family나 Define -> Plan -> Build -> Verify -> Review -> Ship 라우팅을 대체하지 않습니다.

## 큰 그림

Mansu는 하나의 만능 스킬이 아니라 프로젝트 운영 레이어입니다.

```text
Lifecycle phase spine
= addyosmani/agent-skills, or a source route verified by mansu-source-curator: Define -> Plan -> Build -> Verify -> Review -> Ship

Project definition / memory source
= Ouroboros, or a source route verified by mansu-source-curator: purpose, Seed, Ledger, spec, long-horizon direction

Design reference source
= VoltAgent/awesome-design-md, or a design reference verified by mansu-source-curator: DESIGN.md structure, visual atmosphere, tokens, components, responsive behavior

Design workflow source
= Open Design / nexu-io/open-design, or a source route verified by mansu-source-curator: Turn-1 discovery, visual direction picker, artifact-first rendering, preview/export, anti-AI-slop critique

Mansu
= orchestrator, judge, router, doctrine, gates, final accountability

Execution-mode source
= Oh My / OMO / OMC, or a source route verified by mansu-source-curator: research, ultrawork, ralph, tdd, debug inside a phase

Specialist team source
= gstack, or a source route verified by mansu-source-curator: CEO, design, eng, QA, CSO, benchmark, ship

Implementation actor
= Codex or the active coding agent: edits files, runs tests, integrates, commits
```

위 이름들은 대표 route이지 고정 의존성이 아닙니다.
다만 다른 source route를 쓰려면 `mansu-source-curator`가 실제 원천, 버전, 역할, 산출물을 확인하고 `SOURCE_SKILL_LOCK.json`과 `SOURCE_SKILL_CATALOG.md`에 기록해야 합니다. 그래야 Mansu routing의 근거로 쓸 수 있습니다.

Mansu의 canonical doctrine은 `mansu-operating-model`이 맡습니다.
프로젝트별 `AGENTS.md`는 그 doctrine으로 에이전트를 안내하는 계약 문서입니다.
프로젝트별 `CODING_RULES.md`는 실제 runtime, 검증, ship 기준을 적는 로컬 운영 매뉴얼입니다.

프로젝트 로드맵과 phase order는 spec, TDR, design 문서에 둡니다.
큰 기능 순서를 먼저 정하고, 그다음 현재 phase의 `PLAN.md`를 만듭니다.
`PLAN.md`는 현재 phase의 active execution plan입니다.

## 핵심 철학

좋은 Mansu skill은 얇게 둘 곳은 얇게 두고, 엄격해야 할 곳은 엄격하게 잡습니다.

- 얇게 둘 것: source별 세부 사용법, 긴 체크리스트, 전문 실행 루틴
- 엄격하게 잡을 것: 계획, 안전선, scope boundary, 증거, 검증, 완료 조건

중요한 작업에서 Mansu planning은 multi-role critique loop로 진행됩니다.
Planner가 계획을 만들고, Critics가 비평하고, Synthesizer가 실행 가능한 하나의 계획으로 합칩니다.
그 뒤 explicit approval gate, 위험한 행동, unresolved blocker가 없다면 slice는 자동으로 진행됩니다.

실제 critic agent를 시작했다면 그 피드백은 선택 사항이 아닙니다.
끝까지 기다리거나, timeout/failure를 기록해야 합니다. 위험도가 높은 질문은 blocker로 남깁니다.

Slice는 기본적으로 순차 진행입니다.
slice N+1은 slice N이 validation, review, QA, checkpoint, log, commit 또는 no-commit 기록까지 닫힌 뒤 시작합니다.

자세한 기준은 [MANSU_PHILOSOPHY.md](./MANSU_PHILOSOPHY.md)에 있습니다.

## Skills

| Skill | 언제 쓰나 | 핵심 |
| --- | --- | --- |
| `mansu-0help` | 초보자이거나 지금 무엇을 해야 할지 모를 때 | 다음 route 추천 |
| `mansu-0manual` | HTML 매뉴얼을 보고 싶을 때 | 시각 매뉴얼 |
| `mansu-1define` | 새 제품, 앱, 레포, 큰 기능군의 목적, 사용자, 문제, 후보 기능, 우선순위 신호, 요구사항, 성공 기준, source of truth를 잡을 때 | Define phase |
| `mansu-2plan` | Requirements/Spec, Feature Priority / MVP Cut, Project Phase Roadmap, 현재 Phase Plan, Slice, Architecture, Design Direction이 필요할 때. 위험도에 따라 Quick Plan, Standard Plan, Heavy Plan 깊이를 고릅니다. | Plan phase |
| `mansu-3build` | 기능/리팩토링을 `mansu-tdd-total` slice로 구현할 때 | Build phase |
| `mansu-4verify` | 테스트, runtime/browser 확인, QA evidence, BDD-style Given/When/Then 증거, 보안/성능 증명이 필요할 때. 통과하면 기본적으로 `mansu-5review`로 이어집니다. | Verify phase |
| `mansu-5review` | 품질, 유지보수성, 구조, 디자인, 보안, decision risk를 검토할 때 | Review phase |
| `mansu-6ship` | ship/hold 판단, PR, release docs, deploy/canary, learning closeout이 필요할 때 | Ship phase |
| `mansu-9setup` | 설치, 읽기 전용 source health check, 업데이트, runtime 감지, source tool setup, skill sync, repair, adapter compatibility가 필요할 때 | bootstrap/check/update gate |
| `mansu-source-curator` | drift가 확인되어 Mansu reference, validator, manual, worklog를 갱신해야 할 때 | 내부 source-reference maintenance |
| `mansu-operating-model` | 프로젝트 행동양식, role separation, evidence rule, `AGENTS.md`, `CODING_RULES.md`를 정할 때 | canonical doctrine |
| `mansu-debug` | 버그를 재현, 격리, 원인 증명, 최소 수정, 회귀 검증할 때 | Debug route |
| `mansu-tdd-total` | `mansu-build` 아래의 기본 구현 엔진. active phase 증거가 없으면 `mansu-1define` / `mansu-2plan`으로 되돌립니다. | build engine |
| `mansu-tdd-strict` | 위험한 slice에 의미 있는 RED test가 필요할 때 | strict TDD loop |
| `mansu-tdd-lite` | 계획, review, QA, checkpoint는 필요하지만 RED test가 억지스러울 때 | relaxed RED, not quality |
| `mansu-debug-rootcause` | `mansu-debug` 아래의 compatibility route | root-cause debugger |
| `mansu-web-verify` | `mansu-verify` 아래의 실제 사용자 관점 웹 검증 route | web verification |
| `mansu-ship-release` | `mansu-ship` 아래의 release readiness route | release readiness |
| `mansu-help` / `mansu-define` / `mansu-plan` / `mansu-build` / `mansu-verify` / `mansu-review` / `mansu-ship` / `mansu-setup` / `mansu-manual` | 번호 없는 기존 이름 | compatibility alias |

Compatibility/admin surfaces:

- `mansu-setting`은 `mansu-setup`으로 넘기는 순수 legacy alias입니다. 공개 setup 안내에서는 `mansu-9setup`을 사용합니다.
- `mansu-project-start`는 legacy 또는 specialized Zero-to-PLAN kickoff 요청을 위해 남깁니다. 공개 lifecycle 안내에서는 `mansu-1define`, 그다음 `mansu-2plan`을 사용합니다.

## 상황별 선택

- 새롭거나 헷갈릴 때: `mansu-0help`
- 시각 매뉴얼: `mansu-0manual` 또는 [docs/mansu-manual.html](./docs/mansu-manual.html)
- 설치, 읽기 전용 source health check, 업데이트, runtime 감지, skill sync, adapter compatibility: `mansu-9setup`
- drift 확인 후 내부 source catalog/manual/validator를 유지보수할 때: `mansu-source-curator`
- 새 프로젝트 또는 큰 기능군: `mansu-1define`, 그다음 `mansu-2plan`. UI/user-facing scope는 Ouroboros 정의 뒤 디자인 문맥 인터뷰를 거치고, Plan이 design intent seed를 `DESIGN.md` / design direction / artifact로 바꿉니다
- project doctrine, `AGENTS.md`, `CODING_RULES.md`: `mansu-operating-model`
- 기능/리팩토링 구현: `mansu-3build`
- 동작 증명, BDD-style Given/When/Then QA, browser/runtime 검증, 그다음 기본 review handoff: `mansu-4verify`
- 품질, 구조, 디자인, 보안, decision-risk review: `mansu-5review`
- 위험하고 RED test가 유용한 slice: `mansu-tdd-strict`
- RED가 억지스러운 낮은 위험 slice: `mansu-tdd-lite`
- 버그, 회귀, stack trace, "왜 깨졌지?": `mansu-debug`
- ship-ready, PR, release docs, deploy/canary, learning closeout: `mansu-6ship`

## 신뢰와 검증

Mansu를 처음 쓴다고 해서 이 섹션을 꼭 실행할 필요는 없습니다.
repo 구조를 확인하거나, 스킬을 수정하기 전에 검증하고 싶을 때 쓰면 됩니다.

```bash
scripts/validate_mansu_skills.sh
MANSU_COMPARE_INSTALLED=1 scripts/validate_mansu_installed_copies.sh /Users/hansol/.codex/skills
```

기대 결과: 모든 Mansu 구조 validator가 통과합니다.
이 suite는 skill frontmatter, manual/catalog 일관성, source-lock reference, runtime-readiness 문구, TDD/debug/web/ship workflow, installed-copy validation hook을 확인합니다.
두 번째 명령은 현재 Codex 전역 설치본까지 비교합니다. nested reference file도 비교하고, 더 이상 소스에 없는 `mansu-*` 스킬이 설치본에 남아 있으면 실패합니다.

세부 검증은 [scripts](./scripts)에 있습니다.
예를 들면 `scripts/validate_mansu_help.sh`, `scripts/validate_mansu_manual.sh`,
`scripts/validate_mansu_operating_model.sh`, `scripts/validate_mansu_installed_copies.sh`가 있습니다.

## Repo Map

- [README.md](./README.md): 영어 README
- [MANSU_PHILOSOPHY.md](./MANSU_PHILOSOPHY.md): Mansu 공통 철학
- [mansu-operating-model](./mansu-operating-model/SKILL.md): canonical doctrine + `AGENTS.md` / `CODING_RULES.md` templates
- [SOURCE_SKILL_CATALOG.md](./mansu-operating-model/references/SOURCE_SKILL_CATALOG.md): source skill map과 조합법
- [SOURCE_SKILL_COMPOSITION.md](./mansu-operating-model/references/SOURCE_SKILL_COMPOSITION.md): 비슷한 source skill 비교와 조합 route
- [SOURCE_SKILL_LOCK.json](./mansu-operating-model/references/SOURCE_SKILL_LOCK.json): source-family freshness snapshot과 evidence
- [DOCUMENT_CREATION_ORDER.md](./mansu-operating-model/references/DOCUMENT_CREATION_ORDER.md): 문서 생성 router
- [CODE_CONSTRUCTION_ORDER.md](./mansu-operating-model/references/CODE_CONSTRUCTION_ORDER.md): 현재 phase 감지와 coding-order source skill 라우팅
- [PLAN.md](./PLAN.md): 현재 phase의 active execution plan. 전체 프로젝트 로드맵과 큰 기능 순서는 spec/TDR/design 문서에 둡니다.
- [개발일지.md](./개발일지.md): 시간순 작업 기록
- [mansu-0help](./mansu-0help/SKILL.md): 번호가 붙은 주 route helper
- [mansu-9setup](./mansu-9setup/SKILL.md): 번호가 붙은 주 설치/업데이트/복구 진입점
- [mansu-0manual](./mansu-0manual/SKILL.md): 번호가 붙은 주 정적 HTML 매뉴얼 안내
- [mansu-source-curator](./mansu-source-curator/SKILL.md): 내부 source-reference 유지보수
- [mansu-1define](./mansu-1define/SKILL.md): 번호가 붙은 주 Define phase
- [mansu-2plan](./mansu-2plan/SKILL.md): 번호가 붙은 주 Plan phase
- [mansu-3build](./mansu-3build/SKILL.md): 번호가 붙은 주 Build phase와 `mansu-tdd-total` dispatcher
- [mansu-4verify](./mansu-4verify/SKILL.md): 번호가 붙은 주 Verify phase
- [mansu-5review](./mansu-5review/SKILL.md): 번호가 붙은 주 Review phase
- [mansu-debug](./mansu-debug/SKILL.md): 특수 root-cause route
- [mansu-6ship](./mansu-6ship/SKILL.md): 번호가 붙은 주 Ship phase
- [mansu-help](./mansu-help/SKILL.md), [mansu-setup](./mansu-setup/SKILL.md), [mansu-define](./mansu-define/SKILL.md), [mansu-plan](./mansu-plan/SKILL.md), [mansu-build](./mansu-build/SKILL.md), [mansu-verify](./mansu-verify/SKILL.md), [mansu-review](./mansu-review/SKILL.md), [mansu-ship](./mansu-ship/SKILL.md), [mansu-manual](./mansu-manual/SKILL.md): compatibility implementation path
- [mansu-setting](./mansu-setting/SKILL.md): `mansu-setup`으로 넘기는 pure compatibility alias
- [mansu-project-start](./mansu-project-start/SKILL.md): legacy kickoff용 compatibility-only alias. 공개 lifecycle 안내에서는 `mansu-1define` 사용
- [mansu-tdd-total](./mansu-tdd-total/SKILL.md): `mansu-build`가 쓰는 구현 엔진
- [mansu-tdd-strict](./mansu-tdd-strict/SKILL.md): strict TDD 실행
- [mansu-tdd-lite](./mansu-tdd-lite/SKILL.md): lite 실행
- [mansu-debug-rootcause](./mansu-debug-rootcause/SKILL.md): root-cause 디버그
- [mansu-web-verify](./mansu-web-verify/SKILL.md): 웹 검증 오케스트레이터
- [mansu-ship-release](./mansu-ship-release/SKILL.md): release readiness와 ship/hold 판단
- [mansu-manual.html](./docs/mansu-manual.html): 시각 매뉴얼
- [scripts](./scripts): 구조 검증 스크립트

## 사용 기준

- Mansu는 기획, source skill 라우팅, 구현 규율, 검증이 함께 필요한 작업에 가장 잘 맞습니다.
- 작은 오탈자나 단순 수정은 바로 고치면 됩니다.
- 제품, 아키텍처, UI, 디버그, 출하 작업에서는 상황에 맞는 Mansu route를 쓰면 좋습니다.
- 중요한 작업 전에 로컬 스킬이 오래됐다고 느껴지면 `mansu-9setup`으로 먼저 정리합니다.
- `mansu-*`는 좋은 도구를 대체하지 않습니다. 좋은 도구들을 하나의 안전한 agentic software development 흐름으로 조합합니다.

## Status

active

## License

TBD
