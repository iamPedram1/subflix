# API Rules

## Core Contract

- Base URL pattern: `/v1/*`
- Response format should stay stable for Flutter clients
- Public read routes may be cacheable when safe
- Device-scoped routes must require `x-device-id`
- Each request should include `x-request-id` when available
- Error `message` values may be localized using the `Accept-Language` header (fallback: `en`)

## Versioning

- Keep the `v1` prefix on every public route
- Avoid breaking response shapes inside the same API version
- Add new optional fields before introducing any breaking change
- Use a future `v2` only when contract compatibility cannot be preserved

## Ownership And Access

- `x-device-id` is the current ownership boundary
- Device-scoped data must never be returned across device boundaries
- Missing `x-device-id` must fail with `401`
- Invalid `x-device-id` must fail with `400`

## Validation

- Validate all request bodies, params, and queries with DTOs
- Strip unknown fields through the global whitelist validation pipe
- Reject unsupported enum values explicitly
- Keep query and body limits conservative to reduce abuse risk

## Error Envelope

Every non-success response should use the normalized envelope:

```json
{
  "code": "validation_failed",
  "message": "Human-readable message",
  "details": {},
  "requestId": "request-id",
  "timestamp": "2026-03-13T20:00:00.000Z"
}
```

Notes:

- `code` values are stable and must not be localized.
- `message` is human-readable and may be localized based on `Accept-Language` with fallback to English (`en`).

## Route Rules

### Health

- `GET /v1/health` must stay public
- Keep it lightweight and side-effect free

### Catalog

- `GET /v1/catalog/search`
- `GET /v1/catalog/media/:mediaId/subtitle-sources`
- These routes are public and cacheable
- Search queries must be trimmed and validated
- `subtitle-sources` may accept optional `preferredLanguage`, `seasonNumber`, `episodeNumber`, and `releaseHint` query params
- `seasonNumber` and `episodeNumber` must be supplied together and are only supported for TV titles (movies reject them with `400`)
- `subtitleSourceId` values returned from `subtitle-sources` are stable opaque ids in the `ssrc:*` format and may be persisted by clients
- `subtitle-sources` responses may include optional `languageCode` and `languageName` fields for display and selection logic

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

Rules:

- access tokens must be sent via `Authorization: Bearer <accessToken>`
- refresh tokens must be sent in the request body
- email sign-ups must normalize emails to lowercase
- email/password sign-in requires a confirmed email
- OAuth sign-ins must validate Firebase id tokens

### Preferences

- `GET /v1/preferences`
- `PATCH /v1/preferences`
- These routes are private and must default to `Cache-Control: no-store`

### Subtitles

- `POST /v1/subtitles/parse`
- Accept only `.srt` and `.vtt`
- Multipart field name must remain `file`
- Parsing stays backend-owned

### Translation Jobs

- `POST /v1/translation-jobs`
- `GET /v1/translation-jobs`
- `GET /v1/translation-jobs/:jobId`
- `GET /v1/translation-jobs/:jobId/preview`
- `GET /v1/translation-jobs/:jobId/export`
- `POST /v1/translation-jobs/:jobId/retry`
- `DELETE /v1/translation-jobs`

Rules:

- history endpoints return summaries only
- preview data comes from the dedicated preview endpoint
- export generation stays backend-owned
- completed jobs are exportable, incomplete jobs are not
- catalog-backed jobs may include additional optional subtitle quality metadata on job reads:
  - `subtitleConfidenceScore` (0-100)
  - `subtitleConfidenceLevel` (`high` | `medium` | `low`)
  - `subtitleWarnings` (stable warning codes)
- catalog-backed jobs may include additional optional subtitle timing alignment metadata on job reads:
  - `subtitleTimingOffsetMs` (detected offset in milliseconds)
  - `subtitleTimingConfidence` (0-100)
  - `subtitleTimingCorrected` (boolean)
- catalog-backed jobs may include additional optional subtitle acquisition metadata on job reads:
  - `subtitleAcquisitionMode` (`existing_target_subtitle` | `ai_translation`)
  - `reusedExistingSubtitle` (boolean)
  - `reusedSubtitleConfidenceScore` (0-100)
  - `reusedSubtitleConfidenceLevel` (`high` | `medium` | `low`)
- catalog-backed jobs may include additional optional translation reuse metadata on job reads:
  - `translationReuse` (boolean)
  - `translationReusedFromJobId` (job id when reuse is applied)
- catalog-backed job creation may accept additional optional fields to improve subtitle matching:
  - `seasonNumber` and `episodeNumber` (must be supplied together for TV episode scope)
  - `releaseHint` (free-form filename/release hint used for ranking and quality signals)

## Pagination

- Default page: `1`
- Default limit: `20`
- Max limit: `100`
- Paginated responses should consistently include:
  - `items`
  - `page`
  - `limit`
  - `total`
  - `totalPages`

## Translation Job Lifecycle

Public statuses:

- `queued`
- `translating`
- `completed`
- `failed`

Additional rules:

- newly created jobs are persisted before async processing begins
- progress values should move forward monotonically
- `stageLabel` should remain human-readable and UI-friendly

## Caching Rules

- public catalog routes may return explicit cache headers
- private routes should default to `no-store`
- application caching must never bypass ownership checks
- cached data must be invalidated when related private state changes

## Security Rules

- never trust raw request headers without normalization
- never expose internal DB errors directly
- do not add raw SQL string interpolation
- escape or sanitize only at the correct layer; validation is not rendering protection
- do not store secrets in Postman collections or sample environments
