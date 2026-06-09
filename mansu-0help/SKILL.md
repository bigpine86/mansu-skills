---
name: mansu-0help
description: Primary numbered entry route backed by mansu-help. Use first when the user is unsure which Mansu process step comes next.
---

# Mansu 0 Help

Use this skill as the primary numbered route. It delegates execution details to the compatibility implementation `mansu-help`.

This is the user-facing numbered route. Read and follow the compatibility implementation `mansu-help/SKILL.md`.

## Route

- Compatibility implementation: `mansu-help`
- Process position: entry / orientation
- Next route: choose the correct numbered Mansu skill and give the user the
  exact next command.

Prefer the numbered names in final guidance:

- `mansu-1define`
- `mansu-2plan`
- `mansu-3build`
- `mansu-4verify`
- `mansu-5review`
- `mansu-6ship`
- `mansu-debug`
