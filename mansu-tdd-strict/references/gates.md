# Gates

Each slice closes in this exact order:

1. `gstack-review`
2. `gstack-qa`
3. `gstack-checkpoint`
4. `git commit`

Do not change the order.

## Gate 1: review

Use `gstack-review` after REFACTOR is complete.

The review gate checks for:

- structural regressions
- unsafe side effects
- hidden coupling
- missed correctness risks

Do not continue if review finds a blocking issue.

## Gate 2: qa

Use `gstack-qa` after review is clean.

The QA gate must verify the contracts relevant to the slice.

Examples:

- slice-specific deterministic contract
- build or type-level validation when appropriate
- browser smoke when visible behavior changed

If QA fails:

- do not checkpoint the slice as closed
- do not commit
- return to RED/GREEN/REFACTOR inside the same slice

## Gate 3: checkpoint

Use `gstack-checkpoint` only after QA passes.

The checkpoint must capture:

- what this slice changed
- decisions made
- remaining work
- the next slice entry point
- the updated plan file current status and next actions for the still-active work

Checkpoint is required before commit.

## Gate 4: commit

Commit only after:

- review passed
- QA passed
- checkpoint saved

Rules:

- exactly one final commit per slice
- no auto-commit during QA
- no auto-commit during checkpoint
- no extra cleanup commit after the slice commit

## Slice lock

The next slice is forbidden until the current slice has:

- RED confirmed
- GREEN confirmed
- REFACTOR completed
- review completed
- QA completed
- checkpoint completed
- exactly one commit created

## Program closeout gate

After the final slice commit, but before declaring the overall loop complete:

1. run the relevant project-level build/test/type/lint suite
2. run final QA or browser verification when user-visible behavior changed
3. move completed program detail out of the active plan file
4. write the completed program into `개발일지.md`
5. leave only active follow-up items in the plan file
6. report verified checks, unverified checks, remaining risks, and follow-up items

Do not leave a fully completed program as active detail in the plan file.
