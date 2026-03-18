# Key Diagrams

The highest-value diagrams for understanding SubFlix Back quickly. Each section shows the rendered diagram image followed by the Mermaid source for in-context editing.

> **Rendered assets:** [`docs/assets/diagrams/`](assets/diagrams/) · **Regenerate:** `pnpm docs:diagrams`

---

## 1. System Context

> What the backend is, who uses it, and what it talks to.

![System Context](assets/diagrams/system-context.svg)

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

**Full context:** [VISUAL_ARCHITECTURE.md](visual/VISUAL_ARCHITECTURE.md)

---

## 2. Module Dependency Graph

> Which NestJS modules depend on which. `TranslationJobsModule` is the only cross-feature consumer.

![Module Dependency Graph](assets/diagrams/module-dependency.svg)

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

**Full context:** [VISUAL_ARCHITECTURE.md](visual/VISUAL_ARCHITECTURE.md)

---

## 3. Layer Architecture

> The request pipeline every call passes through, from guard to database.

![Layer Architecture](assets/diagrams/layer-architecture.svg)

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

**Full context:** [VISUAL_ARCHITECTURE.md](visual/VISUAL_ARCHITECTURE.md)

---

## 4. TranslationJob Lifecycle State Machine

> The job state machine. Recovery adds a re-entry path from `translating` back to `queued`.

![Translation Job Lifecycle](assets/diagrams/job-lifecycle.svg)

```mermaid
stateDiagram-v2
    direction LR

    [*] --> queued : POST /v1/translation-jobs\n(or recovery requeue)

    queued --> translating : runner.run()\nSELECT FOR UPDATE SKIP LOCKED\nUPDATE status=translating\nstartedAt=now, attemptCount++

    translating --> completed : job success\nreplaceJobCues()\nUPDATE status=completed\nprogress=1

    translating --> failed : error thrown\nor stall_recovery_exhausted\nUPDATE status=failed\nerrorMessage set

    translating --> queued : stall recovery\n(updatedAt stale + retries remain)\nUPDATE status=queued\nrecoveredFromStall=true

    completed --> [*]
    failed --> [*]
```

**Full context:** [VISUAL_STATE_MAP.md](visual/VISUAL_STATE_MAP.md)

---

## 5. Background Processing Architecture

> How the scheduler, recovery, dispatch, runner, and limiter interact. This is the async core of the system.

![Background Processing Architecture](assets/diagrams/background-processing.svg)

```mermaid
graph TB
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

    HTTP["POST /v1/translation-jobs"] -->|schedule| RUNNER
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

**Full context:** [VISUAL_ARCHITECTURE.md](visual/VISUAL_ARCHITECTURE.md) · [VISUAL_RUNTIME_FLOWS.md](visual/VISUAL_RUNTIME_FLOWS.md)

---

## 6. Catalog Job Decision Tree

> The most complex flow in the system. Every catalog job passes through this branching logic.

![Catalog Job Decision Tree](assets/diagrams/catalog-decision-tree.svg)

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

**Full context:** [VISUAL_RUNTIME_FLOWS.md](visual/VISUAL_RUNTIME_FLOWS.md)

---

## 7. Subtitle Discovery + Provider Fallback

> How subtitle sources are found for a media item, with circuit-breaker fallback logic.

![Subtitle Discovery and Provider Fallback](assets/diagrams/subtitle-discovery.svg)

```mermaid
flowchart TD
    A["GET /v1/catalog/media/:id/subtitle-sources"] --> B["SubtitleSourceDiscoveryService\n.discover"]

    B --> C{Cache hit?\n6h TTL}
    C -- yes --> DONE["Return CatalogSubtitleSource[]"]
    C -- no --> D["Start provider chain"]

    D --> E{SubDL enabled\nand healthy?}
    E -- yes --> F["SubDLProvider\n.searchSources"]
    F -- success --> FA["recordSuccess · add candidates"]
    F -- error --> FB["recordFailure\n≥3 failures → 60s cooldown"]
    E -- no/cooldown --> G

    FA --> G
    FB --> G

    G{Podnapisi healthy?} -- yes --> H["PodnapisiProvider\n.searchSources (scraper)"]
    H -- success --> HA["add candidates"]
    H -- error --> HB["recordFailure"]
    G -- no --> I

    HA --> I
    HB --> I

    I{TVSubs healthy?} -- yes --> J["TVSubsProvider\n.searchSources (scraper)"]
    J -- success --> JA["add candidates"]
    J -- error --> JB["recordFailure"]
    I -- no --> K

    JA --> K
    JB --> K

    K["Deduplicate · Rank · Limit 20 · Cache 6h"] --> DONE
```

**Full context:** [VISUAL_RUNTIME_FLOWS.md](visual/VISUAL_RUNTIME_FLOWS.md) · [EXTERNAL_INTEGRATIONS.md](reference/EXTERNAL_INTEGRATIONS.md)

---

## 8. Risky Areas Map

> Before changing anything non-trivial, check this map.

![Risky Areas Map](assets/diagrams/risky-areas.svg)

```mermaid
graph TD
    subgraph "HIGH RISK"
        R1["claimQueuedJobForRunner()\nMust stay SKIP LOCKED atomic"]
        R2["recoverStalledJobs()\ntry/finally — advisory lock must release"]
        R3["jobMeta mutations\nAlways use job-staleness.util.ts"]
        R4["replaceJobCues()\nNot idempotent — second call clears first"]
    end

    subgraph "MEDIUM RISK"
        M1["dispatch() priority scoring\nAffects all job ordering globally"]
        M2["SubtitleProviderHealthService\nShared state across all 3 providers"]
        M3["AppCacheService.getOrSet()\nCoalescing relies on promise reference"]
    end

    subgraph "LOW RISK — isolated pure functions"
        L1["SubtitleParserService"]
        L2["SubtitleTimingAlignmentService"]
        L3["SubtitleExportService"]
        L4["translation-job-priority.util.ts"]
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

**Full context:** [VISUAL_CONTRIBUTOR_GUIDE.md](visual/VISUAL_CONTRIBUTOR_GUIDE.md) · [CODEBASE_REVIEW_NOTES.md](reference/CODEBASE_REVIEW_NOTES.md)

---

## 9. Entity Relationship Overview

> Ownership hierarchy and key relationships at a glance.

![Entity Relationship Overview](assets/diagrams/entity-relationship.svg)

```mermaid
graph TD
    CD["ClientDevice\n(x-device-id header)"]

    CD --> PREF["UserPreference\n1:1"]
    CD --> FILE["ParsedSubtitleFile\n1:N"]
    CD --> JOB["TranslationJob\n1:N"]

    FILE --> CUE1["ParsedSubtitleCue\n1:N"]
    FILE -.->|parsedFileId| JOB
    JOB --> CUE2["TranslationJobCue\n1:N (written on completion)"]

    USER["User\n(optional — auth only)"] --> IDENT["UserIdentity\n1:N\nemail · firebase_*"]
    USER --> TOK["RefreshToken\n1:N"]

    style CD fill:#e3f2fd,stroke:#1976d2,font-weight:bold
    style JOB fill:#fff3cd,stroke:#f9a825
    style CUE2 fill:#fff3cd
    style USER fill:#f3e5f5,stroke:#7b1fa2
```

**Full context:** [VISUAL_DATA_MAP.md](visual/VISUAL_DATA_MAP.md) · [DATA_AND_STATE_MODEL.md](reference/DATA_AND_STATE_MODEL.md)

---

## Regenerating Diagram Assets

SVG assets live in [`docs/assets/diagrams/`](assets/diagrams/). To regenerate after editing a diagram:

```bash
# Regenerate all diagrams
pnpm docs:diagrams

# Regenerate a single diagram manually
mmdc -i docs/assets/diagrams/<name>.mmd -o docs/assets/diagrams/<name>.svg --backgroundColor transparent
```

The `.mmd` source files in `docs/assets/diagrams/` are the export sources. The Mermaid code blocks in this document are the **authoritative source of truth** — keep them in sync when editing.
