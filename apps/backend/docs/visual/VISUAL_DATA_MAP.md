# Visual Data Map

> **Docs index:** [README.md](../README.md) · **See also:** [DATA_AND_STATE_MODEL.md](../reference/DATA_AND_STATE_MODEL.md) · [VISUAL_STATE_MAP.md](VISUAL_STATE_MAP.md) · [KEY_DIAGRAMS.md](../KEY_DIAGRAMS.md)
>
> **Covers:** full ERD, ownership hierarchy, all three JSON blob schemas (`mediaRef` / `subtitleSourceRef` / `jobMeta`), read/write ownership map, DB index → query pattern map, `SubtitleCue` internal model flow.
> **Does not cover:** state transitions (→ VISUAL_STATE_MAP), field-level reference tables (→ DATA_AND_STATE_MODEL).

Visual guide to the data model: entity relationships, JSON blob schemas, and who reads/writes each piece of state.

---

## 1. Entity Relationship Diagram

```mermaid
erDiagram
    User {
        uuid id PK
        string email UK
        string passwordHash "nullable"
        boolean emailVerified
    }

    UserIdentity {
        uuid id PK
        uuid userId FK
        enum provider "email|firebase_google|firebase_facebook|firebase_apple"
        string providerUserId
        string email "nullable"
    }

    RefreshToken {
        uuid id PK
        uuid userId FK
        string tokenHash UK
        datetime expiresAt
        datetime revokedAt "nullable"
        datetime lastUsedAt "nullable"
    }

    EmailVerificationToken {
        uuid id PK
        uuid userId FK
        string tokenHash UK
        datetime expiresAt
        datetime consumedAt "nullable"
    }

    PasswordResetToken {
        uuid id PK
        uuid userId FK
        string tokenHash UK
        datetime expiresAt
        datetime consumedAt "nullable"
    }

    ClientDevice {
        uuid id PK
        string deviceId UK
    }

    UserPreference {
        uuid id PK
        uuid clientDeviceId FK UK
        enum preferredTargetLanguage
        enum themePreference
        boolean hasSeenOnboarding
    }

    ParsedSubtitleFile {
        uuid id PK
        uuid clientDeviceId FK
        string fileName
        enum format "srt|vtt"
        enum sourceLanguage
        int lineCount
        int durationMs
        string checksum
        text rawContent
    }

    ParsedSubtitleCue {
        uuid id PK
        uuid parsedFileId FK
        int cueIndex
        int startMs
        int endMs
        text text
    }

    TranslationJob {
        uuid id PK
        uuid clientDeviceId FK
        uuid parsedFileId FK "nullable upload-only"
        enum sourceType "catalog|upload"
        enum status "queued|translating|completed|failed"
        enum targetLanguage
        float progress
        json mediaRef "nullable catalog-only"
        json subtitleSourceRef "nullable catalog-only"
        json jobMeta "retry tracking"
        datetime startedAt "nullable"
        datetime completedAt "nullable"
    }

    TranslationJobCue {
        uuid id PK
        uuid jobId FK
        int cueIndex
        int startMs
        int endMs
        text originalText
        text translatedText "nullable"
    }

    User ||--o{ UserIdentity : "has"
    User ||--o{ RefreshToken : "has"
    User ||--o{ EmailVerificationToken : "has"
    User ||--o{ PasswordResetToken : "has"
    ClientDevice ||--o| UserPreference : "has"
    ClientDevice ||--o{ ParsedSubtitleFile : "owns"
    ClientDevice ||--o{ TranslationJob : "owns"
    ParsedSubtitleFile ||--o{ ParsedSubtitleCue : "contains"
    ParsedSubtitleFile ||--o{ TranslationJob : "source for"
    TranslationJob ||--o{ TranslationJobCue : "produces"
```

---

## 2. Ownership Hierarchy

> All private data is scoped to a `ClientDevice`.

```mermaid
graph TD
    CD["ClientDevice\n(x-device-id header → upsert)"]

    CD --> PREF["UserPreference\n1:1\nhasSeenOnboarding\npreferredTargetLanguage\nthemePreference"]

    CD --> FILE["ParsedSubtitleFile\n1:N\nUploaded .srt / .vtt files"]
    FILE --> CUE["ParsedSubtitleCue\n1:N\ncueIndex · startMs · endMs · text"]

    CD --> JOB["TranslationJob\n1:N\nFull job history"]
    JOB --> JCUE["TranslationJobCue\n1:N\noriginalText · translatedText"]

    FILE -.->|parsedFileId FK| JOB

    style CD fill:#e3f2fd,stroke:#1976d2,font-weight:bold
    style PREF fill:#f3e5f5
    style FILE fill:#e8f5e9
    style CUE fill:#e8f5e9
    style JOB fill:#fff3cd
    style JCUE fill:#fff3cd
```

---

## 3. TranslationJob JSON Blobs

Three `Json?` columns carry typed-but-schema-less data. These are the trickiest fields in the model.

### 3a. `mediaRef` (catalog jobs only)

```mermaid
graph LR
    A["mediaRef\n(Json?)"] --> B["mediaId: string\n'tmdb:movie:27205'"]
    A --> C["title: string"]
    A --> D["year: number"]
    A --> E["mediaType: 'movie' | 'series'"]
```

Written at job creation. Read by the runner to look up media details.

---

### 3b. `subtitleSourceRef` — evolution over job lifecycle

```mermaid
flowchart LR
    subgraph "At creation (client sets)"
        C1["subtitleSourceId\nssrc:* opaque ID"]
        C2["seasonNumber?"]
        C3["episodeNumber?"]
        C4["releaseHint?"]
    end

    subgraph "Added by runner after execution"
        R1["fallbackSubtitleSourceId\nactual source used for AI path"]
        R2["selectedSubtitleSourceId\nfinal subtitle actually used"]
        R3["acquisition: {\n  mode, reusedExistingSubtitle,\n  requestedTargetLanguage,\n  selectedLanguageCode, reason\n}"]
        R4["quality: {\n  confidenceScore (0–100),\n  confidenceLevel, warnings[]\n}"]
        R5["timing?: {\n  detectedOffsetMs,\n  appliedCorrection,\n  confidence\n}"]
        R6["translationReuse?: {\n  reused: boolean,\n  reusedFromJobId\n}"]
    end

    C1 & C2 & C3 & C4 --> MERGE["merged in runner\npersistCatalogAcquisitionResult()"]
    MERGE --> R1 & R2 & R3 & R4 & R5 & R6
```

---

### 3c. `jobMeta` — retry tracking

```mermaid
graph LR
    A["jobMeta\n(Json?)"] --> B["attemptCount: number\n0 → 1 → 2 → 3"]
    A --> C["recoveredFromStall: boolean\nset by recovery service"]
    A --> D["lastAttemptStartedAt?: ISO string"]
    A --> E["lastFailureReasonCode?\n'execution_error'\n'stall_recovery_exhausted'"]
    A --> F["lastFailedAt?: ISO string"]
```

Managed exclusively through `job-staleness.util.ts` — never write to `jobMeta` directly.

---

## 4. Who Reads / Writes Key State

```mermaid
graph TD
    subgraph "Writes status=queued"
        W1["TranslationJobsService\n.createJob()"]
        W2["RecoveryService\n.requeueStalledJob()"]
    end

    subgraph "Writes status=translating"
        W3["TranslationJobRunnerService\n.run() — after SKIP LOCKED claim"]
    end

    subgraph "Writes status=completed"
        W4["RunnerService\n.run() — upload path"]
        W5["RunnerService\n.completeCatalogJobWithReuse()"]
        W6["RunnerService\n.completeCatalogJobWithTranslation()"]
    end

    subgraph "Writes status=failed"
        W7["RunnerService\n.markFailure()"]
        W8["RecoveryService\n.failStalledJob()"]
    end

    subgraph "Reads status"
        R1["DispatchService\nfindQueuedJobsForDispatch"]
        R2["RecoveryService\nfindStalledJobs (status=translating)"]
        R3["TranslationJobsController\nGET :jobId, GET preview, GET export"]
    end

    W1 & W2 -.->|queued| R1
    W3 -.->|translating| R2
    W4 & W5 & W6 -.->|completed| R3
```

---

## 5. Database Indexes and Query Patterns

```mermaid
graph TD
    subgraph "TranslationJob indexes"
        I1["(clientDeviceId, createdAt DESC)\n→ listOwnedJobs\n→ GET /translation-jobs"]
        I2["(status, updatedAt DESC)\n→ findStalledJobs (translating + old)\n→ findQueuedJobsForDispatch (queued)"]
    end

    subgraph "ParsedSubtitleFile indexes"
        I3["(clientDeviceId, createdAt DESC)\n→ list uploads per device"]
    end

    subgraph "TranslationJobCue indexes"
        I4["(jobId, cueIndex) UNIQUE\n→ listPreviewCues (ordered, paginated)\n→ listAllOwnedJobCues (export)"]
    end

    subgraph "ParsedSubtitleCue indexes"
        I5["(parsedFileId, cueIndex) UNIQUE\n→ listOwnedParsedFileCues\n→ loaded by runner for upload jobs"]
    end

    subgraph "Auth indexes"
        I6["RefreshToken: (userId, expiresAt)\n→ cleanup expired tokens"]
        I7["UserIdentity: (userId)\n→ load all provider links for a user"]
    end
```

---

## 6. `SubtitleCue` — The Internal Normalized Model

This is NOT a Prisma entity. It's the shared in-memory type that flows between parser, catalog providers, quality evaluation, timing alignment, and the translation runner.

```mermaid
graph LR
    A["SubtitleCue\n(in-memory)"] --> B["cueIndex: number"]
    A --> C["startMs: number"]
    A --> D["endMs: number"]
    A --> E["text: string"]

    subgraph "Produced by"
        P1["SubtitleParserService\n(uploaded files)"]
        P2["CatalogSubtitleCueProvider\n(downloaded catalog subtitles)"]
        P3["TranslationJobsRepository\n.findReusableCatalogSourceCues()"]
    end

    subgraph "Consumed by"
        C1["QualityEvaluationService"]
        C2["TimingAlignmentService"]
        C3["TranslationProviderPort.translate()"]
        C4["RunnerService\nbuildPersistedJobCues()"]
    end

    P1 & P2 & P3 --> A
    A --> C1 & C2 & C3 & C4
```
