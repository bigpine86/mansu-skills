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
- Public lifecycle spine: `mansu-1define -> mansu-2plan -> mansu-3build -> mansu-4verify -> mansu-5review -> mansu-6ship`
- New product and UI/user-facing starts: recommend `mansu-1define` first.
  Define runs Ouroboros before any design-context work, records the design intent seed,
  then routes UI/user-facing scope to source-skill design-context
  interview. `mansu-2plan` consumes that handoff into `DESIGN.md`, design
  direction, approved artifacts, and roadmap.
- Compatibility aliases such as `mansu-project-start` must not replace, merge,
  rename, or hide the six separate numbered public phase routes.
- Hide legacy setup/kickoff surfaces from primary lifecycle guidance:
  `mansu-setting` remains a pure alias to `mansu-setup`, and
  `mansu-project-start` remains only a compatibility/specialized Zero-to-PLAN
  route. Recommend `mansu-1define`, then `mansu-2plan`, for new project starts.

Prefer the numbered names in final guidance:

- `mansu-1define`
- `mansu-2plan`
- `mansu-3build`
- `mansu-4verify`
- `mansu-5review`
- `mansu-6ship`
- `mansu-debug`
