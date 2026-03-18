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
- Scopes user-owned data with the `x-device-id` header until real auth is added

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
AUTH_ACCESS_TOKEN_TTL_SECONDS=900
AUTH_REFRESH_TOKEN_TTL_DAYS=30
AUTH_EMAIL_VERIFICATION_TTL_HOURS=24
AUTH_PASSWORD_RESET_TTL_HOURS=2
AUTH_BCRYPT_SALT_ROUNDS=12
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

### Single-instance limitation

The recovery scheduler runs in-process using `setInterval`. It is safe for single-instance deployments. If you run multiple instances behind a load balancer, concurrent recovery cycles are possible. The repository's atomic `updateMany(status: translating)` pre-check prevents double-recovery of the same job (concurrent attempts just silently skip), but for true leader-election behavior you would need a database advisory lock or an external coordination mechanism.

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

### Single-instance limitation

The concurrency limit is in-memory and per-process. Running multiple instances behind a load balancer means each process enforces its own budget independently — global concurrency across instances is not bounded by this mechanism.

## DB-backed dispatch

`TranslationJobDispatchService` is the durable dispatch coordinator. It uses the database as the source of truth for which jobs are waiting, so dispatch intent survives process restarts.

### How it works

1. `dispatch(trigger)` reads the current concurrency metrics to determine how many slots are free.
2. If slots are available, it queries `findNextQueuedJobs(slotsAvailable)` — returning the oldest `queued` jobs first (createdAt ASC for FIFO fairness).
3. Each found job is handed to the runner via `schedule()`.
4. If no slots are free or no queued jobs exist, it exits cleanly with a structured log.

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

### Single-instance limitation

The dispatch coordinator reads concurrency state from the in-memory limiter. Multiple process instances each dispatch independently against their own budgets. Concurrent `dispatch()` calls (e.g. startup and a poll firing simultaneously) may both read the same available slot count, but the runner's schedule dedup and the repository's atomic `claimQueuedJobForRunner` prevent duplicate execution.

### Interaction with stalled job recovery

- Recovery requeues stalled jobs (status `translating` → `queued`).
- The dispatch coordinator picks them up on the next startup or poll cycle.
- No coordination is needed between the two: correctness is guaranteed by the DB state, not by in-memory hand-off.

## Current limitations

- Device-scoped data is still owned by `x-device-id`; authenticated user ownership is not wired into those flows yet.
- `.zip` archive extraction is supported for catalog subtitle downloads. `.rar` archives are not supported yet.
- Translation execution is still mocked behind its provider boundary.
- No Redis/BullMQ worker pipeline yet. Jobs are run in-process to keep V1 simple.
- DB-backed tests require a reachable PostgreSQL database.
- Stalled job recovery uses in-process scheduling, not distributed locks (see above).
