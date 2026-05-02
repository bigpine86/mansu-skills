# Runtime Target Matrix

이 문서는 Mansu를 현재 런타임에 설치/동기화할 때 어떤 skill target과 fallback을 써야 하는지 정리한 운영 기준입니다.

## 목적
- `mansu-start`가 어떤 runtime/host를 먼저 식별해야 하는지 명확히 한다.
- adapter(`omx`/`omo`/`omc`)를 필수 기반이 아니라 optional compatibility tooling으로 다룬다.
- skill install/update 시 잘못된 경로 추측을 줄인다.

## Matrix

| Runtime target | Host clue | Primary skill target | Adapter expectation | Fallback behavior |
| --- | --- | --- | --- | --- |
| Hermes | `hermes`, `.hermes`, tmux + OpenCode session | host-detected Hermes/OpenCode-style skill dir | `omo` optional | Mansu + gstack checks 계속 진행, adapter는 skipped/missing으로 보고 |
| OpenCode | `opencode`, `.opencode` | host-detected OpenCode skill dir | `omo` optional | skill sync 우선, adapter 상태는 별도 보고 |
| Codex | `codex`, `.codex` | `$HOME/.codex/skills` | `omx` optional | adapter가 없어도 install/update는 계속, adapter 작업만 별도 후속 |
| Claude Code | `claude`, `.claude` | `$HOME/.claude/skills` when present | `omc` optional | layout가 불명확하면 `check` 모드로 멈추고 manual target 보고 |
| Unknown | weak or conflicting signals | do not write automatically | none | `check` 모드로 전환, candidate path와 근거만 보고 |

## 운영 규칙
1. runtime target을 먼저 고르고, adapter는 그 다음에 본다.
2. adapter 부재는 기본적으로 warning이지 install failure가 아니다.
3. skill target confidence가 낮으면 쓰지 말고 `check` 모드로 보고한다.
4. `review` / `qa` / `checkpoint` 같은 gate family는 특정 역사적 tool name보다 우선한다.
5. validator는 wording뿐 아니라 stale runtime assumptions도 잡아야 한다.

## 현재 남은 follow-up
- Hermes의 canonical skill target path를 완전히 고정할지 결정
- broader runtime-readiness validator 추가 여부 검토
- 남은 skill들(`mansu-web-verify` 등)의 runtime wording drift 점검
