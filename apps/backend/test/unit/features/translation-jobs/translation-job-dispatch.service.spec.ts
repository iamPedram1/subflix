import { ConfigService } from '@nestjs/config';
import { TranslationSourceType } from '@prisma/client';

import { TranslationJobDispatchService } from 'features/translation-jobs/translation-job-dispatch.service';
import { TranslationJobExecutionLimiterService } from 'features/translation-jobs/translation-job-execution-limiter.service';
import { TranslationJobRunnerService } from 'features/translation-jobs/translation-job-runner.service';
import { TranslationJobsRepository } from 'features/translation-jobs/translation-jobs.repository';
import { DispatchPriority } from 'features/translation-jobs/utils/translation-job-priority.util';

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

const FAIRNESS_MS = 5 * 60_000;

// ---------------------------------------------------------------------------
// Mock factories
// ---------------------------------------------------------------------------

const makeLimiter = (
  overrides: Partial<{
    getMetrics: ReturnType<typeof vi.fn>;
  }> = {},
): TranslationJobExecutionLimiterService =>
  ({
    getMetrics: vi.fn().mockReturnValue({ activeCount: 0, maxConcurrency: 3 }),
    ...overrides,
  }) as unknown as TranslationJobExecutionLimiterService;

type DispatchCandidate = {
  id: string;
  sourceType: TranslationSourceType;
  createdAt: Date;
  jobMeta: null;
};

const makeRepository = (
  overrides: Partial<{
    findQueuedJobsForDispatch: ReturnType<typeof vi.fn>;
  }> = {},
): TranslationJobsRepository =>
  ({
    findQueuedJobsForDispatch: vi.fn().mockResolvedValue([]),
    ...overrides,
  }) as unknown as TranslationJobsRepository;

const makeRunner = (
  overrides: Partial<{
    schedule: ReturnType<typeof vi.fn>;
  }> = {},
): TranslationJobRunnerService =>
  ({
    schedule: vi.fn(),
    ...overrides,
  }) as unknown as TranslationJobRunnerService;

const makeConfigService = (
  overrides: Record<string, unknown> = {},
): ConfigService =>
  ({
    get: vi.fn((key: string) => {
      const defaults: Record<string, unknown> = {
        'translationJobs.dispatchFairnessThresholdMs': FAIRNESS_MS,
        ...overrides,
      };
      return defaults[key];
    }),
  }) as unknown as ConfigService;

const buildDispatch = ({
  limiter = makeLimiter(),
  repository = makeRepository(),
  runner = makeRunner(),
  configService = makeConfigService(),
}: Partial<{
  limiter: TranslationJobExecutionLimiterService;
  repository: TranslationJobsRepository;
  runner: TranslationJobRunnerService;
  configService: ConfigService;
}> = {}): TranslationJobDispatchService =>
  new TranslationJobDispatchService(repository, limiter, runner, configService);

// Helper to build a minimal dispatch candidate
const makeCandidate = (
  id: string,
  sourceType: TranslationSourceType = TranslationSourceType.catalog,
  createdAt = new Date('2026-01-01T10:00:00.000Z'),
): DispatchCandidate => ({ id, sourceType, createdAt, jobMeta: null });

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

describe('TranslationJobDispatchService', () => {
  describe('capacity checks', () => {
    it('does not query the DB when all slots are in use', async () => {
      const repository = makeRepository();
      const limiter = makeLimiter({
        getMetrics: vi
          .fn()
          .mockReturnValue({ activeCount: 3, maxConcurrency: 3 }),
      });
      const service = buildDispatch({ limiter, repository });

      await service.dispatch('test');

      expect(repository.findQueuedJobsForDispatch).not.toHaveBeenCalled();
    });

    it('does not schedule any jobs when all slots are in use', async () => {
      const runner = makeRunner();
      const limiter = makeLimiter({
        getMetrics: vi
          .fn()
          .mockReturnValue({ activeCount: 3, maxConcurrency: 3 }),
      });
      const service = buildDispatch({ limiter, runner });

      await service.dispatch('test');

      expect(runner.schedule).not.toHaveBeenCalled();
    });
  });

  describe('no queued jobs', () => {
    it('does not schedule any jobs when the repository returns empty', async () => {
      const runner = makeRunner();
      const repository = makeRepository({
        findQueuedJobsForDispatch: vi.fn().mockResolvedValue([]),
      });
      const service = buildDispatch({ runner, repository });

      await service.dispatch('test');

      expect(runner.schedule).not.toHaveBeenCalled();
    });

    it('queries the repository when slots are available', async () => {
      const repository = makeRepository({
        findQueuedJobsForDispatch: vi.fn().mockResolvedValue([]),
      });
      const limiter = makeLimiter({
        getMetrics: vi
          .fn()
          .mockReturnValue({ activeCount: 0, maxConcurrency: 3 }),
      });
      const service = buildDispatch({ repository, limiter });

      await service.dispatch('test');

      expect(repository.findQueuedJobsForDispatch).toHaveBeenCalledWith(3);
    });
  });

  describe('scheduling', () => {
    it('schedules each selected job', async () => {
      const runner = makeRunner();
      const repository = makeRepository({
        findQueuedJobsForDispatch: vi.fn().mockResolvedValue([
          makeCandidate('job-a'),
          makeCandidate('job-b'),
        ]),
      });
      const limiter = makeLimiter({
        getMetrics: vi
          .fn()
          .mockReturnValue({ activeCount: 1, maxConcurrency: 3 }),
      });
      const service = buildDispatch({ runner, repository, limiter });

      await service.dispatch('test');

      expect(runner.schedule).toHaveBeenCalledTimes(2);
      expect(runner.schedule).toHaveBeenCalledWith('job-a');
      expect(runner.schedule).toHaveBeenCalledWith('job-b');
    });

    it('passes slotsAvailable to the repository', async () => {
      const repository = makeRepository({
        findQueuedJobsForDispatch: vi.fn().mockResolvedValue([]),
      });
      const limiter = makeLimiter({
        getMetrics: vi
          .fn()
          .mockReturnValue({ activeCount: 1, maxConcurrency: 3 }),
      });
      const service = buildDispatch({ repository, limiter });

      await service.dispatch('test');

      expect(repository.findQueuedJobsForDispatch).toHaveBeenCalledWith(2);
    });

    it('schedules only one job when only one slot is available', async () => {
      const runner = makeRunner();
      const repository = makeRepository({
        findQueuedJobsForDispatch: vi
          .fn()
          .mockResolvedValue([makeCandidate('job-only')]),
      });
      const limiter = makeLimiter({
        getMetrics: vi
          .fn()
          .mockReturnValue({ activeCount: 2, maxConcurrency: 3 }),
      });
      const service = buildDispatch({ runner, repository, limiter });

      await service.dispatch('test');

      expect(runner.schedule).toHaveBeenCalledTimes(1);
      expect(runner.schedule).toHaveBeenCalledWith('job-only');
    });
  });

  describe('priority ordering', () => {
    it('schedules catalog jobs before upload jobs', async () => {
      const scheduled: string[] = [];
      const runner = makeRunner({
        schedule: vi.fn((id: string) => {
          scheduled.push(id);
        }),
      });
      // Both have the same createdAt so only sourceType differs
      const createdAt = new Date('2026-01-01T10:00:00.000Z');
      const repository = makeRepository({
        findQueuedJobsForDispatch: vi.fn().mockResolvedValue([
          makeCandidate('upload-1', TranslationSourceType.upload, createdAt),
          makeCandidate('catalog-1', TranslationSourceType.catalog, createdAt),
        ]),
      });
      const limiter = makeLimiter({
        getMetrics: vi
          .fn()
          .mockReturnValue({ activeCount: 0, maxConcurrency: 3 }),
      });
      const service = buildDispatch({ runner, repository, limiter });

      await service.dispatch('test');

      expect(scheduled[0]).toBe('catalog-1');
      expect(scheduled[1]).toBe('upload-1');
    });

    it('FIFO within the same tier: older createdAt is scheduled first', async () => {
      const scheduled: string[] = [];
      const runner = makeRunner({
        schedule: vi.fn((id: string) => {
          scheduled.push(id);
        }),
      });
      const repository = makeRepository({
        findQueuedJobsForDispatch: vi.fn().mockResolvedValue([
          makeCandidate(
            'catalog-newer',
            TranslationSourceType.catalog,
            new Date('2026-01-01T11:00:00.000Z'),
          ),
          makeCandidate(
            'catalog-older',
            TranslationSourceType.catalog,
            new Date('2026-01-01T09:00:00.000Z'),
          ),
        ]),
      });
      const limiter = makeLimiter({
        getMetrics: vi
          .fn()
          .mockReturnValue({ activeCount: 0, maxConcurrency: 3 }),
      });
      const service = buildDispatch({ runner, repository, limiter });

      await service.dispatch('test');

      expect(scheduled[0]).toBe('catalog-older');
      expect(scheduled[1]).toBe('catalog-newer');
    });

    it('fresh jobs are scheduled before recovered-from-stall jobs', async () => {
      const scheduled: string[] = [];
      const runner = makeRunner({
        schedule: vi.fn((id: string) => {
          scheduled.push(id);
        }),
      });

      const now = new Date('2026-01-01T12:00:00.000Z');
      // Recovered job created 1 minute ago — under fairness threshold
      const recentCreatedAt = new Date(now.getTime() - 60_000);
      // Fresh catalog job created 2 minutes ago
      const freshCreatedAt = new Date(now.getTime() - 2 * 60_000);

      const repository = makeRepository({
        findQueuedJobsForDispatch: vi.fn().mockResolvedValue([
          {
            id: 'recovered-1',
            sourceType: TranslationSourceType.catalog,
            createdAt: recentCreatedAt,
            jobMeta: { attemptCount: 1, recoveredFromStall: true },
          },
          makeCandidate('fresh-1', TranslationSourceType.catalog, freshCreatedAt),
        ]),
      });
      const limiter = makeLimiter({
        getMetrics: vi
          .fn()
          .mockReturnValue({ activeCount: 0, maxConcurrency: 3 }),
      });
      const service = buildDispatch({ runner, repository, limiter });

      await service.dispatch('test');

      expect(scheduled[0]).toBe('fresh-1');
      expect(scheduled[1]).toBe('recovered-1');
    });

    it('a recovered job past the fairness threshold is promoted and dispatched with fresh jobs', async () => {
      const scheduled: string[] = [];
      const runner = makeRunner({
        schedule: vi.fn((id: string) => {
          scheduled.push(id);
        }),
      });

      const now = new Date('2026-01-01T12:00:00.000Z');
      // Aged recovered catalog job — 6 minutes old, exceeds 5-minute threshold
      const agedCreatedAt = new Date(now.getTime() - 6 * 60_000);
      // Fresh upload job — 1 minute old
      const uploadCreatedAt = new Date(now.getTime() - 60_000);

      const repository = makeRepository({
        findQueuedJobsForDispatch: vi.fn().mockResolvedValue([
          {
            id: 'recovered-aged',
            sourceType: TranslationSourceType.catalog,
            createdAt: agedCreatedAt,
            jobMeta: { attemptCount: 1, recoveredFromStall: true },
          },
          makeCandidate('upload-fresh', TranslationSourceType.upload, uploadCreatedAt),
        ]),
      });
      const limiter = makeLimiter({
        getMetrics: vi
          .fn()
          .mockReturnValue({ activeCount: 0, maxConcurrency: 3 }),
      });
      const service = buildDispatch({ runner, repository, limiter });

      await service.dispatch('test');

      // Aged recovered catalog (promoted to CATALOG=10) before fresh upload (UPLOAD=20)
      expect(scheduled[0]).toBe('recovered-aged');
      expect(scheduled[1]).toBe('upload-fresh');
    });
  });

  describe('trigger label passthrough', () => {
    it('completes without error for any trigger value', async () => {
      const service = buildDispatch();
      await expect(service.dispatch('startup')).resolves.not.toThrow();
      await expect(service.dispatch('poll')).resolves.not.toThrow();
      await expect(service.dispatch('job_created')).resolves.not.toThrow();
    });
  });
});
