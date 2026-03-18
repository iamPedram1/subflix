# Visual Runtime Flows

> **Docs index:** [README.md](README.md) · **See also:** [VISUAL_ARCHITECTURE.md](VISUAL_ARCHITECTURE.md) · [VISUAL_STATE_MAP.md](VISUAL_STATE_MAP.md) · [KEY_DIAGRAMS.md](KEY_DIAGRAMS.md)
>
> **Covers:** 12 runtime flows with diagrams — auth, upload, catalog search, subtitle discovery, job creation, job execution (both paths), catalog decision tree, target-language reuse, translation reuse, stall recovery, dispatch.
> **Does not cover:** state machine internals (→ VISUAL_STATE_MAP), data model (→ VISUAL_DATA_MAP), module structure (→ VISUAL_ARCHITECTURE).

Each section shows a single runtime flow with a diagram and a brief explanation. Flows are ordered from simple to complex.

---

## 1. Auth — Sign-Up

```mermaid
sequenceDiagram
    participant C as Client
    participant S as AuthService
    participant DB as PostgreSQL

    C->>S: POST /v1/auth/signup { email, password }
    S->>DB: email already exists?
    DB-->>S: no
    S->>S: bcrypt.hash(password, 12 rounds)
    S->>DB: INSERT User + UserIdentity (provider=email)
    S->>DB: INSERT EmailVerificationToken (hash only)
    S-->>C: 201 { user, verificationToken }

    C->>S: POST /v1/auth/confirm-email { token }
    S->>DB: SELECT token WHERE not consumed + not expired
    S->>DB: UPDATE emailVerified=true, consumedAt=now
    S-->>C: 200 ok

    Note over C,S: User can now sign in
```

---

## 2. Auth — Sign-In and Token Refresh

```mermaid
sequenceDiagram
    participant C as Client
    participant S as AuthService
    participant DB as PostgreSQL

    C->>S: POST /v1/auth/signin { email, password }
    S->>DB: SELECT User by email (emailVerified=true required)
    S->>S: bcrypt.compare(password, hash)
    S->>DB: INSERT RefreshToken (hash, expiresAt=+30d)
    S-->>C: 200 { accessToken (15min JWT), refreshToken (30d UUID) }

    Note over C: accessToken expires
    C->>S: POST /v1/auth/refresh { refreshToken }
    S->>DB: SELECT RefreshToken by hash
    S->>S: validate: not expired, not revoked
    S-->>C: 200 { accessToken (new 15min JWT) }
```

---

## 3. Subtitle Upload Flow

```mermaid
flowchart TD
    A["POST /v1/subtitles/parse\n(multipart, max 2MB)"] --> B

    B["DeviceContextGuard\nvalidate x-device-id\nupsert ClientDevice"] --> C

    C["SubtitlesService\n.parseAndStore"] --> D

    D["SubtitleParserService\n.parse(content, format)"] --> E{valid cues?}
    E -- no --> ERR["400 ValidationDomainError\nno valid cues found"]
    E -- yes --> F["SubtitlesRepository\n.createParsedFile"]

    F --> G[("DB: INSERT ParsedSubtitleFile\n+ createMany ParsedSubtitleCue\n(transaction)")]

    G --> H["201 { id, fileName, format,\nlineCount, durationMs }"]

    H --> I["Client stores parsedFileId\n→ used when creating a translation job"]
```

---

## 4. Catalog Media Search

```mermaid
flowchart LR
    A["GET /v1/catalog/search?q=Breaking+Bad"] --> B["CatalogService\n.search"]

    B --> C{AppCache\nhit?}
    C -- yes --> Z["Return cached CatalogMediaItem[]"]
    C -- no --> D["TmdbMediaCatalogProvider\n(or MockCatalogProvider\nif no token)"]

    D --> E["GET api.themoviedb.org\n/search/multi?query=..."]
    E --> F["Map → CatalogMediaItem[]\nwith opaque tmdb:movie:* IDs"]
    F --> G["Cache:\nmovies 30d · series 1d"]
    G --> Z
```

---

## 5. Catalog Subtitle Discovery + Provider Fallback

```mermaid
flowchart TD
    A["GET /v1/catalog/media/:id/subtitle-sources\n?preferredLanguage=fr"] --> B["SubtitleSourceDiscoveryService\n.discover"]

    B --> C{Cache hit?\n6h TTL}
    C -- yes --> DONE["Return CatalogSubtitleSource[]"]
    C -- no --> D["Start provider chain"]

    D --> E{SubDL enabled\nand healthy?}
    E -- yes --> F["SubDLProvider\n.searchSources"]
    F -- success --> FA["recordSuccess\nadd candidates"]
    F -- error --> FB["recordFailure\n≥3 failures → 60s cooldown"]
    E -- no/cooldown --> G

    FA --> G
    FB --> G

    G{Podnapisi enabled\nand healthy?}
    G -- yes --> H["PodnapisiProvider\n.searchSources (scraper)"]
    H -- success --> HA["add candidates"]
    H -- error --> HB["recordFailure"]
    G -- no/cooldown --> I

    HA --> I
    HB --> I

    I{TVSubs enabled\nand healthy?}
    I -- yes --> J["TVSubsProvider\n.searchSources (scraper)"]
    J -- success --> JA["add candidates"]
    J -- error --> JB["recordFailure"]
    I -- no/cooldown --> K

    JA --> K
    JB --> K

    K["Deduplicate by title+episode\nRank by relevance score\nLimit to 20 results\nCache 6h"] --> DONE
```

---

## 6. Translation Job Creation

Two source types share the same creation path but differ in what gets persisted.

```mermaid
flowchart TD
    A["POST /v1/translation-jobs"] --> B["DeviceContextGuard"]

    B --> C["TranslationJobsService\n.createJob"]

    C --> D{sourceType?}

    D -- upload --> E["Find ParsedSubtitleFile\n(owned by device)"]
    E --> F["INSERT TranslationJob\nparsedFileId set\nstatus=queued"]

    D -- catalog --> G["Verify mediaId via CatalogService\nValidate subtitleSourceId format"]
    G --> H["INSERT TranslationJob\nmediaRef + subtitleSourceRef stored as JSON\nstatus=queued"]

    F --> I["runner.schedule(jobId)\n(non-blocking setTimeout 0)"]
    H --> I

    I --> J["201 TranslationJobSummary\nstatus=queued"]

    J --> K["Client polls:\nGET /v1/translation-jobs/:jobId"]
```

---

## 7. Async Translation Job Execution

Full execution flow after `runner.schedule(jobId)` fires.

```mermaid
flowchart TD
    A["setTimeout(0) fires\nrunner.run(jobId)"] --> B{already active?}
    B -- yes --> SKIP["return — deduplicated"]
    B -- no --> C

    C["ExecutionLimiter\n.tryAcquireSlot"] --> D{slot available?}
    D -- no --> WAIT["return — stays queued\ndispatch picks up on next cycle"]
    D -- yes --> E

    E["DB: SELECT FOR UPDATE SKIP LOCKED\nWHERE id=? AND status=queued"] --> F{row returned?}
    F -- no/locked --> REL["release slot · return\n(another instance claimed it)"]
    F -- yes --> G

    G["UPDATE status=translating\nincrement attemptCount in jobMeta"] --> H{sourceType?}

    H -- upload --> I["loadUploadedSourceCues\nfrom ParsedSubtitleFile"]
    I --> I2["translationProvider.translate\ncues → translatedLines"]
    I2 --> I3["replaceJobCues\nUPDATE status=completed"]

    H -- catalog --> J["runCatalogJob\n(see Catalog Job Decision Tree)"]
    J --> J2["replaceJobCues\nUPDATE status=completed"]

    I3 --> DONE["releaseSlot"]
    J2 --> DONE

    ERR["any exception\napplyAttemptFailed\nmarkFailure"] --> DONE
```

---

## 8. Catalog Job Decision Tree

Expanded view of `runCatalogJob()` — the most complex branch in the system.

```mermaid
flowchart TD
    A["runCatalogJob(job)"] --> B

    B["SubtitleAcquisitionStrategy\n.decideCatalogAcquisition\n(search subtitle sources in targetLanguage)"] --> C{acquisitionMode?}

    C -- existing_target_subtitle --> D["Load cues from\ntarget-language source"]
    D --> E["QualityEvaluation\nconfidenceScore · warnings"]
    E --> F{shouldBlockAutoUse?}
    F -- yes --> FAIL1["Persist quality metadata\nthrow → job fails"]
    F -- no --> G["TimingAlignment\nalignCatalogCues\ndetect constant offset"]
    G --> H["replaceJobCues (cues as-is)\nUPDATE status=completed"]

    C -- ai_translation --> I["loadCatalogSourceCues\n(DB-cached or download from provider)"]
    I --> J["QualityEvaluation"]
    J --> K{shouldBlockAutoUse?}
    K -- yes --> FAIL2["Persist + throw → job fails"]
    K -- no --> L["TimingAlignment"]
    L --> M["TranslationReuseService\n.decideCatalogTranslationReuse"]
    M --> N{prior translation\nreusable?}
    N -- yes --> O["Copy translated cues\nfrom prior job\nUPDATE status=completed"]
    N -- no --> P["translationProvider\n.translate(cues)"]
    P --> Q["replaceJobCues\nUPDATE status=completed"]

    style FAIL1 fill:#fce4ec
    style FAIL2 fill:#fce4ec
    style O fill:#e8f5e9
    style H fill:#e8f5e9
    style Q fill:#e8f5e9
```

---

## 9. Target-Language Subtitle Reuse Flow

Runs at the start of every catalog job inside `SubtitleAcquisitionStrategyService`.

```mermaid
sequenceDiagram
    participant Runner
    participant Acq as SubtitleAcquisitionStrategy
    participant Catalog as CatalogService
    participant QE as QualityEvalService

    Runner->>Acq: decideCatalogAcquisition({ mediaId, targetLang, fallbackSourceId })
    Acq->>Catalog: getSubtitleSources(mediaId, { preferredLanguage: targetLang })
    Catalog-->>Acq: sources in target language

    loop for each candidate
        Acq->>QE: evaluateCatalogJob(candidate)
        QE-->>Acq: { confidenceScore, shouldBlockAutoUse }
    end

    alt best candidate confidence ≥ threshold
        Acq-->>Runner: { acquisitionMode: 'existing_target_subtitle', sourceId }
        Note over Runner: Skips AI translation entirely
    else no suitable candidate
        Acq-->>Runner: { acquisitionMode: 'ai_translation', sourceId: fallbackSourceId }
        Note over Runner: Proceeds with source-language subtitle + AI translate
    end
```

---

## 10. Translation Reuse Flow

Runs on the `ai_translation` path before calling the translation provider.

```mermaid
sequenceDiagram
    participant Runner
    participant Reuse as TranslationReuseService
    participant Repo as TranslationJobsRepository
    participant Provider as TranslationProviderPort

    Runner->>Reuse: decideCatalogTranslationReuse({ deviceId, subtitleSourceId, targetLang, alignedCues })
    Reuse->>Repo: findReusableCatalogTranslation(deviceId, sourceId, targetLang)

    alt no prior job found
        Repo-->>Reuse: null
        Reuse-->>Runner: { reuseAllowed: false, reason: 'no_prior_translation' }
        Runner->>Provider: translate(cues)
        Provider-->>Runner: translatedLines[]
    else prior job found, cues incompatible
        Repo-->>Reuse: priorJob
        Reuse-->>Runner: { reuseAllowed: false, reason: 'cue_mismatch' }
        Runner->>Provider: translate(cues)
        Provider-->>Runner: translatedLines[]
    else prior job found, cues compatible
        Repo-->>Reuse: priorJob + translatedCues
        Reuse-->>Runner: { reuseAllowed: true, translatedCues }
        Note over Runner: No AI call needed — uses cached translation
    end
```

---

## 11. Stalled Job Recovery Flow

Runs on startup and every 60 seconds. Advisory lock ensures single-instance execution.

```mermaid
sequenceDiagram
    participant Scheduler
    participant Recovery as RecoveryService
    participant Repo as Repository
    participant DB as PostgreSQL
    participant Runner

    Scheduler->>Recovery: recoverStalledJobs()
    Recovery->>DB: pg_try_advisory_lock(7734812019)

    alt lock unavailable (another instance holds it)
        DB-->>Recovery: false
        Recovery-->>Scheduler: { requeued:0, failed:0, scanned:0 }
        Note over Recovery: log: translation.recovery.lock_skipped
    else lock acquired
        DB-->>Recovery: true
        Note over Recovery: log: translation.recovery.lock_acquired

        Recovery->>Repo: findStalledJobs(updatedAt < now - 5min)
        Repo-->>Recovery: stalledJobs[]

        loop per stalled job
            alt attemptCount < maxAttempts (3)
                Recovery->>Repo: requeueStalledJob → UPDATE status=queued
                Recovery->>Runner: schedule(jobId)
            else attempts exhausted
                Recovery->>Repo: failStalledJob → UPDATE status=failed
            end
        end

        Recovery->>DB: pg_advisory_unlock(7734812019)
        Note over Recovery: log: translation.recovery.lock_released
    end
```

---

## 12. Dispatch + Concurrency Flow

Runs on startup and every 10 seconds to fill available execution slots.

```mermaid
flowchart TD
    A["DispatchService.dispatch(trigger)"] --> B

    B["ExecutionLimiter.getMetrics()\nslotsAvailable = max - activeCount"] --> C{slotsAvailable\n> 0?}
    C -- no --> LOG["log: dispatch.no_capacity\nreturn"]
    C -- yes --> D

    D["Repository.findQueuedJobsForDispatch\n(slotsAvailable × 5, max 50 candidates)"] --> E

    E["pickDispatchCandidates(candidates, slotsAvailable)\n(priority sort — see state map)"] --> F

    F["For each selected job:\nrunner.schedule(jobId)"] --> G["log: translation.dispatch.prioritized\n{ jobId, priority, trigger }"]
```

**Priority scoring table:**

| Job Type | Score | Notes |
|----------|-------|-------|
| CATALOG (fresh) | 10 | May short-circuit via subtitle reuse |
| UPLOAD (fresh) | 20 | Always needs AI translation |
| RECOVERED (fresh) | 30 | Deprioritized — already failed once |
| RECOVERED (> 5min old) | 10 | Promoted to prevent starvation |

Lower score = higher priority. Within same score: FIFO by `createdAt`.
