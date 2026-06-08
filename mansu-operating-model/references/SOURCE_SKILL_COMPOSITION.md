# Mansu Source Skill Composition

Mansu uses this reference when similar source skills overlap.

Canonical lifecycle:

```text
Define -> Plan -> Build -> Verify -> Review -> Ship
```

Mansu does not choose one source family forever. It chooses the source skill that
best fits the current phase, then keeps Mansu-owned gates, evidence, and final
judgment visible.

LazyCodex is runtime transport for Codex. It may carry OMO execution modes, but
it must not appear as a phase source or replace Mansu's source-skill routing.

## Reference Layers

| Layer | File | Use |
| --- | --- | --- |
| Source family encyclopedia | `SOURCE_SKILL_CATALOG.md` | what each upstream family can do |
| Similar-skill comparison | `SOURCE_SKILL_COMPOSITION.md` | how to combine overlapping skills |
| Construction router | `CODE_CONSTRUCTION_ORDER.md` | how phase and coding order are detected |
| Runtime readiness | `mansu-setup` | how Codex/OpenCode/Claude Code/Hermes transports are installed and checked |

## Phase Composition Map

| Mansu phase | Internal order | Primary source skill mix |
| --- | --- | --- |
| `mansu-define` | Idea intake -> User/problem interview -> Requirements -> Acceptance criteria -> Source-of-truth seed | addyosmani `interview-me`, `idea-refine`, `spec-driven-development`; Ouroboros `interview`, `pm`, `seed`, `brownfield`; gstack `office-hours`, `plan-ceo-review` |
| `mansu-plan` | Requirements/Spec -> Architecture -> Design Direction -> Implementation Roadmap | addyosmani `spec-driven-development`, `planning-and-task-breakdown`, `api-and-interface-design`, `source-driven-development`; OMO `ulw-plan`; gstack `autoplan`, `plan-ceo-review`, `plan-eng-review`, `plan-devex-review`, `gstack-plan-design-review` |
| Design inside `mansu-plan` | Reference discovery -> Design system/artifact -> Variant exploration -> Design review -> Build handoff | OMO research/deepsearch when available; Open Design; VoltAgent/awesome-design-md; gstack `gstack-design-consultation`, `gstack-design-shotgun`, `gstack-plan-design-review`, `gstack-design-html`; addyosmani `frontend-ui-engineering` |
| `mansu-build` | Context pack -> Contract/source verification -> Slice plan -> Implement -> Local validation -> Checkpoint | `mansu-tdd-total` as the default build orchestrator; addyosmani `context-engineering`, `source-driven-development`, `incremental-implementation`, `test-driven-development`; OMO `start-work`, `programming`, `ulw-loop`, `lsp`; gstack `guard`, `careful`, `checkpoint` |
| `mansu-verify` | Test evidence -> Runtime/browser evidence -> QA report -> Security/perf checks -> Closeout | addyosmani `test-driven-development`, `browser-testing-with-devtools`, `security-and-hardening`, `performance-optimization`; gstack `qa-only`, `qa`, `browse`, `health`, `cso`, `benchmark`; Ouroboros `qa`, `evaluate`; OMO `review-work` |
| `mansu-review` | Diff review -> Architecture/design/security critique -> AI-slop/simplification pass -> Root-cause loop -> Re-verify | addyosmani `code-review-and-quality`, `code-simplification`, `debugging-and-error-recovery`, `doubt-driven-development`; gstack `review`, `plan-eng-review`, `plan-design-review`, `design-review`, `investigate`, `cso`; OMO `review-work`, `remove-ai-slops`, `debugging`, `comment-checker` |
| `mansu-debug` | Reproduce -> Isolate -> Hypothesize -> Prove root cause -> Minimal fix -> Regression proof | `mansu-debug-rootcause`; OMO `debugging`; addyosmani `debugging-and-error-recovery`, `doubt-driven-development`; gstack `investigate`, `browse`, `qa-only` |
| `mansu-ship` | Release readiness -> Version/changelog/docs -> Commit/push/PR/deploy decision -> Canary -> Learning handoff | `mansu-ship-release`; addyosmani `git-workflow-and-versioning`, `ci-cd-and-automation`, `documentation-and-adrs`, `shipping-and-launch`; gstack `ship`, `document-release`, `land-and-deploy`, `canary`, `retro`, `learn`; Ouroboros `publish`, `status` |

## Similar Skill Choices

| Overlap | Prefer this when | Combine this way |
| --- | --- | --- |
| addyosmani `interview-me` vs Ouroboros `interview` | Use `interview-me` for lightweight clarification; use Ouroboros when the project needs durable Seed/Ledger/source-of-truth artifacts. | Start with addyosmani for crisp questions if needed, then let Ouroboros create the durable definition. |
| addyosmani planning vs OMO `ulw-plan` vs gstack `autoplan` | Use addyosmani for engineering phase discipline, OMO for decomposition mechanics, and gstack for specialist critique. | Draft with addyosmani/OMO, then send the plan through gstack reviewers before Build. |
| Open Design vs design-md vs gstack design skills | Use Open Design for callable artifact generation, design-md for `DESIGN.md` grammar, and gstack for critique/options. | Research references, create or update design artifact, compare options, then run plan-stage design review. |
| `mansu-tdd-total` vs OMO build modes | Use `mansu-tdd-total` for Mansu build governance; use OMO modes as execution habits inside a slice. | Mansu owns slice gates and evidence; OMO can accelerate the actual execution path. |
| gstack QA vs addyosmani verification | Use addyosmani to choose the verification style; use gstack to act as independent QA/browser/security/perf specialist. | Verify proves behavior; Review judges quality. Do not merge these gates. |

## Composition Routes

- Fuzzy new product: addyosmani `interview-me` -> gstack `office-hours` -> Ouroboros `interview`/`seed` -> `mansu-plan`.
- Clear new project: Ouroboros `interview`/`pm`/`seed` -> addyosmani `spec-driven-development` -> gstack plan review -> `mansu-plan`.
- Complex implementation: addyosmani `planning-and-task-breakdown` -> OMO `ulw-plan` or gstack `autoplan` -> `mansu-build` / `mansu-tdd-total`.
- UI/product design: OMO research/deepsearch -> Open Design or design-md route -> gstack `gstack-design-shotgun` or `gstack-design-consultation` -> `gstack-plan-design-review`.
- Unknown failure: `mansu-debug` -> `mansu-debug-rootcause` -> OMO `debugging` habit -> gstack `investigate` -> regression proof.
- Ship candidate: `mansu-verify` -> `mansu-review` -> `mansu-ship` / `mansu-ship-release` -> gstack ship/deploy/canary/learn as needed.

## Invariants

- Source skills own specialist craft; Mansu owns routing, gates, evidence, and final accountability.
- If a source skill is unavailable, record the skipped source and use the closest verified fallback.
- Design is part of Plan for user-facing products, not an afterthought during Build.
- Verify proves behavior with evidence.
- Review judges quality, maintainability, security, design risk, and decision risk.
- Debug is a special route that can interrupt any phase when the cause is unknown.
- LazyCodex is runtime transport and must not appear as a phase source.
