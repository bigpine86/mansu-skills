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

## One sentence

Mansu plans, protects, routes, verifies, and records; specialized skills execute the
deep craft when they are better suited for it.
