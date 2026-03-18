# External Integrations

This document covers every external dependency the backend talks to: why it exists, how it's abstracted, how failures are handled, and what happens when it's unavailable.

---

## TMDb (The Movie Database)

**Why it exists:** Provides structured media metadata — movie and TV series titles, years, genres, poster images, episode information. Without this, users would have no way to search for movies or TV shows to find subtitle sources.

**Where it's used:**
- `GET /v1/catalog/search` — media title search
- `GET /v1/catalog/media/:id/subtitle-sources` — resolving media details before subtitle discovery

**How it's abstracted:**

`MediaCatalogPort` interface (`src/features/catalog/ports/media-catalog.port.ts`):

```typescript
interface MediaCatalogPort {
  search(query: string): Promise<CatalogMediaItem[]>;
  findById(mediaId: string): Promise<CatalogMediaDetails | null>;
}
```

Two implementations:
- `TmdbMediaCatalogProvider` — real API (used when `TMDB_API_READ_TOKEN` is set)
- `MockCatalogProvider` — static in-memory data (used in development and test when no token is configured)

The injection is conditional: if the environment variable is absent, the module wires `MockCatalogProvider` as the `MediaCatalogPort` implementation. No code outside the catalog module needs to know which is in use.

**Caching:**

All TMDb results are cached in `AppCacheService`:
- Movie search results: 30-day TTL
- TV series search results: 1-day TTL (series update more frequently)
- Each unique search query gets its own cache entry

**Failure handling:**

- If TMDb returns a non-200 response or times out, the HTTP error propagates up through the provider and surfaces as a `ServiceUnavailableDomainError` or is caught by the global exception filter as a 500.
- There is no retry logic or circuit breaker for TMDb. The cache acts as the primary protection against TMDb downtime — if a result is cached, it will be served even if TMDb is down.

**Configuration:**

```
TMDB_API_READ_TOKEN          (required for real data; absent = mock)
TMDB_API_BASE_URL            https://api.themoviedb.org/3
TMDB_MOVIE_SEARCH_CACHE_TTL_MS   2592000000  (30 days)
TMDB_SERIES_SEARCH_CACHE_TTL_MS  86400000    (1 day)
TMDB_INCLUDE_ADULT           false
TMDB_DEFAULT_LANGUAGE        en-US
```

---

## SubDL

**Why it exists:** API-based subtitle repository. Provides structured subtitle search (title, year, language, episode) and direct download links. Treated as the primary subtitle source provider.

**Where it's used:** `SubtitleSourceDiscoveryService.discover()` — first in the provider chain when healthy and enabled.

**How it's abstracted:**

`SubtitleSourceProvider` interface (`src/features/catalog/ports/subtitle-source-provider.port.ts`):

```typescript
interface SubtitleSourceProvider {
  readonly name: string;
  searchSources(input: SubtitleSourceSearchInput): Promise<SubtitleSourceCandidate[]>;
}
```

`SubDLProvider` in `src/features/catalog/providers/subdl.provider.ts` implements this interface. The API key is injected from config.

**Availability:** Provider is disabled (skipped entirely) if `SUBDL_API_KEY` is absent. `SUBDL_ENABLED=true` (default when key is present).

**Caching:** Results from all subtitle providers are cached together at the `SubtitleSourceDiscoveryService` level (6h TTL per media+language+episode combination). SubDL itself does not cache individually.

**Failure handling:**

SubDL participates in the `SubtitleProviderHealthService` circuit breaker:
- After 3 consecutive failures, SubDL enters a 60s cooldown
- During cooldown, it is skipped and Podnapisi/TVSubs are tried instead
- On first success after a failure, failure counter resets to 0

On error, the discovery service logs `subtitle.provider.error` and continues to the next provider. Results are non-fatal — a missing SubDL response means fewer subtitle options, not an API error.

**Configuration:**

```
SUBDL_API_KEY                (required to enable; absent = disabled)
SUBDL_API_BASE_URL           https://api.subdl.com/api/v1
SUBDL_TIMEOUT_MS             7000
SUBDL_ENABLED                true
```

---

## Podnapisi

**Why it exists:** Secondary subtitle source. Web scraper targeting `podnapisi.net` — does not require an API key. Used as a fallback when SubDL is unavailable or returns insufficient results.

**Where it's used:** `SubtitleSourceDiscoveryService.discover()` — second in the provider chain.

**How it's abstracted:** Same `SubtitleSourceProvider` interface as SubDL. `PodnapisiProvider` in `src/features/catalog/providers/podnapisi.provider.ts`.

**Important note:** This is a **web scraper**, not an API client. It parses HTML from `podnapisi.net`. This makes it fragile — if the site changes its HTML structure, the scraper will break silently (returning 0 results rather than an error). The circuit breaker handles errors but cannot detect silent scraping breakage.

**Configuration:**

```
PODNAPISI_BASE_URL           https://www.podnapisi.net
PODNAPISI_TIMEOUT_MS         10000
PODNAPISI_ENABLED            true
```

---

## TVSubs (tvsubtitles.net)

**Why it exists:** Tertiary subtitle source specifically for TV episodes. Another web scraper.

**Where it's used:** `SubtitleSourceDiscoveryService.discover()` — third in the provider chain.

**How it's abstracted:** Same `SubtitleSourceProvider` interface. `TVSubsProvider` in `src/features/catalog/providers/tvsubs.provider.ts`.

**Same scraper fragility note as Podnapisi applies here.** TVSubs tends to focus on TV shows rather than movies, so it may return nothing for movie searches.

**Configuration:**

```
TVSUBS_BASE_URL              https://www.tvsubtitles.net
TVSUBS_TIMEOUT_MS            10000
TVSUBS_ENABLED               true
```

---

## Subtitle Provider Health Service (Circuit Breaker)

All three subtitle providers (SubDL, Podnapisi, TVSubs) share a single health tracking system.

**Key file:** [src/features/catalog/subtitle-provider-health.service.ts](../src/features/catalog/subtitle-provider-health.service.ts)

**Circuit breaker state per provider (in-memory):**

| State | Condition |
|-------|-----------|
| Healthy | failureCount < threshold |
| In cooldown | failureCount >= threshold AND lastFailureAt > (now - cooldownMs) |
| Auto-recovered | cooldownMs has elapsed since last failure |

**Behavior:**
- `isAllowed(providerName)` — returns `false` when in cooldown (provider is skipped)
- `recordSuccess(providerName)` — resets failure count to 0
- `recordFailure(providerName)` — increments failure count, records timestamp

**Configuration:**

```
SUBTITLE_PROVIDER_FAILURE_THRESHOLD   3      (failures before cooldown)
SUBTITLE_PROVIDER_COOLDOWN_MS         60000  (1 minute cooldown)
```

**Important limitation:** Health state is in-memory and per-process. In a multi-instance deployment, each instance has its own health tracking. A provider that is failing for all instances will independently enter cooldown on each — which is fine. But a provider that is flapping (failing for one instance, healthy for another) will have inconsistent routing across instances. This is acceptable for the current use case.

---

## Translation Provider

**Why it exists:** The core value of the application — translate subtitle cues from one language to another.

**Where it's used:** `TranslationJobRunnerService.run()` — called after source cues are loaded and quality-evaluated, when AI translation is needed.

**How it's abstracted:**

`TranslationProviderPort` interface (`src/features/translation-jobs/ports/translation-provider.port.ts`):

```typescript
interface TranslationProviderPort {
  translate(params: {
    title: string;
    targetLanguage: AppLanguage;
    cues: SubtitleCue[];
  }): Promise<string[]>;  // Returns one translated string per input cue
}
```

**Current implementation:** `MockTranslationProvider` (`src/features/translation-jobs/providers/mock-translation.provider.ts`)

- Simulates a 450ms processing delay
- Returns deterministic output: each cue prefixed with a language-specific tag (e.g., `"Version française: "` for `fr`)
- If target language is `en`, returns cues unchanged
- Throws an error if `title` includes the substring `"error"` (useful for testing failure paths)

**Replacing the mock:** Any real translation service (Claude API, DeepL, Google Translate, OpenAI) can be wired by implementing `TranslationProviderPort` and changing the module injection in `translation-jobs.module.ts`. No changes to the runner or orchestration code are needed.

**No retry logic at the provider level.** Failures propagate up to the runner, which applies the job-level retry policy (up to `maxAttempts`, tracked in `jobMeta`).

---

## Firebase Admin SDK

**Why it exists:** Supports Firebase OAuth sign-in (Google, Facebook, Apple via Firebase). The client-side Firebase SDK handles the OAuth flow and returns an ID token; the backend verifies the token server-side.

**Where it's used:** `POST /v1/auth/oauth/firebase` — Firebase ID token verification.

**Key file:** [src/features/auth/firebase-auth.service.ts](../src/features/auth/firebase-auth.service.ts)

**How it's abstracted:** `FirebaseAuthService` is a thin wrapper around `firebase-admin`. It exposes one method:

```typescript
verifyIdToken(idToken: string): Promise<{ uid, email, provider }>
```

`AuthService.signInWithFirebase()` calls this, then maps the verified identity to a `User` + `UserIdentity` record.

**Availability:** Firebase integration is optional. If `FIREBASE_PROJECT_ID` / `FIREBASE_CLIENT_EMAIL` / `FIREBASE_PRIVATE_KEY` are absent, the Firebase app is not initialized and the `/oauth/firebase` route will fail at runtime (the SDK will throw). The rest of the auth module (email/password) continues to work.

**Configuration:**

```
FIREBASE_PROJECT_ID           (required for Firebase OAuth)
FIREBASE_CLIENT_EMAIL         (required)
FIREBASE_PRIVATE_KEY          (required; PEM key with \\n replaced by \n)
FIREBASE_SERVICE_ACCOUNT_JSON (alternative: full service account JSON)
```

---

## PostgreSQL

**Why it exists:** Primary durable data store. All jobs, users, devices, preferences, and subtitle data live here.

**Key file:** [src/common/database/prisma/prisma.service.ts](../src/common/database/prisma/prisma.service.ts)

**How it's abstracted:** `PrismaService` extends the Prisma client. All feature repositories inject `PrismaService` and call Prisma methods directly. No ORM adapter layer beyond Prisma itself.

**Advanced usage:**
- `$transaction()` with `$queryRaw` — used in `claimQueuedJobForRunner()` for `SELECT ... FOR UPDATE SKIP LOCKED`
- `$queryRawUnsafe()` — used for advisory lock calls (`pg_try_advisory_lock`, `pg_advisory_unlock`)

**Failure handling:** Prisma errors are caught in repository methods via `normalizeDatabaseError()` and translated into `DomainError` subclasses. For example, a unique constraint violation becomes a `ConflictDomainError`.

**Configuration:**

```
DATABASE_URL    postgresql://user:pass@host:5432/dbname
```

---

## Integration Summary

| Integration | Type | Required | Fallback |
|-------------|------|----------|----------|
| TMDb | REST API | No | `MockCatalogProvider` |
| SubDL | REST API | No | Skipped (next provider tried) |
| Podnapisi | Web scraper | No | Skipped (next provider tried) |
| TVSubs | Web scraper | No | Skipped (next provider tried) |
| Translation provider | Interface | Yes (mocked) | `MockTranslationProvider` |
| Firebase Admin | SDK | No | Auth route fails; others work |
| PostgreSQL | Driver | Yes | No fallback — app fails to start |
