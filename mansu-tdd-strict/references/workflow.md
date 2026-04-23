# Workflow

Use this workflow only after prerequisites and bootstrap are complete.

## Phase 1: Plan-first synthesis

### Step 1. Draft with Prometheus

Create the first plan draft from the implementation request.

The draft must:

- define the problem in concrete terms
- identify the smallest user-visible end-to-end slices
- prefer narrow, shippable slices over abstract layers
- propose tests before implementation

### Step 2. Critique with Metis

Use Metis to critique:

- execution risk
- architecture risk
- hidden dependency risk
- missing validations
- slice boundary weakness

### Step 3. Critique with Momus

Use Momus to critique:

- over-scope
- unnecessary complexity
- fake elegance
- “too much system for too little user value”

### Step 4. Synthesize the final plan

Resolve disagreements with this priority order:

1. correctness
2. smallest executable slice
3. lower hidden dependency
4. lower gate burden

Record the final plan in `PLAN.md` before implementation starts.

## Phase 2: Slice decomposition

Break the work into sequential vertical slices.

Each slice must include:

- completion conditions
- impact files
- test criteria
- risk factors

Each slice must be:

- user-visible or behavior-visible
- independently closable
- small enough to fit a single RED/GREEN/REFACTOR loop

Do not start a new slice until the current one is fully closed.

## Phase 3: TDD execution

Each slice must follow:

### RED

- write the failing test first
- confirm it fails for the expected reason
- record the failing test name and failure reason

Prefer:

- behavior tests
- API contract tests
- browser or user-flow contracts

Avoid weak RED tests that only grep source text unless no stronger contract is possible.

### GREEN

- implement the smallest change that makes the RED test pass
- do not add extra features while making GREEN pass

### REFACTOR

- split responsibilities when they start mixing
- do not keep appending to a giant route, service, or component
- create files by responsibility:
  - route/handler
  - service
  - repository
  - read model
  - contract test
  - browser test

## File-structure rule

From the beginning, write toward stable responsibility boundaries.

If a file starts handling more than one responsibility:

- split it in the same slice
- do not leave that cleanup for “later”

## Partial-response policy for planning agents

- if 2 or more planning agents respond, synthesis may proceed
- if only 1 responds, do not start implementation
- if a critique is partial, note the missing area explicitly before continuing
