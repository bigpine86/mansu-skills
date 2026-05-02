# mansu-skills

AI 코딩이 빨라질수록, 좋은 스킬을 고르는 일보다 `어떻게 조합하고 끝까지 검증할지`가 더 중요해집니다.
Mansu는 좋은 Oh My, gstack, 공개 스킬을 해부하고, 필요한 순간에 정확히 라우팅하는 개인 작업 운영체계입니다.
Install the skills. Pick the right Mansu route. Finish with evidence.

## Quick Start
Last verified: 2026-05-02

Canonical branch: `main`

### For Humans

처음 설치할 때는 `mansu-start`만 먼저 부트스트랩한 뒤, 그 스킬로 전체 설치를 맡깁니다.
Codex가 아닌 OpenCode나 Claude Code에서도 `mansu-start`가 host와 OS를 먼저 감지해
맞는 skill directory와 Oh My adapter를 고르게 합니다.

```bash
git clone https://github.com/bigpine86/mansu-skills.git
cd mansu-skills

# Codex example. Other hosts should copy mansu-start into that host's skill directory.
mkdir -p "$HOME/.codex/skills/mansu-start"
cp -R mansu-start/. "$HOME/.codex/skills/mansu-start"/
```

그 다음 Codex에서:

```text
Use $mansu-start install from this repo. Detect my host and OS before choosing paths.
```

업데이트할 때는:

```text
Use $mansu-start update. Check Mansu, gstack, and the matching Oh My adapter, then sync local skills.
```

### For Agents

```text
If Mansu is not installed or may be stale, run mansu-start first.
Read MANSU_PHILOSOPHY.md first.
Then choose the correct mansu-* skill for the task.
Do not invent a new workflow before checking the source skill map.
```

## Why This Exists

Mansu는 모든 것을 직접 발명하지 않습니다.
이미 잘 만든 스킬과 도구를 먼저 읽고, 그 안에 담긴 철학과 게이트를 존중합니다.

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
| `mansu-start` | Mansu를 처음 설치하거나, host/OS별 skill directory와 Oh My adapter를 고르고 gstack/Oh My/Mansu 스킬을 업데이트/복구할 때 | host-aware bootstrap and update gate |
| `mansu-tdd-total` | 기능/리팩토링 작업을 먼저 계획하고 slice별로 `lite`/`strict`를 나눌 때 | planning dispatcher |
| `mansu-tdd-strict` | RED 테스트가 의미 있고 위험도가 높은 slice를 엄격한 TDD로 진행할 때 | strict TDD slice loop |
| `mansu-tdd-lite` | 계획, slice, review, QA, checkpoint는 유지하되 RED 테스트를 강제하지 않을 때 | relaxed RED, not relaxed quality |
| `mansu-debug-rootcause` | 원인 모를 버그를 재현, 격리, 원인 증명, 최소 수정, 회귀 검증할 때 | root-cause-first debugger |
| `mansu-web-verify` | 웹앱을 실제 사용자처럼 눌러보고 기능/안정성/성능/반응형/기본 보안을 검증할 때 | web verification orchestrator |

## Recommended Routing

- 처음 설치, 업데이트, 스킬 동기화, gstack/Oh My adapter 상태 확인:
  `mansu-start`
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

## Source Skill Policy

새 `mansu-*` 스킬을 만들거나 확장하기 전에:

1. 관련 Oh My, gstack, 공개 source skill을 먼저 찾습니다.
2. 그 스킬의 목적, 게이트, 철학을 읽습니다.
3. Mansu가 맡을 경계와 source skill에 맡길 경계를 나눕니다.
4. 모든 작업에 필요한 필수 게이트만 Mansu 스킬에 짧게 내장합니다.
5. 깊은 실행은 source skill map으로 라우팅합니다.
6. 검증 결과와 배운 점을 `개발일지.md`에 남깁니다.

## Branch Policy

- `main` is the canonical branch.
- `codex/*` branches are temporary work branches.
- Finished skill changes should land on `main` before being treated as installed or shared.
- If local installed skills in `$HOME/.codex/skills` drift from this repo, sync from `main` first.

## Validation

```bash
scripts/validate_mansu_skills.sh
```

개별 검증:

```bash
scripts/validate_mansu_start.sh
scripts/validate_mansu_tdd_series.sh
scripts/validate_mansu_debug_rootcause.sh
scripts/validate_mansu_web_verify.sh
```

## Repo Map

- [MANSU_PHILOSOPHY.md](./MANSU_PHILOSOPHY.md): Mansu 공통 철학
- [PLAN.md](./PLAN.md): 현재 follow-up과 다음 작업
- [개발일지.md](./개발일지.md): 시간순 작업 기록
- [mansu-start](./mansu-start/SKILL.md): 설치/업데이트/복구 진입점
- [mansu-tdd-total](./mansu-tdd-total/SKILL.md): TDD 시리즈 진입점
- [mansu-tdd-strict](./mansu-tdd-strict/SKILL.md): strict TDD 실행
- [mansu-tdd-lite](./mansu-tdd-lite/SKILL.md): lite 실행
- [mansu-debug-rootcause](./mansu-debug-rootcause/SKILL.md): root-cause 디버그
- [mansu-web-verify](./mansu-web-verify/SKILL.md): 웹 검증 오케스트레이터
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
