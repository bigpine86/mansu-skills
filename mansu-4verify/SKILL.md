---
name: mansu-4verify
description: Primary numbered process route backed by mansu-verify. Prove that the built behavior works.
---

# Mansu 4 Verify

Use this skill as the primary numbered route. It delegates execution details to the compatibility implementation `mansu-verify`.

This is the user-facing numbered route. Read and follow the compatibility implementation `mansu-verify/SKILL.md`.

## Route

- Compatibility implementation: `mansu-verify`
- Process position: 4. Verify
- Previous route: `mansu-3build`
- Next route when verification passes: `mansu-5review`

If verification fails and the cause is unknown, route to `mansu-debug`. If the
fix is clear, route back to `mansu-3build`.
