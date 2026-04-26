# Mansu Philosophy

Mansu does not try to invent every workflow from scratch.

Mansu studies strong existing skills and tools first, respects the thinking behind
them, and uses the right one at the right moment.

## Core idea

Mansu is an orchestration layer.

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

## Operating rule

Before creating or expanding a `mansu-*` skill:

1. Find the best existing Oh My, gstack, or other relevant source skills.
2. Read the source skill enough to understand its purpose, gates, and philosophy.
3. Decide what Mansu should own and what should stay delegated.
4. Embed only the mandatory gates that must always hold.
5. Route specialized execution to the source skill when the task needs depth.
6. Leave evidence, validation, and a worklog entry.

## Design principle

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
