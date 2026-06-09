---
name: mansu-5review
description: Primary numbered process route backed by mansu-review. Review quality, risk, maintainability, design, and safety after verification.
---

# Mansu 5 Review

Use this skill as the primary numbered route. It delegates execution details to the compatibility implementation `mansu-review`.

This is the user-facing numbered route. Read and follow the compatibility implementation `mansu-review/SKILL.md`.

## Route

- Compatibility implementation: `mansu-review`
- Process position: 5. Review
- Previous route: `mansu-4verify`
- Next route when review passes: `mansu-6ship`

If review finds clear fixes, route back to `mansu-3build` and then
`mansu-4verify`. If the cause is unknown, route to `mansu-debug`.
