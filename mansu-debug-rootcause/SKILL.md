---
name: mansu-debug-rootcause
description: Root-cause debugging workflow for bugs, regressions, stack traces, broken behavior, intermittent failures, and "why is this broken?" situations. Use when the user wants debug, investigate, root cause analysis, or a fix that must be reproduced, explained, minimally changed, and verified before shipping. Not for planned feature work.
---

# Mansu Debug Rootcause

Use this skill for bugs, not feature work.

This is a compact wrapper around two source ideas:

- Oh My `debug`: the memorable 6-stage loop.
- gstack `investigate`: strict gates that stop guessing.

## Core promise

- No fixes before root cause.
- Reproduce the symptom or gather enough evidence to explain why reproduction is blocked.
- Isolate the smallest responsible area.
- Run a pattern-analysis checkpoint before forming the final hypothesis.
- Form one testable root-cause hypothesis before editing.
- Scope-lock edits after the hypothesis, or document why locking is skipped.
- Fix the root cause with the smallest safe change.
- Add regression proof by default.
- Prove the original bug is gone and no obvious regression was introduced.
- Leave behind a debug report and any reusable lesson.

## Source relationship

Do not load full source skills by default. This skill embeds the mandatory gates so the
normal path stays light.

Load source skills only when the task is ambiguous, high-risk, already failed once, or
needs a specialized branch:

- `$HOME/.codex/skills/debug/SKILL.md`
  Use for the original Oh My loop, common bug patterns, debugging tools, and diagnostic questions.
- `$HOME/.gstack/repos/gstack/.agents/skills/gstack-investigate/SKILL.md`
  Use for the full root-cause protocol, exact scope-lock behavior, prior learnings, pattern analysis, 3-hypothesis stop rule, blast-radius handling, verification report, and learn capture.

If a source skill is unavailable, say which source was missing and continue with this
compact procedure. Do not silently replace missing source skills with memory.

## When to use

Use this skill when:

- the user reports an error, crash, stack trace, or broken behavior
- something worked before and now fails
- a bug is intermittent or environment-dependent
- multiple previous fixes did not hold
- the task is "debug this", "why is this broken?", "investigate this", or "fix this bug"

If the work is a planned feature or refactor, use the `mansu-tdd-*` series instead.

## What this skill does not do

- Do not start by editing code.
- Do not apply "quick fix for now" patches.
- Do not fix symptoms while leaving the mechanism unexplained.
- Do not expand into unrelated cleanup or feature work.
- Do not run broad `gstack-qa` fix loops before root cause is confirmed.
- Do not ship a fix that cannot be verified.

## Route table

Choose one route before editing. Load only the relevant branch source when needed.

| Trigger | Optional source to load | Required artifact |
|---|---|---|
| App/runtime bug | None by default | Repro, code path, root-cause hypothesis |
| Build/type/lint/import/dependency failure | `$HOME/.codex/skills/build-fix/SKILL.md` | Error category, fix order, build/type/lint output |
| Oh My/Codex/tooling/install/config/MCP/runtime failure | `$HOME/.codex/skills/doctor/SKILL.md` | Environment/config/runtime health result |
| Regression with unclear start point | `$HOME/.codex/skills/git-master/SKILL.md` if `git bisect` is needed | Recent-change evidence or known good/bad commits |
| Browser/UI/user-flow bug | gstack `browse` or `qa-only` procedures | Screenshot/snapshot/console/repro evidence |
| Confirmed browser/UI fix needing broad QA | gstack `qa`, only after root cause is confirmed or the user explicitly asks for full QA | Before/after QA evidence |
| Performance regression | `$HOME/.gstack/repos/gstack/.agents/skills/gstack-benchmark/SKILL.md` | Baseline/current metrics and regression judgment |
| Agent orchestration or decision-flow bug | `$HOME/.codex/skills/trace/SKILL.md` | Timeline or event evidence |
| Resistant bug needing multiple perspectives | Oh My `team` idea | Debugger/analyst/tester perspectives, still capped by 3-hypothesis stop |

## Six-stage loop with gstack gates

Use Oh My `debug` as the outer loop.

1. REPRODUCE
   Capture exact steps, environment, expected behavior, actual behavior, and error output.
   If required context is missing, ask exactly one highest-leverage question, then continue.
   If reproduction is blocked, gather evidence before guessing.
2. ISOLATE
   Trace from symptom to likely owner. Check code path, recent diffs, related files, configuration, data flow, and prior learnings.
   Pattern analysis checkpoint before the final hypothesis:
   check known bug patterns, `TODOS.md`, same-file recurring fixes, and sanitized external sources when appropriate.
3. HYPOTHESIZE
   State one specific, testable root-cause hypothesis that explains what is wrong and why the symptom appears.
   After the hypothesis, scope-lock the narrowest affected directory or document why scope lock is skipped.
4. TEST
   Verify the hypothesis with focused logs, assertions, a failing regression test, browser evidence, benchmark evidence, or a smaller reproduction.
   If a hypothesis fails, record what disproved it before forming the next one.
   If 3 hypotheses fail, stop and escalate instead of guessing.
5. FIX
   Apply the minimal fix only after the hypothesis is supported.
   Fix root cause, not symptoms.
   If the fix touches more than 5 files, stop and call out the blast radius before continuing.
6. VERIFY
   Re-run the original reproduction.
   Run the new regression proof.
   Run the relevant automated suite, or document exactly why the suite cannot run.
   Fresh verification is mandatory before claiming success.

Then report the result.

## Evidence rules

- Quote or summarize the exact error without leaking secrets.
- If searching externally, sanitize hostnames, IPs, file paths, SQL, customer data, tokens, and internal identifiers.
- Prefer behavior evidence over implementation guesses.
- Treat recurring bugs in the same files as an architectural smell, not a coincidence.
- If a hypothesis fails, record the disproof before forming the next one.

## Fix rules

- Fix the root cause, not the symptom.
- Use the minimal fix that removes the actual cause.
- Add a regression test by default.
- The regression test should fail before the fix and pass after the fix when feasible.
- If automated regression proof is not feasible, record the reason and an explicit manual verification path.
- Keep unrelated refactors out of the bug fix.
- Use freeze/scope-lock behavior when the suspected area is narrow enough to prevent accidental adjacent cleanup.

## Verification and report

A debug fix is not complete until the original bug scenario has been re-tested.

Leave this report:

```markdown
DEBUG REPORT
Source skills loaded: {none | paths and why}
Symptom:              {what the user observed}
Reproduction:         {exact steps or why reproduction was blocked}
Pattern check:        {known pattern, TODO, recurring fix, or external source result}
Root cause:           {what was actually wrong}
Hypothesis proof:     {what confirmed the root-cause hypothesis}
Scope lock:           {locked path or skip reason}
Fix:                  {what changed, with files}
Evidence:             {reproduction, logs, tests, browser proof, or benchmark proof}
Regression:           {fails-before/passes-after test, or explicit skip reason and manual path}
Suite:                {relevant suite command/result, or why it could not run}
Related risk:         {remaining concern or architectural note}
Status:               DONE | DONE_WITH_CONCERNS | BLOCKED
```

## Relationship to other Mansu skills

- Use `mansu-debug-rootcause` when the primary job is to explain and fix broken behavior.
- Use `mansu-tdd-total` when the primary job is planned feature work.
- After root cause is found, a large fix may be routed into `mansu-tdd-total` for slice planning.
- If the bug reveals missing release checks, follow up with a future ship/release skill.
- If the bug reveals a reusable pitfall, save it to the project learning flow after verification.

## Escalation

Stop and report `BLOCKED` when:

- the bug cannot be reproduced and there is not enough evidence to continue
- 3 hypotheses have failed
- the fix requires a broad architecture change
- the blast radius exceeds what can be verified in the current session
- required logs, credentials, environment, or test data are missing
