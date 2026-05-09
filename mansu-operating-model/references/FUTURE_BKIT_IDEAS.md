# Future bkit Ideas For Mansu

This is a parking-lot document, not an active routing catalog.

bkit is not adopted by Mansu right now. Do not treat this file as an installed
skill map, source-family lock, runtime dependency, or current execution path.

Use this only when we decide to design a future Mansu skill inspired by bkit.

## Why This Is Separate

`SOURCE_SKILL_CATALOG.md` is for source skills Mansu actively knows how to route
to or compose today.

bkit does not belong there yet because:

- we are not installing it now
- we are not depending on its runtime
- we are not asking agents to route work through bkit
- its public Codex-specific install contract was not confirmed during the
  2026-05-07 reference check

This document keeps the useful ideas without making the active Mansu map noisy.

## Reference Snapshot

Checked on: 2026-05-07

Sources:

- GitHub: `https://github.com/popup-studio-ai/bkit-claude-code`
- Article: `https://www.edaily.co.kr/News/Read?mediaCodeNo=257&newsId=03821206645379712`

Observed status:

- The public GitHub repo checked was Claude Code plugin oriented.
- The article says bkit was released for Gemini CLI and OpenAI Codex too.
- A public Codex-specific repo or install contract was not confirmed in this
  check.

## Ideas Worth Reusing Later

| Idea | Why it matters | Possible Mansu form |
| --- | --- | --- |
| Gap check | Compare original intent against the built result so implementation does not drift from spec, TDR, design, or PLAN | `mansu-gap-check` or a ship-release subgate |
| Docs as state | Treat docs as operational state, not post-hoc explanation | stronger closeout / handoff gate |
| Bounded iteration | Allow autonomous fix loops, but require stop conditions and evidence | QA, review, and release repair loop policy |
| Phase transition criteria | Define what must be true before moving from idea to plan, plan to slice, slice to verify, verify to ship, and ship to learn | `mansu-phase-guard` or project-start / tdd-total reinforcement |
| PDCA/state-machine framing | Useful mental model for future orchestration runtime design | future runtime adapter architecture note |

## Patterns Not To Import

- Do not import automation levels. Mansu aims for maximum autonomy by default.
- Do not make bkit a mandatory dependency.
- Do not copy a whole state machine before proving it fits Mansu.
- Do not weaken Mansu's existing doctrine: plan deeply, execute autonomously,
  verify with evidence, and pause only for unresolved risk, unsafe action,
  missing evidence, or violated doctrine.

## Future Development Candidates

### `mansu-gap-check`

Purpose:

- compare intent artifacts against implementation artifacts before ship
- find mismatches between spec/TDR/design/PLAN and actual diff/tests/UI/docs
- produce a clear `match / mismatch / unknown` report

Potential source skills to compose:

- `gstack-review` for diff risk
- `gstack-qa-only` or `mansu-web-verify` for runtime evidence
- `gstack-document-release` for doc drift
- addyosmani `documentation-and-adrs` and `shipping-and-launch` for release
  discipline

### `mansu-phase-guard`

Purpose:

- decide whether the project can move to the next phase
- avoid premature implementation, premature ship, and fake completion
- preserve autonomy by giving the agent executable criteria instead of waiting
  for manual approval by default

Potential phase checks:

- idea to plan: user, problem, non-goals, constraints, research path
- plan to slice: domain model, architecture, risks, slice table, validation path
- slice to verify: tests, diff review, checkpoint, worklog
- verify to ship: health, QA evidence, security/performance if relevant, doc sync
- ship to learn: release note, retro, reusable rule, next starting point

## Revisit Trigger

Reopen this document when:

- the user explicitly asks to evaluate bkit adoption
- a future Mansu skill needs stronger gap detection
- release closeout keeps missing spec/design/document drift
- a public Codex/OpenCode/Hermes-compatible bkit path becomes clear
