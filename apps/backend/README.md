# SubFlix Backend

Production-oriented NestJS backend for the SubFlix subtitle translation app.

## What it does

- Searches a mocked movie and series catalog
- Searches movies and series through TMDb when a read token is configured
- Returns provider-backed subtitle source options through a backend-owned chain
- Accepts `.srt` and `.vtt` subtitle uploads
- Parses subtitle files on the backend and stores normalized cues
- Creates async translation jobs with persisted progress and stage labels
- Exposes history, job status polling, preview, export, retry, and preferences APIs
- Scopes device-owned data with the `x-device-id` header; authenticated user ownership is not wired into those flows yet

## Stack

- NestJS
- PostgreSQL
- Prisma
- Vitest + Supertest
- Feature-based module structure

## Project structure

```text
src/
  common/
    config/
    database/
    domain/
    http/
  features/
    catalog/
    devices/
    health/
    preferences/
    subtitles/
    translation-jobs/

test/
  core/shared/
  e2e/
  integration/
  unit/
```

## Local setup

### 1. Install dependencies

```bash
pnpm install
```

### 2. Configure environment

Copy `.env.example` to `.env` and update values if needed.

```bash
NODE_ENV=development
PORT=3000
DATABASE_URL=postgresql://postgres:postgres@localhost:5432/subflix
MAX_UPLOAD_BYTES=2097152
TMDB_API_READ_TOKEN=your_tmdb_read_token
SUBDL_API_KEY=your_subdl_api_key
AUTH_JWT_SECRET=replace_with_secure_secret
AUTH_DEBUG_TOKEN_ECHO=false
AUTH_ACCESS_TOKEN_TTL_SECONDS=900
AUTH_REFRESH_TOKEN_TTL_DAYS=30
AUTH_EMAIL_VERIFICATION_TTL_HOURS=24
AUTH_PASSWORD_RESET_TTL_HOURS=2
AUTH_BCRYPT_SALT_ROUNDS=12
SUBTITLE_PROVIDER_PAGE_MAX_BYTES=524288
SUBTITLE_PROVIDER_API_RESPONSE_MAX_BYTES=524288
SUBTITLE_PROVIDER_MAX_REDIRECTS=3
FIREBASE_PROJECT_ID=your_firebase_project_id
FIREBASE_CLIENT_EMAIL=your_firebase_client_email
FIREBASE_PRIVATE_KEY=your_firebase_private_key
```

You can also set `FIREBASE_SERVICE_ACCOUNT_JSON` instead of the individual Firebase fields.

### 3. Start PostgreSQL

If you have Docker:

```bash
docker compose up -d
```

If you do not have Docker, point `DATABASE_URL` to an existing local PostgreSQL instance.

### 4. Generate Prisma client

```bash
pnpm prisma:generate
```

### 5. Apply migrations

```bash
pnpm prisma:migrate:dev
```

Notes on Prisma commands:
- `pnpm db:push:local` syncs the schema to your local database without creating migration files (fast for local iteration).
- `pnpm db:migrate:local` creates/applies migration files and is the right choice for shared or production-bound changes.

### 6. Run the API

```bash
pnpm start:dev
```

The app runs on `http://localhost:3000` and all routes are prefixed with `/v1`.

## TMDb search integration

- Set `TMDB_API_READ_TOKEN` in `.env.local` or `.env` to enable real movie and series search through TMDb.
- Search results are cached aggressively to reduce TMDb usage:
  - movie query results: 30 days
  - series query results: 1 day

## Subtitle source provider chain

- Subtitle source discovery is backend-owned and public through `GET /v1/catalog/media/:mediaId/subtitle-sources`.
- Optional query params are supported for discovery:
  - `preferredLanguage`
  - `seasonNumber`
  - `episodeNumber`
  - `releaseHint`
- Provider order is:
  - cache
  - SubDL API
  - Podnapisi scraper fallback
  - TVSubs scraper fallback
- Subtitle source lookup is provider-backed, and catalog translation jobs download and parse real subtitle payloads (supports direct `.srt`/`.vtt` and `.zip` archives).
- Catalog translation jobs compute deterministic subtitle confidence metadata (score, level, and warning codes) after cues are parsed, so suspicious subtitle matches can be flagged.
- Catalog translation jobs attempt deterministic timing offset correction for constant subtitle shifts before translation starts.
- Catalog translation jobs can reuse an existing target-language subtitle when one is available with sufficient confidence, skipping AI translation entirely.
- Catalog translation jobs reuse previously completed translations for the same subtitle source + target language (device-scoped) to avoid repeated AI translation requests.

## Core API routes

### Public

- `GET /v1/health`
- `GET /v1/catalog/search?q=...`
- `GET /v1/catalog/media/:mediaId/subtitle-sources`

### Auth

- `POST /v1/auth/signup`
- `POST /v1/auth/confirm-email`
- `POST /v1/auth/signin`
- `POST /v1/auth/oauth/firebase`
- `POST /v1/auth/refresh`
- `POST /v1/auth/forgot-password`
- `POST /v1/auth/reset-password`
- `POST /v1/auth/signout`
- `GET /v1/auth/me`

### Device-scoped

These routes require the `x-device-id` header.

- `GET /v1/preferences`
- `PATCH /v1/preferences`
- `POST /v1/subtitles/parse`
- `POST /v1/translation-jobs`
- `GET /v1/translation-jobs`
- `GET /v1/translation-jobs/:jobId`
- `GET /v1/translation-jobs/:jobId/preview`
- `GET /v1/translation-jobs/:jobId/export`
- `POST /v1/translation-jobs/:jobId/retry`
- `DELETE /v1/translation-jobs`

## Example requests

### Search catalog

```bash
curl "http://localhost:3000/v1/catalog/search?q=dune"
```

### Fetch preferences

```bash
curl -H "x-device-id: simulator-001" \
  "http://localhost:3000/v1/preferences"
```

### Parse subtitle upload

```bash
curl -X POST "http://localhost:3000/v1/subtitles/parse" \
  -H "x-device-id: simulator-001" \
  -F "file=@./sample.srt"
```

### Create translation job

```bash
curl -X POST "http://localhost:3000/v1/translation-jobs" \
  -H "Content-Type: application/json" \
  -H "x-device-id: simulator-001" \
  -d '{
    "sourceType": "upload",
    "parsedFileId": "REPLACE_WITH_FILE_ID",
    "targetLanguage": "fr"
  }'
```

### Create catalog translation job (optional release hints)

```bash
curl -X POST "http://localhost:3000/v1/translation-jobs" \
  -H "Content-Type: application/json" \
  -H "x-device-id: simulator-001" \
  -d '{
    "sourceType": "catalog",
    "mediaId": "inception",
    "subtitleSourceId": "REPLACE_WITH_SSRC_ID",
    "releaseHint": "Inception.2010.1080p.BluRay.x264-GRP",
    "targetLanguage": "fr"
  }'
```

## Testing

### Run everything

```bash
pnpm test
```

### Run specific suites

```bash
pnpm test:unit
pnpm test:integration
pnpm test:e2e
```

### Vitest notes

- Unit, integration, and e2e suites all run through Vitest.
- The repo uses a shared Vitest config with suite-specific entry configs so setup stays DRY.
- Decorator metadata is preserved during tests, which keeps NestJS modules and DI behavior aligned with the runtime app.

### Important test note

- Unit tests run without PostgreSQL.
- Integration and DB-backed e2e tests are present in the repo from day one.
- When `DATABASE_URL` is not configured, those DB-backed suites skip instead of failing the whole repo locally.
- On a machine with PostgreSQL available, the same suites will execute against the configured database.

## Quality commands

```bash
pnpm build
pnpm lint
pnpm format
```

## Current architecture decisions

- Controllers stay thin and delegate to feature services.
- Repositories own Prisma access only.
- Shared DB helpers are intentionally small: pagination, entity lookup, and DB error normalization.
- Translation runs asynchronously in-process for now and is isolated behind a runner + provider boundary so it can move to a worker queue later.
- Catalog search is backed by TMDb when configured, and subtitle source lookup now runs through swappable SubDL + scraper provider adapters behind the catalog feature.
- Export generation happens on the backend, not in the client.

## Stalled job recovery

Translation jobs that get stuck in the `translating` state (e.g. due to a process crash mid-flight) are automatically recovered on a schedule.

### How it works

- On application startup, a recovery pass runs immediately if `TRANSLATION_JOB_STARTUP_RECOVERY_ENABLED=true`.
- A periodic recovery interval fires every `TRANSLATION_JOB_RECOVERY_INTERVAL_MS` milliseconds (default: 60 seconds).
- A job is considered stalled when its `updatedAt` has not advanced for longer than `TRANSLATION_JOB_STALE_AFTER_MS` (default: 5 minutes). The runner heartbeats `updatedAt` via every progress update, so this doubles as an activity signal.
- Recovery policy per stalled job:
  - `attemptCount < TRANSLATION_JOB_MAX_ATTEMPTS` → requeue (status: `queued`, `recoveredFromStall: true` in metadata)
  - `attemptCount >= TRANSLATION_JOB_MAX_ATTEMPTS` → permanently fail with reason `stall_recovery_exhausted`

### Recovery config

| Variable | Default | Description |
|---|---|---|
| `TRANSLATION_JOB_RECOVERY_ENABLED` | `true` | Master switch. Set to `false` to disable all recovery. |
| `TRANSLATION_JOB_RECOVERY_INTERVAL_MS` | `60000` | How often the periodic recovery cycle runs (ms). |
| `TRANSLATION_JOB_STARTUP_RECOVERY_ENABLED` | `true` | Whether to run a recovery pass on application startup. |
| `TRANSLATION_JOB_STALE_AFTER_MS` | `300000` | How long a job must be inactive to be considered stalled (ms). |
| `TRANSLATION_JOB_MAX_ATTEMPTS` | `3` | Maximum stall-recovery attempts before a job is permanently failed. |

### Multi-instance safety

The recovery scheduler runs in-process using `setInterval`. Before each recovery cycle the service acquires a PostgreSQL session-level advisory lock via `pg_try_advisory_lock`. At most one process instance holds the lock at a time:

- If the lock is acquired, the recovery cycle runs normally and the lock is released in a `finally` block.
- If the lock is unavailable (another instance is already recovering), the cycle exits immediately with a `translation.recovery.lock_skipped` log — no job state is touched.

This prevents duplicate recovery work and conflicting state transitions across multiple workers. Advisory locks are session-scoped and automatically released when the database connection closes, so a crashed process will not leave a dangling lock.

## Execution concurrency control

The runner enforces a per-process ceiling on how many translation jobs can execute at the same time. This keeps AI/provider usage predictable and prevents the process from being overwhelmed under load.

### How it works

- Before a job is claimed from the database, the runner acquires an execution slot from `TranslationJobExecutionLimiterService`.
- If the concurrency limit is already reached, the runner returns immediately — the job remains in `queued` status in the database and will be dispatched by `TranslationJobDispatchService` when capacity opens (see "DB-backed dispatch" below).
- Slot release always happens in a `finally` block, so slots are never leaked even when execution throws.

### Concurrency config

| Variable | Default | Description |
|---|---|---|
| `TRANSLATION_JOB_MAX_CONCURRENCY` | `3` | Maximum number of translation jobs that may execute simultaneously per process. |

### Concurrency model under multi-instance deployment

The concurrency limit is in-memory and per-process. Running `N` instances each with `TRANSLATION_JOB_MAX_CONCURRENCY=3` allows up to `3 × N` jobs to execute concurrently across the fleet. There is no global concurrency cap across instances. This is intentional for V1: the per-process ceiling keeps each instance predictable and avoids the complexity of a distributed semaphore. Document and tune `TRANSLATION_JOB_MAX_CONCURRENCY` accordingly when scaling horizontally.

## DB-backed dispatch

`TranslationJobDispatchService` is the durable dispatch coordinator. It uses the database as the source of truth for which jobs are waiting, so dispatch intent survives process restarts.

### How it works

1. `dispatch(trigger)` reads the current concurrency metrics to determine how many slots are free.
2. If slots are available, it fetches an overscanned candidate batch (`findQueuedJobsForDispatch`) pre-sorted by createdAt ASC.
3. `pickDispatchCandidates` scores candidates by priority tier and selects the best `slotsAvailable` jobs.
4. Each selected job is handed to the runner via `schedule()`.
5. If no slots are free or no queued jobs exist, it exits cleanly with a structured log.

### Trigger points

| When | Trigger value |
|---|---|
| Application startup (after stalled-job recovery) | `startup` |
| Periodic poll interval | `poll` |

### Startup ordering

On bootstrap, the lifecycle scheduler always runs stalled-job recovery first, then startup dispatch. This ensures that any jobs recovered from a stale `translating` state are requeued before the dispatch coordinator looks for work.

### Dispatch config

| Variable | Default | Description |
|---|---|---|
| `TRANSLATION_JOB_DISPATCH_ON_STARTUP_ENABLED` | `true` | Whether to run a dispatch pass immediately on startup (after recovery). |
| `TRANSLATION_JOB_DISPATCH_POLL_INTERVAL_MS` | `10000` | How often the periodic dispatch poll fires (ms). Set to `0` to disable polling. |
| `TRANSLATION_JOB_DISPATCH_FAIRNESS_THRESHOLD_MS` | `300000` | Age after which recovered-from-stall jobs are promoted to their base tier (see scheduling policy). |

### Multi-instance safety

Multiple process instances dispatch independently against their own per-process concurrency budgets. The dispatch coordinator reads candidates from the DB and passes their IDs to the runner. The runner's `claimQueuedJobForRunner` uses `SELECT ... FOR UPDATE SKIP LOCKED` inside a transaction: at most one worker can claim any given job regardless of how many dispatch instances run concurrently. Workers that lose the race receive `null` and move on cleanly — no blocking, no duplicate execution.

Under high concurrent dispatch load across many instances, job ordering may become approximately FIFO rather than strictly FIFO, because different workers see slightly different snapshots of the queue. This is documented as an acceptable trade-off; correctness (no duplicates, no skipped jobs) is guaranteed by the DB-level SKIP LOCKED claim.

### Interaction with stalled job recovery

- Recovery requeues stalled jobs (status `translating` → `queued`).
- The dispatch coordinator picks them up on the next startup or poll cycle.
- Recovered jobs are placed in the `RECOVERED` priority tier initially (see scheduling policy below).
- No coordination is needed between the two: correctness is guaranteed by the DB state, not by in-memory hand-off.

## Scheduling policy

The dispatch coordinator uses a deterministic, two-level scheduling policy to decide which queued jobs to run next.

### Priority tiers

| Tier | Value | Applies to | Rationale |
|---|---|---|---|
| `CATALOG` | 10 (highest) | Fresh catalog jobs | May complete without AI translation (via target-language subtitle reuse or cached translation), making them the highest-value candidates. |
| `UPLOAD` | 20 | Fresh upload jobs | Always require AI translation but skip catalog overhead (no subtitle download or quality eval). |
| `RECOVERED` | 30 (lowest) | Recovered-from-stall jobs | Deprioritized to avoid consuming concurrency slots at the expense of fresh jobs. Promoted after the fairness threshold. |

### FIFO tiebreaker

Within the same priority tier, jobs are ordered by `createdAt` ascending. Older jobs in the same tier are always dispatched before newer ones.

### Fairness / starvation protection

A recovered-from-stall job that has been waiting longer than `TRANSLATION_JOB_DISPATCH_FAIRNESS_THRESHOLD_MS` (default 5 minutes, measured from `createdAt`) is promoted back to its base tier (`CATALOG` or `UPLOAD`). This guarantees that no job waits indefinitely regardless of how many fresh jobs are created behind it.

### Overscan

The repository fetches up to `slotsAvailable × 5` candidates (capped at 50) for each dispatch call. This ensures that higher-priority jobs later in the FIFO queue can be found and selected ahead of lower-priority jobs that arrived earlier.

### Assumptions and limitations

- Priority is computed at dispatch time from fields already on the job (`sourceType`, `jobMeta.recoveredFromStall`, `createdAt`). No extra DB round-trips are made during priority scoring.
- The system does not predict at dispatch time whether a catalog job will use translation or subtitle reuse. It uses `sourceType` as a proxy signal: catalog jobs are prioritized on the assumption that they are more likely to short-circuit AI translation.
- Single-instance only: priority scoring is in-process and per-dispatch call. Multi-instance deployments score independently per process (correctness is still guaranteed by atomic DB claims).

## Multi-instance coordination

SubFlix Back is designed to run safely across multiple process instances (e.g. behind a load balancer or as Kubernetes replicas). The three coordination mechanisms below make this safe without requiring Redis, BullMQ, or an external lock server.

### Job claiming — SELECT FOR UPDATE SKIP LOCKED

Every job claim uses a PostgreSQL-native `SELECT ... FOR UPDATE SKIP LOCKED` pattern inside a transaction:

1. Lock the target row if it is still `queued` — skip it non-blockingly if another transaction already holds the lock.
2. If the row was locked, update status to `translating` in the same transaction.
3. Return the claimed job (or `null` on skip).

Result: at most one worker can execute any given job, even when multiple instances race to claim it. Workers that lose the race return `null` immediately — no blocking, no deadlocks.

### Recovery coordination — PostgreSQL advisory lock

Only one instance should run stalled-job recovery at a time to avoid conflicting state transitions. Before each recovery cycle the service calls `pg_try_advisory_lock(key)`:

| Outcome | Behaviour |
|---|---|
| Lock acquired | Recovery runs normally; lock released in `finally` block |
| Lock unavailable | `translation.recovery.lock_skipped` logged; cycle exits immediately |

Advisory locks are session-scoped. A crashed process automatically releases the lock when its database connection closes, so there is no risk of a permanent dead-lock.

### Concurrency — per-process, documented global budget

The execution limiter (`TRANSLATION_JOB_MAX_CONCURRENCY`) is in-memory and per-process. With `N` instances each set to `M` concurrent jobs, the global concurrency budget is `N × M`. There is no cross-instance cap in V1. Tune `TRANSLATION_JOB_MAX_CONCURRENCY` to account for the expected replica count.

### PostgreSQL assumptions

All coordination relies on a single shared PostgreSQL database. Advisory locks are scoped to the database connection, not a schema or table. The default lock key (`7734812019`) is hardcoded and stable — do not change it between deployments.

## Current limitations

- Device-scoped data is still owned by `x-device-id`; authenticated user ownership is not wired into those flows yet.
- `.zip` archive extraction is supported for catalog subtitle downloads. `.rar` archives are not supported yet.
- Translation execution is still mocked behind its provider boundary.
- No Redis/BullMQ worker pipeline yet. Jobs are run in-process to keep V1 simple.
- DB-backed tests require a reachable PostgreSQL database.
- Global concurrency across instances is the sum of per-process limits (see Multi-instance coordination above).
