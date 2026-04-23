# Templates

Use these templates as starting points. Keep them short and concrete.

## Final plan template

```markdown
## Active Work Item: {program name}
- Status: Planned
- Principle: {one sentence}

### Final plan
- {summary of intent}

### Sequential vertical slices
#### Slice 1. {name}
- Completion conditions
  - {condition}
- Impact files
  - `{path}`
- Test criteria
  - RED: {failing test}
  - GREEN: {passing condition}
  - REFACTOR: {cleanup rule}
- Risk factors
  - {risk}
```

## Slice decomposition row template

```markdown
#### Slice {n}. {slice name}
- Completion conditions
  - {done condition 1}
  - {done condition 2}
- Impact files
  - `{file 1}`
  - `{file 2}`
- Test criteria
  - RED: {what fails first}
  - GREEN: {what passes}
  - REFACTOR: {what gets split or cleaned}
- Risk factors
  - {risk 1}
  - {risk 2}
```

## Slice report template

```markdown
Slice {n}
- Completed slice: `{slice name}`
- Implementation:
  - {one or two concrete changes}
- Files:
  - `{path}`
  - `{path}`
- Tests:
  - `{command}` PASS
- Review / QA / checkpoint:
  - review: {summary}
  - qa: {summary}
  - checkpoint: {summary}
- Commit:
  - `{hash}` `{message}`
- Next slice:
  - `{next slice name}`
```

## Active plan maintenance rule

The active plan file should contain:

- active work item
- current execution status
- next actions
- decision log

At each slice checkpoint:

- update the current slice status
- replace stale next actions with the next concrete steps
- keep completed slice detail minimal while the program is still active

Remove completed program detail from the plan file once the whole loop is done.

## Completed-work log template

```markdown
## 📅 {date}: {program title}
> **"{one-line outcome}"**

### 1. Work summary
- {summary}

### 2. Slices completed
- Slice 1: {result}
- Slice 2: {result}

### 3. Verification
- `{command}` PASS

### 4. Commits
- `{hash}` `{message}`

### 5. Follow-up
- {remaining observation or deployment follow-up}
```

## Final closeout checklist

When all slices are complete:

- add the finished program to `개발일지.md`
- trim the plan file back to active follow-up only
- keep the plan file and `개발일지.md` from describing the same completed work in parallel
