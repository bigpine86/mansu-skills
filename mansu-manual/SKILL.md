---
name: mansu-manual
description: Open or point to the prebuilt beginner-friendly HTML manual for the Mansu skill suite. Use for visual guides, skill lists, and route explanations.
---

# Mansu Manual

Use this skill to show the prebuilt beginner-friendly HTML manual for Mansu.

This skill should not generate the manual every time. The manual is a maintained
static artifact that lives in `docs/mansu-manual.html`.

## Core promise

- Point the user to the single self-contained HTML manual.
- Explain Mansu in beginner-friendly Korean.
- Put the development lifecycle flow first.
- Keep top-level `mansu-*` skills in their own `Mansu Skill` tab.
- Keep source-family details in the skill catalog, without duplicating Mansu's own top-level skills there.
- Keep an agent-facing routing map in the manual for entry, setup, help, and maintenance flows.
- List all current `mansu-*` skills with simple "when to use" guidance.
- Keep the manual easy to scan in a browser.
- Keep the manual updated whenever a new `mansu-*` skill is added or renamed.

## Agent self-orientation

When an agent is choosing which Mansu route to use, or when it invokes
`mansu-help`, `mansu-manual`, `mansu-setup`, or `mansu-source-curator`, treat
`docs/mansu-manual.html` as both:

- the human-facing visual manual
- the lightweight agent routing map

If a specific execution skill has already been selected, its own `SKILL.md`
remains the source of truth. Do not require every Mansu skill to read the manual
before execution.

Before answering about Mansu usage, selecting a route, or syncing installed
skills, read enough of the manual to confirm:

- the `에이전트 안내` tab exists and explains Mansu's routing posture
- the `Mansu Skill` tab exists and lists top-level `mansu-*` skills
- the `스킬 카탈로그` tab exists and is grouped by source family first, then purpose
- the runtime adapter mapping is visible: Codex -> LazyCodex / OMO with `omx` fallback, OpenCode/Hermes -> `omo`, Claude Code -> `omc`
- the lifecycle tab still points beginners to `mansu-help` first

Do not parse the whole HTML when targeted checks are enough. Do not open a
browser unless the user asked to view the manual.

## Manual path

The manual lives at:

```text
docs/mansu-manual.html
```

When the user asks for `mansu-manual`, provide this path and a short explanation.
If the environment supports opening local HTML, open or offer to open this file.

## Workflow

1. Locate the Mansu repo root.
2. Confirm `docs/mansu-manual.html` exists.
3. Report the manual path and what it contains.
4. If the manual is stale, update the static HTML file directly as part of the
   same change that added or renamed a skill.
5. Run `scripts/validate_mansu_manual.sh`.

## Manual maintenance requirements

Whenever a `mansu-*` skill is added, renamed, or materially changes purpose,
update `docs/mansu-manual.html` in the same change.

The HTML manual must include:

- What Mansu is, in plain language.
- Development lifecycle flow from first help/setup through project start,
  implementation, debugging, web verification, ship, and maintenance.
- `Mansu Skill` tab for directly callable top-level `mansu-*` skills.
- Agent guide tab explaining how agents should route Mansu work before acting.
- Skill cards for every top-level `mansu-*` skill.
- Skill catalog grouped by external/source family first, then purpose.
- Situation shortcuts for source skills.
- Generated timestamp or source note.

## Beginner tone

Use the same spirit as `mansu-help`:

- Plain Korean first, tool names second.
- No jargon before explanation.
- Prefer "what to do next" over complete theory.
- Make uncertainty visible.
- Give one recommended next step when possible.

## Validation

After generating, run:

```bash
scripts/validate_mansu_manual.sh
```

For suite validation:

```bash
scripts/validate_mansu_skills.sh
```

## Safety

- Showing the manual should not modify files.
- Updating the manual is allowed only when the manual is stale or a skill changed.
- Do not modify skill behavior while updating the manual.
- Do not commit or push unless the user explicitly asks.
