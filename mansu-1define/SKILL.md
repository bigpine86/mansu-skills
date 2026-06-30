---
name: mansu-1define
description: Primary numbered process route backed by mansu-define. Define what to build before planning or implementation.
---

# Mansu 1 Define

Use this skill as the primary numbered route. It delegates execution details to the compatibility implementation `mansu-define`.

This is the user-facing numbered route. Read and follow the compatibility implementation `mansu-define/SKILL.md`.

In Codex, `mansu-1define` must actively discover and invoke the Ouroboros MCP
interview tool through `tool_search` before asking any Mansu-owned definition
question. If `mcp__ouroboros.ouroboros_interview` is exposed, call it with the
user's idea as `initial_context` and the current project directory as `cwd`.
If it is not exposed, route to `mansu-9setup repair` and re-check discovery
before any fallback definition.

## Route

- Compatibility implementation: `mansu-define`
- Process position: 1. Define
- Next route when complete: `mansu-2plan`

Do not start implementation from this skill. Finish the definition gate first,
then route to `mansu-2plan`.
