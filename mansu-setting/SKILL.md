---
name: mansu-setting
description: Pure compatibility alias for `mansu-setup`. Use only to route older `mansu-setting` calls to `mansu-setup` with the same mode and user intent.
---

# Mansu Setup Compatibility Alias

`mansu-setting` is kept as a pure compatibility alias for legacy calls.
Compatibility alias for `mansu-setup`; it must not grow setup behavior of its
own.

Use `$mansu-setup` for the actual setup, install, update, source-check,
source-curate, repair, validation, and runtime sync workflow.

When invoked:

1. Preserve the user's requested mode and intent.
2. Hand off to `$mansu-setup` with the same mode.
3. Do not duplicate setup logic in this alias.
4. Do not present `mansu-setting` as a public setup route; user-facing docs
   should prefer `mansu-9setup` and keep this alias only in compatibility notes.
