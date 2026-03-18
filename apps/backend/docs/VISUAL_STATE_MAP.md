# Visual State Map

> **Docs index:** [README.md](README.md) · **See also:** [VISUAL_RUNTIME_FLOWS.md](VISUAL_RUNTIME_FLOWS.md) · [DATA_AND_STATE_MODEL.md](DATA_AND_STATE_MODEL.md) · [KEY_DIAGRAMS.md](KEY_DIAGRAMS.md)
>
> **Covers:** TranslationJob state machine, progress milestones, stall recovery transitions, circuit breaker states, acquisition decision tree, translation reuse decision tree, durable vs in-memory state.
> **Does not cover:** how states are reached step-by-step (→ VISUAL_RUNTIME_FLOWS), full field-level data model (→ DATA_AND_STATE_MODEL).

All important states, transitions, and decision trees in one document.

---

## 1. TranslationJob Lifecycle

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

---

## 2. Job Progress Milestones

> `stageLabel` and `progress` are written at fixed checkpoints — not real percentages.

```mermaid
flowchart LR
    Q["queued\nprogress: 0"] --> T1

    T1["translating\n0.18\n'Loading source subtitle cues'"] --> T2

    T2["translating\n0.56\n'Translating subtitle lines'"] --> T3

    T3["translating\n0.86\n'Building preview and export payloads'"] --> T4

    T4["completed\n1.0\n'Translation ready'\nor 'Subtitle ready'"]

    style Q fill:#fff3cd
    style T1 fill:#cce5ff
    style T2 fill:#cce5ff
    style T3 fill:#cce5ff
    style T4 fill:#d4edda
```

---

## 3. Stall Recovery State Transitions

```mermaid
stateDiagram-v2
    direction TB

    state "translating (stalled)" as S
    state "Recovery Check" as R
    state check_attempts <<choice>>

    S --> R : updatedAt < (now − staleAfterMs)\nupdatedAt not refreshed by active job

    R --> check_attempts

    check_attempts --> queued : attemptCount < maxAttempts (3)\nUPDATE status=queued\nrecoveredFromStall=true

    check_attempts --> failed : attemptCount ≥ maxAttempts\nreason: stall_recovery_exhausted

    queued --> translating : dispatcher picks up\nrunner claims via SKIP LOCKED

    note right of queued
        Job gets RECOVERED(30) priority
        unless it's been queued > 5min
        (then promoted to priority 10)
    end note
```

---

## 4. Provider Circuit Breaker State

Applies to SubDL, Podnapisi, and TVSubs independently.

```mermaid
stateDiagram-v2
    direction LR

    [*] --> Healthy : provider starts healthy\nfailureCount = 0

    Healthy --> Healthy : request success\nrecordSuccess() → reset count

    Healthy --> Degraded : request failure\nrecordFailure() → failureCount++\n(count < threshold)

    Degraded --> Degraded : more failures\nfailureCount < threshold

    Degraded --> Healthy : request success\nrecordSuccess() → reset count

    Degraded --> Cooldown : failureCount ≥ threshold (3)\nlastFailureAt recorded

    Cooldown --> Healthy : cooldownMs elapsed (60s)\nnext isAllowed() call\nauto-resets state

    note right of Cooldown
        isAllowed() returns false
        provider is skipped in chain
        no requests sent
    end note
```

---

## 5. Subtitle Acquisition Decision Tree

> Every catalog job starts here. The outcome determines whether AI translation runs.

```mermaid
flowchart TD
    START["decideCatalogAcquisition\n(called by runner for every catalog job)"] --> A

    A["Search subtitle sources\nin targetLanguage"] --> B{any candidates\nin target language?}

    B -- no --> TRANS["acquisitionMode:\nai_translation\n(no target-lang source found)"]

    B -- yes --> C["Evaluate best candidate\nQualityEvalService.evaluate"]

    C --> D{confidence ≥ threshold\nand not blocked?}

    D -- yes --> REUSE["acquisitionMode:\nexisting_target_subtitle\n✓ Skip AI translation\nuse this subtitle as-is"]

    D -- no --> TRANS

    TRANS --> E["Use fallbackSubtitleSourceId\n(source-language subtitle)"]

    style REUSE fill:#d4edda,stroke:#388e3c
    style TRANS fill:#fff3cd,stroke:#ffc107
```

---

## 6. Translation Reuse Decision Tree

> Only runs on the `ai_translation` path, after timing alignment, before calling the provider.

```mermaid
flowchart TD
    START["decideCatalogTranslationReuse\n(called on ai_translation path)"] --> A

    A["Query DB: completed job\non same device\nsame subtitleSourceId + targetLanguage"] --> B{prior job\nexists?}

    B -- no --> FRESH["reuseAllowed: false\nreason: no_prior_translation\n→ call translationProvider.translate"]

    B -- yes --> C["Compare cue count\nand timing compatibility"]

    C --> D{cues match?}

    D -- no --> FRESH2["reuseAllowed: false\nreason: cue_mismatch\n→ call translationProvider.translate"]

    D -- yes --> SAVED["reuseAllowed: true\n✓ Copy translatedCues from prior job\nNo AI call needed"]

    style SAVED fill:#d4edda,stroke:#388e3c
    style FRESH fill:#fff3cd
    style FRESH2 fill:#fff3cd
```

---

## 7. Durable vs In-Memory State Map

```mermaid
graph TD
    subgraph DURABLE["Durable — PostgreSQL (survives restarts)"]
        D1["TranslationJob rows\n(status, progress, metadata)"]
        D2["TranslationJobCue rows\n(translated output)"]
        D3["ParsedSubtitleFile\n+ ParsedSubtitleCue"]
        D4["User + UserIdentity\nRefreshToken, VerifyToken"]
        D5["ClientDevice\nUserPreference"]
    end

    subgraph MEMORY["In-Memory — per process (reset on restart)"]
        M1["AppCacheService entries\nTMDb results · subtitle sources · prefs"]
        M2["ExecutionLimiterService\nactiveCount slot counter"]
        M3["RateLimitService\nbucket windows per IP+route"]
        M4["RunnerService\nscheduledJobIds · activeJobIds sets"]
        M5["ProviderHealthService\nfailureCount per provider"]
        M6["PostgreSQL advisory lock\nsession-scoped, auto-released on crash"]
    end

    subgraph RECOVERY["What keeps in-memory loss safe"]
        R1["Recovery scheduler detects\nstalled translating jobs\n(updatedAt not updated)"]
        R2["Dispatch scheduler\nrefills slots from queued jobs\non startup"]
        R3["Cache rebuilt\nfrom DB / external API\non next request"]
    end

    M2 -->|lost on restart| R2
    M4 -->|lost on restart| R2
    M6 -->|released on crash| R1
    M1 -->|cold cache| R3

    style DURABLE fill:#e8f5e9,stroke:#388e3c
    style MEMORY fill:#fff3cd,stroke:#ffc107
    style RECOVERY fill:#e3f2fd,stroke:#1976d2
```

**Key guarantee:** No queued or stalled job is permanently lost when a process restarts. All recovery paths run from DB state.
