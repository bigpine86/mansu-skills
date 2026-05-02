---
name: mansu-start
description: Runtime-target-aware bootstrap/update workflow for the Mansu skill suite. Use when installing Mansu for the first time, choosing the right runtime target and host such as Hermes, OpenCode, Codex, or Claude Code, syncing `mansu-*` skills into the correct local skill directory, checking source tools like git and gstack, reporting optional adapter compatibility, refreshing gstack skill links, validating the installed skill suite, repairing a broken local skill install, or updating Mansu/gstack/adapter tooling before serious work.
---

# Mansu Start

Use this skill before relying on other Mansu skills, especially on a new machine,
after pulling repo changes, or after updating gstack / runtime compatibility tooling.

## Core promise

- Find the local Mansu repo and canonical branch.
- Detect the current runtime target, agent host, and operating system before choosing paths or commands.
- Sync `mansu-*` skills into the correct runtime skill directory.
- Check required source tools: runtime skill dir, git, and gstack.
- Verify optional compatibility adapters when they are installed or when the user explicitly asks.
- Refresh gstack skill links after a gstack update.
- Validate the installed Mansu suite.
- Report versions, missing pieces, compatibility warnings, and the next safe action.

## Modes

- `check`: report-only preflight; make no changes except harmless reads.
- `install`: first bootstrap from a local or cloned `mansu-skills` repo.
- `update`: update Mansu, gstack, and/or installed compatibility adapters when the user asks for updates.
- `repair`: fix missing local Mansu copies or stale gstack skill links without changing source repos.

Default behavior:

- If the user only asks to check readiness, use `check`.
- If Mansu skills are missing locally, use `install`.
- If the user says update, upgrade, latest, or refresh, use `update`.
- If source repos are current but local skill links/copies are broken, use `repair`.

## Runtime target, host, and OS detection

Before install, update, or repair, identify all three:

- Runtime target: `hermes`, `opencode`, `codex`, `claude-code`, or `unknown`
- Agent host: `opencode`, `codex`, `claude-code`, or `unknown`
- OS: `macos`, `linux`, `windows`, or `unknown`

Use direct evidence when possible:

- runtime/session signals: `tmux`, Hermes session metadata, OpenCode session context
- executable names: `codex`, `opencode`, `claude`
- config/home directories: `.codex`, `.opencode`, `.claude`
- environment variables exposed by the running agent
- `uname`, `sw_vers`, `/etc/os-release`, or Windows PowerShell / `cmd.exe` version checks

Do not assume the current repo was opened by Codex just because this skill is being read.
Do not infer adapter requirements from runtime target detection alone.

## Runtime target matrix

Choose the skill target from the detected runtime target and host first:

| Runtime target | Host | Skill target | Adapter expectation | Fallback behavior |
| --- | --- | --- | --- | --- |
| Hermes | OpenCode in tmux when detected | host-detected OpenCode skill dir | `omo` optional compatibility tooling | continue with Mansu + gstack checks; report adapter as skipped/missing if unavailable |
| OpenCode | `opencode` | host-detected OpenCode skill dir | `omo` optional compatibility tooling | continue with Mansu + gstack checks; report adapter status separately |
| Codex | `codex` | `$HOME/.codex/skills` | `omx` optional compatibility tooling | continue with Mansu + gstack checks; only block adapter work if explicitly requested |
| Claude Code | `claude-code` | `$HOME/.claude/skills` when present | `omc` optional compatibility tooling | continue with Mansu + gstack checks; report manual follow-up if layout is unclear |
| Unknown | `unknown` | do not write automatically | none | run `check`, report manual target, and avoid guessing |

## Adapter detection and compatibility

Treat adapters as optional compatibility tooling layered on top of the runtime target:

| Runtime target | Compatibility adapter | Notes |
| --- | --- | --- |
| Hermes | `omo` / Oh My OpenCode when installed | Hermes may run cleanly without an adapter; verify presence before using it |
| Codex | `omx` / Oh My Codex when installed | Optional compatibility tooling for Codex flows |
| OpenCode | `omo` / Oh My OpenCode when installed | Optional compatibility tooling for OpenCode flows |
| Claude Code | `omc` / Oh My Claude when installed | Optional compatibility tooling for Claude flows |
| Unknown | none | report required manual follow-up |

If a command exists but the host does not match, report it as available but do not
use it as the primary adapter without user confirmation.

If compatibility tooling is missing, continue with Mansu and gstack checks, skip adapter actions gracefully,
and report what was unavailable instead of failing the whole bootstrap/update flow.

If the user explicitly asked for adapter update/repair and the matching adapter is missing,
stop only that adapter step and report the exact manual follow-up.

## OS path rules

- macOS/Linux: prefer `$HOME/...` paths and POSIX shell commands.
- Windows: prefer `%USERPROFILE%` / PowerShell paths and avoid POSIX-only copy commands.
- WSL: record both Linux and Windows context if detected; install into the active agent's skill directory, not both.
- If path rules are uncertain, run `check` mode and report exact manual copy instructions instead of guessing.

## Safety rules

- Never use destructive git commands such as `git reset --hard` or `git checkout --` unless the user explicitly asks.
- Prefer `git pull --ff-only`, `git fetch` plus `git merge --ff-only`, or tool-provided safe update flows.
- Do not overwrite non-Mansu user skills in any host skill directory.
- Only write Mansu skill copies under the selected runtime target's `mansu-*` skill folders unless the user asks for a wider change.
- Only refresh gstack links under the selected runtime target's `gstack-*` skill folders from the installed gstack repo.
- If a repo is dirty, do not pull or merge it automatically; report the dirty state and ask for direction.
- Treat latest gstack `context-save` / `context-restore` as the checkpoint-family source skills. Flag stale `gstack-checkpoint` references as compatibility notes.

## Preflight

Collect this before making changes:

- current working directory and whether it is `mansu-skills`
- detected runtime target and confidence
- detected agent host and confidence
- detected OS and shell family
- Mansu repo path, branch, remote, and dirty state
- selected runtime skill directory existence and writeability
- installed Mansu skill folders in the selected runtime skill directory
- `git --version`
- `codex --version` when available
- `opencode --version` when available
- `claude --version` when available
- `uv --version` when available
- matching adapter expectation and whether `omx`, `omo`, or `omc` is actually available
- `uv tool list` when available
- gstack repo path, `VERSION`, and installed `gstack-*` skill links
- whether `gstack-context-save` and `gstack-context-restore` are available
- result of `scripts/validate_mansu_skills.sh` when the repo is present

## First install

If no Mansu repo exists, clone the canonical repo:

```bash
git clone https://github.com/bigpine86/mansu-skills.git
```

Then from the Mansu repo:

1. Confirm the branch is `main` or explain why it is not.
2. Detect runtime target, host, and OS, then choose the target skill directory.
3. Create the selected runtime skill directory if missing and safe.
4. Sync every top-level `mansu-*` directory into `<runtime-skill-dir>/<skill-name>`.
5. Do not copy `.git`, root docs, or non-skill files into individual skill folders.
6. Run `scripts/validate_mansu_skills.sh`.
7. Confirm the installed `mansu-start` path can be read.

## Update

When the user asks to update:

1. Check Mansu repo status. If clean, update with `git pull --ff-only`; if dirty, stop and report.
2. Re-detect runtime target, host, OS, and selected skill directory.
3. Sync all top-level `mansu-*` directories into the selected runtime skill directory.
4. Check gstack. If the user requested gstack update, use gstack's update flow or a safe `fetch` plus `merge --ff-only`, then run its setup if required.
5. Refresh gstack skill links from the installed gstack repo into the selected runtime skill directory.
6. Check compatibility tooling separately from runtime detection: Hermes/OpenCode may use `omo`, Codex may use `omx`, and Claude Code may use `omc`.
7. If the user requested adapter updates, update only the installed matching adapter; for Codex this may be `uv tool upgrade oh-my-codex` then `omx --update`.
8. Re-run `scripts/validate_mansu_skills.sh`.
9. Report version changes and compatibility notes.

If adapter tooling is missing and adapter work was not explicitly requested, continue the Mansu/gstack update path and record that the adapter step was skipped.

## Repair

Use repair when the source repos look correct but local runtime skills are missing or stale.

- Re-copy local `mansu-*` skill folders from the Mansu repo.
- Recreate missing gstack skill symlinks from the gstack repo if gstack exists.
- Verify `gstack-context-save` and `gstack-context-restore` are present after refresh.
- Re-run Mansu validation.
- Do not update remote repos during repair unless the user also requested update.

## Compatibility checks

Always watch for these drift signals:

- Mansu skills mention source skills that are no longer installed.
- gstack has `context-save` / `context-restore`, but Mansu docs still mention only `checkpoint`.
- The selected runtime target's adapter package version and CLI printed version disagree.
- installed `<runtime-skill-dir>/mansu-*` differs from the local repo.
- validators pass in the repo but the installed copy is missing `SKILL.md` or `agents/openai.yaml`.
- runtime/host detection is low-confidence, especially on Windows, WSL, or mixed Hermes/OpenCode/Claude/Codex setups.
- the runtime target is known but adapter tooling is missing, stale, or mapped to a different host than the active session.

Report drift instead of hiding it. Fix only safe sync/link drift automatically.

## Required report

End with this report:

```text
MANSU START REPORT
Mode:
Runtime target:
Host:
OS:
Detection confidence:
Skill target:
Mansu repo:
Mansu skills synced:
gstack:
Adapter status:
Validation:
Skipped checks:
Compatibility notes:
Next action:
```

If anything could not be checked, say exactly what was skipped and why.
