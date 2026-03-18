# Feature Map

> **Docs index:** [README.md](README.md) · **See also:** [VISUAL_ARCHITECTURE.md](VISUAL_ARCHITECTURE.md) · [VISUAL_CONTRIBUTOR_GUIDE.md](VISUAL_CONTRIBUTOR_GUIDE.md)
>
> **Covers:** every feature module — problem solved, key files, public/internal responsibilities, inter-module dependencies, important models/DTOs.
> **Does not cover:** runtime flows (→ VISUAL_RUNTIME_FLOWS), visual module graph (→ VISUAL_ARCHITECTURE).

This document describes each feature module in the codebase: what problem it solves, which files own what, and how it connects to other features.

---

## Health

**Problem it solves:** Provides a minimal liveness/readiness endpoint for infrastructure health checks.

**Key files:**
- [src/features/health/health.controller.ts](../src/features/health/health.controller.ts) — `GET /v1/health`
- [src/features/health/health.service.ts](../src/features/health/health.service.ts) — reads env/service name from config

**Public responsibilities:**
- Returns `{status: 'ok', service: 'subflix-back', environment, timestamp}`
- No auth, no device guard, no rate limit

**Internal responsibilities:** None — purely delegates to `ConfigService`.

**Dependencies:** `AppConfigModule` only.

**Depended on by:** Nothing in the application code. Consumed by load balancers and orchestration platforms.

---

## Auth

**Problem it solves:** Issues JWT access/refresh tokens for email/password accounts and Firebase OAuth identities. Manages email verification and password reset.

**Key files:**
- [src/features/auth/auth.controller.ts](../src/features/auth/auth.controller.ts) — 8 routes
- [src/features/auth/auth.service.ts](../src/features/auth/auth.service.ts) — sign-up, sign-in, refresh, forgot/reset password, sign-out, me
- [src/features/auth/auth.repository.ts](../src/features/auth/auth.repository.ts) — User, UserIdentity, token persistence
- [src/features/auth/firebase-auth.service.ts](../src/features/auth/firebase-auth.service.ts) — Firebase Admin SDK wrapper
- [src/features/auth/guards/access-token.guard.ts](../src/features/auth/guards/access-token.guard.ts) — JWT validation for protected routes

**Public responsibilities:**
- `POST /v1/auth/signup` — create account + issue email verification token
- `POST /v1/auth/confirm-email` — consume verification token
- `POST /v1/auth/signin` — return access + refresh tokens (verified email required)
- `POST /v1/auth/oauth/firebase` — verify Firebase id token, return tokens
- `POST /v1/auth/refresh` — exchange refresh token for new access token
- `POST /v1/auth/forgot-password` / `reset-password` — password recovery flow
- `POST /v1/auth/signout` — revoke refresh token
- `GET /v1/auth/me` — return current user (requires `AccessTokenGuard`)

**Internal responsibilities:**
- bcrypt password hashing (12 rounds by default)
- refresh token hash storage (never store raw token)
- token TTL enforcement: access 15min, refresh 30d, verify 24h, reset 2h
- linking Firebase provider identities to User records on first OAuth sign-in

**Dependencies:** `PrismaModule`, `AppConfigModule`, `JwtModule`, `FirebaseAuthService`

**Depended on by:** Nothing depends on `AuthModule` at runtime. `AccessTokenGuard` is used optionally on the `GET /v1/auth/me` route and could be applied to any route that needs user identity.

**Important DTOs:**
- `SignUpDto`, `SignInDto`, `ConfirmEmailDto`, `RefreshTokenDto`, `ForgotPasswordDto`, `ResetPasswordDto`, `FirebaseOAuthDto`

**Notes:**
- Email is normalized to lowercase before lookup and storage.
- The email verification token value is returned in the API response in development. Production needs an email delivery integration.
- Auth is currently orthogonal to device ownership. Private feature routes use the device guard, not `AccessTokenGuard`.

---

## Devices

**Problem it solves:** Establishes the ownership boundary for all user data without requiring a traditional user account. Every device ID from the `x-device-id` header maps to a `ClientDevice` row that owns preferences, uploaded files, and jobs.

**Key files:**
- [src/features/devices/devices.service.ts](../src/features/devices/devices.service.ts) — `resolveDevice(deviceId)` upsert
- [src/features/devices/devices.repository.ts](../src/features/devices/devices.repository.ts) — Prisma upsert by deviceId
- [src/common/http/guards/device-context.guard.ts](../src/common/http/guards/device-context.guard.ts) — validates header, calls service, attaches `request.device`

**Public responsibilities:**
- None — this module has no HTTP routes.

**Internal responsibilities:**
- `DeviceContextGuard` validates the `x-device-id` header is present, non-empty, and safe (no newlines, reasonable length).
- Calls `DevicesService.resolveDevice()` which upserts a `ClientDevice` row by the raw device ID string.
- Attaches the resulting `ClientDevice` object to `request.device` for downstream use in controllers.

**Dependencies:** `PrismaModule`, `AppConfigModule`

**Depended on by:** Every feature that has private routes (`PreferencesModule`, `SubtitlesModule`, `CatalogModule`, `TranslationJobsModule`) imports `DevicesModule` to access `DeviceContextGuard`.

**Notes:**
- Device IDs are whatever string the client sends. There is no format validation beyond safety checks. Typically a UUID generated by the Flutter app on first install.
- Upserting on every request means the first time a device ID is seen, a new row is created. No explicit device registration endpoint exists.

---

## Preferences

**Problem it solves:** Stores and retrieves device-scoped application settings (onboarding state, preferred target language, theme).

**Key files:**
- [src/features/preferences/preferences.controller.ts](../src/features/preferences/preferences.controller.ts) — `GET/PATCH /v1/preferences`
- [src/features/preferences/preferences.service.ts](../src/features/preferences/preferences.service.ts) — get with defaults, update, cache management
- [src/features/preferences/preferences.repository.ts](../src/features/preferences/preferences.repository.ts) — find + upsert by clientDeviceId

**Public responsibilities:**
- `GET /v1/preferences` — return current preferences, creating defaults if none exist
- `PATCH /v1/preferences` — partial update (any subset of fields)

**Internal responsibilities:**
- Cache-backed reads: key `preferences:{clientDeviceId}`, TTL 15min
- Default preferences: `{hasSeenOnboarding: false, preferredTargetLanguage: 'es', themePreference: 'system'}`
- On update: merge partial DTO with current state, write to DB, invalidate cache

**Dependencies:** `AppCacheService`, `PrismaModule`, `DevicesModule`

**Depended on by:** Nothing depends on `PreferencesModule` in the application code.

**Important DTOs:**
- `UpdatePreferencesDto` — all fields optional: `hasSeenOnboarding?`, `preferredTargetLanguage?`, `themePreference?`

---

## Subtitles

**Problem it solves:** Accepts uploaded subtitle files (SRT or VTT), parses them into normalized cues, and persists them for use as a translation job source. Also provides subtitle export (format cues back to SRT/VTT) for completed translation jobs.

**Key files:**
- [src/features/subtitles/subtitles.controller.ts](../src/features/subtitles/subtitles.controller.ts) — `POST /v1/subtitles/parse`
- [src/features/subtitles/subtitles.service.ts](../src/features/subtitles/subtitles.service.ts) — orchestrates parse + persist
- [src/features/subtitles/subtitles.repository.ts](../src/features/subtitles/subtitles.repository.ts) — create `ParsedSubtitleFile` + cues; load owned cues
- [src/features/subtitles/utils/subtitle-parser.service.ts](../src/features/subtitles/utils/subtitle-parser.service.ts) — parse raw SRT/VTT content
- [src/features/subtitles/utils/subtitle-export.service.ts](../src/features/subtitles/utils/subtitle-export.service.ts) — format cues to SRT/VTT string

**Public responsibilities:**
- `POST /v1/subtitles/parse` — multipart upload of `.srt` or `.vtt`, returns parsed file metadata

**Internal responsibilities:**
- **`SubtitleParserService.parse(content, format)`**: Normalizes line endings, splits blocks, extracts cueIndex + timecodes + text. Returns `SubtitleCue[]` or throws `ValidationDomainError` if no valid cues found.
- **`SubtitleExportService.formatCues(cues, format)`**: Rebuilds SRT (1-indexed, `HH:MM:SS,mmm`) or VTT (with header, `HH:MM:SS.mmm`) from `TranslationJobCue[]`.
- **`SubtitlesRepository.createParsedFile()`**: Transaction: insert `ParsedSubtitleFile` + `createMany` `ParsedSubtitleCue` rows.
- **`SubtitlesRepository.listOwnedParsedFileCues()`**: Load cues for a file owned by a device — used by runner for upload-source jobs.

**Dependencies:** `PrismaModule`, `DevicesModule`, `AppConfigModule`

**Depended on by:** `TranslationJobsModule` — the runner loads uploaded cues from `SubtitlesRepository` for upload-source jobs.

**Important models:**
- `ParsedSubtitleFile` — id, fileName, format, sourceLanguage, lineCount, durationMs, checksum, rawContent
- `ParsedSubtitleCue` — cueIndex, startMs, endMs, text
- `SubtitleCue` — in-memory normalized cue model shared across catalog and upload paths

---

## Catalog

**Problem it solves:** Lets users search for movies and TV series, then discover subtitle files available for a specific media item from third-party providers. Also evaluates subtitle quality and optionally corrects timing offsets.

**Key files:**
- [src/features/catalog/catalog.controller.ts](../src/features/catalog/catalog.controller.ts) — `GET /v1/catalog/search`, `GET /v1/catalog/media/:id/subtitle-sources`
- [src/features/catalog/catalog.service.ts](../src/features/catalog/catalog.service.ts) — orchestrates search and subtitle source discovery
- [src/features/catalog/subtitle-source-discovery.service.ts](../src/features/catalog/subtitle-source-discovery.service.ts) — provider chain with caching, dedup, ranking
- [src/features/catalog/subtitle-quality-evaluation.service.ts](../src/features/catalog/subtitle-quality-evaluation.service.ts) — confidence scoring + warning codes
- [src/features/catalog/subtitle-timing-alignment.service.ts](../src/features/catalog/subtitle-timing-alignment.service.ts) — constant offset detection and correction
- [src/features/catalog/subtitle-provider-health.service.ts](../src/features/catalog/subtitle-provider-health.service.ts) — per-provider circuit breaker
- [src/features/catalog/providers/](../src/features/catalog/providers/) — TMDb, SubDL, Podnapisi, TVSubs, Mock adapters
- [src/features/catalog/ports/](../src/features/catalog/ports/) — `MediaCatalogPort`, `SubtitleSourceProvider`, `SubtitleCuePort`

**Public responsibilities:**
- `GET /v1/catalog/search?q=<query>` — returns `CatalogMediaItem[]` (title, year, mediaType, posterUrl, etc.)
- `GET /v1/catalog/media/:mediaId/subtitle-sources` — returns `CatalogSubtitleSource[]` with opaque `ssrc:*` IDs

**Internal responsibilities:**
- **`SubtitleSourceDiscoveryService.discover()`**: Iterates subtitle providers (SubDL first if healthy, then Podnapisi, TVSubs), collects candidates, deduplicates by normalized title + episode, ranks by relevance score, limits to 20 results. Uses cache with 6h TTL.
- **`SubtitleQualityEvaluationService.evaluateCatalogJob()`**: Scores downloaded cues against expected language, timing plausibility, release hint match. Produces `confidenceScore` (0–100), `confidenceLevel` (high/medium/low), `warnings[]`, and `shouldBlockAutoUse` flag.
- **`SubtitleTimingAlignmentService.alignCatalogCues()`**: Scans −10s to +10s in 1s steps to find a constant offset that maximizes cue alignment score. Returns corrected cues + analysis metadata.
- **`SubtitleProviderHealthService`**: Circuit breaker per provider. Tracks failures; after 3 consecutive failures, provider is skipped for 60s cooldown.

**Dependencies:** `AppCacheService`, `AppConfigModule`, `PrismaModule` (not directly — catalog itself doesn't persist to DB)

**Depended on by:** `TranslationJobsModule` — the runner calls `CatalogService.getSubtitleCues()` and `findById()`, and uses `SubtitleQualityEvaluationService` and `SubtitleTimingAlignmentService`.

**Important models:**
- `CatalogMediaItem` — id, title, year, mediaType, posterUrl, popularity, genres
- `CatalogMediaDetails` — extends `CatalogMediaItem` with synopsis, runtimeMinutes
- `CatalogSubtitleSource` — id (`ssrc:*`), label, language, format, provider, episodeInfo
- `SubtitleSourceCandidate` — internal model before dedup/ranking

**Notes:**
- `mediaId` values are opaque strings prefixed with provider source (e.g., `tmdb:movie:123`). The catalog service resolves these to real lookups.
- Subtitle source IDs (`ssrc:*`) encode provider + internal ID to allow routing in the cue-fetch path.

---

## Translation Jobs

**Problem it solves:** The central feature of the application. Manages the full lifecycle of a subtitle translation job: creation, queueing, execution, progress tracking, preview, export, retry, and cleanup. Also handles stall recovery and multi-instance-safe dispatch.

This module is the most complex in the codebase and is split into several focused services.

### TranslationJobsService (Orchestration)

**Key file:** [src/features/translation-jobs/translation-jobs.service.ts](../src/features/translation-jobs/translation-jobs.service.ts)

**Responsibilities:**
- Validate and persist a new job from either an uploaded subtitle file or a catalog subtitle source.
- Trigger `runner.schedule(jobId)` after creation.
- List jobs (paginated), get single job status, retry a job, get preview cues, export cues, clear history.

**Routes exposed:**
- `POST /v1/translation-jobs` — create + queue
- `GET /v1/translation-jobs` — list with pagination
- `GET /v1/translation-jobs/:jobId` — status + metadata
- `GET /v1/translation-jobs/:jobId/preview` — paginated translated cues (with optional text search)
- `GET /v1/translation-jobs/:jobId/export` — download translated SRT/VTT
- `POST /v1/translation-jobs/:jobId/retry` — recreate from same source
- `DELETE /v1/translation-jobs` — clear device's job history

---

### TranslationJobRunnerService (Execution Engine)

**Key file:** [src/features/translation-jobs/translation-job-runner.service.ts](../src/features/translation-jobs/translation-job-runner.service.ts)

**Responsibilities:**
- `schedule(jobId)` — Deduplicate via in-memory sets; enqueue via `setTimeout(0)`.
- `run(jobId)` — Try to acquire execution slot; claim job atomically from DB; determine job type; execute catalog or upload path; persist results; release slot.
- Catalog path: acquisition strategy decision → quality evaluation → timing alignment → reuse check → AI translation (if needed) → persist.
- Upload path: load parsed cues → AI translation → persist.
- On error: record attempt failure metadata; mark job failed.

**In-memory state:**
- `scheduledJobIds: Set<string>` — prevents duplicate `setTimeout` enqueues
- `activeJobIds: Set<string>` — prevents concurrent `run()` calls for same job

---

### TranslationJobExecutionLimiterService (Concurrency Ceiling)

**Key file:** [src/features/translation-jobs/translation-job-execution-limiter.service.ts](../src/features/translation-jobs/translation-job-execution-limiter.service.ts)

**Responsibilities:**
- Maintain an in-process slot counter (max = `TRANSLATION_JOB_MAX_CONCURRENCY`, default 3).
- `tryAcquireSlot(jobId)` — increment if under limit, return true; else return false.
- `releaseSlot(jobId)` — decrement (idempotent).
- `getMetrics()` — return `{activeCount, maxConcurrency}` for dispatch decisions.

---

### TranslationJobDispatchService (DB-Backed Queue Coordinator)

**Key file:** [src/features/translation-jobs/translation-job-dispatch.service.ts](../src/features/translation-jobs/translation-job-dispatch.service.ts)

**Responsibilities:**
- On startup, after recovery, and on periodic poll: check available slots, fetch candidates from DB (overscan × 5, max 50), apply priority scoring, schedule selected jobs via runner.
- Priority tiers: `CATALOG=10` (may short-circuit via reuse) → `UPLOAD=20` → `RECOVERED=30` (deprioritized).
- Fairness: recovered jobs older than 5min are promoted to base tier to prevent starvation.
- Uses `findQueuedJobsForDispatch()` from the repository.

---

### TranslationJobRecoveryService (Stall Detection)

**Key file:** [src/features/translation-jobs/translation-job-recovery.service.ts](../src/features/translation-jobs/translation-job-recovery.service.ts)

**Responsibilities:**
- Acquire PostgreSQL advisory lock before running a cycle (prevents two instances recovering simultaneously).
- Find jobs with `status=translating` and `updatedAt < (now - staleAfterMs)`.
- Per stalled job: if `attemptCount < maxAttempts` → requeue; else → permanent fail.
- Log: `translation.recovery.lock_acquired`, `translation.recovery.lock_skipped`, `translation.recovery.lock_released`.
- Return `{requeued, failed, scanned}` counts.

---

### TranslationJobRecoverySchedulerService (Lifecycle Wiring)

**Key file:** [src/features/translation-jobs/translation-job-recovery-scheduler.service.ts](../src/features/translation-jobs/translation-job-recovery-scheduler.service.ts)

**Responsibilities:**
- On `OnApplicationBootstrap`: run recovery once (if enabled), then run dispatch.
- Set `setInterval` timers for periodic recovery (60s default) and dispatch poll (10s default).
- On `OnApplicationShutdown`: clear timers.

---

### SubtitleAcquisitionStrategyService

**Key file:** [src/features/translation-jobs/subtitle-acquisition-strategy.service.ts](../src/features/translation-jobs/subtitle-acquisition-strategy.service.ts)

**Responsibilities:**
- For catalog jobs: decide whether to use an existing target-language subtitle (skipping AI translation) or proceed to AI translation with a source-language subtitle.
- Calls `CatalogService.getSubtitleSources()` with the target language, evaluates quality of candidates.
- Returns `SubtitleAcquisitionDecision` with `acquisitionMode: 'existing_target_subtitle' | 'ai_translation'`.

---

### TranslationReuseService

**Key file:** [src/features/translation-jobs/translation-reuse.service.ts](../src/features/translation-jobs/translation-reuse.service.ts)

**Responsibilities:**
- Before running AI translation, check if the same device already has a completed translation for the same subtitle source + target language.
- Validate cue-level compatibility between the new aligned cues and the stored translation.
- If compatible, return the existing translated cues (avoiding another AI call).

---

### TranslationJobsRepository

**Key file:** [src/features/translation-jobs/translation-jobs.repository.ts](../src/features/translation-jobs/translation-jobs.repository.ts)

**Responsibilities (all DB access for this feature):**
- `createJob()`, `updateJob()`, `replaceJobCues()` — lifecycle mutations
- `claimQueuedJobForRunner(jobId)` — atomic claim via `SELECT ... FOR UPDATE SKIP LOCKED` inside a transaction
- `findOwnedJob()`, `findOwnedJobSummary()`, `listOwnedJobs()` — device-scoped reads
- `listPreviewCues()`, `listAllOwnedJobCues()` — paginated and full cue reads
- `findStalledJobs()` — recovery queries by status + updatedAt
- `findQueuedJobsForDispatch()` — overscan candidates with sourceType + jobMeta for priority scoring
- `findReusableCatalogTranslation()` — find completed jobs for translation reuse
- `tryAcquireRecoveryAdvisoryLock()` / `releaseRecoveryAdvisoryLock()` — PostgreSQL advisory lock (key: 7734812019)

**Dependencies:** `CatalogModule`, `SubtitlesModule`, `AppConfigModule`, `PrismaModule`

**Depended on by:** Nothing depends on `TranslationJobsModule` at the NestJS level. This is the terminal consumer module.

**Important models/DTOs:**
- `CreateTranslationJobDto` — sourceType, title, targetLanguage, format, parsedFileId or catalog references
- `TranslationJobSummary` — status, progress, stageLabel, metadata (no raw jobMeta exposed)
- `JobRetryMeta` — attemptCount, recoveredFromStall, lastFailureReasonCode, lastAttemptStartedAt

---

## Common Infrastructure (not a feature, but worth mapping)

### AppCacheService

**Key file:** [src/common/cache/app-cache.service.ts](../src/common/cache/app-cache.service.ts)

Used by: `SubtitleSourceDiscoveryService` (6h subtitle sources), `CatalogService` (30d movies / 1d series), `PreferencesService` (15min).

Key behavior: `getOrSet()` coalesces concurrent loaders — two callers for the same key at the same time share one outbound request. Capacity-bounded at 1000 entries with FIFO eviction.

### RateLimitService

**Key file:** [src/common/rate-limit/rate-limit.service.ts](../src/common/rate-limit/rate-limit.service.ts)

In-memory fixed-window buckets per IP+route. Limits by route:

| Route | Limit | Window |
|-------|-------|--------|
| auth/signup | 10 | 15min |
| auth/signin | 20 | 15min |
| subtitles/parse | 8 | 10min |
| translation-job/create | 12 | 10min |
| catalog/search | 30 | 1min |
| default | 120 | 1min |

### GlobalExceptionFilter

**Key file:** [src/common/http/filters/global-exception.filter.ts](../src/common/http/filters/global-exception.filter.ts)

Catches all exceptions and normalizes:
- `DomainError` → shaped error JSON with i18n message lookup
- `MulterError` → 413 or 400
- `HttpException` → validation_failed or http_error
- Unknown → 500 internal_error with stack logging

### StructuredLogger

**Key file:** [src/common/utils/structured-logger.ts](../src/common/utils/structured-logger.ts)

Wraps NestJS `Logger` and adds `{event, ...context}` shape. Used consistently across all services for machine-parseable log events like `translation.completed`, `subtitle.quality.evaluated`, etc.
