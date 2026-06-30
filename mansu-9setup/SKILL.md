---
name: mansu-9setup
description: Primary numbered admin route backed by mansu-setup. Install, update, sync, and check Mansu runtime/source readiness.
---

# Mansu 9 Setup

Use this skill as the primary numbered route. It delegates execution details to the compatibility implementation `mansu-setup`.

This is the user-facing numbered route. Read and follow the compatibility implementation `mansu-setup/SKILL.md`.

Canonical Mansu repo:

```text
https://github.com/bigpine86/mansu-skills.git
```

If `mansu-setup/SKILL.md` is missing, stale, or unreadable on this machine, do
not stop with "cannot find Mansu". Bootstrap from the canonical repo:

1. Search for an existing `mansu-skills` checkout in the current workspace,
   common project roots, and `$HOME/.mansu/repos/mansu-skills`.
2. If no checkout exists, clone
   `https://github.com/bigpine86/mansu-skills.git` into
   `$HOME/.mansu/repos/mansu-skills`.
3. Use that checkout's `mansu-setup/SKILL.md` as the backing implementation.
4. For Codex, register/sync the current Mansu skills by copying every top-level
   `mansu-*` skill directory into `$HOME/.codex/skills/<skill-name>`.
5. Treat older registered Codex copies as stale. Replace Mansu-owned skill
   copies from the checkout, then run installed-copy validation before reporting
   setup complete.

## Route

- Compatibility implementation: `mansu-setup`
- Process position: 9. Setup / admin
- Use for install, update, source-check, runtime detection, sync, repair, and
  adapter compatibility.
- Codex registration target: `$HOME/.codex/skills`

`mansu-9setup` is not part of the normal 1 -> 6 development process. It is the
numbered setup/admin route.
