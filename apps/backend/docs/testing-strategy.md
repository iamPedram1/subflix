# Testing Strategy

## Goals

- protect the Flutter-facing API contract
- keep business logic trustworthy as features grow
- catch persistence regressions early
- keep tests fast enough for regular local use

## Test Levels

### Unit Tests

Use unit tests for:

- subtitle parsing and formatting
- catalog provider behavior
- caching behavior
- preferences service logic
- translation job orchestration logic
- small pure utilities and mappers

Characteristics:

- no real database required
- mock collaborators at feature boundaries
- keep assertions focused on behavior, not implementation trivia

### Integration Tests

Use integration tests for:

- repository-backed service flows
- device ownership resolution
- preference persistence
- subtitle parse persistence
- translation job lifecycle persistence
- history, preview, retry, and cleanup flows

Characteristics:

- run against a real PostgreSQL database
- validate Prisma mappings and transactional behavior
- reuse shared DB reset helpers to keep suites isolated

### E2E Tests

Use e2e tests for:

- health route
- catalog search and subtitle source routes
- preferences routes
- subtitle upload route
- translation job creation, polling, preview, export, and retry

Characteristics:

- boot the Nest app with real HTTP handling
- use Supertest against the actual route contract
- verify headers, status codes, and public payload shapes

## Folder Structure

```text
test/
  core/shared/
  unit/
  integration/
  e2e/
```

Rules:

- shared fixtures and helpers belong in `test/core/shared`
- unit tests should mirror the feature/module being exercised
- integration and e2e tests should stay organized by feature

## Current Tooling

- Vitest for unit, integration, and e2e runners
- Supertest for HTTP-level assertions
- Prisma-backed DB tests gated by local database availability

## Database Test Policy

- DB-backed tests should be skipped gracefully when no test database is configured
- when enabled, each test suite must reset state before each test
- never depend on leftover state from previous runs
- prefer deterministic fixtures over random data unless uniqueness requires it

## Contract Protection

The most important API guarantees to keep tested are:

- normalized error envelope
- `x-device-id` enforcement on private routes
- pagination response shape
- translation job status transitions
- export availability only after completion
- preview data coming only from the preview endpoint

## Performance And Stability Coverage

Tests should also guard non-functional behavior where it matters:

- cache coalescing behavior
- duplicate runner scheduling protection
- ownership isolation between devices
- retry behavior creating a new job rather than mutating the old one

## Writing New Tests

When adding a backend feature:

1. add or update unit tests for the service or utility logic
2. add integration coverage if persistence or transactions are involved
3. add e2e coverage if the public route contract changes
4. prefer reusable helpers over copy-pasted app/bootstrap code

## Anti-Patterns To Avoid

- over-mocking Prisma for flows that should be integration tested
- asserting private method calls instead of public behavior
- mixing large scenario setup inline in every test
- allowing API response snapshots to become unreadable or brittle

## Recommended Local Commands

```bash
pnpm test
pnpm test:unit
pnpm test:integration
pnpm test:e2e
```

Run full validation before merging:

```bash
pnpm lint
pnpm build
pnpm test
```
