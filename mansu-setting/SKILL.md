---
name: mansu-setting
description: Runtime-target-aware bootstrap/update workflow for the Mansu skill suite. Use when installing Mansu for the first time, choosing the right runtime target and host such as Hermes, OpenCode, Codex, or Claude Code, syncing `mansu-*` skills into the correct local skill directory, installing or updating required source tools like Ouroboros, gstack, and the matching Oh My adapter, checking Ouroboros, Oh My / OMO / OMC source skill freshness, checking addyosmani/agent-skills freshness for coding-order source workflows, checking VoltAgent/awesome-design-md freshness for DESIGN.md design-reference workflows, reporting optional adapter compatibility, refreshing gstack and Oh My source skill links, validating the source suite before sync and installed runtime copies after sync, repairing a broken local skill install, or updating Mansu/Ouroboros/gstack/Oh My/agent-skills/design-reference/adapter tooling before serious work.
---

# Mansu Setting

Use this skill before relying on other Mansu skills, especially on a new machine,
after pulling repo changes, or after updating Ouroboros / gstack / runtime compatibility tooling.

This is Mansu's basic setting skill. It should not merely report that source
tools are missing during `install` or `update`; it should install or update the
safe, expected tools for the detected runtime whenever the required package
manager is available.

## Core promise

- Find the local Mansu repo and canonical branch.
- Detect the current runtime target, agent host, and operating system before choosing paths or commands.
- Sync `mansu-*` skills into the correct runtime skill directory.
- Install or update required source tools: runtime skill dir, git, Ouroboros, and gstack.
- Check source skill freshness for Ouroboros, gstack, Oh My / OMO / OMC, addyosmani/agent-skills style skills, and VoltAgent/awesome-design-md design references.
- Install or update the matching Oh My adapter for the detected runtime when in `install` or `update` mode.
- Refresh gstack and Oh My source skill links after source updates.
- Route deep source-reference refresh work to `mansu-source-curator`.
- Read/verify the Mansu manual's agent guidance and catalog before syncing installed skills.
- Validate the Mansu source suite before sync and installed runtime copies after sync.
- Report versions, missing pieces, compatibility warnings, and the next safe action.

## Modes

- `check`: report-only preflight; make no changes except harmless reads.
- `install`: first bootstrap from a local or cloned `mansu-skills` repo, then install required source tools such as Ouroboros, gstack, and the matching Oh My adapter when safe.
- `update`: update Mansu, Ouroboros, gstack, installed source repos, and the matching Oh My adapter when the user asks for updates.
- `source-check`: report whether Ouroboros, gstack, Oh My / OMO / OMC, addyosmani/agent-skills, and VoltAgent/awesome-design-md source references look stale against installed repos/adapters; make no changes unless the user also asked for update.
- `source-curate`: use `mansu-source-curator` when source skills changed and Mansu references, validators, or worklog must be updated.
- `repair`: fix missing local Mansu copies or stale gstack skill links without changing source repos.

Default behavior:

- If the user only asks to check readiness, use `check`.
- If Mansu skills are missing locally, use `install`.
- If the user asks whether source tools are latest, current, stale, fresh, or
  needs a refresh, use `source-check` first and make no changes.
- If the user says setup, setting, bootstrap, or install, use the mutating
  install path only after runtime target, host, OS, and install recipe evidence
  are checked.
- If the user explicitly says update, upgrade, sync, install missing tools, or
  "make changes", use the mutating update/install path.
- If source repos are current but local skill links/copies are broken, use `repair`.
- If source skills changed and Mansu reference docs must be updated, use `source-curate` or hand off to `mansu-source-curator`.

## Source freshness ladder

Use `Check -> Decide -> Mutate` for source ecosystem work.

1. Check: `mansu-setting source-check` is read-only. It checks Ouroboros,
   gstack, Oh My / OMO / OMC, addyosmani/agent-skills, and
   VoltAgent/awesome-design-md freshness, then reports skipped checks as yellow
   rather than green.
2. Decide: explain whether the source tools are current, which drift matters for
   Mansu routing, and which exact next route is recommended.
3. Mutate: only after explicit user approval, run `mansu-setting update` for
   source tool updates or `mansu-source-curator curate` for Mansu reference,
   validator, manual, and worklog updates.

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
| Hermes | OpenCode in tmux when detected | OpenCode global `~/.config/opencode/skills` or project `.opencode/skills` | `omo` optional compatibility tooling | continue with Mansu + gstack checks; report adapter as skipped/missing if unavailable |
| OpenCode | `opencode` | OpenCode global `~/.config/opencode/skills` or project `.opencode/skills` | `omo` optional compatibility tooling | continue with Mansu + gstack checks; report adapter status separately |
| Codex | `codex` | `$HOME/.codex/skills` | `omx` optional compatibility tooling | continue with Mansu + gstack checks; only block adapter work if explicitly requested |
| Claude Code | `claude-code` | `$HOME/.claude/skills` when present | `omc` optional compatibility tooling | continue with Mansu + gstack checks; report manual follow-up if layout is unclear |
| Unknown | `unknown` | do not write automatically | none | run `check`, report manual target, and avoid guessing |

## Source tool install policy

In `install` and `update` modes, missing source tools are work to do, not just facts to report.

Before any third-party or global install command runs, verify the install recipe.
Acceptable evidence is current source-lock evidence, installed source docs,
official repository documentation, official release notes, or package-manager
metadata that clearly matches the intended source family. If the recipe cannot be
verified, do not execute remote scripts or global package installs. Report the
step as `blocked by unverified install recipe` and continue with safe checks.

| Tool family | Install target | Install / update rule |
| --- | --- | --- |
| Ouroboros / `ouroboros` | user-level CLI plus runtime MCP/setup integration | If missing, prefer the official installer `curl -fsSL https://raw.githubusercontent.com/Q00/ouroboros/main/scripts/install.sh \| bash` when shell/network policy allows; otherwise use `uv tool install 'ouroboros-ai[all]'`, `pipx install 'ouroboros-ai[mcp]'`, or `pip install ouroboros-ai` depending on available Python tooling. After install or update, run `ouroboros setup --runtime <detected-runtime>` when the runtime is supported, otherwise run `ouroboros setup` and report runtime ambiguity. Mansu-setting only prepares Ouroboros; it must not run `ooo auto`, `ooo interview`, or project creation commands. |
| gstack | `$HOME/.gstack/repos/gstack` | If missing, clone `https://github.com/garrytan/gstack.git`; if present and clean, fast-forward update; then run `./setup --host <detected-host>` when the host is known, otherwise run `./setup` and report the host ambiguity. |
| Oh My Codex / `omx` | Codex runtime | If missing, install `oh-my-codex` with `uv tool install oh-my-codex` when `uv` exists, otherwise use an available Python tool installer such as `pipx`; on update prefer `uv tool upgrade oh-my-codex`, then run `omx-setup` or `omx --update` when available. |
| Oh My OpenCode / `omo` | Hermes or OpenCode runtime | If missing, install `oh-my-opencode` with `npm install -g oh-my-opencode` when Node/npm is available; on update run the same global npm install and then verify `omo` exists. |
| Oh My Claude / `omc` | Claude Code runtime | Prefer the currently documented Claude Code plugin install route for OMC; if the current OMC install command cannot be verified in the local/runtime docs, do not guess a package name. Report the exact missing install recipe as the blocker for this adapter only. |
| addyosmani/agent-skills | source-reference repo only | Keep as a source-reference family by default. If needed and missing, clone/update a local read-only reference copy, but do not copy it into runtime skill directories unless the user explicitly asks. |
| VoltAgent/awesome-design-md | source-reference repo only | Keep as a design-reference family by default. If UI/design workflows need it or the user asks, clone/update a local read-only reference copy and use it to shape `DESIGN.md`; do not copy it into runtime skill directories. |

Source tool installation rules:

- `check` never installs or updates anything.
- `install` installs missing Ouroboros, gstack, and the matching Oh My adapter when the runtime target is known and the package manager exists.
- `update` updates already-installed source tools and installs missing expected tools unless the user explicitly requested a check-only update report.
- If a source repo exists but is dirty, do not pull it; report the dirty state and skip only that source update.
- If a package manager is missing, do not fail the whole Mansu setup. Record the blocked tool, the missing package manager, and the exact next manual command.
- If an install recipe is unverified, do not fail the whole Mansu setup. Record the blocked tool, evidence checked, and the exact recipe gap.
- After any source tool install/update, rerun source freshness checks and then validation before syncing Mansu skills.
- Do not install adapters for runtimes that are not the active target unless the user explicitly asks for multi-runtime setup.
- Do not let `mansu-setting` start a project through Ouroboros. `mansu-project-start` owns Ouroboros PM/interview/Seed/Ledger usage.

## Adapter detection and compatibility

Treat adapters as runtime-matched compatibility tooling layered on top of the runtime target:

| Runtime target | Compatibility adapter | Notes |
| --- | --- | --- |
| Hermes | `omo` / Oh My OpenCode when installed | Hermes may run cleanly without an adapter; verify presence before using it |
| Codex | `omx` / Oh My Codex when installed | Optional compatibility tooling for Codex flows |
| OpenCode | `omo` / Oh My OpenCode when installed | Optional compatibility tooling for OpenCode flows |
| Claude Code | `omc` / Oh My Claude when installed | Optional compatibility tooling for Claude flows |
| Unknown | none | report required manual follow-up |

If a command exists but the host does not match, report it as available but do not
use it as the primary adapter without user confirmation.

In `check` mode, missing compatibility tooling is reported only.

In `install` or `update` mode, missing compatibility tooling for the detected runtime should be installed
using the source tool install policy above. If installation cannot proceed safely, skip only that adapter
step and report the blocker instead of silently treating the missing adapter as acceptable.

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
- Do not sync uncommitted Mansu repo changes into installed runtime skill copies unless the user explicitly requests WIP sync. Otherwise wait until the Mansu repo changes are committed or update-approved.
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
- `node --version` and `npm --version` when available
- `pipx --version` when available
- `ouroboros --version` when available
- Ouroboros setup status, runtime integration status, and whether `ooo` commands are available
- matching adapter expectation and whether `omx`, `omo`, or `omc` is actually available
- `uv tool list` when available
- gstack repo path, `VERSION`, and installed `gstack-*` skill links
- Oh My / OMO / OMC source skill locations, installed adapter version when available, and installed source-skill folders
- addyosmani/agent-skills repo path when installed, latest known release/tag or commit, and whether key coding-order skills exist
- VoltAgent/awesome-design-md repo path when installed, latest known commit, `DESIGN.md` inventory count, and whether the 9-section `DESIGN.md` shape still matches Mansu's design reference map
- whether `gstack-context-save` and `gstack-context-restore` are available
- whether Ouroboros, gstack, Oh My / OMO / OMC, addyosmani/agent-skills, and VoltAgent/awesome-design-md source names/formats still match the Mansu source catalog
- whether `CODE_CONSTRUCTION_ORDER.md` still maps to installed addyosmani/agent-skills phase names
- `docs/mansu-manual.html` existence, `에이전트 안내` tab, family-first `스킬 카탈로그`, and runtime adapter mapping
- result of `scripts/validate_mansu_skills.sh` when the repo is present
- install-recipe evidence for every third-party/global install step before it runs

## First install

If no Mansu repo exists, clone the canonical repo:

```bash
git clone https://github.com/bigpine86/mansu-skills.git
```

Then from the Mansu repo:

1. Confirm the branch is `main` or explain why it is not.
2. Detect runtime target, host, and OS, then choose the target skill directory.
3. Install or update Ouroboros using the source tool install policy.
4. Install or update gstack using the source tool install policy.
5. Install the matching Oh My adapter for the detected runtime when safe.
6. Check addyosmani/agent-skills as a source-reference family; clone/update a local reference only when coding-order workflows need it or the user asks.
7. Check VoltAgent/awesome-design-md as a design-reference family; clone/update a local reference only when UI/design workflows need it or the user asks.
8. Confirm `docs/mansu-manual.html` exists and includes the agent guide, family-first catalog, and selected runtime/adapter expectation.
9. Run `scripts/validate_mansu_manual.sh` and `scripts/validate_mansu_skills.sh` in the repo before syncing runtime copies.
10. Create the selected runtime skill directory if missing and safe.
11. Sync every top-level `mansu-*` directory into `<runtime-skill-dir>/<skill-name>`.
12. Copy `docs/mansu-manual.html` into `<runtime-skill-dir>/mansu-manual/docs/mansu-manual.html` so the installed manual skill has its HTML artifact.
13. Refresh gstack and Oh My source skill links/copies into the selected runtime target after their installers run.
14. Do not copy `.git`, unrelated root docs, or non-skill files into individual skill folders. The manual HTML is the only root-doc exception.
15. Run `MANSU_COMPARE_INSTALLED=1 scripts/validate_mansu_installed_copies.sh <runtime-skill-dir>` after syncing runtime copies.
16. Confirm the installed `mansu-setting` path can be read.
17. Confirm the installed `mansu-project-start` can use Ouroboros later, but do not start a project here.

## Update

When the user asks to update:

1. Check Mansu repo status. If clean, update with `git pull --ff-only`; if dirty, stop and report.
2. Re-detect runtime target, host, OS, and selected skill directory.
3. Install Ouroboros if missing; otherwise update it with the official installer/package manager path, then run `ouroboros setup` for the selected runtime when safe.
4. Install gstack if missing; otherwise update it with gstack's update flow or a safe `fetch` plus `merge --ff-only`, then run its setup for the selected host.
5. Install the matching Oh My adapter if missing; otherwise update it with the runtime-specific package manager and run its update/setup command when available.
6. Check Ouroboros and Oh My / OMO / OMC source skill freshness separately from runtime detection.
7. Check addyosmani/agent-skills freshness when installed or when coding-order workflows are requested.
8. Check VoltAgent/awesome-design-md freshness when installed, when UI/design workflows are requested, or when the design reference catalog is being curated.
9. If source skills changed in a way that affects Mansu routing, use `mansu-source-curator` to update `SOURCE_SKILL_CATALOG.md`, `SOURCE_SKILL_LOCK.json`, document/code-order references, validators, and worklog before relying on the new assumptions.
10. Confirm `docs/mansu-manual.html` still matches the updated routing assumptions; if runtime/source routing changed, update it before syncing.
11. Re-run `scripts/validate_mansu_manual.sh` and `scripts/validate_mansu_skills.sh`.
12. Sync all top-level `mansu-*` directories into the selected runtime skill directory only after source curation and validation pass.
13. Copy `docs/mansu-manual.html` into `<runtime-skill-dir>/mansu-manual/docs/mansu-manual.html` whenever the manual changed or runtime copies are refreshed.
14. Refresh gstack skill links from the installed gstack repo into the selected runtime skill directory.
15. Refresh Oh My / OMO / OMC source skill links or copies after the matching source is installed and the selected runtime target expects it.
16. Do not automatically install or copy addyosmani/agent-skills into runtime skill directories unless the user asks; use it as a source-reference family by default.
17. Do not automatically install or copy VoltAgent/awesome-design-md into runtime skill directories; use it as a design-reference family by default.
18. Run `MANSU_COMPARE_INSTALLED=1 scripts/validate_mansu_installed_copies.sh <runtime-skill-dir>` after runtime copies are refreshed.
19. Report version changes, installs performed, source skill freshness, manual readiness, installed-copy validation, reference curation status, and compatibility notes.

If adapter tooling is missing in `install` or `update`, attempt the matching install path.
Only record it as skipped after the install path is blocked by missing package manager,
unknown runtime target, dirty source directory, or unverified install recipe.

If addyosmani/agent-skills is missing and coding-order source work was not
explicitly requested, continue the Mansu/Ouroboros/gstack/Oh My update path and record that
the agent-skills source check was skipped.

If VoltAgent/awesome-design-md is missing and UI/design source work was not
explicitly requested, continue the Mansu/Ouroboros/gstack/Oh My update path and
record that the design-reference source check was skipped.

## Repair

Use repair when the source repos look correct but local runtime skills are missing or stale.

- Re-copy local `mansu-*` skill folders from the Mansu repo.
- Recreate missing gstack skill symlinks from the gstack repo if gstack exists.
- Recreate missing Oh My / OMO / OMC source skill links only when the matching source exists and the runtime target expects it.
- If Ouroboros, gstack, or the matching Oh My adapter is missing during repair, report that repair needs `install` mode rather than silently skipping the tool.
- Re-check addyosmani/agent-skills phase names against `CODE_CONSTRUCTION_ORDER.md`; do not copy them unless explicitly requested.
- Verify `gstack-context-save` and `gstack-context-restore` are present after refresh.
- Re-run Mansu validation.
- Run `scripts/validate_mansu_installed_copies.sh <runtime-skill-dir>` after repair; use `MANSU_COMPARE_INSTALLED=1` when the repair should exactly match the source repo.
- Do not update remote repos during repair unless the user also requested update.

## Compatibility checks

Always watch for these drift signals:

- Mansu skills mention source skills that are no longer installed.
- `mansu-operating-model/references/SOURCE_SKILL_CATALOG.md` is older than the installed Ouroboros, gstack, Oh My / OMO / OMC, or addyosmani/agent-skills source skills.
- `CODE_CONSTRUCTION_ORDER.md` references addyosmani/agent-skills phases that were renamed, removed, or split.
- `DOCUMENT_CREATION_ORDER.md` or the HTML manual references an older VoltAgent/awesome-design-md `DESIGN.md` format.
- source skills changed but `mansu-source-curator` has not updated affected Mansu references or validators.
- gstack has `context-save` / `context-restore`, but Mansu docs still mention only `checkpoint`.
- The selected runtime target's adapter package version and CLI printed version disagree.
- installed `<runtime-skill-dir>/mansu-*` differs from the local repo.
- validators pass in the repo but the installed copy is missing `SKILL.md` or `agents/openai.yaml`.
- installed-copy validation was skipped because no runtime skill directory was selected.
- runtime/host detection is low-confidence, especially on Windows, WSL, or mixed Hermes/OpenCode/Claude/Codex setups.
- the runtime target is known but adapter tooling is missing, stale, or mapped to a different host than the active session.

Report drift instead of hiding it. Fix only safe sync/link drift automatically.

## Required report

End with this report in the user's language or the project's default language.
The Korean field labels below are canonical for this repo; translate labels when
the target project or user language differs.

```text
MANSU SETTING 보고서
모드:
런타임 대상:
호스트:
운영체제:
감지 신뢰도:
스킬 설치 대상:
Mansu 레포:
Mansu 스킬 동기화:
매뉴얼:
gstack:
Ouroboros:
Oh My / OMO / OMC:
addyosmani/agent-skills:
VoltAgent/awesome-design-md:
설치/업데이트한 도구:
원천 스킬 최신성:
원천 레퍼런스 정리:
어댑터 상태:
검증:
설치본 검증:
건너뛴 확인:
호환성 메모:
다음 행동:
```

Write prose and values in the user's language or the project's default language. Keep
tool names, paths, commands, runtime names, and package names in their original
spelling. If anything could not be checked, say exactly what was skipped and why.
