# Diagrams

A focused reference of system diagrams. Each diagram has a short explanation of what it shows and why it matters.

---

## 1. Module Dependency Graph

Shows which NestJS feature modules depend on which others, and which common modules they all rely on.

```mermaid
graph TD
    subgraph Common
        C1[AppConfigModule]
        C2[PrismaModule]
        C3[AppCacheModule]
        C4[DevicesModule]
    end

    subgraph Features
        F1[AuthModule]
        F2[HealthModule]
        F3[PreferencesModule]
        F4[SubtitlesModule]
        F5[CatalogModule]
        F6[TranslationJobsModule]
    end

    F1 --> C1
    F1 --> C2
    F2 --> C1
    F3 --> C1
    F3 --> C2
    F3 --> C3
    F3 --> C4
    F4 --> C1
    F4 --> C2
    F4 --> C4
    F5 --> C1
    F5 --> C3
    F6 --> C1
    F6 --> C2
    F6 --> C4
    F6 --> F4
    F6 --> F5
```

**Key insight:** `TranslationJobsModule` is the only module that imports other feature modules. It depends on both `CatalogModule` (for subtitle discovery and cue fetching) and `SubtitlesModule` (for loading uploaded cues). Everything else is self-contained.

---

## 2. HTTP Request Lifecycle

Shows the middleware/guard/interceptor pipeline every incoming request passes through before reaching controller logic.

```mermaid
flowchart TD
    A[Incoming HTTP Request] --> B[RequestIdInterceptor\nadd x-request-id header]
    B --> C{Route requires device?}
    C -- Yes --> D[DeviceContextGuard\nvalidate x-device-id header]
    D --> E[DevicesService.resolveDevice\nupsert ClientDevice in DB]
    E --> F[attach request.device]
    C -- No --> G{Route requires auth?}
    F --> G
    G -- Yes --> H[AccessTokenGuard\nverify JWT Bearer token]
    H --> I[ValidationPipe\nvalidate + transform DTO]
    G -- No --> I
    I --> J[RateLimitGuard\ncheck per-IP fixed-window bucket]
    J --> K[Controller method]
    K --> L[Service → Repository → DB]
    L --> M[Response]

    N[Any exception] -->|caught| O[GlobalExceptionFilter\nnormalize to error envelope]
    O --> M
```

---

## 3. Translation Job Lifecycle

Shows the full state machine for a `TranslationJob` record, including the recovery re-entry path.

```mermaid
stateDiagram-v2
    [*] --> queued : POST /v1/translation-jobs\n(or recovery requeue)

    queued --> translating : runner.run(jobId)\nSELECT FOR UPDATE SKIP LOCKED\nUPDATE status=translating

    translating --> completed : execution success\nreplaceJobCues + UPDATE status=completed

    translating --> failed : execution error\nor stall_recovery_exhausted\nUPDATE status=failed

    translating --> queued : stall recovery\n(updatedAt stale, attemptCount < max)\nUPDATE status=queued\njobMeta.recoveredFromStall=true

    note right of translating
        progress: 0.18 → 0.56 → 0.86 → 1.0
        stageLabel updated at each milestone
        updatedAt = heartbeat for staleness detection
    end note

    note right of queued
        Dispatch service picks this up
        on next cycle or startup
    end note
```

---

## 4. Subtitle Discovery and Provider Fallback

Shows the provider chain logic in `SubtitleSourceDiscoveryService.discover()`.

```mermaid
flowchart TD
    A[GET /v1/catalog/media/:id/subtitle-sources] --> B[CatalogService\n.getSubtitleSources]
    B --> C{Cache hit?}
    C -- Yes --> Z[Return cached sources]
    C -- No --> D[Start provider chain]

    D --> E{SubDL enabled\nand healthy?}
    E -- No --> H
    E -- Yes --> F[SubDLProvider\n.searchSources]
    F -- Success --> G[recordSuccess\nadd candidates]
    F -- Error --> GG[recordFailure\nif count >= 3: enter cooldown]
    G --> H
    GG --> H

    H{Podnapisi enabled\nand healthy?}
    H -- No --> K
    H -- Yes --> I[PodnapisiProvider\n.searchSources]
    I -- Success --> J[recordSuccess\nadd candidates]
    I -- Error --> JJ[recordFailure]
    J --> K
    JJ --> K

    K{TVSubs enabled\nand healthy?}
    K -- No --> N
    K -- Yes --> L[TVSubsProvider\n.searchSources]
    L -- Success --> M[recordSuccess\nadd candidates]
    L -- Error --> MM[recordFailure]
    M --> N
    MM --> N

    N[Deduplicate candidates\nby title+episode signature]
    N --> O[Rank by relevance score\nlanguage, episode, release hint]
    O --> P[Limit to 20 results]
    P --> Q[Cache for 6h]
    Q --> Z
```

---

## 5. Dispatch / Runner / Recovery Interactions

Shows how the three background components (scheduler, dispatch, recovery, runner) interact with the DB and each other.

```mermaid
flowchart LR
    subgraph Lifecycle
        Boot[OnApplicationBootstrap]
        RecTimer[setInterval 60s\nrecovery]
        DispTimer[setInterval 10s\ndispatch]
    end

    subgraph Background Services
        Recovery[TranslationJobRecoveryService]
        Dispatch[TranslationJobDispatchService]
        Runner[TranslationJobRunnerService]
        Limiter[ExecutionLimiterService\nper-process slot counter]
    end

    subgraph Database
        DB[(PostgreSQL)]
    end

    Boot -->|1. recoverStalledJobs| Recovery
    Boot -->|2. dispatch startup| Dispatch
    RecTimer --> Recovery
    DispTimer --> Dispatch

    Recovery -->|pg_try_advisory_lock| DB
    Recovery -->|find stalled jobs\nstatus=translating, updatedAt old| DB
    Recovery -->|UPDATE status=queued\nor UPDATE status=failed| DB
    Recovery -->|schedule recovered jobs| Runner

    Dispatch -->|getMetrics| Limiter
    Dispatch -->|findQueuedJobsForDispatch\noverscan ×5| DB
    Dispatch -->|schedule selected jobs| Runner

    Runner -->|tryAcquireSlot| Limiter
    Runner -->|SELECT FOR UPDATE SKIP LOCKED| DB
    Runner -->|UPDATE status=translating| DB
    Runner -->|... executes job ...| DB
    Runner -->|UPDATE status=completed/failed| DB
    Runner -->|releaseSlot| Limiter
```

---

## 6. Catalog Job Execution Decision Tree

Shows the branching logic inside `runCatalogJob()` that determines how a catalog job completes.

```mermaid
flowchart TD
    A[runCatalogJob] --> B[SubtitleAcquisitionStrategy\n.decideCatalogAcquisition]

    B --> C{acquisitionMode?}

    C -- existing_target_subtitle --> D[Load target-language\nsubtitle cues from catalog]
    D --> E[QualityEvaluation\nconfidenceScore, warnings]
    E --> F{shouldBlockAutoUse?}
    F -- Yes --> G[Persist quality metadata\nthrow error → job fails]
    F -- No --> H[TimingAlignment\nalign cues]
    H --> I[Persist cues\nreplaceJobCues]
    I --> J[UPDATE status=completed]

    C -- ai_translation --> K[Load source-language\nsubtitle cues]
    K --> L[QualityEvaluation]
    L --> M{shouldBlockAutoUse?}
    M -- Yes --> N[Persist + throw → job fails]
    M -- No --> O[TimingAlignment]
    O --> P[TranslationReuseService\n.decideCatalogTranslationReuse]
    P --> Q{reuseAllowed?}
    Q -- Yes --> R[Copy translated cues\nfrom prior job]
    R --> J2[UPDATE status=completed]
    Q -- No --> S[translationProvider\n.translate cues]
    S --> T[Persist translated cues]
    T --> J2
```

---

## 7. Data Flow: Upload Path vs Catalog Path

Compares how data moves for the two job source types.

```mermaid
flowchart LR
    subgraph Upload Path
        UA[Client uploads .srt/.vtt] -->|POST /v1/subtitles/parse| UB[SubtitleParserService\nparse cues]
        UB -->|persist| UC[(ParsedSubtitleFile\n+ ParsedSubtitleCue)]
        UC -->|POST /v1/translation-jobs\nparsedFileId| UD[TranslationJob created\nsourceType=upload]
        UD -->|runner loads cues| UC
        UC -->|SubtitleCue list| UE[TranslationProviderPort\n.translate]
        UE -->|translatedLines| UF[(TranslationJobCue\noriginalText + translatedText)]
    end

    subgraph Catalog Path
        CA[Client searches media] -->|GET /v1/catalog/search| CB[TmdbMediaCatalogProvider]
        CB -->|GET /v1/catalog/media/:id/subtitle-sources| CC[SubtitleSourceDiscoveryService\nSubDL / Podnapisi / TVSubs]
        CC -->|ssrc:* ID selected| CD[TranslationJob created\nsourceType=catalog]
        CD -->|runner downloads cues| CE[CatalogService\n.getSubtitleCues]
        CE -->|SubtitleCue list| CF{AcquisitionStrategy}
        CF --existing subtitle--> CG[Use as-is\n→ TranslationJobCue]
        CF --ai translation--> CH[TranslationProviderPort\n.translate]
        CH --> CG
    end
```

---

## 8. Auth Flow Overview

Shows the sign-up / sign-in token issuance and refresh cycle.

```mermaid
sequenceDiagram
    participant Client
    participant Auth as AuthController/Service
    participant DB as PostgreSQL

    Client->>Auth: POST /v1/auth/signup { email, password }
    Auth->>DB: INSERT User + UserIdentity
    Auth->>DB: INSERT EmailVerificationToken (hash)
    Auth-->>Client: 201 { user, verificationRequired, verificationToken? }

    Client->>Auth: POST /v1/auth/confirm-email { token }
    Auth->>DB: SELECT + validate token (not expired, not consumed)
    Auth->>DB: UPDATE emailVerified=true + consumedAt
    Auth-->>Client: 200 { verified: true }

    Client->>Auth: POST /v1/auth/signin { email, password }
    Auth->>DB: SELECT User by email
    Auth->>Auth: bcrypt.compare(password, hash)
    Auth->>DB: INSERT RefreshToken (hash + expiresAt)
    Auth-->>Client: 201 { user, accessToken, refreshToken, expiresIn, tokenType }

    Client->>Auth: POST /v1/auth/refresh { refreshToken }
    Auth->>DB: SELECT RefreshToken by hash
    Auth->>Auth: validate not expired, not revoked
    Auth-->>Client: 201 { user, accessToken, refreshToken, expiresIn, tokenType }
```

---

## 9. Multi-Instance Coordination

Shows how two API instances coordinate without duplicate work.

```mermaid
sequenceDiagram
    participant I1 as Instance 1
    participant I2 as Instance 2
    participant DB as PostgreSQL

    Note over I1,I2: Both instances call recoverStalledJobs() at the same time

    I1->>DB: pg_try_advisory_lock(7734812019)
    I2->>DB: pg_try_advisory_lock(7734812019)
    DB-->>I1: true (lock acquired)
    DB-->>I2: false (lock unavailable)

    I2->>I2: log recovery.lock_skipped\nreturn zeros

    I1->>DB: SELECT stalled jobs
    I1->>DB: UPDATE stalled jobs
    I1->>DB: pg_advisory_unlock(7734812019)

    Note over I1,I2: Both instances try to claim the same queued job

    I1->>DB: SELECT FOR UPDATE SKIP LOCKED WHERE id=$1 AND status=queued
    I2->>DB: SELECT FOR UPDATE SKIP LOCKED WHERE id=$1 AND status=queued

    DB-->>I1: row locked + returned
    DB-->>I2: empty set (row locked by I1)

    I1->>DB: UPDATE status=translating
    I2->>I2: claimQueuedJobForRunner returns null\n → release slot, return
```
