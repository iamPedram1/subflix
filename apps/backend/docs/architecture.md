# Architecture

## Overview

SubFlix Back is a feature-first NestJS backend built for a Flutter client that searches media, parses subtitle files, creates async translation jobs, previews results, exports translated subtitles, and persists device-scoped preferences.

## Principles

- feature-first structure over layer-only structure
- thin controllers
- business logic in services
- database access in repositories
- small shared helpers only where duplication is clearly generic
- mock provider adapters behind ports so real providers can replace them later

## Folder Shape

```text
src/
  common/
    cache/
    config/
    database/
    domain/
    http/
    utils/
  features/
    auth/
    catalog/
    devices/
    health/
    preferences/
    subtitles/
    translation-jobs/
```

## Common Layer

### `common/config`

- central app configuration
- environment parsing
- size and cache defaults

### `common/database`

- Prisma client module
- shared pagination helpers
- shared DB error normalization
- entity existence helpers

This layer should stop at generic persistence concerns. It should not absorb feature business rules.

### `common/http`

- request guard for `x-device-id`
- current-device decorator
- request-id interceptor
- global exception filter
- DTOs used across features

### `common/cache`

- in-memory TTL cache for read-heavy flows
- request coalescing to reduce duplicate provider work
- currently used for catalog reads and preference reads

## Feature Modules

### `health`

- public health endpoint
- intentionally lightweight

### `auth`

- email/password sign-up and sign-in
- Firebase OAuth sign-in (Google, Facebook, Apple)
- access + refresh token issuance and rotation

### `devices`

- resolves or creates the persisted device owner record
- currently driven by `x-device-id`

### `catalog`

- media search
- TMDb-backed movie and TV discovery when a read token is configured
- subtitle source discovery
- provider-backed subtitle source orchestration with cache-first lookup
- SubDL primary provider with scraper fallbacks
- stable opaque subtitle source ids (`ssrc:*`) returned to the client for later reuse (for example translation job creation)
- mock cue adapter retained only until real catalog subtitle downloads land
- read-heavy and cache-friendly

### `preferences`

- device-scoped user preference read/update
- default preference creation
- cache-backed reads

### `subtitles`

- upload validation
- subtitle parsing
- parsed file persistence
- export formatting utilities

### `translation-jobs`

- job creation and retry
- async translation orchestration
- history listing
- preview retrieval
- export handling

## Request Flow

1. Request enters Nest app with global validation and exception handling.
2. Private routes pass through `DeviceContextGuard`.
3. Guard resolves the persisted device owner from `x-device-id`.
4. Controller maps HTTP input to a feature service call.
5. Service orchestrates validation, repository calls, and provider adapters.
6. Repository performs Prisma persistence and returns typed records.
7. Mappers shape the public DTO payload.

## Async Translation Flow

1. Client creates a translation job.
2. Job is stored immediately with status `queued`.
3. Runner schedules background execution inside the API process.
4. Runner atomically claims the job.
5. Source cues are loaded from upload storage or catalog provider.
6. Mock translation provider generates translated lines.
7. Preview/export cues are persisted.
8. Job is marked `completed` or `failed`.

## Abstraction Boundary

Good shared abstractions:

- pagination helpers
- DB error normalization
- entity not-found helpers
- cache primitives

Abstractions that should stay feature-local:

- subtitle parsing rules
- translation job orchestration
- retry reconstruction
- export eligibility
- provider-specific catalog behavior

## Performance Notes

- public catalog routes are cached
- TMDb movie queries are cached for 30 days
- TMDb series queries are cached for 1 day
- preferences reads are cached per device
- upload-backed job creation reads file metadata without loading all cues
- summary endpoints use lean DB selects rather than full row hydration
- job scheduling avoids duplicate in-process queueing for the same job id

## Future Extension Points

- replace mock providers with real media/subtitle/translation adapters
- move translation execution from in-process runner to a queue worker
- replace `x-device-id` ownership with authenticated users
- add object storage for subtitle payloads if files grow beyond DB-friendly sizes
