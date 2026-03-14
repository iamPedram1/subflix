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
```

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
- Catalog translation jobs also attempt deterministic timing offset correction for constant subtitle shifts before translation starts.

## Core API routes

### Public

- `GET /v1/health`
- `GET /v1/catalog/search?q=...`
- `GET /v1/catalog/media/:mediaId/subtitle-sources`

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

## Current limitations

- No real authentication yet. Ownership is header-based via `x-device-id`.
- `.zip` archive extraction is supported for catalog subtitle downloads. `.rar` archives are not supported yet.
- Translation execution is still mocked behind its provider boundary.
- No Redis/BullMQ worker pipeline yet. Jobs are run in-process to keep V1 simple.
- DB-backed tests require a reachable PostgreSQL database.
