---
name: mansu-debug-rootcause
description: Root-cause debugging workflow for bugs, regressions, stack traces, broken behavior, intermittent failures, and "why is this broken?" situations. Use when the user wants `mansu-debug-rootcause`, debug, investigate, root cause analysis, or a fix that must be reproduced, isolated, explained, minimally fixed, and verified before shipping. This skill borrows the "no fixes without root cause" discipline from gstack-investigate and the reproduce/isolate/hypothesize/test/fix/verify loop from Oh My Codex debug.
---

# Mansu Debug Rootcause

Use this skill for bugs, not feature work.

## Core promise

- No fixes before root cause.
- Reproduce the symptom or gather enough evidence to explain why reproduction is blocked.
- Isolate the smallest responsible area.
- Form a testable hypothesis before editing.
- Fix the root cause with the smallest safe change.
- Prove the original bug is gone.
- Leave behind a debug report and any reusable lesson.

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
- Do not ship a fix that cannot be verified.

## Debug loop

1. Reproduce
   Capture exact steps, environment, expected behavior, actual behavior, and error output.
2. Isolate
   Trace from symptom to likely owner. Check recent diffs, related files, configuration, and data flow.
3. Hypothesize
   State one specific, testable root-cause hypothesis.
4. Test the hypothesis
   Use focused logs, assertions, a failing regression test, browser evidence, or a smaller reproduction.
5. Fix
   Apply the minimal fix only after the hypothesis is supported.
6. Verify
   Re-run the original reproduction and the relevant automated checks.
7. Report
   Record symptom, root cause, fix, evidence, regression coverage, and remaining risk.

## Evidence rules

- Quote or summarize the exact error without leaking secrets.
- If searching externally, sanitize hostnames, IPs, file paths, SQL, customer data, tokens, and internal identifiers.
- Prefer behavior evidence over implementation guesses.
- If a hypothesis fails, record what disproved it before forming the next one.
- If 3 hypotheses fail, stop and escalate instead of guessing.

## Fix rules

- Fix the root cause, not the symptom.
- Use the minimal fix that removes the actual cause.
- Add a regression check when it is natural and meaningful.
- If an automated regression test is not natural, record the explicit verification path.
- If the fix touches more than 5 files, stop and call out the blast radius before continuing.
- Keep unrelated refactors out of the bug fix.

## Verification and report

A debug fix is not complete until the original bug scenario has been re-tested.

Leave this report:

```markdown
DEBUG REPORT
Symptom:         {what the user observed}
Root cause:      {what was actually wrong}
Fix:             {what changed, with files}
Evidence:        {reproduction, logs, tests, or browser proof}
Regression:      {test or explicit verification path}
Related risk:    {remaining concern or architectural note}
Status:          DONE | DONE_WITH_CONCERNS | BLOCKED
```

## Relationship to other Mansu skills

- Use `mansu-debug-rootcause` when the primary job is to explain and fix broken behavior.
- Use `mansu-tdd-total` when the primary job is planned feature work.
- After root cause is found, a large fix may be routed into `mansu-tdd-total` for slice planning.
- If the bug reveals missing release checks, follow up with a future ship/release skill.

## Escalation

Stop and report `BLOCKED` when:

- the bug cannot be reproduced and there is not enough evidence to continue
- 3 hypotheses have failed
- the fix requires a broad architecture change
- the blast radius exceeds what can be verified in the current session
- required logs, credentials, environment, or test data are missing
