# Data and State Model

This document describes the persisted data, state machines, JSON metadata fields, and the boundary between durable storage and in-memory state.

---

## Prisma Entities

### User

Authentication identity. Not required to use the app (device-only usage works), but needed for email/password or OAuth sign-in.

| Field | Type | Notes |
|-------|------|-------|
| id | UUID | Primary key |
| email | String (unique) | Normalized to lowercase |
| passwordHash | String? | bcrypt hash; null for OAuth-only users |
| displayName | String? | Optional display name |
| photoUrl | String? | Profile picture URL from OAuth |
| emailVerified | Boolean | Must be true before sign-in allowed |
| createdAt / updatedAt | DateTime | Standard timestamps |

**Relations:** `identities[]`, `refreshTokens[]`, `emailVerificationTokens[]`, `passwordResetTokens[]`

---

### UserIdentity

Links a user to a specific auth provider.

| Field | Type | Notes |
|-------|------|-------|
| userId | UUID (FK → User) | |
| provider | AuthProvider enum | email, firebase_google, firebase_facebook, firebase_apple |
| providerUserId | String | Provider-specific user ID |
| email | String? | Email from OAuth provider (may differ from User.email) |

**Unique constraint:** `(provider, providerUserId)` — one user per provider ID.

---

### RefreshToken

Long-lived session token. Never stored raw — only `tokenHash` is persisted.

| Field | Type | Notes |
|-------|------|-------|
| userId | UUID (FK → User) | |
| tokenHash | String (unique) | SHA-256 or bcrypt of raw token |
| expiresAt | DateTime | 30 days from issuance |
| revokedAt | DateTime? | Set on sign-out |
| lastUsedAt | DateTime? | Updated on each refresh |
| userAgent / ipAddress | String? | Optional fingerprinting for auditing |

**Index:** `(userId, expiresAt)` — efficient cleanup of expired tokens.

---

### EmailVerificationToken / PasswordResetToken

Short-lived one-time tokens.

| Field | Type | Notes |
|-------|------|-------|
| userId | UUID (FK → User) | |
| tokenHash | String (unique) | Raw token is returned to client only |
| expiresAt | DateTime | 24h (verify) / 2h (reset) |
| consumedAt | DateTime? | Set when token is used |

A token is valid if: `consumedAt IS NULL AND expiresAt > NOW()`.

---

### ClientDevice

The ownership boundary for all user-facing data. Created automatically on first request via `x-device-id` upsert.

| Field | Type | Notes |
|-------|------|-------|
| id | UUID | Internal PK (used in FKs) |
| deviceId | String (unique) | Raw value from `x-device-id` header |
| createdAt / updatedAt | DateTime | |

**Relations:** `preferences?`, `parsedSubtitleFiles[]`, `translationJobs[]`

All private routes resolve the `x-device-id` header to a `ClientDevice` row. Controllers and services always work with the internal UUID ID, not the raw device ID string.

---

### UserPreference

1:1 with `ClientDevice`. Created on first `GET /v1/preferences` if missing.

| Field | Type | Default |
|-------|------|---------|
| clientDeviceId | UUID (unique FK → ClientDevice) | |
| hasSeenOnboarding | Boolean | false |
| preferredTargetLanguage | AppLanguage | es |
| themePreference | ThemePreference | system |

---

### ParsedSubtitleFile

Stores a user-uploaded subtitle file. Owns the raw content and normalized cues.

| Field | Type | Notes |
|-------|------|-------|
| clientDeviceId | UUID (FK → ClientDevice) | Ownership |
| fileName | String | Original file name |
| format | SubtitleFormat | srt or vtt |
| sourceLanguage | AppLanguage | Detected or defaulted to `en` |
| lineCount | Int | Number of cues |
| durationMs | Int | Duration of last cue's endMs |
| checksum | String | File content hash (for dedup or integrity checks) |
| rawContent | String (Text) | Full original file content |

**Index:** `(clientDeviceId, createdAt DESC)` — fast device-scoped listing.

**Relations:** `cues[]` (ParsedSubtitleCue), `translationJobs[]`

---

### ParsedSubtitleCue

Normalized cues for an uploaded file.

| Field | Type | Notes |
|-------|------|-------|
| parsedFileId | UUID (FK → ParsedSubtitleFile) | |
| cueIndex | Int | 1-based sequential index |
| startMs / endMs | Int | Millisecond timestamps |
| text | String (Text) | Raw cue text (may include line breaks) |

**Unique constraint + index:** `(parsedFileId, cueIndex)` — direct ordered access.

---

### TranslationJob

The central entity. Tracks the full lifecycle of a translation request.

| Field | Type | Notes |
|-------|------|-------|
| clientDeviceId | UUID (FK → ClientDevice) | Ownership |
| sourceType | TranslationSourceType | catalog or upload |
| status | TranslationJobStatus | queued → translating → completed / failed |
| stageLabel | String | Human-readable progress description |
| title | String | Movie/show title or file name |
| sourceName | String | Source subtitle file name or provider label |
| sourceLanguage | AppLanguage | Language of the source subtitles |
| targetLanguage | AppLanguage | Desired translation language |
| format | SubtitleFormat | srt or vtt |
| progress | Float | 0.0 – 1.0 execution progress |
| lineCount | Int | Number of subtitle cues |
| durationMs | Int | Total subtitle duration |
| errorMessage | String? (Text) | Set on failure |
| parsedFileId | UUID? (FK → ParsedSubtitleFile) | Set only for upload-source jobs |
| mediaRef | Json? | Catalog job: media context (see below) |
| subtitleSourceRef | Json? | Catalog job: subtitle source + quality/timing metadata |
| jobMeta | Json? | Retry tracking (see below) |
| startedAt | DateTime? | When runner claimed the job |
| completedAt | DateTime? | When job reached completed status |

**Indexes:**
- `(clientDeviceId, createdAt DESC)` — device job listing
- `(status, updatedAt DESC)` — recovery and dispatch queries

---

### TranslationJobCue

The translated output of a job. Written as a batch when the job completes.

| Field | Type | Notes |
|-------|------|-------|
| jobId | UUID (FK → TranslationJob) | |
| cueIndex | Int | Mirrors source cue index |
| startMs / endMs | Int | Timing from source |
| originalText | String (Text) | Original source cue text |
| translatedText | String? (Text) | Translated text; null if not yet written |

**Unique constraint + index:** `(jobId, cueIndex)`

---

## JSON Metadata Fields

Three `Json?` fields on `TranslationJob` carry structured but schema-less data. They are cast to typed interfaces in TypeScript.

### `mediaRef`

Populated for catalog-source jobs only.

```typescript
{
  mediaId: string;           // e.g., "tmdb:movie:27205"
  title: string;
  year: number;
  mediaType: 'movie' | 'series';
}
```

### `subtitleSourceRef`

Populated for catalog-source jobs. Grows during execution as quality and timing metadata are added.

At job creation:
```typescript
{
  subtitleSourceId: string;       // Original ssrc:* ID selected by user
  seasonNumber?: number;
  episodeNumber?: number;
  releaseHint?: string;
}
```

After execution:
```typescript
{
  subtitleSourceId: string;
  fallbackSubtitleSourceId: string;   // Source used for AI translation path
  selectedSubtitleSourceId: string;   // Actually used subtitle source ID
  seasonNumber?: number;
  episodeNumber?: number;
  releaseHint?: string;
  acquisition: {
    mode: 'existing_target_subtitle' | 'ai_translation';
    reusedExistingSubtitle: boolean;
    requestedTargetLanguage: AppLanguage;
    selectedLanguageCode: string;
    reason: string;
    reusedSubtitleConfidenceScore?: number;
    reusedSubtitleConfidenceLevel?: string;
  };
  quality: {
    confidenceScore: number;          // 0–100
    confidenceLevel: 'high' | 'medium' | 'low';
    warnings: string[];               // e.g., ['wrong_language', 'timing_mismatch']
  };
  timing?: {
    detectedOffsetMs: number;
    appliedCorrection: boolean;
    confidence: number;               // 0–100
  };
  translationReuse?: {
    reused: boolean;
    reusedFromJobId: string;
  };
}
```

### `jobMeta`

Retry and recovery tracking. Populated by the runner and recovery service.

```typescript
{
  attemptCount: number;                     // Incremented each time runner claims the job
  recoveredFromStall: boolean;              // Set by recovery service on requeue
  lastAttemptStartedAt?: string;            // ISO timestamp
  lastFailureReasonCode?: string;           // 'execution_error' | 'stall_recovery_exhausted'
  lastFailedAt?: string;                    // ISO timestamp
}
```

`jobMeta` starts as `{}` (effectively `{attemptCount: 0}`). The `parseJobRetryMeta()` utility handles nulls and missing fields safely.

---

## TranslationJob Status Transitions

```
                    ┌─────────────────────────────────────────────┐
                    │                  queued                     │
                    │  (created by service or requeued by recovery)│
                    └───────────────────┬─────────────────────────┘
                                        │
                     runner claims job  │ SELECT FOR UPDATE SKIP LOCKED
                                        │ UPDATE status = translating
                                        ▼
                    ┌─────────────────────────────────────────────┐
                    │                translating                  │
                    │   progress: 0.18 → 0.56 → 0.86 → 1.0       │
                    │   stageLabel updated at each milestone       │
                    └──────────────┬─────────────────┬────────────┘
                                   │                 │
                  job succeeds      │                 │   execution error OR
                                   │                 │   stall recovery exhausted
                                   ▼                 ▼
                    ┌──────────────────┐    ┌────────────────────┐
                    │   completed      │    │      failed        │
                    │ (cues available) │    │ (errorMessage set) │
                    └──────────────────┘    └────────────────────┘
```

**Re-entry path (stall recovery):**

```
translating (stalled, updatedAt old)
    │
    │ recovery service detects: updatedAt < (now - 5min)
    │ attemptCount < maxAttempts (default 3)
    │
    ▼
queued (status reset, jobMeta.recoveredFromStall = true)
    │
    │ dispatch picks up, runner claims
    ▼
translating (attempt 2 or 3)
    │
    ├── success → completed
    └── failure / stall × maxAttempts → failed (stall_recovery_exhausted)
```

---

## Where State Lives

| Data | Location | Survives Restart? |
|------|----------|-------------------|
| All job records | PostgreSQL (`TranslationJob`) | Yes |
| Job cues (output) | PostgreSQL (`TranslationJobCue`) | Yes |
| Parsed subtitle files and cues | PostgreSQL | Yes |
| Auth tokens (hashes) | PostgreSQL | Yes |
| Device preferences | PostgreSQL | Yes |
| Catalog search results | In-memory cache (`AppCacheService`) | No — rebuilt from TMDb on next request |
| Subtitle source lists | In-memory cache | No — rebuilt from providers |
| Preference cache | In-memory cache | No — rebuilt from DB on next request |
| Execution slot counter | In-memory (`TranslationJobExecutionLimiterService`) | No — reset to 0 on restart (jobs that were running are recovered by stall detection) |
| Rate limit buckets | In-memory (`RateLimitService`) | No — reset on restart |
| Scheduled job IDs | In-memory set (runner) | No — dispatcher refills on startup |
| Advisory lock | PostgreSQL session-level | No — released on connection close / process crash |

---

## Current Design Assumptions

**`jobMeta`, `mediaRef`, `subtitleSourceRef` are untyped JSON blobs.** The application enforces types in TypeScript via cast helpers and utility functions (`parseJobRetryMeta()`, `getCatalogReferences()`), but nothing prevents storing arbitrary data. Schema migrations are purely in application code, not in the Prisma schema.

**`progress` is a floating-point milestone, not a real percentage.** The runner writes specific values (0.18, 0.56, 0.86, 1.0) at fixed points in the execution path. These values are meaningful to the UI as "stage indicators" but do not represent actual work proportion.

**`lineCount` and `durationMs` on `TranslationJob` reflect the source subtitle dimensions.** For catalog jobs, these are updated after cues are downloaded and quality-evaluated. For upload jobs, they are set at creation from the parsed file metadata.

**`stageLabel` is a human-readable string, not a stable enum.** Do not use it as a state machine key in client code. Use `status` for programmatic decisions.

**`checksum` on `ParsedSubtitleFile` is stored but not checked for deduplication.** It could be used to avoid storing duplicate uploads from the same device, but currently there is no dedup logic.
