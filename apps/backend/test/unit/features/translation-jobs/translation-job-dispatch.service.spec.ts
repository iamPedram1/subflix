import { TranslationJobDispatchService } from 'features/translation-jobs/translation-job-dispatch.service';
import { TranslationJobExecutionLimiterService } from 'features/translation-jobs/translation-job-execution-limiter.service';
import { TranslationJobRunnerService } from 'features/translation-jobs/translation-job-runner.service';
import { TranslationJobsRepository } from 'features/translation-jobs/translation-jobs.repository';

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

const makeRepository = (
  overrides: Partial<{
    findNextQueuedJobs: ReturnType<typeof vi.fn>;
  }> = {},
): TranslationJobsRepository =>
  ({
    findNextQueuedJobs: vi.fn().mockResolvedValue([]),
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

const buildDispatch = ({
  limiter = makeLimiter(),
  repository = makeRepository(),
  runner = makeRunner(),
}: Partial<{
  limiter: TranslationJobExecutionLimiterService;
  repository: TranslationJobsRepository;
  runner: TranslationJobRunnerService;
}> = {}): TranslationJobDispatchService =>
  new TranslationJobDispatchService(repository, limiter, runner);

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

describe('TranslationJobDispatchService', () => {
  describe('dispatch — capacity checks', () => {
    it('does not query the DB when all slots are in use', async () => {
      const repository = makeRepository();
      const limiter = makeLimiter({
        getMetrics: vi.fn().mockReturnValue({ activeCount: 3, maxConcurrency: 3 }),
      });
      const service = buildDispatch({ limiter, repository });

      await service.dispatch('test');

      expect(repository.findNextQueuedJobs).not.toHaveBeenCalled();
    });

    it('does not schedule any jobs when all slots are in use', async () => {
      const runner = makeRunner();
      const limiter = makeLimiter({
        getMetrics: vi.fn().mockReturnValue({ activeCount: 3, maxConcurrency: 3 }),
      });
      const service = buildDispatch({ limiter, runner });

      await service.dispatch('test');

      expect(runner.schedule).not.toHaveBeenCalled();
    });
  });

  describe('dispatch — no queued jobs', () => {
    it('does not schedule any jobs when the repository returns empty', async () => {
      const runner = makeRunner();
      const repository = makeRepository({
        findNextQueuedJobs: vi.fn().mockResolvedValue([]),
      });
      const service = buildDispatch({ runner, repository });

      await service.dispatch('test');

      expect(runner.schedule).not.toHaveBeenCalled();
    });

    it('queries the repository even when there are available slots', async () => {
      const repository = makeRepository({
        findNextQueuedJobs: vi.fn().mockResolvedValue([]),
      });
      const limiter = makeLimiter({
        getMetrics: vi.fn().mockReturnValue({ activeCount: 0, maxConcurrency: 3 }),
      });
      const service = buildDispatch({ repository, limiter });

      await service.dispatch('test');

      expect(repository.findNextQueuedJobs).toHaveBeenCalledWith(3);
    });
  });

  describe('dispatch — scheduling', () => {
    it('schedules each queued job returned by the repository', async () => {
      const runner = makeRunner();
      const repository = makeRepository({
        findNextQueuedJobs: vi.fn().mockResolvedValue([
          { id: 'job-a' },
          { id: 'job-b' },
        ]),
      });
      const limiter = makeLimiter({
        getMetrics: vi.fn().mockReturnValue({ activeCount: 1, maxConcurrency: 3 }),
      });
      const service = buildDispatch({ runner, repository, limiter });

      await service.dispatch('test');

      expect(runner.schedule).toHaveBeenCalledTimes(2);
      expect(runner.schedule).toHaveBeenCalledWith('job-a');
      expect(runner.schedule).toHaveBeenCalledWith('job-b');
    });

    it('requests exactly the number of available slots from the repository', async () => {
      const repository = makeRepository({
        findNextQueuedJobs: vi.fn().mockResolvedValue([]),
      });
      const limiter = makeLimiter({
        getMetrics: vi.fn().mockReturnValue({ activeCount: 1, maxConcurrency: 3 }),
      });
      const service = buildDispatch({ repository, limiter });

      await service.dispatch('test');

      expect(repository.findNextQueuedJobs).toHaveBeenCalledWith(2);
    });

    it('schedules only one job when only one slot is available', async () => {
      const runner = makeRunner();
      const repository = makeRepository({
        findNextQueuedJobs: vi.fn().mockResolvedValue([{ id: 'job-only' }]),
      });
      const limiter = makeLimiter({
        getMetrics: vi.fn().mockReturnValue({ activeCount: 2, maxConcurrency: 3 }),
      });
      const service = buildDispatch({ runner, repository, limiter });

      await service.dispatch('test');

      expect(runner.schedule).toHaveBeenCalledTimes(1);
      expect(runner.schedule).toHaveBeenCalledWith('job-only');
    });
  });

  describe('dispatch — dispatch order', () => {
    it('schedules jobs in the order returned by the repository (oldest first)', async () => {
      const scheduled: string[] = [];
      const runner = makeRunner({
        schedule: vi.fn((id: string) => { scheduled.push(id); }),
      });
      const repository = makeRepository({
        findNextQueuedJobs: vi.fn().mockResolvedValue([
          { id: 'job-oldest' },
          { id: 'job-middle' },
          { id: 'job-newest' },
        ]),
      });
      const limiter = makeLimiter({
        getMetrics: vi.fn().mockReturnValue({ activeCount: 0, maxConcurrency: 3 }),
      });
      const service = buildDispatch({ runner, repository, limiter });

      await service.dispatch('test');

      expect(scheduled).toEqual(['job-oldest', 'job-middle', 'job-newest']);
    });
  });

  describe('dispatch — trigger label is passed through', () => {
    it('completes without error for any trigger value', async () => {
      const service = buildDispatch();
      await expect(service.dispatch('startup')).resolves.not.toThrow();
      await expect(service.dispatch('poll')).resolves.not.toThrow();
      await expect(service.dispatch('job_created')).resolves.not.toThrow();
    });
  });
});
