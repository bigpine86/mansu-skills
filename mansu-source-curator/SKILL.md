---
name: mansu-source-curator
description: Hidden/internal maintenance workflow for refreshing Mansu's source-skill knowledge. Use when source drift requires catalog, validator, manual, or worklog updates.
---

# Mansu Source Curator

This is an internal maintenance skill.

Use it to keep Mansu's source-skill map honest after Ouroboros, gstack, Oh My /
OMO / OMC, addyosmani/agent-skills, VoltAgent/awesome-design-md, Open Design,
or runtime adapter changes.

Do not use this skill for normal feature implementation. It maintains Mansu's
knowledge of other skills.

## Core promise

- Check source freshness before editing references.
- Update source tools only when the user asked for update.
- Read original source skills before changing Mansu routing.
- Record added, removed, renamed, and semantically changed source skills.
- Update Mansu references and validators together.
- Preserve Mansu as an orchestrator, not a clone of source skills.
- Keep the HTML manual's agent guide and catalog in sync with source-skill routing.
- Leave a worklog entry and validation evidence.

## Modes

- `check`: report source freshness and reference drift without changing files.
- `update`: safely update installed source repos or adapters, then inspect drift.
- `curate`: update Mansu references and validators after source drift is known.
- `full-refresh`: update, inspect, curate, validate, dry-run routing, and sync local installed Mansu skills.
- `repair`: fix stale local Mansu copies or broken reference links without updating remote sources.

Default to `check` for latest/current/stale/freshness/check/refresh wording.
Only mutate when the user explicitly says update, install, sync, curate,
full-refresh, repair, or "make changes".

## Mansu Self-Evolution Loop

Use this loop only for Mansu-suite maintenance. It keeps Mansu's routing map
fresh; it must not clone source-skill workflows into Mansu.

1. Check source freshness from source-of-truth repos, installed tools, lock
   evidence, or official GitHub data.
2. Decide routing impact: for each drift item, record whether Mansu routing,
   gates, artifacts, validators, manual guidance, or worklogs must change.
3. Mutate only affected Mansu artifacts: `SOURCE_SKILL_LOCK.json`,
   `SOURCE_SKILL_CATALOG.md`, document/code routers, affected `mansu-*` skills,
   `docs/mansu-manual.html`, validators, and worklog.
4. Validate with `scripts/validate_mansu_manual.sh`,
   `scripts/validate_mansu_skills.sh`, and `git diff --check`.
5. Dry-run the updated routing in check/report-only mode against representative
   tasks before syncing installed copies.
6. Sync installed Mansu copies only after validation and dry-run pass.
7. Record worklog evidence: sources checked, routing decisions, files changed,
   validators run, dry-run result, sync result, and remaining drift.

## Source families

| Source family | Check | Update when requested | Mansu references to review |
| --- | --- | --- | --- |
| Ouroboros | installed `ouroboros` command, Codex `mcp__ouroboros.ouroboros_interview` exposure, package version, runtime setup status, Seed/Ledger/project-definition docs or skills; record `ooo` only as legacy compatibility evidence | official installer or safe Python tool update, then `ouroboros setup --runtime <target>` when supported | `SOURCE_SKILL_CATALOG.md`, `mansu-setup`, `mansu-project-start`, document-order references, validators |
| gstack | installed repo, `VERSION`, `.agents/skills/gstack-*` names, notable skill docs | `gstack-upgrade` skill or safe `git fetch` + fast-forward path | `SOURCE_SKILL_CATALOG.md`, `DOCUMENT_CREATION_ORDER.md`, `mansu-setup`, validators |
| Oh My / OMO / OMC | installed adapter command, skill directories, execution-mode names | matching adapter update only when installed or requested | `SOURCE_SKILL_CATALOG.md`, TDD/debug/web verify docs, runtime wording |
| addyosmani/agent-skills | local clone if present, otherwise GitHub contents/API, skill names and phase semantics | safe fast-forward local clone only; do not install into runtime skills by default | `SOURCE_SKILL_CATALOG.md`, `DOCUMENT_CREATION_ORDER.md`, `CODE_CONSTRUCTION_ORDER.md`, TDD docs |
| VoltAgent/awesome-design-md | local clone if present, otherwise GitHub contents/API, commit, `DESIGN.md` count, and notable format changes | safe fast-forward local clone only; source-reference only; do not install into runtime skills | `SOURCE_SKILL_CATALOG.md`, `DOCUMENT_CREATION_ORDER.md`, `mansu-project-start`, `mansu-setup`, `docs/mansu-manual.html`, validators |
| Open Design / nexu-io/open-design | local clone if present, otherwise GitHub contents/API, commit, skills, design systems, lifecycle command, preview/export contract | safe fast-forward local clone only; install/update/run lifecycle only when user approved design artifact work | `SOURCE_SKILL_CATALOG.md`, `DOCUMENT_CREATION_ORDER.md`, `mansu-project-start`, `mansu-setup`, `docs/mansu-manual.html`, validators |
| Mansu repo | branch, dirty state, validator health, local installed skill copies | `git pull --ff-only` only when clean and requested | README, validators, worklog, local skill cache |
| Runtime adapters | `omx`, `omo`, `omc`, host/runtime target, optional compatibility status | update only the matching installed adapter when requested | `mansu-setup`, runtime target matrix, runtime readiness validator |

## Safety rules

- Never use destructive git commands.
- Do not pull or merge a dirty repo automatically.
- Do not install addyosmani/agent-skills into runtime skill directories unless the user explicitly asks.
- Do not install VoltAgent/awesome-design-md into runtime skill directories. It is
  a source-reference collection for `DESIGN.md`, not an executable skill family.
- Do not copy Open Design into runtime skill directories. It is an external
  callable design-artifact route with its own repo, daemon, preview, and
  artifact workspace.
- Do not ask the user to run Open Design CLI commands manually when Mansu has
  been asked and approved to prepare or use Open Design. Mansu runs the commands
  and records the evidence.
- Do not copy public brand identities blindly from design references.
- Do not treat missing optional adapters as fatal unless adapter work was requested.
- Do not update Mansu references from memory. Read source skill files, source directory listings, or official GitHub data first.
- Do not copy whole source workflows into Mansu. Capture routing, gates, artifacts, and composition insights.
- Do not make project-delivery claims. This skill only maintains the Mansu suite.
- Do not sync uncommitted Mansu repo changes into installed runtime skill copies unless the user explicitly requests WIP sync. Otherwise wait until the Mansu changes are committed or update-approved.

## Phase 0: Preflight

Collect:

- Mansu repo path, branch, remote, dirty state
- selected runtime target and local skill directory when available
- Ouroboros CLI/package version, setup status, and relevant project-definition artifacts or skills
- gstack repo path and version
- Oh My / OMO / OMC adapter status and source-skill locations
- addyosmani/agent-skills source availability: local clone or GitHub
- VoltAgent/awesome-design-md source availability: local clone or GitHub,
  commit, `DESIGN.md` inventory count, and format sections
- Open Design source availability: local clone or GitHub, commit, lifecycle
  command, skills, design systems, visual directions, preview/export contract,
  and current install/run evidence
- current `SOURCE_SKILL_CATALOG.md` snapshot date
- current `SOURCE_SKILL_LOCK.json` source paths, versions, commits, inventory, and evidence commands
- current `DOCUMENT_CREATION_ORDER.md` and `CODE_CONSTRUCTION_ORDER.md` coverage
- current `docs/mansu-manual.html` agent guide, catalog grouping, runtime adapter mapping, and validator status
- validator status before changes when useful

If the Mansu repo is dirty, continue with read-only checks but do not update
source repos automatically.

## Phase 1: Source freshness check

For each source family:

1. List available source skills or commands.
2. Compare names against Mansu references.
3. Identify added, removed, renamed, or split skills.
4. Identify semantic changes that affect routing, gates, artifact names, or validation.
5. Record unknowns and skipped checks with reasons.

Use current official or source-of-truth data when the source may have changed.
For GitHub-hosted sources, prefer GitHub API or raw files over memory.

## Phase 2: Optional source update

Only run this phase when the user asked for update or full refresh.

- gstack: use `gstack-upgrade` when available; otherwise use safe fetch and fast-forward only.
- Ouroboros: use the official installer/package-manager update path when safe, then rerun runtime setup; do not start a project from the curator.
- Oh My / OMO / OMC: update the matching installed adapter or source repo only when it exists or was explicitly requested.
- addyosmani/agent-skills: update a local clone with safe fast-forward only; otherwise use read-only GitHub data.
- VoltAgent/awesome-design-md: update a local clone with safe fast-forward only
  or use read-only GitHub data; do not install or copy it into runtime skill dirs.
- Open Design: update a local clone with safe fast-forward only or use read-only
  GitHub data; install dependencies or run lifecycle commands only when the user
  explicitly approved Open Design setup/use for design artifact work.
- Mansu: update with `git pull --ff-only` only when clean and requested.

After updating, repeat Phase 1. Source update without re-inspection is incomplete.

## Phase 3: Curate Mansu references

Update only the Mansu files affected by source drift.

Common targets:

- `mansu-operating-model/references/SOURCE_SKILL_CATALOG.md`
- `mansu-operating-model/references/SOURCE_SKILL_LOCK.json`
- `mansu-operating-model/references/DOCUMENT_CREATION_ORDER.md`
- `mansu-operating-model/references/CODE_CONSTRUCTION_ORDER.md`
- `docs/mansu-manual.html`
- `mansu-manual/SKILL.md`
- `mansu-setup/SKILL.md`
- `mansu-project-start/SKILL.md`
- `mansu-tdd-total/SKILL.md`
- `mansu-tdd-lite/SKILL.md`
- `mansu-tdd-strict/SKILL.md`
- `mansu-debug-rootcause/SKILL.md`
- `mansu-web-verify/SKILL.md`
- validation scripts under `scripts/`
- `README.md` only when a user-facing entry point changed
- `개발일지.md` or `WORKLOG.md`

For each reference change, preserve this shape:

- source family
- source skill or artifact name
- what changed
- how Mansu routes to it
- what Mansu owns
- what stays delegated
- validation added to prevent drift

For Oh My / OMO / OMC, do not treat aggregated runtime skill listings as upstream
truth. Prefer adapter-owned package/repo roots or adapter-owned skill roots. If
using `omx --skills`, `omo` output, or `~/.codex/skills` as installed evidence,
Exclude `mansu-*`, `gstack-*`, project-local skills, and unrelated curated skills
before recording source drift.

## Phase 4: Validate and sync

Run:

```bash
scripts/validate_mansu_manual.sh
scripts/validate_mansu_skills.sh
git diff --check
```

Before syncing installed runtime copies, dry-run the updated routing in
check/report-only mode against representative tasks. At minimum include one
source-health task, and include implementation, design, debug, or release tasks
when those routes changed. Record the dry-run result and unresolved questions.

When local installed Mansu skills are part of the requested update, sync the
changed `mansu-*` folders into the active runtime skill directory after validation.
If `docs/mansu-manual.html` changed, also copy it into the installed
`mansu-manual/docs/mansu-manual.html` artifact path.
After syncing, run `MANSU_COMPARE_INSTALLED=1 scripts/validate_mansu_installed_copies.sh <runtime-skill-dir>`.

Do not sync if validation fails.

## Required report

End with:

```text
MANSU SOURCE CURATOR REPORT
Mode:
Status: Green/Yellow/Red
Read-only or mutating:
Sources checked:
Sources updated:
Added/removed/renamed skills:
Routing impact:
Reference files changed:
Manual updated:
Source lock:
Validators changed:
Validation:
Dry-run:
Local skill sync:
Changes made:
Catalog trustworthy:
Skipped checks:
Remaining drift:
Approval needed:
Next action:
Beginner next prompt:
Worklog:
```

If no references changed, say so and include the evidence that they are current.
