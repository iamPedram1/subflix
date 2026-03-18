# Codebase Review Notes

> **Docs index:** [README.md](../README.md) · **See also:** [VISUAL_CONTRIBUTOR_GUIDE.md](../visual/VISUAL_CONTRIBUTOR_GUIDE.md) · [BACKEND_ARCHITECTURE_OVERVIEW.md](../architecture/BACKEND_ARCHITECTURE_OVERVIEW.md)
>
> **Covers:** what is well-designed, hard-to-understand areas, coupling, clean abstractions, naming issues, maintenance risks, future refactor opportunities, "be careful here" warnings.

A candid engineering review of the current architecture. Written for contributors who want to understand where the design is solid, where it gets complicated, and where careful attention is needed.

---

## What Is Well-Designed

### Layer separation is genuinely clean

Controllers are thin. They map HTTP to service calls, handle `@CurrentDevice()` / `@CurrentUser()` extraction, and return results. Business logic does not leak into controllers. This is consistent across all features.

Repositories own all Prisma access. Services do not import `PrismaService`. This boundary is respected throughout the codebase, not just where it's convenient. It means database changes are localized.

### Port/adapter pattern is well-executed

`MediaCatalogPort`, `SubtitleSourceProvider`, and `TranslationProviderPort` are real abstractions that enable genuine substitution. The mock providers are not test-only stubs buried in test files — they are real implementations that the app runs with when production credentials are absent. This makes the system functional out of the box without any external dependencies.

### The job system has good durability guarantees

Jobs are persisted before the runner is called. If the process crashes between creation and execution, the recovery scheduler will pick up the job within 60 seconds. The combination of `SELECT FOR UPDATE SKIP LOCKED` + per-process slot limit + advisory-lock-protected recovery provides meaningful multi-instance safety without requiring Redis or a separate message broker.

### Error normalization is complete and consistent

Every exception type — domain errors, Prisma constraint violations, Multer upload errors, NestJS HTTP exceptions, and unhandled errors — is caught by `GlobalExceptionFilter` and normalized to the same envelope shape. There are no escape hatches where an unexpected error would leak a stack trace or an inconsistent JSON structure to the client.

### Structured logging is uniform

`StructuredLogger` is used consistently. Log events have machine-readable names (`translation.completed`, `subtitle.quality.evaluated`, `translation.recovery.lock_acquired`). They carry typed context objects. This is not perfect (see concerns below), but the pattern is followed everywhere, and the log events make the job lifecycle observable.

### Request coalescing in the cache is a smart call

`AppCacheService.getOrSet()` shares a single in-flight promise across concurrent callers for the same key. This matters for subtitle source discovery: multiple users hitting the same media endpoint simultaneously will trigger one outbound HTTP call to SubDL/Podnapisi, not N. This is a real production concern and it's handled correctly.

### Test architecture reflects system design

The test suite is split into unit / integration / e2e layers with clear purpose for each. Unit tests mock the DB. Integration tests hit a real DB. E2E tests go through the full HTTP stack. The `describeIfDatabase` helper allows the integration and e2e suites to be skipped gracefully when no DB is available. Tests that cover multi-instance coordination (advisory lock, SKIP LOCKED) are integration tests that use real DB transactions — the right call.

---

## What Is Hard to Understand

### `runCatalogJob()` in the runner is very long and branchy

`TranslationJobRunnerService.runCatalogJob()` is the most complex method in the codebase. It orchestrates: acquisition strategy decision, quality evaluation, timing alignment, reuse check, translation provider call, cue persistence, and progress updates — each with its own conditional path. Reading through it requires holding a lot of context simultaneously.

The method is divided into `completeCatalogJobWithReuse()` and `completeCatalogJobWithTranslation()`, which helps, but those are also long methods with multiple steps. The acquisition decision tree has at least 4 distinct outcomes (reuse existing subtitle, AI translate with translation reuse, fresh AI translate, quality blocked fail). Each outcome follows a slightly different sequence.

If you're changing the catalog job execution path, budget extra time to trace all branches.

### The JSON blob fields on `TranslationJob` are a documentation debt

`mediaRef`, `subtitleSourceRef`, and `jobMeta` are three `Json?` columns. The actual schemas for these are defined only in TypeScript type aliases scattered across the runner and utility files. There is no single place that documents what these blobs contain at each stage of the job lifecycle.

The `DATA_AND_STATE_MODEL.md` document in this repo captures the shapes, but a future contributor who hasn't read it will need to trace types across multiple files to understand what's in a `subtitleSourceRef` for a completed catalog job. This is a real onboarding friction point.

### The dispatch priority system requires reading three places

Understanding how a queued job gets dispatched requires reading: `TranslationJobDispatchService.dispatch()`, `translation-job-priority.util.ts` (which defines `DispatchPriority` enum and `pickDispatchCandidates()`), and `TranslationJobsRepository.findQueuedJobsForDispatch()`. None of these is wrong — the separation is reasonable — but the "why" of the priority algorithm isn't obvious from any single file.

---

## Tightly Coupled Areas

### Runner depends on too many services

`TranslationJobRunnerService` constructor takes 9 injected dependencies: `TranslationJobsRepository`, `SubtitlesRepository`, `CatalogService`, `SubtitleQualityEvaluationService`, `SubtitleTimingAlignmentService`, `SubtitleAcquisitionStrategyService`, `TranslationReuseService`, `TranslationProviderPort`, and `ExecutionLimiterService`.

This isn't a bug — the runner is the integration point where most concerns meet. But it means the runner is a wide-net dependency. If you add a new capability to catalog jobs, you'll likely need to add another service to the runner's constructor.

### Catalog job logic lives in the runner

The catalog job execution logic (acquisition, quality eval, timing, reuse) currently lives inside `TranslationJobRunnerService` methods. This makes it harder to test catalog job logic independently from the runner infrastructure (slot acquisition, claiming, metadata updates).

A future improvement could extract a dedicated `CatalogJobExecutorService` that the runner delegates to. This would shrink the runner to infrastructure concerns only (slot management, claiming, failure handling) and make catalog job logic testable in isolation.

---

## Cleanly Abstracted Parts

**`SubtitleParserService`** — Pure function style. Takes a string and returns structured data. No side effects, no dependencies. Easy to test, easy to reason about.

**`SubtitleTimingAlignmentService`** — Same quality. Takes cues, returns aligned cues + analysis metadata. No external dependencies.

**`job-staleness.util.ts`** — All the `jobMeta` mutation functions (`applyAttemptStarted`, `applyAttemptFailed`, `applyRecoveredFromStall`, `canRetryAfterStall`, `parseJobRetryMeta`) are pure utilities. They don't touch the DB, don't have side effects, and are unit-tested exhaustively. This is the right way to handle complex state transitions on a JSON blob.

**`translation-job-priority.util.ts`** — Same pattern. The priority scoring algorithm is a pure function that takes a candidate list and returns a sorted selection. Easy to test with deterministic inputs and outputs.

**`AppCacheService`** — Well-encapsulated. Request coalescing, TTL, capacity limiting, and periodic cleanup are all internal. Consumers call `get`, `set`, or `getOrSet`. The implementation details don't leak.

---

## Naming Observations

These are minor but worth noting for consistency:

- The recovery service is called `TranslationJobRecoveryService` but its scheduler wrapper is `TranslationJobRecoverySchedulerService`. The "recovery" in the scheduler name refers to the recovery feature it schedules, not a "recovery scheduler" concept. The name is accurate but slightly redundant — `TranslationJobLifecycleSchedulerService` might be more precise since it also runs dispatch.

- `SubtitleAcquisitionStrategyService` is a long name but it accurately describes a service that makes a strategic decision about subtitle acquisition. The alternative — embedding this logic in the runner — would be worse.

- `sourceName` and `title` on `TranslationJob` serve different purposes: `title` is the movie/show name (for display), `sourceName` is the subtitle file name or provider label (also display). New developers sometimes confuse these.

- Some log event names use past tense (`translation.completed`) while others use present continuous (`translation.attempt.started`). Not harmful but inconsistent.

---

## Potential Maintenance Risks

### Web scrapers will break silently

Podnapisi and TVSubs providers are HTML scrapers. When those sites change their markup, the scrapers return 0 results rather than throwing an error. The circuit breaker won't trip because there is no HTTP error — just empty data. This can cause gradual subtitle availability degradation that won't be obvious from logs alone. Monitoring subtitle discovery result counts per provider would catch this.

### In-process job execution under load

The runner shares the Node.js event loop with HTTP request handling. Under sustained translation load (e.g., 3 concurrent jobs, each with multiple DB round-trips and an external HTTP call to the translation provider), HTTP request latency will increase. This is fine at low volume but will become a real issue as traffic grows. The concurrency limit (`TRANSLATION_JOB_MAX_CONCURRENCY=3`) is the current mitigation.

The fix is to move job execution to a worker process. The runner is already designed for this (it's injectable and its `schedule()` method could be replaced with a queue publish call). But the move itself requires infrastructure changes.

### Advisory lock edge case on connection pool churn

The recovery advisory lock is session-scoped. If PostgreSQL closes the connection mid-recovery (due to idle timeout or pool recycling), the lock is released automatically — which is the desired behavior. However, if the `finally` block in `recoverStalledJobs()` tries to call `releaseRecoveryAdvisoryLock()` after the connection has been recycled, it will run the `pg_advisory_unlock` on a different session and silently do nothing (pg_advisory_unlock returns false if the lock isn't held by the current session). This is safe but means the lock release log message might not correspond to an actual lock release in edge cases.

### No email delivery

Auth tokens (verification, password reset) are returned in the API response. In a production deployment, these must be sent by email. The backend has no email integration and no email service abstraction. This is a functional gap if the product needs email-verified accounts.

### Cache is per-process, not shared

In a multi-instance deployment, the first request to each new instance will be a cache miss for catalog searches and subtitle source lists. This means N instances × cold-start period = N × upstream API load on deployment. For providers with rate limits (SubDL), this could be a problem if you scale out quickly. A shared cache (Redis) would fix this but adds infrastructure complexity.

---

## Where Future Refactors May Help

**Extract `CatalogJobExecutorService`** from the runner. This would make catalog job logic independently testable and shrink the runner to pure infrastructure work.

**Add a typed schema for JSON blobs.** Using Zod or a similar validation library to parse `mediaRef`, `subtitleSourceRef`, and `jobMeta` at read time would catch schema drift at the application boundary rather than at runtime when a null-access fails.

**Add `ParsedSubtitleFile` deduplication via `checksum`.** The checksum field exists but is unused for dedup. Two identical uploads from the same device create two rows. This is harmless but wasteful.

**Unify TTL configuration for cache entries.** TTL values are currently spread across config namespaces (TMDb config, subtitle sources config, app config). A single `cacheTtls` namespace would make them easier to tune.

**Add a `SubtitleCuePort` implementation for real provider downloads.** The current `CatalogSubtitleCueProvider` directly handles provider selection, download, extraction, and parsing in one place. Splitting this would enable provider-specific cue fetching logic without cross-contamination.

---

## Places Where Contributors Should Be Careful

**`claimQueuedJobForRunner()` must remain atomic.** Any change to how the runner claims jobs must preserve the `SELECT ... FOR UPDATE SKIP LOCKED` pattern inside a transaction. Splitting this into two queries would re-introduce the double-execution bug this was built to prevent.

**`jobMeta` mutations must go through the utility functions.** The `job-staleness.util.ts` functions handle null/missing field cases safely and return new objects (not mutations). Bypassing them with direct object spread risks corrupting retry state.

**Release the advisory lock in a `finally` block.** The current implementation does this correctly. Any change to `recoverStalledJobs()` must preserve the `try/finally` structure — if an exception causes the `finally` to be skipped, the advisory lock will be held until the session closes (could be minutes, depending on connection pool idle timeout).

**Dispatch must not call the runner inside a DB transaction.** `runner.schedule(jobId)` uses `setTimeout(0)`. If it were called inside an active Prisma transaction, the scheduled function would execute after the transaction committed — which is correct — but it's not obvious from reading the code. Don't move dispatch calls inside `$transaction()` blocks.

**Rate limit keys include the route and IP.** The key format is important — changing it would reset all existing rate limit windows. If you change the rate limit key scheme, expect a brief grace period where the old limits effectively reset.
