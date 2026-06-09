---
name: mansu-6ship
description: Primary numbered process route backed by mansu-ship. Decide ship or hold after verification and review.
---

# Mansu 6 Ship

Use this skill as the primary numbered route. It delegates execution details to the compatibility implementation `mansu-ship`.

This is the user-facing numbered route. Read and follow the compatibility implementation `mansu-ship/SKILL.md`.

## Route

- Compatibility implementation: `mansu-ship`
- Process position: 6. Ship
- Previous route: `mansu-5review`
- Final status: ship or hold

If shipping is held, name the missing gate and route back to `mansu-4verify`,
`mansu-5review`, `mansu-3build`, or `mansu-debug`.
