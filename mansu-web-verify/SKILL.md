---
name: mansu-web-verify
description: Plan-first, report-only web verification workflow for checking a web app like a real user. Use when the user wants all important pages, buttons, links, forms, flows, responsive layouts, console/network stability, performance, and basic security reviewed with evidence. Default is verification and reporting, not fixing.
---

# Mansu Web Verify

Use this skill to verify a web app before shipping or after a major change.

This skill is a verifier and orchestrator, not a feature builder. It plans first,
tests like a real user, gathers evidence, and delegates specialized work to the
right source skill instead of reimplementing everything here.

Mansu's role here is orchestration: own the plan, safety boundary, evidence, routing,
and final accountability; delegate specialized craft to the best source skill.

## Core promise

- Plan before clicking.
- Default to report-only.
- Test real user flows, not just unit tests.
- Capture evidence for every important claim.
- Check function, stability, performance, responsiveness, and basic security.
- Use a bounded Ralph loop: keep going until the planned safe checks are complete, blocked, or unsafe.
- Never perform destructive, financial, spammy, privacy-sensitive, or irreversible actions without explicit approval.
- Route unclear bugs to `mansu-debug-rootcause` instead of guessing or broad-fixing.
- Prefer source skills for specialized execution. Mansu owns the plan, safety boundary, routing, and final report.

## Source skill map

Do not load every source skill by default. Start with this orchestration workflow,
then load or invoke the narrow source skill when that phase needs tool-specific detail.

| Source skill | Use it for | Load or invoke when |
| --- | --- | --- |
| gstack `browse` | browser interaction, screenshots, snapshots, console, network, responsive checks | any browser phase needs concrete tool mechanics |
| gstack `qa-only` | report-only QA, evidence rules, health score, repro discipline | broad real-user QA is requested and fixes are not approved |
| gstack `qa` | test-fix-verify loop | only in approved fix mode, or after a root cause is confirmed and the user wants fixes |
| gstack `benchmark` | performance baselines, regression thresholds, resource analysis | performance is a major concern or baseline comparison is needed |
| gstack `cso` | deeper OWASP, STRIDE, secret, dependency, CI/CD, supply-chain review | security concerns exceed safe browser checks |
| gstack `canary` | post-deploy monitoring, baseline comparison, repeated checks | the target is live after deploy or the user asks for monitoring |
| gstack `setup-browser-cookies` / `open-gstack-browser` | authenticated or visible-browser handoff | login, MFA, CAPTCHA, or watchable manual handoff is needed |
| Oh My `playwright` | durable E2E or visual regression tests | a discovered flow should become repeatable automation |
| Oh My `ultraqa` | test-pyramid coverage and release-quality categories | suite-level QA or coverage gaps matter |
| Oh My `security-review` | lightweight OWASP checklist | safe security review needs a concise checklist |
| Oh My `ralph` | persistence philosophy | only as bounded Ralph, never infinite verification |
| `mansu-debug-rootcause` | root-cause-first bug investigation and fix verification | behavior is broken, unclear, intermittent, or non-trivial |

## Mansu-owned orchestration

This skill should stay thin. It owns:

- preflight and safety boundaries
- product surface discovery before browser testing
- mode selection and verification plan
- delegation to the source skill map
- evidence requirements and issue routing
- final WEB VERIFY REPORT

It should not duplicate full `qa-only`, `benchmark`, `cso`, `canary`, or `playwright`
workflows. If a specialized phase grows beyond a short check, route to that source skill.

## Modes

- `report-only` is the default. Verify, document, and recommend next actions without editing source code.
- `diff-aware` means inspect recent changes first, infer affected routes/flows, then verify those plus nearby regressions.
- `quick` means homepage, top navigation, obvious interactions, console/network smoke, and a compact report.
- `full` means systematic reachable-page and core-flow verification with stronger evidence.
- `regression` means compare against a prior report, baseline, screenshot set, or known behavior.
- `fix-approved` means the user explicitly asked to fix issues. Even then, root-cause bugs go through `mansu-debug-rootcause`.
- `post-deploy` means verify the live app and use canary-style monitoring when appropriate.

## Bounded Ralph loop

Use Ralph-style persistence inside each safe phase:

1. Attempt the planned check.
2. Verify whether the check produced evidence.
3. Retry once if the failure looks like timing, loading, or flaky UI.
4. If still blocked, record `BLOCKED` with evidence and move to the next planned check.

Do not use infinite Ralph behavior here. Stop immediately for:

- destructive or irreversible actions
- payments, emails, SMS, production writes, or real user notifications
- missing login credentials or MFA
- unclear test data safety
- security checks that would become invasive
- three failed attempts on the same flow

## Phase 0: Preflight

Identify:

- target URL or local run command
- environment: local, preview, staging, production
- report-only vs fix-approved mode
- auth requirements and available test account
- forbidden actions and safe substitutes
- current branch and recent diff, if this is branch verification
- expected output location for screenshots and reports

If dangerous actions are possible, pause and list them before testing.

## Phase 1: Product surface discovery

Inspect the project before opening the browser:

- README, docs, package scripts, route files, app/router directories, page files, API routes, forms, and major components
- recent git diff and changed files
- known issue files such as `TODO`, `TODOS.md`, `CHANGELOG`, or project notes
- user-provided priority flows

Produce a compact surface map:

- pages/routes to visit
- core user flows
- forms and inputs
- buttons and links worth checking
- auth/role boundaries
- risky actions to avoid or simulate
- pages for performance measurement
- security-sensitive areas

Read source to plan coverage, but judge behavior from browser evidence. Source
assumptions do not count as verification.

## Phase 2: Verification plan

Before browser testing, write a short plan with:

- scope
- mode
- flows
- responsive viewports
- performance targets
- stability checks
- security checks
- forbidden actions
- expected evidence
- source skills to load or invoke from the source skill map

Ask for approval only when the scope is broad, production is involved, login is required, or risky actions exist. Otherwise proceed.

## Phase 3: Browser verification

Prefer gstack `browse` for concrete browser actions. Prefer gstack `qa-only` when the
requested scope is broad report-only QA. Do not switch into gstack `qa` unless the
mode is `fix-approved` or the user explicitly requests a fix loop.
Rule of thumb: use gstack `qa` only in approved fix mode, or after root cause is clear.

Test like a real user:

- open the target page
- check page load and visible content
- click navigation, links, buttons, menus, tabs, modals, and interactive elements
- fill forms with safe test data
- verify validation, empty states, loading states, error states, and success states
- test refresh, back/forward, and repeated interactions where relevant
- check console errors after page load and after important interactions
- capture screenshots or snapshots for important flows and failures
- test mobile, tablet, and desktop when UI matters

Evidence rules:

- interactive bug: before evidence, action taken, after evidence, repro steps, and console/network context
- static visual/content bug: annotated screenshot or precise page/element evidence
- blocked flow: what was attempted, why it was blocked, and what safe substitute was used

Do not perform forbidden actions. Use safe substitutes such as opening confirmation modals,
using dry-run/test data, stopping before final submit, or documenting that the action needs
manual verification.

## Phase 4: Stability checks

Look for:

- console errors
- failed network requests
- 404/500 states
- broken links
- forms that submit twice
- stale loading states
- auth/session confusion
- data disappearing after refresh
- layout shifts or unusable responsive states
- obvious accessibility blockers such as unreachable controls or invisible focus-critical UI

Classify each issue by severity: critical, high, medium, low, cosmetic.

## Phase 5: Performance checks

Measure the pages selected in the plan.

Use gstack `benchmark` when performance is central, when a baseline exists, or when
the user asks for page speed, bundle size, Web Vitals, or regression detection.
Otherwise collect lightweight performance signals and avoid overclaiming precision.

Use benchmark-style evidence:

- first load and reload behavior
- rough page load time
- obvious bundle/resource bloat
- large images or blocking scripts
- Core Web Vitals when available
- baseline vs current when a baseline exists
- timing regression threshold: greater than 50% or greater than 500ms is a regression signal
- bundle regression threshold: greater than 25% is a regression signal

Do not overclaim precision. If the environment is noisy, say so and report relative signals.

## Phase 6: Safe security checks

Use safe browser-level checks by default. Route to gstack `cso` when the work needs
deep OWASP, STRIDE, secrets archaeology, dependency supply-chain, CI/CD, infrastructure,
or LLM security analysis.

Run safe, non-invasive checks:

- auth-only pages are not accessible when logged out
- role-sensitive actions are not exposed to the wrong user
- forms validate unexpected input safely
- secrets, tokens, stack traces, or sensitive data are not visible in page source, network output, or console
- logout/session expiration behavior is sane
- destructive actions require confirmation or protection

Do not run aggressive scans, exploit attempts, password attacks, data exfiltration, or production abuse. If deeper security is needed, route to `gstack-cso` style review.

## Phase 7: Issue routing

For every issue:

- record repro steps and evidence
- classify severity and likely area
- keep report-only unless `fix-approved`
- route unclear/non-trivial bugs to `mansu-debug-rootcause`
- route broad report-only QA to gstack `qa-only`
- route approved browser fix loops to gstack `qa` only after root cause is clear or explicitly requested
- route pure performance regressions to gstack `benchmark`
- route security concerns to gstack `cso`
- route broad post-deploy concerns to gstack `canary`
- route durable regression automation to Oh My `playwright`

If in `fix-approved` mode, fix only after the issue is understood. Do not bundle unrelated fixes.

## Final report

Leave this report:

```markdown
WEB VERIFY REPORT
Mode:              report-only | diff-aware | quick | full | regression | fix-approved | post-deploy
Target:            {url/environment}
Surface map:       {pages, flows, forms, risky actions}
Plan completed:    {yes/no, blocked items}
Source skills:     {skills loaded/invoked, skipped, or recommended}
Flows tested:      {flow list with pass/fail/blocked}
Responsive:        {desktop/tablet/mobile summary}
Stability:         {console, network, reload, error states}
Performance:       {pages measured, metrics/signals, concerns}
Security:          {safe checks performed, concerns}
Issues:            {severity, repro, evidence, suggested route/source skill}
Forbidden actions: {skipped actions and safe substitutes}
Evidence:          {screenshots, snapshots, logs, commands}
Next actions:      {debug, qa-only, qa, benchmark, cso, canary, playwright, manual check}
Status:            DONE | DONE_WITH_CONCERNS | BLOCKED
```

## Completion rule

Do not declare `DONE` unless every planned safe check has evidence or an explicit
blocked reason. Use `DONE_WITH_CONCERNS` when verification completed but issues remain.
Use `BLOCKED` when the app cannot be run, auth is missing, safety is unclear, or the
requested verification exceeds what can be safely tested.
