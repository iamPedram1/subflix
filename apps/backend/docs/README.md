# SubFlix Back — Documentation

SubFlix Back is a NestJS REST API for a Flutter subtitle translation app. It handles subtitle sourcing (upload or catalog discovery), translation job orchestration, and device-scoped data — all backed by PostgreSQL.

This docs package is written for backend developers: people onboarding, making feature changes, debugging job failures, or extending the system with new providers.

---

## If You Only Have 15 Minutes

Read these in order:

1. **[VISUAL_ARCHITECTURE.md](visual/VISUAL_ARCHITECTURE.md)** — System context, module structure, and how layers connect. Start here.
2. **[VISUAL_STATE_MAP.md](visual/VISUAL_STATE_MAP.md) § TranslationJob Lifecycle** — The job state machine is the heart of the system.
3. **[VISUAL_CONTRIBUTOR_GUIDE.md](visual/VISUAL_CONTRIBUTOR_GUIDE.md) § Risky Areas Map** — What to be careful about before touching anything.

That gives you enough to navigate the codebase confidently.

---

## Reading Paths

### New developer — full onboarding

| Step | Document | Why |
|------|----------|-----|
| 1 | [VISUAL_ARCHITECTURE.md](visual/VISUAL_ARCHITECTURE.md) | System context, module layout, layer diagram |
| 2 | [BACKEND_ARCHITECTURE_OVERVIEW.md](architecture/BACKEND_ARCHITECTURE_OVERVIEW.md) | Design decisions, assumptions, limitations |
| 3 | [FEATURE_MAP.md](architecture/FEATURE_MAP.md) | What each module owns and depends on |
| 4 | [VISUAL_RUNTIME_FLOWS.md](visual/VISUAL_RUNTIME_FLOWS.md) | How requests actually move through the system |
| 5 | [VISUAL_STATE_MAP.md](visual/VISUAL_STATE_MAP.md) | Job states, recovery, decision trees |
| 6 | [VISUAL_DATA_MAP.md](visual/VISUAL_DATA_MAP.md) | Data model and JSON blob schemas |

### Working on a feature change

| Step | Document |
|------|----------|
| 1 | [VISUAL_CONTRIBUTOR_GUIDE.md](visual/VISUAL_CONTRIBUTOR_GUIDE.md) — "Where do I go when changing X" |
| 2 | [FEATURE_MAP.md](architecture/FEATURE_MAP.md) — that feature's responsibilities and dependencies |
| 3 | [CODEBASE_REVIEW_NOTES.md](reference/CODEBASE_REVIEW_NOTES.md) — risky areas and coupling warnings |
| 4 | [ENGINEERING_PLAYBOOK.md](contributor/ENGINEERING_PLAYBOOK.md) — safe patterns and checklists |

### Debugging a job failure or async issue

| Step | Document |
|------|----------|
| 1 | [VISUAL_STATE_MAP.md](visual/VISUAL_STATE_MAP.md) — trace the job state transitions |
| 2 | [VISUAL_RUNTIME_FLOWS.md](visual/VISUAL_RUNTIME_FLOWS.md) § Async Job Execution + Dispatch + Recovery |
| 3 | [DATA_AND_STATE_MODEL.md](reference/DATA_AND_STATE_MODEL.md) § jobMeta — understand retry metadata |
| 4 | [VISUAL_CONTRIBUTOR_GUIDE.md](visual/VISUAL_CONTRIBUTOR_GUIDE.md) § Job Tracing Map |
| 5 | [ENGINEERING_PLAYBOOK.md](contributor/ENGINEERING_PLAYBOOK.md) § Debugging Async Job Issues |

### Working on an integration or provider

| Step | Document |
|------|----------|
| 1 | [EXTERNAL_INTEGRATIONS.md](reference/EXTERNAL_INTEGRATIONS.md) — that provider's abstraction, config, failure handling |
| 2 | [VISUAL_RUNTIME_FLOWS.md](visual/VISUAL_RUNTIME_FLOWS.md) § Provider Fallback + Circuit Breaker |
| 3 | [VISUAL_CONTRIBUTOR_GUIDE.md](visual/VISUAL_CONTRIBUTOR_GUIDE.md) § Adding a New Provider |
| 4 | [ENGINEERING_PLAYBOOK.md](contributor/ENGINEERING_PLAYBOOK.md) § Adding a New Provider |

---

## Documentation Map

### Architecture

| File | Purpose | Read when |
|------|---------|-----------|
| [BACKEND_ARCHITECTURE_OVERVIEW.md](architecture/BACKEND_ARCHITECTURE_OVERVIEW.md) | Design style, module structure, assumptions, limitations | Onboarding; understanding "why" decisions were made |
| [FEATURE_MAP.md](architecture/FEATURE_MAP.md) | Per-feature responsibilities, key files, dependencies | Finding the right file for any feature |
| [DIAGRAMS.md](architecture/DIAGRAMS.md) | Consolidated Mermaid diagrams (legacy reference) | Quick diagram lookup |
| [architecture.md](architecture/architecture.md) | Original architecture decisions | Historical context |

### Visual Architecture

| File | Purpose | Read when |
|------|---------|-----------|
| [VISUAL_ARCHITECTURE.md](visual/VISUAL_ARCHITECTURE.md) | System context (C4), module layout, layer diagram, integration map | First thing for any new developer |
| [VISUAL_RUNTIME_FLOWS.md](visual/VISUAL_RUNTIME_FLOWS.md) | 12 runtime flows with diagrams — auth, upload, catalog, jobs, recovery | Understanding how a specific flow works |
| [VISUAL_STATE_MAP.md](visual/VISUAL_STATE_MAP.md) | Job state machine, circuit breaker, decision trees, durable vs in-memory | Debugging state issues; understanding job lifecycle |
| [VISUAL_DATA_MAP.md](visual/VISUAL_DATA_MAP.md) | ERD, ownership hierarchy, JSON blob schemas, read/write ownership | Understanding the data model; working with jobMeta/subtitleSourceRef |
| [VISUAL_CONTRIBUTOR_GUIDE.md](visual/VISUAL_CONTRIBUTOR_GUIDE.md) | "Where to go" flowchart, risky areas map, safe-change checklist, add-provider guides | Before making any non-trivial change |

### Reference

| File | Purpose | Read when |
|------|---------|-----------|
| [DATA_AND_STATE_MODEL.md](reference/DATA_AND_STATE_MODEL.md) | Full entity/field reference, JSON blob schemas, state transitions | Deep data model questions |
| [EXTERNAL_INTEGRATIONS.md](reference/EXTERNAL_INTEGRATIONS.md) | Every external dependency: TMDb, SubDL, Podnapisi, TVSubs, Firebase, translation | Working on an integration |
| [REQUEST_AND_JOB_FLOWS.md](reference/REQUEST_AND_JOB_FLOWS.md) | Prose + diagram flows for all major paths | Cross-reference for runtime flows |
| [CODEBASE_REVIEW_NOTES.md](reference/CODEBASE_REVIEW_NOTES.md) | Candid review: strengths, risks, coupling, naming, maintenance | Before a non-trivial refactor or review |

### Contributor

| File | Purpose | Read when |
|------|---------|-----------|
| [ENGINEERING_PLAYBOOK.md](contributor/ENGINEERING_PLAYBOOK.md) | How to work safely in this repo — patterns, checklists, anti-patterns | Before any feature change; AI code review; debugging jobs |
| [api-rules.md](contributor/api-rules.md) | API conventions and contract rules | Adding or changing HTTP routes |
| [testing-strategy.md](contributor/testing-strategy.md) | Test layers, tooling, and conventions | Adding tests; understanding test coverage |

---

## Most Risky / Important Parts of the System

These are the areas where mistakes are hardest to reverse. Read the relevant notes before touching them.

| Area | Why it's risky | Where to read |
|------|----------------|---------------|
| `claimQueuedJobForRunner()` | Must stay atomic (SKIP LOCKED in a transaction). Splitting it re-introduces duplicate execution. | [VISUAL_CONTRIBUTOR_GUIDE.md § Risky Areas](visual/VISUAL_CONTRIBUTOR_GUIDE.md) |
| `recoverStalledJobs()` try/finally | Advisory lock must be released in `finally`. Losing the block leaves the lock held until connection timeout. | [CODEBASE_REVIEW_NOTES.md](reference/CODEBASE_REVIEW_NOTES.md) |
| `jobMeta` mutations | Always go through `job-staleness.util.ts`. Direct spread-updates miss null-safety handling. | [VISUAL_DATA_MAP.md § jobMeta](visual/VISUAL_DATA_MAP.md) |
| `runCatalogJob()` branches | 4 distinct completion paths, each with quality eval + persistence. Easy to miss a branch. | [VISUAL_RUNTIME_FLOWS.md § Catalog Job Decision Tree](visual/VISUAL_RUNTIME_FLOWS.md) |
| Web scrapers (Podnapisi, TVSubs) | Fail silently — site markup changes return 0 results, not errors. Circuit breaker won't catch this. | [EXTERNAL_INTEGRATIONS.md](reference/EXTERNAL_INTEGRATIONS.md) |

---

## Where to Go When Changing X

| Changing... | Primary files | Supporting docs |
|-------------|---------------|-----------------|
| Auth / OAuth / tokens | `features/auth/auth.service.ts` `auth.repository.ts` | [EXTERNAL_INTEGRATIONS.md § Firebase](reference/EXTERNAL_INTEGRATIONS.md) |
| Subtitle upload / parsing | `features/subtitles/subtitle-parser.service.ts` | [VISUAL_RUNTIME_FLOWS.md § Upload Flow](visual/VISUAL_RUNTIME_FLOWS.md) |
| Media search (TMDb) | `features/catalog/providers/tmdb-media-catalog.provider.ts` | [EXTERNAL_INTEGRATIONS.md § TMDb](reference/EXTERNAL_INTEGRATIONS.md) |
| Subtitle source providers | `features/catalog/providers/*.provider.ts` | [VISUAL_CONTRIBUTOR_GUIDE.md § Adding a Provider](visual/VISUAL_CONTRIBUTOR_GUIDE.md) |
| Subtitle quality scoring | `features/catalog/subtitle-quality-evaluation.service.ts` | [VISUAL_STATE_MAP.md § Acquisition Decision Tree](visual/VISUAL_STATE_MAP.md) |
| Translation job lifecycle | `features/translation-jobs/translation-jobs.service.ts` | [FEATURE_MAP.md § Translation Jobs](architecture/FEATURE_MAP.md) |
| Job execution logic | `features/translation-jobs/translation-job-runner.service.ts` | [VISUAL_RUNTIME_FLOWS.md § Catalog Job Decision Tree](visual/VISUAL_RUNTIME_FLOWS.md) |
| Dispatch / slot management | `translation-job-dispatch.service.ts` `translation-job-priority.util.ts` | [VISUAL_RUNTIME_FLOWS.md § Dispatch](visual/VISUAL_RUNTIME_FLOWS.md) |
| Stall recovery | `translation-job-recovery.service.ts` `job-staleness.util.ts` | [VISUAL_RUNTIME_FLOWS.md § Recovery](visual/VISUAL_RUNTIME_FLOWS.md) |
| Multi-instance coordination | `translation-jobs.repository.ts` (SKIP LOCKED, advisory lock) | [VISUAL_STATE_MAP.md § Durable vs In-Memory](visual/VISUAL_STATE_MAP.md) |
| Translation provider | `features/translation-jobs/providers/*.provider.ts` | [VISUAL_CONTRIBUTOR_GUIDE.md § Adding a Translation Provider](visual/VISUAL_CONTRIBUTOR_GUIDE.md) |
| Translation reuse | `translation-reuse.service.ts` | [VISUAL_STATE_MAP.md § Translation Reuse Decision Tree](visual/VISUAL_STATE_MAP.md) |
| Target-language subtitle reuse | `subtitle-acquisition-strategy.service.ts` | [VISUAL_STATE_MAP.md § Acquisition Decision Tree](visual/VISUAL_STATE_MAP.md) |
| Error responses / envelope | `common/http/filters/global-exception.filter.ts` | [BACKEND_ARCHITECTURE_OVERVIEW.md](architecture/BACKEND_ARCHITECTURE_OVERVIEW.md) |
| Config / env vars | `common/config/*.config.ts` | [BACKEND_ARCHITECTURE_OVERVIEW.md § Assumptions](architecture/BACKEND_ARCHITECTURE_OVERVIEW.md) |

---

## Key Diagrams at a Glance

The five most important diagrams for understanding this system quickly:

| Diagram | Location |
|---------|----------|
| System context (C4) | [VISUAL_ARCHITECTURE.md § System Context](visual/VISUAL_ARCHITECTURE.md#system-context) |
| Module dependency graph | [VISUAL_ARCHITECTURE.md § Feature Dependency Graph](visual/VISUAL_ARCHITECTURE.md#feature-dependency-graph) |
| TranslationJob lifecycle state machine | [VISUAL_STATE_MAP.md § TranslationJob Lifecycle](visual/VISUAL_STATE_MAP.md#1-translationjob-lifecycle) |
| Catalog job decision tree | [VISUAL_RUNTIME_FLOWS.md § Catalog Job Decision Tree](visual/VISUAL_RUNTIME_FLOWS.md#8-catalog-job-decision-tree) |
| Subtitle discovery + provider fallback | [VISUAL_RUNTIME_FLOWS.md § Subtitle Discovery](visual/VISUAL_RUNTIME_FLOWS.md#5-catalog-subtitle-discovery--provider-fallback) |
| Risky areas map | [VISUAL_CONTRIBUTOR_GUIDE.md § Risky Areas](visual/VISUAL_CONTRIBUTOR_GUIDE.md#5-risky-areas-map) |

See [KEY_DIAGRAMS.md](KEY_DIAGRAMS.md) for all diagrams embedded in one place.
