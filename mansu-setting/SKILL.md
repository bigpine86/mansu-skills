---
name: mansu-setting
description: Compatibility alias for `mansu-setup`. Use only when an older prompt, document, or installed runtime still calls `mansu-setting`; immediately route the work to `mansu-setup` with the same mode and user intent.
---

# Mansu Setup Compatibility Alias

`mansu-setting` is kept as a compatibility alias.

Use `$mansu-setup` for the actual setup, install, update, source-check,
source-curate, repair, validation, and runtime sync workflow.

When invoked:

1. Preserve the user's requested mode and intent.
2. Hand off to `$mansu-setup` with the same mode.
3. Do not duplicate setup logic in this alias.
