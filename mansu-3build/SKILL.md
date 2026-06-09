---
name: mansu-3build
description: Primary numbered process route backed by mansu-build. Implement the active phase through Mansu build slices.
---

# Mansu 3 Build

Use this skill as the primary numbered route. It delegates execution details to the compatibility implementation `mansu-build`.

This is the user-facing numbered route. Read and follow the compatibility implementation `mansu-build/SKILL.md`.

## Route

- Compatibility implementation: `mansu-build`
- Process position: 3. Build
- Previous route: `mansu-2plan`
- Next route when complete: `mansu-4verify`

If the active phase plan is missing, route back to `mansu-1define` /
`mansu-2plan`. If the cause of a failure is unknown, route to `mansu-debug`.
