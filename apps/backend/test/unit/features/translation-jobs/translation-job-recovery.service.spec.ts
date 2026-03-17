import { ConfigService } from '@nestjs/config';

import { TranslationJobRecoveryService } from 'features/translation-jobs/translation-job-recovery.service';
import { TranslationJobRunnerService } from 'features/translation-jobs/translation-job-runner.service';
import { TranslationJobsRepository } from 'features/translation-jobs/translation-jobs.repository';

const T0 = new Date('2024-01-01T12:00:00.000Z');
const STALE_AFTER_MS = 5 * 60_000; // 5 minutes
const MAX_ATTEMPTS = 3;

const createConfigService = (overrides?: Record<string, unknown>) =>
  ({
    get: vi.fn((key: string) => {
      const defaults: Record<string, unknown> = {
        'translationJobs.staleAfterMs': STALE_AFTER_MS,
        'translationJobs.maxAttempts': MAX_ATTEMPTS,
        'translationJobs.recoveryEnabled': true,
        ...overrides,
      };
      return defaults[key];
    }),
  }) as unknown as ConfigService;

const createStalledJob = (
  overrides: Partial<{
    id: string;
    attemptCount: number;
  }> = {},
) => ({
  id: overrides.id ?? 'job-stalled-1',
  clientDeviceId: 'device-1',
  jobMeta: { attemptCount: overrides.attemptCount ?? 1 },
  updatedAt: new Date(T0.getTime() - STALE_AFTER_MS - 1_000),
  startedAt: new Date(T0.getTime() - STALE_AFTER_MS - 2_000),
});

const createRepository = (
  overrides: Partial<{
    findStalledJobs: ReturnType<typeof vi.fn>;
    requeueStalledJob: ReturnType<typeof vi.fn>;
    failStalledJob: ReturnType<typeof vi.fn>;
  }> = {},
): TranslationJobsRepository =>
  ({
    findStalledJobs: vi.fn().mockResolvedValue([]),
    requeueStalledJob: vi.fn().mockResolvedValue(true),
    failStalledJob: vi.fn().mockResolvedValue(true),
    ...overrides,
  }) as unknown as TranslationJobsRepository;

const createRunner = (): TranslationJobRunnerService =>
  ({
    schedule: vi.fn(),
  }) as unknown as TranslationJobRunnerService;

const createService = (
  repo = createRepository(),
  runner = createRunner(),
  config = createConfigService(),
) => new TranslationJobRecoveryService(repo, runner, config);

describe('TranslationJobRecoveryService', () => {
  describe('recoverStalledJobs', () => {
    it('returns zeros without querying when recovery is disabled', async () => {
      const repo = createRepository();
      const service = createService(
        repo,
        createRunner(),
        createConfigService({ 'translationJobs.recoveryEnabled': false }),
      );

      const result = await service.recoverStalledJobs(T0);

      expect(result).toEqual({ requeued: 0, failed: 0, scanned: 0 });
      expect(repo.findStalledJobs).not.toHaveBeenCalled();
    });

    it('returns zeros when no stalled jobs exist', async () => {
      const service = createService();
      const result = await service.recoverStalledJobs(T0);
      expect(result).toEqual({ requeued: 0, failed: 0, scanned: 0 });
    });

    it('requeues a stalled job below maxAttempts', async () => {
      const stalledJob = createStalledJob({ attemptCount: 1 });
      const repo = createRepository({
        findStalledJobs: vi.fn().mockResolvedValue([stalledJob]),
      });
      const runner = createRunner();
      const service = createService(repo, runner);

      const result = await service.recoverStalledJobs(T0);

      expect(result.requeued).toBe(1);
      expect(result.failed).toBe(0);
      expect(repo.requeueStalledJob).toHaveBeenCalledWith(
        stalledJob.id,
        expect.objectContaining({ recoveredFromStall: true }),
      );
      expect(runner.schedule).toHaveBeenCalledWith(stalledJob.id);
    });

    it('fails a stalled job that has reached maxAttempts', async () => {
      const stalledJob = createStalledJob({ attemptCount: MAX_ATTEMPTS });
      const repo = createRepository({
        findStalledJobs: vi.fn().mockResolvedValue([stalledJob]),
      });

      const result = await createService(repo).recoverStalledJobs(T0);

      expect(result.requeued).toBe(0);
      expect(result.failed).toBe(1);
      expect(repo.failStalledJob).toHaveBeenCalledWith(
        stalledJob.id,
        expect.objectContaining({
          lastFailureReasonCode: 'stall_recovery_exhausted',
        }),
        expect.any(String),
      );
    });

    it('does not schedule the runner for a failed job', async () => {
      const stalledJob = createStalledJob({ attemptCount: MAX_ATTEMPTS });
      const repo = createRepository({
        findStalledJobs: vi.fn().mockResolvedValue([stalledJob]),
      });
      const runner = createRunner();

      await createService(repo, runner).recoverStalledJobs(T0);

      expect(runner.schedule).not.toHaveBeenCalled();
    });

    it('handles multiple stalled jobs independently', async () => {
      const belowLimit = createStalledJob({ id: 'job-1', attemptCount: 1 });
      const atLimit = createStalledJob({ id: 'job-2', attemptCount: MAX_ATTEMPTS });
      const repo = createRepository({
        findStalledJobs: vi.fn().mockResolvedValue([belowLimit, atLimit]),
      });
      const runner = createRunner();

      const result = await createService(repo, runner).recoverStalledJobs(T0);

      expect(result.requeued).toBe(1);
      expect(result.failed).toBe(1);
      expect(result.scanned).toBe(2);
      expect(runner.schedule).toHaveBeenCalledTimes(1);
      expect(runner.schedule).toHaveBeenCalledWith('job-1');
    });

    it('skips a job when the DB update returns false (concurrent recovery)', async () => {
      const stalledJob = createStalledJob({ attemptCount: 1 });
      const repo = createRepository({
        findStalledJobs: vi.fn().mockResolvedValue([stalledJob]),
        requeueStalledJob: vi.fn().mockResolvedValue(false),
      });
      const runner = createRunner();

      const result = await createService(repo, runner).recoverStalledJobs(T0);

      expect(result.requeued).toBe(0);
      expect(runner.schedule).not.toHaveBeenCalled();
    });

    it('passes the correct staleBeforeDate to the repository', async () => {
      const repo = createRepository();
      const service = createService(repo);
      const now = T0;

      await service.recoverStalledJobs(now);

      const expectedCutoff = new Date(now.getTime() - STALE_AFTER_MS);
      expect(repo.findStalledJobs).toHaveBeenCalledWith(
        expect.objectContaining({ staleBeforeDate: expectedCutoff }),
      );
    });

    it('treats a job with null jobMeta as zero attempts (first ever attempt)', async () => {
      const stalledJob = {
        id: 'job-fresh',
        clientDeviceId: 'device-1',
        jobMeta: null,
        updatedAt: new Date(T0.getTime() - STALE_AFTER_MS - 1_000),
        startedAt: new Date(T0.getTime() - STALE_AFTER_MS - 2_000),
      };
      const repo = createRepository({
        findStalledJobs: vi.fn().mockResolvedValue([stalledJob]),
      });

      const result = await createService(repo).recoverStalledJobs(T0);
      expect(result.requeued).toBe(1);
    });
  });
});
