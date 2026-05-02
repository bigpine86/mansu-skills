---
name: mansu-start
description: Host-aware and OS-aware bootstrap/update workflow for the Mansu skill suite. Use when installing Mansu for the first time, choosing the right agent host target such as Codex, OpenCode, or Claude Code, syncing `mansu-*` skills into the correct local skill directory, checking source tools like gstack and the matching Oh My adapter, refreshing gstack skill links, validating the installed skill suite, repairing a broken local skill install, or updating Mansu/gstack/Oh My before serious work.
---

# Mansu Start

Use this skill before relying on other Mansu skills, especially on a new machine,
after pulling repo changes, or after updating gstack / the matching Oh My adapter.

## Core promise

- Find the local Mansu repo and canonical branch.
- Detect the current agent host and operating system before choosing paths or commands.
- Sync `mansu-*` skills into the correct host skill directory.
- Check required source tools: host skill dir, git, gstack, and the matching Oh My adapter.
- Refresh gstack skill links after a gstack update.
- Validate the installed Mansu suite.
- Report versions, missing pieces, compatibility warnings, and the next safe action.

## Modes

- `check`: report-only preflight; make no changes except harmless reads.
- `install`: first bootstrap from a local or cloned `mansu-skills` repo.
- `update`: update Mansu, gstack, and/or the matching Oh My adapter when the user asks for updates.
- `repair`: fix missing local Mansu copies or stale gstack skill links without changing source repos.

Default behavior:

- If the user only asks to check readiness, use `check`.
- If Mansu skills are missing locally, use `install`.
- If the user says update, upgrade, latest, or refresh, use `update`.
- If source repos are current but local skill links/copies are broken, use `repair`.

## Host and OS detection

Before install, update, or repair, identify both:

- Agent host: `codex`, `opencode`, `claude-code`, or `unknown`
- OS: `macos`, `linux`, `windows`, or `unknown`

Use direct evidence when possible:

- executable names: `codex`, `opencode`, `claude`
- config/home directories: `.codex`, `.opencode`, `.claude`
- environment variables exposed by the running agent
- `uname`, `sw_vers`, `/etc/os-release`, or Windows PowerShell / `cmd.exe` version checks

Do not assume the current repo was opened by Codex just because this skill is being read.

## Host adapter map

Pick the Oh My adapter by host:

| Host | Skill target | Oh My adapter | Notes |
| --- | --- | --- | --- |
| Codex | `$HOME/.codex/skills` | `omx` / Oh My Codex | Current local default |
| OpenCode | host-detected OpenCode skill dir | `omo` / Oh My OpenCode | Verify install path before writing |
| Claude Code | `$HOME/.claude/skills` when present | `omc` / Oh My Claude | Verify Claude skill layout first |
| Unknown | do not write automatically | none | report required manual target |

If a command exists but the host does not match, report it as available but do not
use it as the primary adapter without user confirmation.

## OS path rules

- macOS/Linux: prefer `$HOME/...` paths and POSIX shell commands.
- Windows: prefer `%USERPROFILE%` / PowerShell paths and avoid POSIX-only copy commands.
- WSL: record both Linux and Windows context if detected; install into the active agent's skill directory, not both.
- If path rules are uncertain, run `check` mode and report exact manual copy instructions instead of guessing.

## Safety rules

- Never use destructive git commands such as `git reset --hard` or `git checkout --` unless the user explicitly asks.
- Prefer `git pull --ff-only`, `git fetch` plus `git merge --ff-only`, or tool-provided safe update flows.
- Do not overwrite non-Mansu user skills in any host skill directory.
- Only write Mansu skill copies under the selected host's `mansu-*` skill folders unless the user asks for a wider change.
- Only refresh gstack links under the selected host's `gstack-*` skill folders from the installed gstack repo.
- If a repo is dirty, do not pull or merge it automatically; report the dirty state and ask for direction.
- Treat latest gstack `context-save` / `context-restore` as the checkpoint-family source skills. Flag stale `gstack-checkpoint` references as compatibility notes.

## Preflight

Collect this before making changes:

- current working directory and whether it is `mansu-skills`
- detected agent host and confidence
- detected OS and shell family
- Mansu repo path, branch, remote, and dirty state
- selected host skill directory existence and writeability
- installed Mansu skill folders in the selected host skill directory
- `git --version`
- `codex --version` when available
- `opencode --version` when available
- `claude --version` when available
- `uv --version` when available
- `omx`, `omo`, or `omc` version/update checks according to host
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
2. Detect host and OS, then choose the target skill directory.
3. Create the selected host skill directory if missing and safe.
4. Sync every top-level `mansu-*` directory into `<host-skill-dir>/<skill-name>`.
5. Do not copy `.git`, root docs, or non-skill files into individual skill folders.
6. Run `scripts/validate_mansu_skills.sh`.
7. Confirm the installed `mansu-start` path can be read.

## Update

When the user asks to update:

1. Check Mansu repo status. If clean, update with `git pull --ff-only`; if dirty, stop and report.
2. Re-detect host, OS, and selected skill directory.
3. Sync all top-level `mansu-*` directories into the selected host skill directory.
4. Check gstack. If the user requested gstack update, use gstack's update flow or a safe `fetch` plus `merge --ff-only`, then run its setup if required.
5. Refresh gstack skill links from the installed gstack repo into the selected host skill directory.
6. Check the host adapter: Codex uses `omx`, OpenCode uses `omo`, Claude Code uses `omc`.
7. If the user requested Oh My update, update the matching adapter only; for Codex this may be `uv tool upgrade oh-my-codex` then `omx --update`.
8. Re-run `scripts/validate_mansu_skills.sh`.
9. Report version changes and compatibility notes.

## Repair

Use repair when the source repos look correct but local host skills are missing or stale.

- Re-copy local `mansu-*` skill folders from the Mansu repo.
- Recreate missing gstack skill symlinks from the gstack repo if gstack exists.
- Verify `gstack-context-save` and `gstack-context-restore` are present after refresh.
- Re-run Mansu validation.
- Do not update remote repos during repair unless the user also requested update.

## Compatibility checks

Always watch for these drift signals:

- Mansu skills mention source skills that are no longer installed.
- gstack has `context-save` / `context-restore`, but Mansu docs still mention only `checkpoint`.
- The selected host's Oh My adapter package version and CLI printed version disagree.
- installed `<host-skill-dir>/mansu-*` differs from the local repo.
- validators pass in the repo but the installed copy is missing `SKILL.md` or `agents/openai.yaml`.
- host detection is low-confidence, especially on Windows, WSL, or mixed Claude/Codex/OpenCode setups.

Report drift instead of hiding it. Fix only safe sync/link drift automatically.

## Required report

End with this report:

```text
MANSU START REPORT
Mode:
Host:
OS:
Skill target:
Mansu repo:
Mansu skills synced:
gstack:
Oh My adapter:
Validation:
Compatibility notes:
Next action:
```

If anything could not be checked, say exactly what was skipped and why.
