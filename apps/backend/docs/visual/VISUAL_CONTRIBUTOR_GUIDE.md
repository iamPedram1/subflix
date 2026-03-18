# Visual Contributor Guide

> **Docs index:** [README.md](../README.md) · **See also:** [CODEBASE_REVIEW_NOTES.md](../reference/CODEBASE_REVIEW_NOTES.md) · [FEATURE_MAP.md](../architecture/FEATURE_MAP.md) · [KEY_DIAGRAMS.md](../KEY_DIAGRAMS.md)
>
> **Covers:** "where do I go" flowchart, module ownership, request tracing, job tracing, risky areas (red/amber/green), safe-change checklist, test coverage map, add-a-provider guides.
> **Does not cover:** candid written review (→ CODEBASE_REVIEW_NOTES), full feature responsibilities (→ FEATURE_MAP).

Quick-reference maps for contributors: where to go, what to watch out for, and how to trace a problem.

---

## 1. "Where Do I Go When Working On X?"

```mermaid
flowchart TD
    START{What do you\nneed to change?}

    START --> A["Auth / OAuth / tokens"]
    START --> B["Preferences / settings"]
    START --> C["Upload / parse subtitles"]
    START --> D["Media search / TMDb"]
    START --> E["Subtitle source providers"]
    START --> F["Subtitle quality scoring"]
    START --> G["Translation job lifecycle\n(create, retry, list, export)"]
    START --> H["Job execution logic\n(how a job runs)"]
    START --> I["Dispatch / slot management"]
    START --> J["Stall recovery"]
    START --> K["Multi-instance coordination"]
    START --> L["Rate limits"]
    START --> M["Error responses / envelope"]
    START --> N["Config / env vars"]

    A --> FA["features/auth/\nauth.service.ts\nauth.repository.ts\nfirebase-auth.service.ts"]
    B --> FB["features/preferences/\npreferences.service.ts\npreferences.repository.ts"]
    C --> FC["features/subtitles/\nsubtitle-parser.service.ts\nsubtitles.repository.ts"]
    D --> FD["features/catalog/\nproviders/tmdb-media-catalog.provider.ts\nports/media-catalog.port.ts"]
    E --> FE["features/catalog/providers/\nsubdl.provider.ts\npodnapisi.provider.ts\ntvsubs.provider.ts"]
    F --> FF["features/catalog/\nsubtitle-quality-evaluation.service.ts\nsubtitle-timing-alignment.service.ts"]
    G --> FG["features/translation-jobs/\ntranslation-jobs.service.ts\ntranslation-jobs.controller.ts\ntranslation-jobs.repository.ts"]
    H --> FH["features/translation-jobs/\ntranslation-job-runner.service.ts\nsubtitle-acquisition-strategy.service.ts\ntranslation-reuse.service.ts"]
    I --> FI["features/translation-jobs/\ntranslation-job-dispatch.service.ts\ntranslation-job-execution-limiter.service.ts\nutils/translation-job-priority.util.ts"]
    J --> FJ["features/translation-jobs/\ntranslation-job-recovery.service.ts\nutils/job-staleness.util.ts"]
    K --> FK["features/translation-jobs/\ntranslation-jobs.repository.ts\n(claimQueuedJobForRunner\ntryAcquireRecoveryAdvisoryLock)"]
    L --> FL["common/rate-limit/\nrate-limit.service.ts"]
    M --> FM["common/http/filters/\nglobal-exception.filter.ts\ncommon/domain/errors/"]
    N --> FN["common/config/\n*.config.ts (8 namespaces)"]
```

---

## 2. Module Ownership Map

```mermaid
graph LR
    subgraph "No cross-module deps"
        HEALTH["health/"]
        AUTH["auth/"]
        PREF["preferences/"]
    end

    subgraph "Device-aware"
        DEV["devices/\n(DeviceContextGuard)"]
        SUBS["subtitles/"]
        PREF
    end

    subgraph "Cross-module hub"
        TJ["translation-jobs/\n← imports catalog + subtitles"]
    end

    subgraph "External-integration heavy"
        CAT["catalog/\nTMDb · SubDL · Podnapisi · TVSubs"]
    end

    TJ -->|imports| CAT
    TJ -->|imports| SUBS
    DEV -->|guard used by| SUBS & PREF & TJ

    style TJ fill:#fce4ec,stroke:#e91e63
    style CAT fill:#e3f2fd,stroke:#1976d2
    style DEV fill:#fff3cd,stroke:#ffc107
```

---

## 3. Request Tracing Map

> Follow a request from client to DB and back.

```mermaid
flowchart LR
    C["Client\nHTTP Request"] --> GU

    subgraph "Guards (src/common/http/)"
        GU["DeviceContextGuard\nor AccessTokenGuard"]
    end

    GU --> CT

    subgraph "Controller (features/*/)"
        CT["Controller\n@Get @Post @Patch @Delete\n@CurrentDevice()"]
    end

    CT --> SV

    subgraph "Service (features/*/)"
        SV["Service\nbusiness logic\norchestration"]
    end

    SV --> REPO & PORT

    subgraph "Repository (features/*/)"
        REPO["Repository\nPrisma only\nnormalizeDatabaseError()"]
    end

    subgraph "Port → Provider"
        PORT["Port interface\n(MediaCatalogPort etc.)"]
        PORT --> PROV["Provider impl\n(TMDb, SubDL, Mock...)"]
    end

    REPO --> DB[("PostgreSQL\nvia PrismaService")]
    PROV --> EXT["External API"]

    ERR["Exception"] --> FLT["GlobalExceptionFilter\nerror envelope"] --> C
```

---

## 4. Job Tracing Map

> Follow a translation job from creation to completion.

```mermaid
flowchart TD
    A["POST /v1/translation-jobs\n→ INSERT status=queued"] --> B

    B["runner.schedule(jobId)\n→ setTimeout(0)"] --> C

    C["runner.run(jobId)\n→ tryAcquireSlot\n→ SELECT FOR UPDATE SKIP LOCKED\n→ UPDATE status=translating"] --> D

    D{job path}

    D -- upload --> U["SubtitlesRepository\n.listOwnedParsedFileCues\n→ translationProvider.translate\n→ replaceJobCues\n→ status=completed"]

    D -- catalog --> CA["SubtitleAcquisitionStrategy\n→ QualityEval + TimingAlign\n→ ReuseCheck → translate?"]

    CA --> E{acquisition\nmode}
    E -- existing subtitle --> F["Load target-lang cues\n→ no translation needed\n→ replaceJobCues\n→ status=completed"]
    E -- ai translation --> G["Load source cues\n→ check translation reuse\n→ translate if needed\n→ replaceJobCues\n→ status=completed"]

    G2["ERROR at any point\n→ markFailure\n→ status=failed\n→ recovery picks up\n→ retry or permanent fail"]

    U & F & G --> DONE["GET /v1/translation-jobs/:id\nGET /v1/translation-jobs/:id/preview\nGET /v1/translation-jobs/:id/export"]
```

---

## 5. Risky Areas Map

> Areas where mistakes are hard to reverse or have broad impact.

```mermaid
graph TD
    subgraph "HIGH RISK — change carefully"
        R1["claimQueuedJobForRunner()\n\nMUST remain atomic SKIP LOCKED\nSplitting into 2 queries re-introduces\nduplicate execution bug"]

        R2["recoverStalledJobs()\ntry/finally block\n\nAdvisory lock MUST be released in finally\nLosing the finally = lock held until\nconnection timeout"]

        R3["jobMeta mutations\n\nALWAYS use job-staleness.util.ts\nNever spread-update jobMeta directly\nMissing field handling is non-trivial"]

        R4["replaceJobCues()\n\nTransactional delete+createMany\nNot idempotent — calling twice\nclears the first write"]
    end

    subgraph "MEDIUM RISK — test before merging"
        M1["dispatch() priority scoring\nChanging tier values affects\njob ordering globally"]

        M2["SubtitleProviderHealthService\nThreshold and cooldown are\nshared in-memory across features\nChanging them affects all 3 providers"]

        M3["AppCacheService.getOrSet()\nRequest coalescing relies on\npromise reference equality\nDon't cache mutable objects"]
    end

    subgraph "LOW RISK — isolated"
        L1["SubtitleParserService\nPure function, no side effects\nWell tested"]
        L2["SubtitleTimingAlignmentService\nPure function"]
        L3["SubtitleExportService\nPure function"]
        L4["translation-job-priority.util.ts\nPure functions, deterministic"]
    end

    style R1 fill:#fce4ec,stroke:#c62828
    style R2 fill:#fce4ec,stroke:#c62828
    style R3 fill:#fce4ec,stroke:#c62828
    style R4 fill:#fce4ec,stroke:#c62828
    style M1 fill:#fff8e1,stroke:#f9a825
    style M2 fill:#fff8e1,stroke:#f9a825
    style M3 fill:#fff8e1,stroke:#f9a825
    style L1 fill:#e8f5e9,stroke:#388e3c
    style L2 fill:#e8f5e9,stroke:#388e3c
    style L3 fill:#e8f5e9,stroke:#388e3c
    style L4 fill:#e8f5e9,stroke:#388e3c
```

---

## 6. Safe-Change Checklist

When adding new behavior, use this to assess impact:

```mermaid
flowchart TD
    CHANGE["Proposed change"] --> Q1

    Q1{Touches\nDB queries?}
    Q1 -- yes --> Q1A["Write an integration test\nagainst real PostgreSQL"]
    Q1 -- no --> Q2

    Q2{Touches job\nstatus transitions?}
    Q2 -- yes --> Q2A["Update VISUAL_STATE_MAP.md\nCheck recovery still handles new state"]
    Q2 -- no --> Q3

    Q3{Touches\njobMeta / subtitleSourceRef?}
    Q3 -- yes --> Q3A["Use job-staleness.util.ts\nUpdate VISUAL_DATA_MAP.md\nConsider existing rows in prod"]
    Q3 -- no --> Q4

    Q4{Adds a new\nprovider / port?}
    Q4 -- yes --> Q4A["Implement the port interface\nWire via module injection token\nAdd mock for tests\nAdd to health tracking if external HTTP"]
    Q4 -- no --> Q5

    Q5{Changes\npriority or dispatch?}
    Q5 -- yes --> Q5A["Run dispatch unit tests\nVerify no starvation for recovered jobs"]
    Q5 -- no --> Q6

    Q6{Touches\nclaimQueuedJobForRunner?}
    Q6 -- yes --> STOP["STOP — write concurrent\nintegration test first\nSKIP LOCKED must remain atomic"]
    Q6 -- no --> SAFE["Likely safe to proceed\nAdd tests, run suite"]
```

---

## 7. Test Coverage Map

> Where to add tests for each type of change.

| Change area | Test type | Location |
|-------------|-----------|----------|
| Subtitle parser / export logic | Unit | `test/unit/features/subtitles/` |
| Job retry metadata utilities | Unit | `test/unit/features/translation-jobs/` |
| Dispatch priority algorithm | Unit | `test/unit/features/translation-jobs/` |
| Recovery advisory lock | Integration | `test/integration/features/translation-jobs/` |
| SKIP LOCKED concurrent claim | Integration | `test/integration/features/translation-jobs/` |
| Repository ownership isolation | Integration | `test/integration/features/*/` |
| HTTP routes / request validation | E2E | `test/e2e/features/*/` |
| Error envelope shape | E2E | `test/e2e/` |
| Provider circuit breaker | Unit | `test/unit/features/catalog/` |
| Cache request coalescing | Unit | `test/unit/common/cache/` |

---

## 8. Adding a New Translation Provider

> The cleanest extensibility path in the system.

```mermaid
flowchart LR
    A["Implement TranslationProviderPort\n\ntranslate(params): Promise<string[]>"] --> B

    B["Add class to\nfeatures/translation-jobs/providers/\ne.g. claude-translation.provider.ts"] --> C

    C["Wire in translation-jobs.module.ts\n\nprovide: TRANSLATION_PROVIDER_PORT\nuseClass: ClaudeTranslationProvider"] --> D

    D["Add config namespace\nif API key needed\ncommon/config/"] --> DONE["Done\nNo changes to runner\nNo changes to dispatch\nNo changes to recovery"]

    style DONE fill:#d4edda,stroke:#388e3c
```

---

## 9. Adding a New Subtitle Source Provider

```mermaid
flowchart LR
    A["Implement SubtitleSourceProvider\n\nname: string\nsearchSources(input): Promise<SubtitleSourceCandidate[]>"] --> B

    B["Add class to\nfeatures/catalog/providers/\ne.g. opensubtitles.provider.ts"] --> C

    C["Register in CatalogModule\nprovide: SUBTITLE_SOURCE_PROVIDERS\nuseValue: [...existing, new OpenSubtitlesProvider]"] --> D

    D["Add to SubtitleSourceDiscoveryService\nprovider chain"] --> E

    E["SubtitleProviderHealthService\nwill automatically track health\n(uses provider.name as key)"] --> DONE["Done"]

    style DONE fill:#d4edda,stroke:#388e3c
```
