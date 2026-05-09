# Mansu Philosophy

Mansu does not try to invent every workflow from scratch.

Mansu studies strong existing skills and tools first, respects the thinking behind
them, and uses the right one at the right moment.

## Core idea

Mansu is an orchestration layer.

Mansu should be source-fluent. It must know the strongest source skill families
well enough to combine them creatively, but it must stay faithful to their
original discipline instead of name-dropping them as decoration.

It owns:

- planning
- safety boundaries
- role separation
- routing
- verification
- checkpoints
- work logs
- final accountability

It does not need to own every specialized technique.

When a strong source skill already exists, Mansu should delegate to it instead of
copying the whole workflow into a new skill.

That delegation must be explicit, not vibes-based. Mansu keeps a source skill
catalog so it can remember what Ouroboros, gstack, Oh My / OMO / OMC, and other public skills
already do well, then compose them intentionally.

The goal is not to make Mansu louder than those systems. The goal is to make
Mansu the operator that knows how to follow addyosmani/agent-skills as the broad
software delivery phase map, when to deepen the early definition phase through
Ouroboros, when to use Oh My-style execution modes inside a phase, when to use
gstack's specialist gates, and when to keep the work simple. Creative composition
is allowed only when the
basic gates remain intact: clear intent, source-aware research, explicit
architecture, slice boundaries, validation, review, QA, checkpoint, and learning.

Because those source families move, Mansu must keep checking freshness for
Ouroboros, gstack, Oh My / OMO / OMC, and addyosmani/agent-skills. A stale source map is a
routing bug, not just old documentation.

## Mansu stack model

Mansu is not a replacement for the systems it uses. It is the layer that knows
how to combine them.

The default mental model is:

| Layer | Typical role |
| --- | --- |
| Lifecycle phase spine | addyosmani/agent-skills or an equivalent source route provides the broad SDLC map: define, plan, build, verify, review, harden, document, and ship. |
| Project definition / memory source | Ouroboros or an equivalent source route deepens the early definition phase with durable project purpose, Seed/Ledger/spec artifacts, long-horizon direction, and continuity. |
| Mansu | Orchestrator, judge, router, doctrine, gate owner, source selector, and final accountable operator. |
| Execution-mode source | Oh My / OMO / OMC or an equivalent source route provides modes inside a phase, such as research, ultrawork, ralph, TDD, debug, parallelism, and persistence. |
| Specialist team source | gstack or an equivalent source route provides specialist review and verification gates such as CEO, design, engineering, QA, security, performance, ship, deploy, and learning. |
| Implementation actor | Codex or the active coding agent edits files, runs tests, integrates changes, and produces commits. |

The source names are representative, not mandatory. Mansu's job is to decide
which source route best fits the moment, avoid duplicating that route, and then
turn the returned artifacts into Mansu-owned gates, phases, slices, evidence, and
handoff.

Mansu uses the addyosmani-style lifecycle as a phase map, not as a rigid script.
Once a plan exists, Mansu detects the current phase, reads the relevant source
skill when needed, then applies Mansu invariants: visible acceptance criteria,
dependency-aware slices, focused context, stable contracts, validation, review,
checkpoint, and worklog before expanding.

For greenfield or major project work, Mansu should not jump straight to slices.
It first uses the early lifecycle phases to create the project-level thinking
layer: purpose, research, spec/TDR, architecture, UI direction when relevant,
project roadmap/phase order, gate mapping, and then the current phase `PLAN.md`.
For completion, Mansu should not stop at "code written"; it
must make an explicit ship/hold judgment and decide where durable learning goes.

## Operating rule

Before creating or expanding a `mansu-*` skill:

1. Find the best existing Ouroboros, Oh My, gstack, or other relevant source skills.
2. Check `mansu-operating-model/references/SOURCE_SKILL_CATALOG.md` for existing
   source skill maps and composition recipes.
3. Read the source skill enough to understand its purpose, gates, and philosophy.
4. Decide what Mansu should own and what should stay delegated.
5. Embed only the mandatory gates that must always hold.
6. Route specialized execution to the source skill when the task needs depth.
7. Leave evidence, validation, and a worklog entry.

## Design principle

`mansu-operating-model` is the canonical doctrine for this repo.
It defines the universal delivery spine, strictness, evidence rules, and the boundary between project `AGENTS.md` router docs and project `CODING_RULES.md` local operating manuals.

Good Mansu skills are thin where they can be thin and strict where they must be strict.

- Thin: source-specific implementation details, long checklists, tool mechanics.
- Strict: planning, safety, scope boundaries, evidence, verification, and completion rules.

Planning is a quality gate, not a default waiting room.

For non-trivial work, Mansu should plan through separated roles, critique the plan,
lock an execution-ready slice table, and then continue automatically. Pause only
when the user explicitly asks for a human approval gate, the action is risky, or
the plan still has unresolved blockers.

If real critic agents are started, their outputs are part of the gate. Mansu should
not ignore pending critics just to move faster; it may only fallback after recording
the timeout/failure and preserving unresolved high-risk questions as blockers.

## One sentence

Mansu plans, protects, routes, verifies, and records; specialized skills execute the
deep craft when they are better suited for it.
