import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest';

import { ConfigService } from '@nestjs/config';

import { TranslationJobDispatchService } from 'features/translation-jobs/translation-job-dispatch.service';
import { TranslationJobRecoverySchedulerService } from 'features/translation-jobs/translation-job-recovery-scheduler.service';
import { TranslationJobRecoveryService } from 'features/translation-jobs/translation-job-recovery.service';

const RECOVERY_INTERVAL_MS = 60_000;
const DISPATCH_POLL_INTERVAL_MS = 10_000;

const createConfigService = (
  overrides: Record<string, unknown> = {},
): ConfigService =>
  ({
    get: vi.fn((key: string) => {
      const defaults: Record<string, unknown> = {
        'translationJobs.recoveryEnabled': true,
        'translationJobs.startupRecoveryEnabled': true,
        'translationJobs.recoveryIntervalMs': RECOVERY_INTERVAL_MS,
        'translationJobs.dispatchOnStartupEnabled': true,
        'translationJobs.dispatchPollIntervalMs': DISPATCH_POLL_INTERVAL_MS,
        ...overrides,
      };
      return defaults[key];
    }),
  }) as unknown as ConfigService;

const createRecoveryService = (
  overrides: Partial<Record<keyof TranslationJobRecoveryService, unknown>> = {},
): TranslationJobRecoveryService =>
  ({
    recoverStalledJobs: vi
      .fn()
      .mockResolvedValue({ requeued: 0, failed: 0, scanned: 0 }),
    ...overrides,
  }) as unknown as TranslationJobRecoveryService;

const createDispatchService = (
  overrides: Partial<{ dispatch: ReturnType<typeof vi.fn> }> = {},
): TranslationJobDispatchService =>
  ({
    dispatch: vi.fn().mockResolvedValue(undefined),
    ...overrides,
  }) as unknown as TranslationJobDispatchService;

const createScheduler = (
  recoveryService = createRecoveryService(),
  dispatchService = createDispatchService(),
  config = createConfigService(),
) =>
  new TranslationJobRecoverySchedulerService(
    recoveryService,
    dispatchService,
    config,
  );

describe('TranslationJobRecoverySchedulerService', () => {
  beforeEach(() => {
    vi.useFakeTimers();
  });

  afterEach(() => {
    vi.useRealTimers();
  });

  describe('onApplicationBootstrap', () => {
    it('does nothing when recoveryEnabled is false', async () => {
      const recovery = createRecoveryService();
      const dispatch = createDispatchService();
      const scheduler = createScheduler(
        recovery,
        dispatch,
        createConfigService({ 'translationJobs.recoveryEnabled': false }),
      );

      await scheduler.onApplicationBootstrap();

      expect(recovery.recoverStalledJobs).not.toHaveBeenCalled();
      expect(dispatch.dispatch).not.toHaveBeenCalled();
    });

    it('does not start any interval when recoveryEnabled is false', async () => {
      const recovery = createRecoveryService();
      const dispatch = createDispatchService();
      const scheduler = createScheduler(
        recovery,
        dispatch,
        createConfigService({ 'translationJobs.recoveryEnabled': false }),
      );

      await scheduler.onApplicationBootstrap();
      await vi.advanceTimersByTimeAsync(RECOVERY_INTERVAL_MS * 2);

      expect(recovery.recoverStalledJobs).not.toHaveBeenCalled();
      expect(dispatch.dispatch).not.toHaveBeenCalled();
    });

    it('runs startup recovery when both recoveryEnabled and startupRecoveryEnabled are true', async () => {
      const recovery = createRecoveryService();
      const scheduler = createScheduler(recovery);

      await scheduler.onApplicationBootstrap();

      expect(recovery.recoverStalledJobs).toHaveBeenCalledTimes(1);
    });

    it('skips startup recovery when startupRecoveryEnabled is false', async () => {
      const recovery = createRecoveryService();
      const scheduler = createScheduler(
        recovery,
        createDispatchService(),
        createConfigService({
          'translationJobs.startupRecoveryEnabled': false,
        }),
      );

      await scheduler.onApplicationBootstrap();

      // startup pass was skipped — no immediate call
      expect(recovery.recoverStalledJobs).not.toHaveBeenCalled();
    });

    it('starts the recovery interval regardless of startupRecoveryEnabled', async () => {
      const recovery = createRecoveryService();
      const scheduler = createScheduler(
        recovery,
        createDispatchService(),
        createConfigService({
          'translationJobs.startupRecoveryEnabled': false,
        }),
      );

      await scheduler.onApplicationBootstrap();
      await vi.advanceTimersByTimeAsync(RECOVERY_INTERVAL_MS);

      expect(recovery.recoverStalledJobs).toHaveBeenCalledTimes(1);
    });

    it('fires the recovery interval multiple times over its lifespan', async () => {
      const recovery = createRecoveryService();
      const scheduler = createScheduler(
        recovery,
        createDispatchService(),
        createConfigService({
          'translationJobs.startupRecoveryEnabled': false,
        }),
      );

      await scheduler.onApplicationBootstrap();
      await vi.advanceTimersByTimeAsync(RECOVERY_INTERVAL_MS * 3);

      expect(recovery.recoverStalledJobs).toHaveBeenCalledTimes(3);
    });

    it('runs startup dispatch after startup recovery when dispatchOnStartupEnabled is true', async () => {
      const dispatch = createDispatchService();
      const scheduler = createScheduler(
        createRecoveryService(),
        dispatch,
      );

      await scheduler.onApplicationBootstrap();

      expect(dispatch.dispatch).toHaveBeenCalledWith('startup');
    });

    it('skips startup dispatch when dispatchOnStartupEnabled is false', async () => {
      const dispatch = createDispatchService();
      const scheduler = createScheduler(
        createRecoveryService(),
        dispatch,
        createConfigService({ 'translationJobs.dispatchOnStartupEnabled': false }),
      );

      await scheduler.onApplicationBootstrap();

      expect(dispatch.dispatch).not.toHaveBeenCalledWith('startup');
    });

    it('startup dispatch is called after startup recovery completes', async () => {
      const callOrder: string[] = [];
      const recovery = createRecoveryService({
        recoverStalledJobs: vi.fn().mockImplementation(async () => {
          callOrder.push('recovery');
          return { requeued: 0, failed: 0, scanned: 0 };
        }),
      });
      const dispatch = createDispatchService({
        dispatch: vi.fn().mockImplementation(async () => {
          callOrder.push('dispatch');
        }),
      });
      const scheduler = createScheduler(recovery, dispatch);

      await scheduler.onApplicationBootstrap();

      expect(callOrder).toEqual(['recovery', 'dispatch']);
    });

    it('starts the dispatch poll interval when dispatchPollIntervalMs > 0', async () => {
      const dispatch = createDispatchService();
      const scheduler = createScheduler(
        createRecoveryService(),
        dispatch,
        createConfigService({ 'translationJobs.dispatchOnStartupEnabled': false }),
      );

      await scheduler.onApplicationBootstrap();
      await vi.advanceTimersByTimeAsync(DISPATCH_POLL_INTERVAL_MS);

      // At least one poll cycle fired
      expect(dispatch.dispatch).toHaveBeenCalledWith('poll');
    });

    it('fires the dispatch poll interval multiple times', async () => {
      const dispatch = createDispatchService();
      const scheduler = createScheduler(
        createRecoveryService(),
        dispatch,
        createConfigService({ 'translationJobs.dispatchOnStartupEnabled': false }),
      );

      await scheduler.onApplicationBootstrap();
      await vi.advanceTimersByTimeAsync(DISPATCH_POLL_INTERVAL_MS * 3);

      const pollCalls = (dispatch.dispatch as ReturnType<typeof vi.fn>).mock.calls.filter(
        ([trigger]) => trigger === 'poll',
      );
      expect(pollCalls).toHaveLength(3);
    });

    it('does not start the dispatch poll interval when dispatchPollIntervalMs is 0', async () => {
      const dispatch = createDispatchService();
      const scheduler = createScheduler(
        createRecoveryService(),
        dispatch,
        createConfigService({
          'translationJobs.dispatchOnStartupEnabled': false,
          'translationJobs.dispatchPollIntervalMs': 0,
        }),
      );

      await scheduler.onApplicationBootstrap();
      await vi.advanceTimersByTimeAsync(60_000);

      expect(dispatch.dispatch).not.toHaveBeenCalledWith('poll');
    });
  });

  describe('onApplicationShutdown', () => {
    it('stops the recovery interval', async () => {
      const recovery = createRecoveryService();
      const scheduler = createScheduler(
        recovery,
        createDispatchService(),
        createConfigService({
          'translationJobs.startupRecoveryEnabled': false,
        }),
      );

      await scheduler.onApplicationBootstrap();
      scheduler.onApplicationShutdown();

      await vi.advanceTimersByTimeAsync(RECOVERY_INTERVAL_MS * 3);

      expect(recovery.recoverStalledJobs).not.toHaveBeenCalled();
    });

    it('stops the dispatch poll interval', async () => {
      const dispatch = createDispatchService();
      const scheduler = createScheduler(
        createRecoveryService(),
        dispatch,
        createConfigService({ 'translationJobs.dispatchOnStartupEnabled': false }),
      );

      await scheduler.onApplicationBootstrap();
      scheduler.onApplicationShutdown();

      await vi.advanceTimersByTimeAsync(DISPATCH_POLL_INTERVAL_MS * 3);

      expect(dispatch.dispatch).not.toHaveBeenCalledWith('poll');
    });

    it('is safe to call when no interval was started', () => {
      const scheduler = createScheduler();
      expect(() => scheduler.onApplicationShutdown()).not.toThrow();
    });
  });

  describe('startup recovery error handling', () => {
    it('handles errors from the recovery service without throwing', async () => {
      const recovery = createRecoveryService({
        recoverStalledJobs: vi
          .fn()
          .mockRejectedValue(new Error('DB unavailable during startup')),
      });
      const scheduler = createScheduler(recovery);

      await expect(scheduler.onApplicationBootstrap()).resolves.not.toThrow();
    });

    it('continues to start the interval even after startup recovery fails', async () => {
      let callCount = 0;
      const recovery = createRecoveryService({
        recoverStalledJobs: vi.fn().mockImplementation(() => {
          callCount++;
          if (callCount === 1) {
            return Promise.reject(new Error('startup failure'));
          }
          return Promise.resolve({ requeued: 0, failed: 0, scanned: 0 });
        }),
      });
      const scheduler = createScheduler(recovery);

      await scheduler.onApplicationBootstrap();
      await vi.advanceTimersByTimeAsync(RECOVERY_INTERVAL_MS);

      // startup (failed) + 1 interval cycle
      expect(recovery.recoverStalledJobs).toHaveBeenCalledTimes(2);
    });

    it('handles errors from startup dispatch without throwing', async () => {
      const dispatch = createDispatchService({
        dispatch: vi.fn().mockRejectedValue(new Error('dispatch failed')),
      });
      const scheduler = createScheduler(createRecoveryService(), dispatch);

      await expect(scheduler.onApplicationBootstrap()).resolves.not.toThrow();
    });
  });

  describe('recovery cycle error handling', () => {
    it('handles errors from the recovery service without throwing', async () => {
      const recovery = createRecoveryService({
        recoverStalledJobs: vi
          .fn()
          .mockRejectedValue(new Error('DB offline during cycle')),
      });
      const scheduler = createScheduler(
        recovery,
        createDispatchService(),
        createConfigService({
          'translationJobs.startupRecoveryEnabled': false,
        }),
      );

      await scheduler.onApplicationBootstrap();

      await expect(
        vi.advanceTimersByTimeAsync(RECOVERY_INTERVAL_MS),
      ).resolves.not.toThrow();
    });

    it('continues cycling after a failed cycle', async () => {
      let callCount = 0;
      const recovery = createRecoveryService({
        recoverStalledJobs: vi.fn().mockImplementation(() => {
          callCount++;
          if (callCount === 1) {
            return Promise.reject(new Error('transient failure'));
          }
          return Promise.resolve({ requeued: 0, failed: 0, scanned: 0 });
        }),
      });
      const scheduler = createScheduler(
        recovery,
        createDispatchService(),
        createConfigService({
          'translationJobs.startupRecoveryEnabled': false,
        }),
      );

      await scheduler.onApplicationBootstrap();
      await vi.advanceTimersByTimeAsync(RECOVERY_INTERVAL_MS * 2);

      expect(recovery.recoverStalledJobs).toHaveBeenCalledTimes(2);
    });

    it('handles errors from the dispatch poll cycle without throwing', async () => {
      const dispatch = createDispatchService({
        dispatch: vi.fn().mockRejectedValue(new Error('poll dispatch failed')),
      });
      const scheduler = createScheduler(
        createRecoveryService(),
        dispatch,
        createConfigService({ 'translationJobs.dispatchOnStartupEnabled': false }),
      );

      await scheduler.onApplicationBootstrap();

      await expect(
        vi.advanceTimersByTimeAsync(DISPATCH_POLL_INTERVAL_MS),
      ).resolves.not.toThrow();
    });
  });
});
