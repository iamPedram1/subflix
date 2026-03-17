import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest';

import { ConfigService } from '@nestjs/config';

import { TranslationJobRecoverySchedulerService } from 'features/translation-jobs/translation-job-recovery-scheduler.service';
import { TranslationJobRecoveryService } from 'features/translation-jobs/translation-job-recovery.service';

const RECOVERY_INTERVAL_MS = 60_000;

const createConfigService = (
  overrides: Record<string, unknown> = {},
): ConfigService =>
  ({
    get: vi.fn((key: string) => {
      const defaults: Record<string, unknown> = {
        'translationJobs.recoveryEnabled': true,
        'translationJobs.startupRecoveryEnabled': true,
        'translationJobs.recoveryIntervalMs': RECOVERY_INTERVAL_MS,
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

const createScheduler = (
  recoveryService = createRecoveryService(),
  config = createConfigService(),
) => new TranslationJobRecoverySchedulerService(recoveryService, config);

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
      const scheduler = createScheduler(
        recovery,
        createConfigService({ 'translationJobs.recoveryEnabled': false }),
      );

      await scheduler.onApplicationBootstrap();

      expect(recovery.recoverStalledJobs).not.toHaveBeenCalled();
    });

    it('does not start the recovery interval when recoveryEnabled is false', async () => {
      const recovery = createRecoveryService();
      const scheduler = createScheduler(
        recovery,
        createConfigService({ 'translationJobs.recoveryEnabled': false }),
      );

      await scheduler.onApplicationBootstrap();
      await vi.advanceTimersByTimeAsync(RECOVERY_INTERVAL_MS * 2);

      expect(recovery.recoverStalledJobs).not.toHaveBeenCalled();
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
        createConfigService({
          'translationJobs.startupRecoveryEnabled': false,
        }),
      );

      await scheduler.onApplicationBootstrap();
      await vi.advanceTimersByTimeAsync(RECOVERY_INTERVAL_MS);

      expect(recovery.recoverStalledJobs).toHaveBeenCalledTimes(1);
    });

    it('fires the interval multiple times over its lifespan', async () => {
      const recovery = createRecoveryService();
      const scheduler = createScheduler(
        recovery,
        createConfigService({
          'translationJobs.startupRecoveryEnabled': false,
        }),
      );

      await scheduler.onApplicationBootstrap();
      await vi.advanceTimersByTimeAsync(RECOVERY_INTERVAL_MS * 3);

      expect(recovery.recoverStalledJobs).toHaveBeenCalledTimes(3);
    });
  });

  describe('onApplicationShutdown', () => {
    it('stops the recovery interval', async () => {
      const recovery = createRecoveryService();
      const scheduler = createScheduler(
        recovery,
        createConfigService({
          'translationJobs.startupRecoveryEnabled': false,
        }),
      );

      await scheduler.onApplicationBootstrap();
      scheduler.onApplicationShutdown();

      await vi.advanceTimersByTimeAsync(RECOVERY_INTERVAL_MS * 3);

      expect(recovery.recoverStalledJobs).not.toHaveBeenCalled();
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
        createConfigService({
          'translationJobs.startupRecoveryEnabled': false,
        }),
      );

      await scheduler.onApplicationBootstrap();
      await vi.advanceTimersByTimeAsync(RECOVERY_INTERVAL_MS * 2);

      expect(recovery.recoverStalledJobs).toHaveBeenCalledTimes(2);
    });
  });
});
