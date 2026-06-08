# Mansu AgenticDev

> Agentic software development skills for planning, TDD, debugging, QA, and release.

English | [한국어](./README.ko.md)

Agentic software development is not about memorizing every prompt.
It is about knowing which proven skill to use, when to use it, and how to verify the result.

Mansu does not try to reinvent the world's best agent skills.
It studies, verifies, and orchestrates them so beginners can move from "I want to build something" to plan, code, QA, release, and learning with evidence.

As the source skills improve, Mansu improves with them.
`mansu-setup source-check` checks the source ecosystem first, and `mansu-source-curator` updates Mansu's internal map only after drift is confirmed and approved.
That is how Mansu keeps absorbing better project-start, planning, coding, design, QA, debug, and release patterns without surprising the user.

Install Mansu. Say `mansu-help`. Let it choose the route. Finish with evidence.

## What Mansu AgenticDev Is

Mansu AgenticDev is a guided software development workflow for AI agents and builders.

It is built around one simple belief:

> The best automation does not come from rebuilding everything yourself.
> It comes from reading, verifying, and composing the best skills already created around the world.

Mansu helps beginners do what experienced agentic coders already do:

- Define the project before coding.
- Research real references instead of guessing.
- Choose the right source skill for the current phase.
- Split work into vertical slices.
- Use strict TDD only where it improves confidence.
- Verify with review, QA, browser checks, security, performance, and release gates.
- Leave `PLAN.md`, worklogs, docs, and evidence behind.

Mansu is thin where source skills are already strong.
Mansu is strict where beginners and agents most often fail: planning, scope, safety, validation, source freshness, and completion evidence.

## Quick Start

Last verified: 2026-05-16

Canonical branch: `main`

### First Install

Bootstrap only `mansu-setup` first, then let that skill install and sync the rest of the suite.
`mansu-setup` detects the runtime target(Hermes, OpenCode, Codex, Claude Code), host, OS,
chooses the correct skill directory, installs or updates Ouroboros, gstack, and the matching
Oh My adapter, then verifies adapter compatibility.

```bash
git clone https://github.com/bigpine86/mansu-agentic-dev.git
cd mansu-agentic-dev

# Example: Hermes + tmux + OpenCode runtime using OpenCode's global skill path.
mkdir -p "$HOME/.config/opencode/skills/mansu-setup"
cp -R mansu-setup/. "$HOME/.config/opencode/skills/mansu-setup"/
```

For a project-local OpenCode setup, copy the same folder into `.opencode/skills/mansu-setup`.
For another runtime target, copy it into that runtime's local or global skill directory.

Then ask your agent runtime:

```text
Use $mansu-setup install from this repo. Detect my runtime target, host, and OS, install/update Ouroboros, gstack, and the matching Oh My adapter when needed, then choose paths and run compatibility checks.
```

### After Install

Use this first:

```text
mansu-help
```

Mansu will classify your situation and route you to the right next skill:

- `mansu-setup` for install, update, and runtime setup.
- `mansu-define` for a new product, app, repo, or major feature family.
- `mansu-plan` for requirements/spec, architecture, design direction, and roadmap.
- `mansu-build` for implementation through `mansu-tdd-total`.
- `mansu-verify` for tests, runtime checks, browser checks, and QA evidence.
- `mansu-review` for quality, architecture, design, security, and decision risk.
- `mansu-debug` for unknown bugs and regressions.
- `mansu-ship` for release readiness.

Before updates, check source freshness without changing anything:

```text
Use $mansu-setup source-check. Check whether Ouroboros, gstack, Oh My / OMO / OMC, addyosmani/agent-skills, VoltAgent/awesome-design-md, and Open Design are still aligned with Mansu's routing. Do not install, update, sync, or edit files. Report Green/Yellow/Red status and the next action that needs approval.
```

When you decide to update:

```text
Use $mansu-setup update. Update Mansu, install/update Ouroboros, gstack, and the matching Oh My adapter when needed and approved, prepare Open Design only when UI/design artifact work needs it or I explicitly approve it, sync Mansu skills, check Ouroboros, gstack, Oh My / OMO / OMC, addyosmani/agent-skills, VoltAgent/awesome-design-md, and Open Design source freshness, and report adapter compatibility with any blocked install steps.
```

### For Agents

```text
If Mansu is not installed or may be stale, run mansu-setup first.
Read MANSU_PHILOSOPHY.md first.
Then choose the correct mansu-* skill for the task.
Do not invent a new workflow before checking the source skill map.
```

## Why This Exists

AI coding is getting fast. That creates a new problem: beginners can now generate
code faster than they can judge the plan, architecture, scope, risk, and quality.

The best agentic workflows already exist in pieces:

- `addyosmani/agent-skills` gives a lifecycle spine: define, plan, build, verify, review, ship.
- Ouroboros is useful for early project definition, memory, Seed, Ledger, and long-horizon direction.
- Oh My / OMO / OMC gives execution modes such as research, ultrawork, ralph, TDD, and debug.
- gstack gives specialist roles and gates: CEO, design, engineering, QA, security, performance, ship, deploy, learn.
- Open Design gives a callable agent-native design artifact workflow when installed or approved.
- VoltAgent/awesome-design-md gives a reference shape for `DESIGN.md` and design handoff.

Mansu's job is not to replace them.
Mansu's job is to know which one to use, connect their outputs, and keep the work honest until it ships.

Mansu owns:

- Planning
- Safety boundaries
- Role separation
- Routing
- Verification
- Checkpoints
- Worklogs and learning records
- Final accountability

Specialized execution should stay with the best matching source skill whenever possible.
The source skill map lives in `mansu-operating-model/references/SOURCE_SKILL_CATALOG.md`.
Composition rules for overlapping source skills live in `mansu-operating-model/references/SOURCE_SKILL_COMPOSITION.md`.
`mansu-setup` must keep checking Ouroboros, gstack, Oh My / OMO / OMC, addyosmani/agent-skills, VoltAgent/awesome-design-md, and Open Design source freshness.

This creates the Mansu flywheel:

- Find strong source skills.
- Read their philosophy, gates, and outputs.
- Route Mansu work to the best matching source instead of cloning it badly.
- Keep only the essential Mansu guardrails in `mansu-*`.
- Refresh the source map as better skills and newer patterns appear.

The broad development flow follows the addyosmani/agent-skills Define -> Plan -> Build -> Verify -> Review -> Ship phase map.
Mansu does not copy that sequence mechanically. It chooses the needed source skill based on the current phase and risk.
Actual code construction order is not hardcoded. `mansu-operating-model/references/CODE_CONSTRUCTION_ORDER.md`
detects the current development phase and routes to the relevant addyosmani/agent-skills phase skill plus gstack, Oh My, or Ouroboros support routes.

Design work prefers Open Design as the callable design-artifact route when installed or explicitly approved. Mansu runs the Open Design CLI/lifecycle commands, records the artifact evidence, then uses VoltAgent/awesome-design-md as a `DESIGN.md` reference source and gstack design/QA gates for critique and verification.

LazyCodex is runtime transport for Codex/OMO execution. It is not a Mansu source skill family and does not replace Define -> Plan -> Build -> Verify -> Review -> Ship routing.

## Big Picture

Mansu is not one mega-skill. It is a project operating layer.

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

These names are representative routes, not fixed dependencies.
However, substitute source routes become valid Mansu routing evidence only after `mansu-source-curator`
verifies their source, version, role, and outputs, then records them in `SOURCE_SKILL_LOCK.json`
and `SOURCE_SKILL_CATALOG.md`.

The canonical doctrine lives in `mansu-operating-model`.
Project-level `AGENTS.md` routes agents into that doctrine.
Project-level `CODING_RULES.md` records local runtime, validation, and ship rules.

The project roadmap/phase order belongs in spec, TDR, and design documents.
Large feature order comes before a phase `PLAN.md`; `PLAN.md` is the active phase execution plan.

## Core Philosophy

Good Mansu skills are thin where they can be thin and strict where they must be strict.

- Thin: source-specific mechanics, long checklists, specialized execution details.
- Strict: planning, safety, scope boundaries, evidence, verification, and completion rules.

For non-trivial work, Mansu planning is a multi-role critique loop:
Planner drafts, Critics challenge, Synthesizer produces one execution-ready plan,
and then slices are dispatched automatically unless an explicit approval gate, risky
action, or unresolved blocker requires a pause.

If real critic agents are started, their feedback is not optional: wait for it, or
record the timeout/failure and preserve unresolved high-risk questions as blockers.

Slices are sequential by default: slice N+1 does not start until slice N is validated,
reviewed, QA'd, checkpointed, logged, and committed or explicitly recorded as not committed.

See [MANSU_PHILOSOPHY.md](./MANSU_PHILOSOPHY.md) for the full doctrine.

## Skills

| Skill | Use when | Core idea |
| --- | --- | --- |
| `mansu-help` | You are new, unsure what to do next, or need the safest Mansu route. | Beginner-friendly route helper |
| `mansu-manual` | You want the visual HTML guide at `docs/mansu-manual.html`. | Beginner-friendly HTML manual |
| `mansu-setup` | You need install, source health checks, update, runtime target detection, source tool setup, skill sync, repair, or adapter compatibility checks. | Runtime-target bootstrap and read-only check/update gate |
| `mansu-source-curator` | Drift was confirmed and Mansu references/validators/manual/worklog must be refreshed. | Hidden source-reference maintenance |
| `mansu-define` | You are starting a new product, app, repo, or major feature family and need source-skill interview, requirements, acceptance criteria, and source-of-truth artifacts. | Define phase |
| `mansu-plan` | You need requirements/spec, architecture, design direction, phase roadmap, and current phase `PLAN.md`. | Plan phase |
| `mansu-operating-model` | You are defining project behavior, role separation, evidence rules, `AGENTS.md`, or `CODING_RULES.md`. | Canonical doctrine and project-document templates |
| `mansu-build` | You are implementing a feature or refactor and need `mansu-tdd-total` slice execution. | Build phase |
| `mansu-verify` | You need tests, runtime checks, browser checks, QA evidence, or security/performance proof. | Verify phase |
| `mansu-review` | You need quality, maintainability, architecture, design, security, or decision-risk review. | Review phase |
| `mansu-debug` | You need to reproduce, isolate, prove root cause, minimally fix, and regression-test a bug. | Debug route |
| `mansu-ship` | Implementation is done and you need a ship/hold decision with health, review, QA, docs, PR/deploy/canary, and learning closeout. | Ship phase |
| `mansu-project-start` | Compatibility alias for `mansu-define`. | Legacy kickoff route |
| `mansu-tdd-total` | Default implementation engine under `mansu-build`. | Build engine |
| `mansu-tdd-strict` | A risky slice benefits from a meaningful failing RED test. | Strict TDD slice loop |
| `mansu-tdd-lite` | A slice still needs planning, review, QA, checkpoint, and commit, but forced RED would be artificial. | Relaxed RED, not relaxed quality |
| `mansu-debug-rootcause` | Compatibility route under `mansu-debug`. | Root-cause-first debugger |
| `mansu-web-verify` | Compatibility route under `mansu-verify` for real-user web checks. | Web verification orchestrator |
| `mansu-ship-release` | Compatibility route under `mansu-ship`. | Release readiness gate |

## Recommended Routing

- New or unsure: `mansu-help`
- Visual guide: `mansu-manual` or [docs/mansu-manual.html](./docs/mansu-manual.html)
- Install, read-only source health check, update, runtime detection, skill sync, adapter compatibility: `mansu-setup`
- Internal source catalog/manual/validator maintenance after confirmed drift: `mansu-source-curator`
- New project or major feature family: `mansu-define`, then `mansu-plan`
- Project doctrine, `AGENTS.md`, `CODING_RULES.md`: `mansu-operating-model`
- Feature or refactor implementation: `mansu-build`
- Behavior proof, QA, browser/runtime verification: `mansu-verify`
- Quality, architecture, design, security, decision-risk review: `mansu-review`
- High-risk slice with useful RED test: `mansu-tdd-strict`
- Lower-risk slice where RED is artificial: `mansu-tdd-lite`
- Bug, regression, stack trace, or "why is this broken?": `mansu-debug`
- Ship-ready, PR, release docs, deploy/canary, learning closeout: `mansu-ship`

## Trust & Verification

You do not need to run this to start using Mansu.
This section is for advanced users, contributors, and maintainers who want to verify the repo structure before trusting or modifying it.

```bash
scripts/validate_mansu_skills.sh
MANSU_COMPARE_INSTALLED=1 scripts/validate_mansu_installed_copies.sh /Users/hansol/.codex/skills
```

Expected result: all Mansu structure validators pass.
The suite checks skill frontmatter, manual/catalog consistency, source-lock references,
runtime-readiness wording, TDD/debug/web/ship workflows, and installed-copy validation hooks.
The second command compares the currently installed Codex skill copies, including nested reference files,
and fails if an obsolete `mansu-*` skill is still installed.

Targeted checks live in [scripts](./scripts), including `scripts/validate_mansu_help.sh`,
`scripts/validate_mansu_manual.sh`, `scripts/validate_mansu_operating_model.sh`,
and `scripts/validate_mansu_installed_copies.sh`.

## Repo Map

- [README.ko.md](./README.ko.md): Korean README
- [MANSU_PHILOSOPHY.md](./MANSU_PHILOSOPHY.md): shared Mansu philosophy
- [mansu-operating-model](./mansu-operating-model/SKILL.md): canonical doctrine plus `AGENTS.md` / `CODING_RULES.md` templates
- [SOURCE_SKILL_CATALOG.md](./mansu-operating-model/references/SOURCE_SKILL_CATALOG.md): Ouroboros / gstack / Oh My / OMO / OMC / addyosmani / VoltAgent / Open Design source map and composition recipes
- [SOURCE_SKILL_COMPOSITION.md](./mansu-operating-model/references/SOURCE_SKILL_COMPOSITION.md): overlapping source-skill comparison and composition routes
- [SOURCE_SKILL_LOCK.json](./mansu-operating-model/references/SOURCE_SKILL_LOCK.json): source-family freshness snapshot and evidence
- [DOCUMENT_CREATION_ORDER.md](./mansu-operating-model/references/DOCUMENT_CREATION_ORDER.md): which document to create, which source skill to use, and which verification skill to run
- [CODE_CONSTRUCTION_ORDER.md](./mansu-operating-model/references/CODE_CONSTRUCTION_ORDER.md): current phase detection and dynamic routing to coding-order source skills
- [PLAN.md](./PLAN.md): active phase execution plan. Whole-project roadmap and large feature order stay in spec/TDR/design docs.
- [개발일지.md](./개발일지.md): chronological worklog
- [mansu-help](./mansu-help/SKILL.md): route helper
- [mansu-manual](./mansu-manual/SKILL.md): static HTML manual route
- [mansu-manual.html](./docs/mansu-manual.html): visual manual
- [mansu-setup](./mansu-setup/SKILL.md): install/update/repair entry point
- [mansu-source-curator](./mansu-source-curator/SKILL.md): internal source-reference maintenance
- [mansu-define](./mansu-define/SKILL.md): Define phase
- [mansu-plan](./mansu-plan/SKILL.md): Plan phase
- [mansu-build](./mansu-build/SKILL.md): Build phase and `mansu-tdd-total` dispatcher
- [mansu-verify](./mansu-verify/SKILL.md): Verify phase
- [mansu-review](./mansu-review/SKILL.md): Review phase
- [mansu-debug](./mansu-debug/SKILL.md): special root-cause route
- [mansu-ship](./mansu-ship/SKILL.md): Ship phase
- [mansu-project-start](./mansu-project-start/SKILL.md): compatibility alias for Define
- [mansu-tdd-total](./mansu-tdd-total/SKILL.md): build engine used by `mansu-build`
- [mansu-tdd-strict](./mansu-tdd-strict/SKILL.md): strict TDD execution
- [mansu-tdd-lite](./mansu-tdd-lite/SKILL.md): lite execution
- [mansu-debug-rootcause](./mansu-debug-rootcause/SKILL.md): root-cause debugging
- [mansu-web-verify](./mansu-web-verify/SKILL.md): web verification orchestrator
- [mansu-ship-release](./mansu-ship-release/SKILL.md): release readiness and ship/hold decision
- [scripts](./scripts): structure validators

## What To Expect

- Mansu works best when a task needs planning, source-skill routing, implementation discipline, and verification.
- For tiny edits, use the fastest direct path. For product, architecture, UI, debugging, or release work, use the matching Mansu route.
- Before important work, run `mansu-setup` if your local skills may be stale.
- `mansu-*` does not replace great tools. It helps compose them into one safer agentic software development workflow.

## Status

active

## License

TBD
