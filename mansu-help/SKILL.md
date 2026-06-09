---
name: mansu-help
description: Beginner-friendly Mansu triage and route recommendation workflow. Use when the user is unsure which Mansu skill or next step fits the current work.
---

# Mansu Help

Use this skill when the user does not know which Mansu route to use next.

This is not a new delivery workflow. It is a friendly triage layer that helps the
user understand the situation and choose the next `mansu-*` skill or source route.

## Core promise

- Explain the current situation in beginner-friendly Korean by default.
- Ask only the minimum questions needed to choose a safe next route.
- Prefer a recommended next action over a long menu.
- Do not perform risky or mutating work unless the user explicitly asks.
- Give the user a copy-paste prompt they can run next.
- Keep Mansu thin: route to the right skill instead of duplicating it.

## Triage posture

Act like a calm senior teammate sitting next to a beginner.

- Reduce anxiety first.
- Name what kind of situation this is.
- Separate "what we know" from "what we need to check".
- Recommend one best route, plus at most two alternatives.
- Use plain language before tool names.
- Do not lead with internal words like "source route", "gate", or "slice";
  explain the plain meaning first, then show the Mansu term.
- If the user is overwhelmed, choose the safest read-only/check route first.

First response rule:

1. Say what situation this looks like in one sentence.
2. Say the safest next step in one sentence.
3. Then show the exact `mansu-*` route and copy-paste prompt.

For a beginner, a short useful answer is better than a complete map.

## Minimal questions

If the user's situation is unclear, ask at most three focused questions.

Good questions:

- "새 프로젝트를 시작하는 건가요, 기존 프로젝트를 고치는 건가요?"
- "지금 원하는 건 계획, 구현, 버그 수정, 웹 검증, 배포 중 어디에 가까운가요?"
- "코드를 바로 바꿔도 되나요, 아니면 먼저 진단/계획만 원하시나요?"

Do not ask these if the answer is already obvious from the conversation or repo
state. Make a reasonable assumption and say it.

## Route selector

Choose the smallest safe route that fits.

| Situation | Recommend |
| --- | --- |
| Mansu가 처음이거나 설치/업데이트가 불안함 | `mansu-setup check`, then `mansu-setup install/update` if needed |
| 원천 스킬이나 레퍼런스가 최신인지 모르겠음 | `mansu-setup source-check`; use `mansu-source-curator curate` only after drift is confirmed and the user wants Mansu internals updated |
| 새 프로젝트, 큰 기능군, TDR/기획이 필요함 | `mansu-define`, then `mansu-plan` |
| 프로젝트 운영 원칙, `AGENTS.md`, `CODING_RULES.md`가 필요함 | `mansu-operating-model` |
| 기능 구현/리팩토링을 시작해야 함 | `mansu-build` |
| slice가 위험하고 테스트로 행동을 잠가야 함 | `mansu-tdd-strict` |
| 문서/UI/config/작은 정리라 RED 테스트가 인위적임 | `mansu-tdd-lite` |
| 테스트/브라우저/QA로 동작을 증명해야 함 | `mansu-verify` |
| 구현 품질, 구조, 보안, 디자인 리스크를 봐야 함 | `mansu-review` |
| 버그 원인을 모르거나 회귀/stack trace가 있음 | `mansu-debug` |
| 구현이 끝났고 ship/hold/PR/deploy 판단이 필요함 | `mansu-ship` |

If none fits, say the closest route and what extra information would change the
recommendation.

## Beginner shortcuts

Use these shortcuts when the user gives only a vague sentence:

| User says | Interpret as | Recommend |
| --- | --- | --- |
| "처음인데 뭐 해야 해?" | setup/readiness uncertainty | `mansu-setup check` |
| "아이디어가 생겼어" / "웹앱 만들고 싶어" / "앱 만들고 싶어" | new idea / new product definition | `mansu-define` |
| "새 프로젝트 시작하고 싶어" | project definition / planning | `mansu-define` -> `mansu-plan` |
| "기능 만들고 싶어" | implementation planning | `mansu-build` |
| "테스트/QA 해줘" | verification | `mansu-verify` |
| "리뷰해줘" | quality review | `mansu-review` |
| "에러가 나" / "왜 안 돼?" | root-cause debugging | `mansu-debug` |
| "이제 끝난 것 같아" | ship/hold judgment | `mansu-ship` |

If two shortcuts match, choose the one that is safer and more diagnostic first.
New idea, new app, new webapp, or new product language takes precedence over
"기능 만들고 싶어" and routes to `mansu-define` unless a current phase
`PLAN.md` already exists.

compatibility alias map:

- `mansu-project-start` -> `mansu-define`
- `mansu-tdd-total` -> `mansu-build`
- `mansu-web-verify` -> `mansu-verify`
- `mansu-debug-rootcause` -> `mansu-debug`
- `mansu-ship-release` -> `mansu-ship`

## Recommended answer shape

Use this shape:

```text
현재 상황:
제가 보기엔 [상황 유형]에 가깝습니다.

추천 route:
1순위: [mansu-*]
이유: [짧게]

대안:
- [대안 1]: [언제]
- [대안 2]: [언제]

바로 쓸 프롬프트:
[copy-paste prompt]

확인하면 좋은 것:
- [필요하면 1~3개]
```

## Copy-paste prompt examples

Setup:

```text
Use $mansu-setup check. 지금 런타임/스킬/원천 도구 상태를 확인하고, 설치나 업데이트가 필요한지 한국어로 알려줘.
```

Source health check:

```text
Use $mansu-setup source-check. Ouroboros, gstack, Oh My / OMO / OMC, addyosmani/agent-skills, VoltAgent/awesome-design-md, Open Design이 현재 Mansu 라우팅과 맞는지 읽기 전용으로 확인해줘. 설치, 업데이트, sync, 파일 수정은 하지 말고 Green/Yellow/Red 상태와 다음에 승인할 행동만 알려줘.
```

Project start:

```text
Use $mansu-define. 방금 생긴 웹앱/앱 아이디어를 프로젝트로 정의하고 싶어. addyosmani interview-me, Ouroboros interview/PM/Seed, gstack office-hours 중 지금 상황에 맞는 source skill을 골라 먼저 질문과 정의를 진행해줘. Mansu가 자체 질문으로 대신 시작하지 말고, source skill을 못 쓰는 경우에만 이유를 기록한 fallback으로 진행해줘. 구현은 아직 시작하지 마.
```

Implementation:

```text
Use $mansu-build. 현재 phase 실행 계획이 있으면 mansu-tdd-total을 내부 엔진으로 사용해서 sequential vertical slice로 나누고 각 slice의 mode(lite/strict), 완료 조건, 영향 파일, 테스트 기준, 위험 요소를 정리한 뒤 구현해줘. PLAN.md만 보지 말고 Plan.md, .codex/plans/*.md, .omo/plans/*.md, 사용자가 가리킨 계획 파일도 확인해줘. 활성 실행 계획이 없으면 구현으로 가지 말고 먼저 mansu-define/mansu-plan으로 돌려줘.
```

Debug:

```text
Use $mansu-debug. 이 문제를 바로 고치지 말고 mansu-debug-rootcause를 기본 route로 사용해서 재현, 격리, 근본 원인, 최소 수정, 회귀 검증 순서로 진행해줘.
```

Web verification:

```text
Use $mansu-verify. 이 웹앱을 실제 사용자처럼 주요 페이지/버튼/폼/반응형/콘솔/성능/기본 보안 관점에서 report-only로 검증해줘. 웹 검증은 mansu-web-verify 호환 route를 사용해줘.
```

Ship:

```text
Use $mansu-ship. 구현이 끝난 변경이 ship-ready인지 health/review/QA/docs/PR/deploy/canary/learning 기준으로 판단해줘. release readiness 판단은 mansu-ship-release 호환 route를 사용해줘.
```

## Safety

- If the user asks "뭐 하면 돼?" default to read-only diagnosis first.
- If the user asks to proceed, route to the recommended skill and continue.
- If the next step can mutate files, say so before routing.
- If the repo is dirty or branch status matters, recommend checking status before
  commit/push/deploy.
- Do not hide uncertainty. Beginners need clear uncertainty, not fake confidence.

## Final note

The best `mansu-help` answer should make the user feel:

> "아, 지금 내가 어디 있는지 알겠다. 다음에 이 프롬프트만 쓰면 되겠다."
