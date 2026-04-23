# Bootstrap

Run this only when `references/prerequisites.md` shows something missing.

## Missing Oh My XX orchestration or multi-agent support

- Stop before the implementation loop.
- Tell the user that this skill requires an Oh My XX orchestration environment with multi-agent support.
- Ask them to enable or install that environment first.
- Do not downgrade into a single-agent imitation of the same workflow.

## Missing gstack gates

If any of these are missing:

- a callable review gate
- a callable QA gate
- a callable checkpoint gate

Then:

- stop before implementation
- tell the user exactly which gate is unavailable
- ask them to install or link `gstack` before proceeding
- do not replace the missing gate with an ad-hoc manual step

## Missing repository documents

### plan file (`PLAN.md` / `Plan.md`)

If no active plan file exists, create one in the repository root and initialize it as:

- active work only
- next actions only
- decision log only

Prefer `PLAN.md` unless the project already uses `Plan.md`.

Do not backfill a fake project history into the plan file.

### `개발일지.md`

If the completed-work log is missing:

- create `doc/개발일지.md` if the repo already uses a `doc/` directory
- otherwise create `개발일지.md` at the repository root

Use it only for completed work. Do not put active slice state there.

## Bootstrap completion gate

Do not enter the planning loop until all of these are true:

- prerequisites are present
- document paths are resolved
- active plan path is known
- completed-work log path is known
