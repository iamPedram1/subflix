# Visual Architecture

> **Docs index:** [README.md](README.md) · **See also:** [BACKEND_ARCHITECTURE_OVERVIEW.md](BACKEND_ARCHITECTURE_OVERVIEW.md) · [VISUAL_RUNTIME_FLOWS.md](VISUAL_RUNTIME_FLOWS.md) · [KEY_DIAGRAMS.md](KEY_DIAGRAMS.md)
>
> **Covers:** system context, module layout, layer diagram, background processing, integrations map.
> **Does not cover:** runtime flows (→ VISUAL_RUNTIME_FLOWS), state machines (→ VISUAL_STATE_MAP), data model (→ VISUAL_DATA_MAP).

---

## System Context

> Who uses the system and what does it talk to?

```mermaid
C4Context
    title SubFlix Back — System Context

    Person(user, "Flutter App User", "Uses device ID to upload subtitles, discover catalog sources, and get translations")

    System(backend, "SubFlix Back", "NestJS REST API\nTranslation job orchestration\nSubtitle sourcing")

    System_Ext(tmdb, "TMDb API", "Movie & TV metadata")
    System_Ext(subdl, "SubDL API", "Subtitle search (primary)")
    System_Ext(podnapisi, "Podnapisi", "Subtitle search (scraper)")
    System_Ext(tvsubs, "TVSubs", "Subtitle search (scraper)")
    System_Ext(firebase, "Firebase Admin", "OAuth token verification")
    System_Ext(translation, "Translation Provider", "Currently: Mock\nFuture: Claude / DeepL")
    SystemDb(db, "PostgreSQL", "All durable state:\njobs, users, files, prefs")

    Rel(user, backend, "REST API calls", "HTTPS")
    Rel(backend, tmdb, "Media search")
    Rel(backend, subdl, "Subtitle search")
    Rel(backend, podnapisi, "Subtitle search")
    Rel(backend, tvsubs, "Subtitle search")
    Rel(backend, firebase, "Verify OAuth tokens")
    Rel(backend, translation, "Translate cues")
    Rel(backend, db, "Read / Write")
```

---

## Container View — Feature Modules

> How is the backend internally divided?

```mermaid
graph TB
    subgraph API["NestJS API Process"]
        subgraph Common["common/ — Shared Infrastructure"]
            Cache["AppCacheService\nTTL cache + request coalescing"]
            Prisma["PrismaService\nPostgreSQL client"]
            RateLimit["RateLimitService\nFixed-window buckets"]
            Filter["GlobalExceptionFilter\nError normalization"]
            DevGuard["DeviceContextGuard\nx-device-id → ClientDevice"]
            Config["AppConfigModule\n8 config namespaces"]
        end

        subgraph Features["features/ — Business Capabilities"]
            Health["Health\nGET /v1/health"]
            Auth["Auth\nSign-up · Sign-in · OAuth\nRefresh · Password reset"]
            Devices["Devices\nDevice upsert / ownership"]
            Prefs["Preferences\nDevice-scoped settings"]
            Subs["Subtitles\nSRT/VTT parse · Export"]
            Catalog["Catalog\nMedia search · Subtitle discovery\nQuality eval · Timing align"]
            Jobs["Translation Jobs\nCreate · Execute · Dispatch\nRecovery · Preview · Export"]
        end
    end

    Jobs --> Catalog
    Jobs --> Subs
    Catalog --> Cache
    Prefs --> Cache
    All --> Prisma
    All --> Config
    All --> Filter

    style Common fill:#f0f4ff,stroke:#6b8cda
    style Features fill:#f0fff4,stroke:#6bda8c
```

---

## Layer Architecture

> Every request passes through these layers in order.

```mermaid
graph LR
    A["HTTP Request"] --> B
    B["Guards\nDeviceContextGuard\nAccessTokenGuard"] --> C
    C["Controller\nHTTP mapping only\nno business logic"] --> D
    D["Service\nOrchestration\nbusiness rules"] --> E
    E["Repository\nPrisma access only\nnormalizes DB errors"] --> F
    F[("PostgreSQL")]

    D --> G["Port interface\nMediaCatalogPort\nTranslationProviderPort\nSubtitleSourceProvider"]
    G --> H["Provider\nTMDb · SubDL · Podnapisi\nMockTranslation"]
    H --> I["External API / Web"]

    style B fill:#fff3cd,stroke:#ffc107
    style C fill:#d4edda,stroke:#28a745
    style D fill:#cce5ff,stroke:#004085
    style E fill:#f8d7da,stroke:#721c24
    style G fill:#e2d9f3,stroke:#6f42c1
```

**Rules enforced:**
- Services never import `PrismaService` directly
- Controllers never call repositories
- Providers are only injected through port tokens — no direct class references in services

---

## Feature Dependency Graph

> Which feature modules depend on which others?

```mermaid
graph TD
    subgraph "Terminal Consumer"
        TJ["TranslationJobsModule"]
    end

    subgraph "Feature Modules"
        CAT["CatalogModule"]
        SUB["SubtitlesModule"]
        AUTH["AuthModule"]
        PREF["PreferencesModule"]
        DEV["DevicesModule"]
        HEALTH["HealthModule"]
    end

    subgraph "Common Modules"
        PRISMA["PrismaModule"]
        CACHE["AppCacheModule"]
        CFGM["AppConfigModule"]
    end

    TJ -->|imports| CAT
    TJ -->|imports| SUB
    TJ --> PRISMA & DEV & CFGM

    CAT --> CACHE & CFGM
    SUB --> PRISMA & DEV & CFGM
    AUTH --> PRISMA & CFGM
    PREF --> PRISMA & CACHE & DEV & CFGM
    DEV --> PRISMA & CFGM
    HEALTH --> CFGM

    style TJ fill:#ffc,stroke:#cc0
    style CAT fill:#dfd,stroke:#0a0
    style SUB fill:#dfd,stroke:#0a0
```

> **Key insight:** Only `TranslationJobsModule` imports other feature modules. All others are self-contained.

---

## Background Processing Architecture

> How jobs run asynchronously inside the API process.

```mermaid
graph TB
    subgraph "HTTP Layer"
        HTTP["POST /v1/translation-jobs"]
    end

    subgraph "Lifecycle Manager"
        SCHED["RecoverySchedulerService\nBootstrap + setInterval timers"]
    end

    subgraph "Background Pipeline"
        RECOVERY["RecoveryService\nFind stalled jobs\nrequeue / fail"]
        DISPATCH["DispatchService\nFill available slots\npriority scoring"]
        RUNNER["RunnerService\nExecute single job\ncatalog or upload path"]
        LIMITER["ExecutionLimiterService\nPer-process slot counter\nmax N concurrent"]
    end

    subgraph "DB Coordination"
        LOCK["pg_try_advisory_lock\n(key: 7734812019)\nsingle-instance recovery"]
        SKIP["SELECT FOR UPDATE\nSKIP LOCKED\natomic job claim"]
    end

    HTTP -->|schedule| RUNNER
    SCHED -->|on boot + 60s| RECOVERY
    SCHED -->|on boot + 10s| DISPATCH
    RECOVERY -->|schedule recovered| RUNNER
    DISPATCH -->|schedule queued| RUNNER
    RECOVERY --- LOCK
    RUNNER --- SKIP
    RUNNER --- LIMITER
    DISPATCH --- LIMITER

    style RECOVERY fill:#fce4ec,stroke:#e91e63
    style DISPATCH fill:#e3f2fd,stroke:#1976d2
    style RUNNER fill:#e8f5e9,stroke:#388e3c
    style LIMITER fill:#fff8e1,stroke:#f9a825
    style LOCK fill:#ede7f6,stroke:#7b1fa2
    style SKIP fill:#ede7f6,stroke:#7b1fa2
```

---

## External Integrations Map

> What the system calls out to, where it's abstracted, and what happens when it fails.

```mermaid
graph LR
    subgraph "Catalog Feature"
        CAT_SVC["CatalogService"]
        DISC["SubtitleSourceDiscovery"]
        HEALTH_SVC["ProviderHealthService\n(circuit breaker)"]
    end

    subgraph "Translation Jobs"
        RUNNER2["RunnerService"]
    end

    subgraph "Auth"
        AUTH_SVC["AuthService"]
    end

    subgraph "Media Catalog Port"
        TMDB["TmdbMediaCatalogProvider\n(requires TMDB_API_READ_TOKEN)"]
        MOCK_CAT["MockCatalogProvider\n(fallback — no token)"]
    end

    subgraph "Subtitle Source Providers"
        SUBDL["SubDLProvider\n(requires SUBDL_API_KEY)"]
        POD["PodnapisiProvider\n(HTML scraper)"]
        TV["TVSubsProvider\n(HTML scraper)"]
    end

    subgraph "Translation Provider Port"
        MOCK_T["MockTranslationProvider\n(current)"]
        REAL_T["RealTranslationProvider\n(future: Claude / DeepL)"]
    end

    subgraph "Firebase"
        FB["FirebaseAuthService"]
    end

    CAT_SVC --> TMDB & MOCK_CAT
    DISC --> HEALTH_SVC
    DISC --> SUBDL & POD & TV
    RUNNER2 --> MOCK_T & REAL_T
    AUTH_SVC --> FB

    HEALTH_SVC -.->|blocks on 3+ failures| SUBDL
    HEALTH_SVC -.->|blocks on 3+ failures| POD
    HEALTH_SVC -.->|blocks on 3+ failures| TV

    style MOCK_CAT fill:#fff3cd
    style MOCK_T fill:#fff3cd
    style REAL_T fill:#d4edda,stroke-dasharray:5 5
```

**Legend:**
- Solid border = active implementation
- Dashed border = not yet implemented
- Yellow fill = mock/fallback
