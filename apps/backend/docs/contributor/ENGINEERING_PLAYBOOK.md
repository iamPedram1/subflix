# Engineering Playbook

> **Docs index:** [README.md](../README.md) · **See also:** [CODEBASE_REVIEW_NOTES.md](../reference/CODEBASE_REVIEW_NOTES.md) · [VISUAL_CONTRIBUTOR_GUIDE.md](../visual/VISUAL_CONTRIBUTOR_GUIDE.md) · [testing-strategy.md](testing-strategy.md)
>
> **Covers:** how to work safely in this repo — approach, workflow, tracing, safe/unsafe patterns, adding features, providers, persistence, tests, debugging jobs, reviewing AI code, checklists.
> **Does not cover:** architectural explanation (→ BACKEND_ARCHITECTURE_OVERVIEW), diagram reference (→ KEY_DIAGRAMS), codebase critique (→ CODEBASE_REVIEW_NOTES).

A practical guide to working in this codebase. Written for contributors who need to move fast without breaking things in a NestJS backend with async jobs, recovery logic, provider fallback, and an AI-assisted code history.

---

## Golden Rules

These rules protect the most fragile parts of the system. Know them before touching anything.

| # | Rule | Why |
|---|------|-----|
| 1 | **Never split `claimQueuedJobForRunner()` into two queries** | `SELECT ... FOR UPDATE SKIP LOCKED` inside a transaction is what prevents two runner instances from executing the same job. Split it and you get duplicate execution. |
| 2 | **Always mutate `jobMeta` through `job-staleness.util.ts`** | The util handles missing/null fields and returns new objects. Direct `{ ...job.jobMeta, field }` spreads corrupt retry state. |
| 3 | **Release the advisory lock in `finally`, always** | `recoverStalledJobs()` uses `pg_try_advisory_lock`. If the lock isn't released in `finally`, it stays held until the connection closes — blocking recovery for minutes. |
| 4 | **Never call `runner.schedule()` inside a `$transaction()` block** | `schedule()` uses `setTimeout(0)`. It will fire after the transaction commits, which is correct — but only because it's called *outside* the transaction. Move it inside and the timing guarantee breaks. |
| 5 | **Test DB-dependent logic with a real database** | Mocking Prisma for repository flows hides constraint violations, transaction behavior, and SKIP LOCKED semantics. |
| 6 | **Scrutinize AI-generated code before accepting it** | This codebase has AI-written history. AI code tends to miss subtle invariants (see §12). Review every generated diff carefully. |

---

## 1. How to Approach Changes

Before editing anything:

1. **Orient with the docs.** Read the "Where Do I Go When Working On X?" flowchart in [VISUAL_CONTRIBUTOR_GUIDE.md](../visual/VISUAL_CONTRIBUTOR_GUIDE.md) to identify the right files. Read [CODEBASE_REVIEW_NOTES.md](../reference/CODEBASE_REVIEW_NOTES.md) for known risks in that area.

2. **Read the code, don't just search it.** This codebase has multiple services working together on jobs. Understanding what a method does from its signature is not enough — read the implementation.

3. **Find the tests first.** Before changing code, find the existing tests in `test/unit/`, `test/integration/`, or `test/e2e/`. They document intended behavior and will catch regressions.

4. **Check the risky areas map.** The [Risky Areas Map](../visual/VISUAL_CONTRIBUTOR_GUIDE.md#5-risky-areas-map) color-codes areas by change risk. If your change touches a red area, slow down.

5. **Use the safe-change checklist.** [§6 of VISUAL_CONTRIBUTOR_GUIDE.md](../visual/VISUAL_CONTRIBUTOR_GUIDE.md#6-safe-change-checklist) is a decision tree for any proposed change. Run through it.

---

## 2. Recommended Workflow Before Changing a Feature

```
1. Identify the feature module:   src/features/<feature>/
2. Read the controller:            <feature>.controller.ts
3. Read the service(s):            <feature>.service.ts, helpers
4. Read the repository:            <feature>.repository.ts
5. Check the DTO:                  dto/
6. Find existing tests:            test/{unit,integration,e2e}/features/<feature>/
7. Read CODEBASE_REVIEW_NOTES.md   for known issues in this area
8. Run the test suite:             pnpm test
9. Make your change + add tests
10. Run the test suite again
```

For features involving async jobs, add step 2a: read the runner, dispatch service, and recovery service before touching anything in `translation-jobs/`.

---

## 3. How to Trace a Request Before Editing It

Follow the request lifecycle for any HTTP route:

```
HTTP Request
  → Global validation pipe (class-validator DTOs)
  → DeviceContextGuard or AccessTokenGuard (src/common/http/)
  → Controller — maps HTTP input to a service call
  → Service — business logic + orchestration
  → Repository — Prisma queries only (never in services)
  → Port → Provider — external calls (TMDb, SubDL, translation)
  → GlobalExceptionFilter — normalizes all thrown exceptions
```

**Practical steps:**

1. Find the route in the controller (`@Get`, `@Post`, etc.) and note the service method it calls.
2. Read the service method. Identify which repository methods and port methods it calls.
3. If it touches a repository, look for the corresponding Prisma query and check what index it uses (documented in [VISUAL_DATA_MAP.md §5](../visual/VISUAL_DATA_MAP.md#5-database-indexes-and-query-patterns)).
4. If it touches a port, find the provider implementation that's wired in the module (`*.module.ts`).
5. Check what the controller returns and compare it to the DTO shape — [api-rules.md](api-rules.md) is the contract.

---

## 4. How to Trace a Translation Job Before Editing It

A job's full journey:

```
POST /v1/translation-jobs
  → TranslationJobsService.createJob()           writes status=queued
  → runner.schedule(jobId)                       setTimeout(0), deferred
  → TranslationJobRunnerService.run()
      → tryAcquireSlot()                         concurrency check (max 3)
      → claimQueuedJobForRunner()                SKIP LOCKED claim, writes status=translating
      → route to runCatalogJob() or upload path
          catalog → SubtitleAcquisitionStrategyService → QualityEval → TimingAlign
                  → ReuseCheck → TranslationProviderPort.translate() (if needed)
                  → replaceJobCues() + status=completed
          upload  → load ParsedSubtitleCue rows → translate → replaceJobCues + status=completed
      → on any error: markFailure() → status=failed
  → TranslationJobRecoveryService (periodic)
      → finds status=translating, updatedAt stale
      → requeues or permanently fails
  → TranslationJobDispatchService (periodic)
      → picks queued jobs by priority score
      → calls runner.schedule() for each
```

Key files to read in order when tracing job execution:
1. `src/features/translation-jobs/translation-job-runner.service.ts` — the full execution path
2. `src/features/translation-jobs/translation-jobs.repository.ts` — `claimQueuedJobForRunner()` and `replaceJobCues()`
3. `src/features/translation-jobs/subtitle-acquisition-strategy.service.ts` — catalog job decision
4. `src/features/translation-jobs/translation-reuse.service.ts` — translation reuse check
5. `src/features/translation-jobs/utils/job-staleness.util.ts` — all jobMeta mutations
6. `src/features/translation-jobs/translation-job-recovery.service.ts` — stall handling

---

## 5. Safe Patterns to Follow

### Repository access
- All Prisma calls belong in repository files. Services call repositories, not `PrismaService` directly.
- Use `normalizeDatabaseError()` (from `src/common/database/`) in repositories to convert Prisma constraint errors to typed domain errors.

### Job metadata mutations
Always use the utility functions in `job-staleness.util.ts`:
```typescript
// Good
const updated = applyAttemptStarted(job.jobMeta);

// Bad — bypasses null handling and returns mutated reference
job.jobMeta = { ...job.jobMeta, attemptCount: (job.jobMeta?.attemptCount ?? 0) + 1 };
```

### Caching
Use `AppCacheService.getOrSet()` for any cacheable read. This method coalesces concurrent requests for the same key into a single in-flight promise. Using `get` + `set` separately does not provide this guarantee.

### Error handling
Throw domain error classes from `src/common/domain/errors/` rather than `HttpException` from inside services. `GlobalExceptionFilter` maps them to the stable error envelope — services should not concern themselves with HTTP status codes.

### Provider calls
Always route external HTTP calls through port interfaces (`MediaCatalogPort`, `TranslationProviderPort`, `SubtitleSourceProvider`). Never call provider implementations directly from services — the injection token wiring is how the mock providers substitute during testing.

### Advisory lock pattern
```typescript
// Good — lock always released, even if recoverStalledJobs() throws
const acquired = await this.repo.tryAcquireRecoveryAdvisoryLock();
if (!acquired) return;
try {
  await this.recoverStalledJobs();
} finally {
  await this.repo.releaseRecoveryAdvisoryLock();
}
```

---

## 6. Unsafe Patterns / Anti-Patterns to Avoid

| Anti-pattern | Why it's unsafe | What to do instead |
|---|---|---|
| Business logic in controllers | Leaks orchestration into HTTP layer; hard to test | Put logic in the service |
| `PrismaService` injected into a feature service | Breaks repository isolation; bypasses error normalization | Inject and call the repository class |
| Two queries where one SKIP LOCKED query is needed | Re-introduces double-execution for concurrent runners | Keep `claimQueuedJobForRunner()` atomic |
| `{ ...job.jobMeta, field: value }` direct spread | Corrupts retry state; misses null/missing fields | Use `job-staleness.util.ts` functions |
| `runner.schedule()` inside `$transaction()` | Timing dependency on transaction commit becomes implicit | Call `schedule()` after the transaction resolves |
| Mocking Prisma in integration tests | Hides constraint violations and transaction semantics | Use a real test database with `describeIfDatabase` |
| Caching mutable objects in `AppCacheService` | Mutating the cached object corrupts future callers | Cache only value types or serialized copies |
| Provider implementation imported directly | Skips port interface; breaks mock substitution in tests | Always use the injection token |
| Swallowing errors in recovery/dispatch | Stalled jobs silently stop retrying | Re-throw or log with sufficient context; let the recovery service handle retry logic |
| Adding raw SQL string interpolation | SQL injection risk | Use Prisma parameterized queries exclusively |

---

## 7. How to Add a New Feature

1. **Create the module directory:** `src/features/<feature-name>/`

2. **Standard file layout:**
   ```
   <feature>.module.ts          ← NestJS module, wires everything
   <feature>.controller.ts      ← HTTP routes, DTOs, guards
   <feature>.service.ts         ← business logic, orchestration
   <feature>.repository.ts      ← Prisma queries only
   dto/                         ← request/response DTO classes
   models/                      ← internal domain types (not Prisma types)
   ```

3. **Controller rules:** Thin. Call one service method. Return the service result (or a mapped DTO). No business logic.

4. **Service rules:** Inject the repository and any ports. Throw domain errors from `src/common/domain/errors/`. No Prisma imports.

5. **Repository rules:** Inject `PrismaService`. Call `normalizeDatabaseError()` around mutation operations. Return typed models, not raw Prisma output.

6. **Wire device context:** If the feature is device-scoped, apply `DeviceContextGuard` at the controller level and use `@CurrentDevice()` to access the device.

7. **Add the module to `AppModule`.**

8. **Add DTOs:** Use `class-validator` decorators. The global validation pipe rejects invalid requests before they reach the controller.

9. **Write tests:** Unit test the service with mocked repository. Integration test the repository against a real DB. E2E test the HTTP contract.

---

## 8. How to Add a New Provider or Integration

### New translation provider

1. Implement `TranslationProviderPort` from `src/features/translation-jobs/ports/`:
   ```typescript
   translate(params: TranslationParams): Promise<string[]>
   ```
2. Add the file to `src/features/translation-jobs/providers/`.
3. Wire in `translation-jobs.module.ts`:
   ```typescript
   { provide: TRANSLATION_PROVIDER_PORT, useClass: YourProvider }
   ```
4. Add a config namespace in `src/common/config/` if an API key or base URL is needed.
5. No changes to the runner, dispatch, or recovery services.

### New subtitle source provider

1. Implement `SubtitleSourceProvider` from `src/features/catalog/ports/`:
   ```typescript
   name: string
   searchSources(input): Promise<SubtitleSourceCandidate[]>
   ```
2. Add the file to `src/features/catalog/providers/`.
3. Register in `CatalogModule` by adding to the `SUBTITLE_SOURCE_PROVIDERS` array.
4. Add to `SubtitleSourceDiscoveryService` provider chain.
5. `SubtitleProviderHealthService` will track circuit breaker state automatically using `provider.name`.
6. **HTML scrapers (like Podnapisi/TVSubs):** note that these fail silently on markup changes — returning empty arrays, not errors. The circuit breaker won't trip. Add response-count monitoring if this provider is important.

### New media catalog provider

1. Implement `MediaCatalogPort` from `src/features/catalog/ports/`.
2. Wire in `CatalogModule` via `MEDIA_CATALOG_PORT` injection token.
3. Add caching in `CatalogService` if the provider has rate limits.

### External service (general)

- Always put the HTTP client behind a port interface.
- Add a mock implementation that runs when credentials are absent — this keeps the system functional in dev without real API keys.
- Add the new service to `SubtitleProviderHealthService` if it can fail and degrade silently.
- Add config to `src/common/config/` for any required env vars.

---

## 9. How to Add or Change Persistence Safely

### Adding a new model or field

1. Edit `prisma/schema.prisma`.
2. Run `pnpm prisma migrate dev --name <description>` to generate and apply the migration.
3. Update or add the repository method that reads/writes the new field.
4. Add integration tests against a real DB to verify constraints and queries.
5. If the field is a `Json?` blob, define its TypeScript type alias and add utility functions to read/write it safely (see `job-staleness.util.ts` as the model to follow).

### Changing a `Json?` blob schema (`mediaRef`, `subtitleSourceRef`, `jobMeta`)

- Existing rows in production will have the old shape. Your code must handle both old and new shapes.
- Always add a field with `?` (optional) before removing the old field.
- Never access `blob.field` without a null check — use the utility functions or explicit optionality.
- Update [VISUAL_DATA_MAP.md §3](../visual/VISUAL_DATA_MAP.md#3-translationjob-json-blobs) when the schema changes.

### Changing a repository query

- If the query is used in a concurrent context (dispatch, claim, recovery), check whether it needs to stay inside a transaction.
- If adding a new query that filters by `status` or `clientDeviceId`, verify that an existing index covers it — see [VISUAL_DATA_MAP.md §5](../visual/VISUAL_DATA_MAP.md#5-database-indexes-and-query-patterns).
- Write an integration test that runs against a real PostgreSQL instance.

### Indexes

Add a new index in `schema.prisma` using `@@index`. Write a query-performance test if the table is large or the query runs on every job tick.

---

## 10. How to Write Tests in This Repo

See [testing-strategy.md](testing-strategy.md) for the full policy. Summary:

| What to test | Test type | Location |
|---|---|---|
| Pure utilities, mappers, formatters | Unit | `test/unit/features/<feature>/` |
| Service logic with mocked dependencies | Unit | `test/unit/features/<feature>/` |
| Repository queries, Prisma constraints, transactions | Integration | `test/integration/features/<feature>/` |
| Concurrent behavior (SKIP LOCKED, advisory lock) | Integration | `test/integration/features/translation-jobs/` |
| HTTP contract, status codes, response shape | E2E | `test/e2e/features/<feature>/` |

**Key conventions:**
- DB-dependent tests must use `describeIfDatabase` so they skip gracefully when no test DB is configured.
- Reset state before each test — never depend on leftover rows.
- Unit tests mock at the *boundary of the feature* (repository, port), not inside the feature.
- E2E tests verify headers, status codes, and envelope shape — not internal state.

**Test commands:**
```bash
pnpm test              # all
pnpm test:unit
pnpm test:integration
pnpm test:e2e

pnpm lint && pnpm build && pnpm test   # full pre-merge check
```

---

## 11. How to Debug Async Job Issues

Jobs execute asynchronously on `setTimeout(0)`. Standard request-response debugging doesn't apply.

### Step 1 — Check structured logs

The job lifecycle emits named log events you can grep:

| Event | What it means |
|---|---|
| `translation.attempt.started` | Runner acquired a slot and claimed the job |
| `translation.completed` | Job finished successfully |
| `translation.failed` | `markFailure()` was called |
| `translation.recovery.lock_acquired` | Recovery service got the advisory lock |
| `translation.recovery.job_requeued` | Stalled job was requeued |
| `translation.recovery.job_failed` | Stalled job exhausted retries |
| `dispatch.job_scheduled` | Dispatch service called `runner.schedule()` |

### Step 2 — Check in-memory dedup sets

The runner maintains two sets:
- `scheduledJobIds` — jobs with a pending `setTimeout` (prevents scheduling the same job twice)
- `activeJobIds` — jobs currently executing (prevents re-entering an in-flight job)

If a job is stuck in either set (e.g., due to a crash without cleanup), it will not be scheduled again until the process restarts. Recovery handles this by requeueing the job in the DB, so the next dispatch cycle will reschedule it on a fresh process.

### Step 3 — Check job state in the DB

```sql
SELECT id, status, "jobMeta", "updatedAt", "startedAt", "completedAt"
FROM "TranslationJob"
WHERE id = '<job-id>';
```

- `status=translating` + `updatedAt` stale → job is stalled; recovery will catch it within the configured stall window (default 60s check interval)
- `jobMeta.attemptCount` → how many times the job has been attempted
- `jobMeta.lastFailureReasonCode` → why the last attempt failed
- `jobMeta.recoveredFromStall` → whether recovery has touched this job

### Step 4 — Check concurrency

If jobs are not being dispatched, the concurrency limit may be saturated. Check `TRANSLATION_JOB_MAX_CONCURRENCY` (default 3). If 3 jobs are stuck in `translating`, new dispatches will be skipped until slots free up.

---

## 12. How to Review AI-Generated Code Before Accepting It

This codebase has significant AI-written history. When AI writes a new diff, check for these common failure modes:

**Structural:**
- [ ] Does the service directly import `PrismaService`? (Should use a repository instead.)
- [ ] Is business logic inside the controller? (Should be in the service.)
- [ ] Does the new class inject everything it needs in the constructor? (AI often forgets to wire optional dependencies.)
- [ ] Is the module file updated with the new provider/class?

**Async job logic:**
- [ ] Is `runner.schedule()` called outside any `$transaction()` block?
- [ ] If `jobMeta` is written, does it go through `job-staleness.util.ts`?
- [ ] If a claim query is added or changed, is it still inside a transaction with SKIP LOCKED?
- [ ] Is the advisory lock released in a `finally` block?

**Error handling:**
- [ ] Does the new code throw `HttpException` from a service? (Should throw domain errors instead.)
- [ ] Are errors swallowed in `catch` blocks without rethrowing or logging?
- [ ] Does the `GlobalExceptionFilter` already handle the thrown error type, or does a new mapping need to be added?

**Caching:**
- [ ] Is `AppCacheService.getOrSet()` used for cacheable reads? (Not raw `get`/`set` pairs.)
- [ ] Is a mutable object being cached directly? (Must cache value types or serialized copies.)

**Testing:**
- [ ] Did the AI add unit tests only? Are there scenarios that need integration tests (DB, transactions)?
- [ ] Are tests asserting on private method calls or internal state? (Should assert on public behavior.)
- [ ] Does the AI test mock Prisma where a real DB is needed?

**Subtle invariants:**
- [ ] Does new code assume `jobMeta`, `mediaRef`, or `subtitleSourceRef` is always present? (These are `Json?` nullable.)
- [ ] Does new JSON field access include null guards?
- [ ] Does new pagination code respect the existing `page`/`limit`/`total`/`totalPages` shape?

---

## 13. Common Contributor Mistakes

1. **Editing the wrong layer.** Route business logic ends up in controllers; DB logic ends up in services. Use the module file structure as a guide: if it's in `*.controller.ts`, it's HTTP mapping only.

2. **Forgetting to register the class.** NestJS DI requires explicit registration in the module. A new service that isn't in the `providers` array fails silently at runtime (or throws a cryptic injection error).

3. **Assuming the runner executes synchronously.** `runner.schedule()` defers execution. Code written after `createJob()` returns may run before the job completes (or ever completes, if the process crashes).

4. **Not reading `CODEBASE_REVIEW_NOTES.md` before touching the runner.** The runner has 9 injected dependencies and multiple branching paths. The review notes explain the tricky parts.

5. **Adding a new test but not running the full suite.** A new test may conflict with shared fixtures or DB state. Always run `pnpm test` before calling the task done.

6. **Changing `dispatch()` priority scoring without reading the full algorithm.** `pickDispatchCandidates()` in `translation-job-priority.util.ts` is a pure function that scores and sorts candidates. Changing tier values affects global job ordering. Run the unit tests and verify no starvation for recovered jobs.

7. **Not updating the docs when changing JSON blob schemas.** The shapes of `mediaRef`, `subtitleSourceRef`, and `jobMeta` are documented in [VISUAL_DATA_MAP.md §3](../visual/VISUAL_DATA_MAP.md#3-translationjob-json-blobs). Update this when schemas change.

8. **Exporting raw Prisma types in controller responses.** The mapper (`translation-jobs.mapper.ts`) exists for a reason. Don't bypass it.

---

## 14. Quick Checklists

### Adding a new feature

- [ ] Module directory created under `src/features/`
- [ ] Controller, Service, Repository, DTOs all created
- [ ] Module registered in `AppModule`
- [ ] `DeviceContextGuard` applied if feature is device-scoped
- [ ] Domain errors thrown from service (not `HttpException`)
- [ ] Repository uses `normalizeDatabaseError()`
- [ ] Unit tests for service logic
- [ ] Integration tests for repository if DB queries added
- [ ] E2E tests if new HTTP routes added
- [ ] API contract follows rules in [api-rules.md](api-rules.md)

### Changing a repository method

- [ ] Read the existing method and its callers first
- [ ] If the query is concurrent-critical (job claim, recovery), keep it inside a transaction
- [ ] Verify an index exists for the query's filter columns
- [ ] Write an integration test against a real DB
- [ ] Do not introduce raw SQL string interpolation

### Changing a provider or adding an integration

- [ ] Implementation is behind a port interface
- [ ] Wired via injection token, not direct import in service
- [ ] Mock provider exists for dev/test without credentials
- [ ] Config namespace added if API keys are needed
- [ ] Circuit breaker / health tracking considered if provider can fail silently
- [ ] Unit tests for provider logic (with mocked HTTP client)

### Changing translation job logic

- [ ] Read `translation-job-runner.service.ts` in full first
- [ ] `jobMeta` mutations go through `job-staleness.util.ts`
- [ ] `claimQueuedJobForRunner()` remains atomic (SKIP LOCKED, inside transaction)
- [ ] `replaceJobCues()` not called more than once per job execution
- [ ] Error path calls `markFailure()` and does not swallow the exception
- [ ] State transition documented in [VISUAL_STATE_MAP.md](../visual/VISUAL_STATE_MAP.md) if changed
- [ ] Integration tests updated for new paths

### Changing recovery or dispatch logic

- [ ] Advisory lock release remains in a `finally` block
- [ ] Recovery does not run DB queries inside the advisory lock scope unnecessarily
- [ ] Dispatch priority change verified against starvation (no job type permanently deprioritized)
- [ ] `runner.schedule()` called outside any `$transaction()` block
- [ ] Multi-instance coordination tested with real DB (integration test)
- [ ] `VISUAL_STATE_MAP.md` updated if new states or transitions added

### Changing a DTO or API contract

- [ ] New fields are optional (non-breaking change first)
- [ ] Response shape still matches [api-rules.md](api-rules.md) envelope
- [ ] E2E tests updated to verify new/changed fields
- [ ] `v1` prefix preserved on all routes
- [ ] Device-scoped routes still require `x-device-id`
- [ ] Pagination shape unchanged (`items`, `page`, `limit`, `total`, `totalPages`)
- [ ] `code` values in error responses are stable (not localized)
