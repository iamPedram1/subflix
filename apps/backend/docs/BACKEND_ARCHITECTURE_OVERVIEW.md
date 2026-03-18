# Backend Architecture Overview

SubFlix Back is the NestJS API server for a Flutter subtitle translation application. Users upload or select subtitles for movies and TV series and receive translated versions in their preferred target language.

---

## Project Purpose

The backend does three things:

1. **Subtitle sourcing** — Let users upload their own subtitle files or discover subtitles from third-party providers (SubDL, Podnapisi, TVSubs) via the catalog search flow.
2. **Translation job orchestration** — Queue, execute, track, and recover subtitle translation jobs with concurrency control and multi-instance coordination.
3. **Device-scoped data management** — Persist subtitle files, job history, and preferences tied to a device ID without requiring a traditional user account.

---

## Architectural Style

The project follows **NestJS feature-first modularity** with several deliberate design choices:

- **Thin controllers** — Controllers map HTTP requests to service calls and return results. No business logic lives there.
- **Repository pattern** — Every feature has a repository that owns all Prisma/DB access. Services never call Prisma directly.
- **Port/adapter pattern** — External integrations (TMDb, subtitle providers, translation engine) are hidden behind interface ports. The application code depends on the port; provider implementations are injected at module wiring time.
- **Layered error normalization** — All errors (domain, Prisma, validation, HTTP) are caught by `GlobalExceptionFilter` and normalized into a stable JSON envelope before reaching the client.
- **Request-scoped device context** — A guard resolves the `x-device-id` header into a `ClientDevice` record and attaches it to the request object. All private routes receive a typed device, not a raw string.

---

## Module Structure

```
src/
├── common/            # Shared infrastructure (not feature-specific)
│   ├── cache/         # In-memory TTL cache with request coalescing
│   ├── config/        # Environment variable registration (8 config namespaces)
│   ├── database/      # PrismaService + helpers (pagination, entity lookup, error normalization)
│   ├── domain/        # DomainError hierarchy, shared enums, provider ID constants
│   ├── http/          # Guards, filters, interceptors, decorators, DTOs
│   ├── i18n/          # Locale message files (en, es, ar, fr, zh, fa, etc.)
│   ├── rate-limit/    # In-memory fixed-window rate limiting
│   └── utils/         # StructuredLogger, timed(), delay()
│
└── features/
    ├── auth/           # Email/password sign-up/sign-in + Firebase OAuth
    ├── devices/        # Device upsert and ownership validation
    ├── health/         # Lightweight readiness endpoint
    ├── preferences/    # Device-scoped user settings (cached)
    ├── subtitles/      # Upload parsing (SRT/VTT) and subtitle export
    ├── catalog/        # Media discovery (TMDb), subtitle source search, quality + timing
    └── translation-jobs/ # Job lifecycle: creation, execution, dispatch, recovery
```

---

## Layer Organization

```
HTTP Request
    │
    ▼
DeviceContextGuard / AccessTokenGuard       ← identity + ownership validation
    │
    ▼
Controller                                  ← HTTP mapping only; no business logic
    │
    ▼
Service                                     ← business rules, orchestration
    │
    ▼
Repository                                  ← all Prisma/DB access
    │
    ▼
PostgreSQL via PrismaService
```

For external calls:
```
Service
    │
    ▼
Port (interface)                            ← dependency on abstraction
    │
    ▼
Provider (implementation)                  ← TMDb, SubDL, MockTranslation, etc.
    │
    ▼
External API / Web
```

---

## Module Communication

NestJS module imports determine which services are visible to each other. Key dependencies between features:

| Consumer | Depends On |
|----------|------------|
| `TranslationJobsModule` | `CatalogModule`, `SubtitlesModule`, translation provider injection |
| `CatalogModule` | `AppCacheService`, `SubtitleProviderHealthService` |
| `PreferencesModule` | `AppCacheService` |
| `AuthModule` | `FirebaseAuthService`, `JwtModule` |
| All features | `PrismaModule`, `AppConfigModule` |

Cross-feature coupling is explicit (via module imports), not implicit. The `common/` layer is imported where needed but does not depend on any feature module.

---

## Data Persistence

All durable state lives in **PostgreSQL** accessed via Prisma.

Key entities:
- `User` / `UserIdentity` / `RefreshToken` — authentication
- `ClientDevice` — the ownership boundary for all user data
- `UserPreference` — device-scoped settings
- `ParsedSubtitleFile` + `ParsedSubtitleCue` — uploaded subtitle storage
- `TranslationJob` + `TranslationJobCue` — job execution records and translated output

In-memory state that does NOT survive restarts:
- Cache entries (`AppCacheService`) — stale on restart, populated on next access
- Rate limit buckets — reset on restart
- Execution limiter slot counter — safe to reset; jobs that were running are recovered by stall detection

---

## Background Processing

Translation jobs are executed **in-process** using `setTimeout(0)` to defer work past the HTTP request/response lifecycle. This is intentional and documented as a future replacement point for an external queue worker.

The processing pipeline has multiple layers:

| Layer | Responsibility |
|-------|----------------|
| `TranslationJobRunnerService` | Execute individual jobs; call translation provider |
| `TranslationJobExecutionLimiterService` | In-memory per-process concurrency ceiling |
| `TranslationJobDispatchService` | DB-backed scheduler; fills available slots from queued jobs |
| `TranslationJobRecoveryService` | Detect stalled jobs; requeue or permanently fail them |
| `TranslationJobRecoverySchedulerService` | Wire recovery + dispatch into application lifecycle via timers |

Multi-instance safety is handled at the DB layer:
- Job claiming uses `SELECT ... FOR UPDATE SKIP LOCKED` so two workers cannot claim the same job.
- Stall recovery is protected by a PostgreSQL session-level advisory lock so only one instance runs recovery at a time.

See [REQUEST_AND_JOB_FLOWS.md](REQUEST_AND_JOB_FLOWS.md) for detailed flow diagrams.

---

## External Integrations

| Integration | Purpose | Port/Abstraction |
|-------------|---------|-----------------|
| **TMDb API** | Media search (movies + TV) | `MediaCatalogPort` |
| **SubDL** | Subtitle source search + download | `SubtitleSourceProvider` |
| **Podnapisi** | Subtitle source search (scraper) | `SubtitleSourceProvider` |
| **TVSubs** | Subtitle source search (scraper) | `SubtitleSourceProvider` |
| **Translation provider** | Translate subtitle cues | `TranslationProviderPort` |
| **Firebase Admin SDK** | OAuth token verification | `FirebaseAuthService` |
| **PostgreSQL** | Primary data store | `PrismaService` |

All integrations are optional or have mock fallbacks. When `TMDB_API_READ_TOKEN` is absent, `MockCatalogProvider` is used. When `SUBDL_API_KEY` is absent, SubDL is disabled. The translation provider is currently `MockTranslationProvider` — a production translation engine (e.g., Claude API, DeepL) would implement `TranslationProviderPort` and be injected without touching runner logic.

See [EXTERNAL_INTEGRATIONS.md](EXTERNAL_INTEGRATIONS.md) for details.

---

## Design Strengths

**Atomic job claiming** — `SELECT ... FOR UPDATE SKIP LOCKED` prevents any duplicate execution across multiple instances without requiring distributed infrastructure.

**Durable job queue** — Jobs live in the DB from creation to completion. Process crashes do not lose queued work; the recovery scheduler picks up stalled jobs on the next cycle.

**Clean port/adapter boundaries** — The translation provider can be swapped from mock to a real AI service without changing runner, dispatch, or controller code.

**Request coalescing in cache** — Concurrent callers for the same catalog search or subtitle source list share a single outbound HTTP request. This is important because subtitle provider scraping is slow and rate-limited.

**Layered error normalization** — All errors surface through a single filter into a consistent JSON envelope. Client code never needs to handle multiple error shapes.

**Honest device ownership model** — No auth is required for private routes, but every request must carry a stable `x-device-id`. The guard upserts the device record, so ownership is enforced at the DB layer without user accounts.

---

## Complexity Points

**Job runner is inside the API process** — The runner executes jobs via `setTimeout`. Under heavy load this shares the Node.js event loop with HTTP requests. The per-process concurrency limit (`TRANSLATION_JOB_MAX_CONCURRENCY=3`) bounds the damage but does not eliminate it. Moving to an external worker is the natural next step.

**Catalog job path has many branches** — A catalog job can complete via: existing target-language subtitle reuse → AI translation with translation reuse → fresh AI translation. Each branch has its own quality evaluation, timing alignment, and persistence logic inside `runCatalogJob()`. This makes the runner complex.

**JSON blobs on `TranslationJob`** — `mediaRef`, `subtitleSourceRef`, and `jobMeta` are all untyped `Json?` fields in the schema. The types are enforced in TypeScript via cast helpers but are invisible to Prisma. Evolving these fields across versions requires careful migration handling.

**In-memory cache is per-process** — In a multi-instance deployment, cache entries are not shared. Each instance builds its own cache independently. This means more outbound requests to TMDb and subtitle providers during the warm-up window after deployment.

**Advisory lock is session-scoped** — The PostgreSQL advisory lock used for recovery is a session-level lock. If a PrismaService instance reuses a connection from the pool, the lock key may already be "held" by that session from a previous cycle. The current code releases the lock in a `finally` block, which prevents leaks under normal operation. Connection pool edge cases (e.g., connection eviction mid-recovery) could theoretically leave the lock held until the pool timeout.

---

## Current Assumptions and Limitations

| Assumption | Detail |
|------------|--------|
| Single-DB, PostgreSQL | Advisory locks and SKIP LOCKED are PostgreSQL-specific. Switching to MySQL or SQLite would require different coordination primitives. |
| In-process job execution | Jobs run in the same process as the HTTP server. Long-running translations will delay other jobs unless concurrency is tuned. |
| Per-process concurrency | `TRANSLATION_JOB_MAX_CONCURRENCY` limits jobs per process, not globally. In a multi-instance deployment, global concurrency = N × limit. |
| In-memory cache is not shared | Cache is per-process. All instances independently fill their caches on cold start. |
| No real translation provider | `MockTranslationProvider` is the only implementation. All translated output is deterministic mock text. |
| Device ownership without auth | Any client that knows a device ID can read that device's data. There is no session invalidation or device revocation mechanism. |
| No email delivery | The auth module issues verification and password-reset tokens but does not send emails. The token values are returned in the API response (dev mode) or need an email service integration. |
