import { describe, expect, it } from 'vitest';

import { ConfigService } from '@nestjs/config';

import { TranslationJobExecutionLimiterService } from 'features/translation-jobs/translation-job-execution-limiter.service';

const MAX_CONCURRENCY = 3;

const makeConfigService = (
  overrides: Record<string, unknown> = {},
): ConfigService =>
  ({
    get: vi.fn((key: string) => {
      const defaults: Record<string, unknown> = {
        'translationJobs.maxConcurrency': MAX_CONCURRENCY,
        ...overrides,
      };
      return defaults[key];
    }),
  }) as unknown as ConfigService;

const makeLimiter = (config = makeConfigService()) =>
  new TranslationJobExecutionLimiterService(config);

describe('TranslationJobExecutionLimiterService', () => {
  describe('tryAcquireSlot', () => {
    it('acquires a slot when capacity is available', () => {
      const limiter = makeLimiter();
      expect(limiter.tryAcquireSlot('job-1')).toBe(true);
    });

    it('acquires multiple slots up to maxConcurrency', () => {
      const limiter = makeLimiter();
      expect(limiter.tryAcquireSlot('job-1')).toBe(true);
      expect(limiter.tryAcquireSlot('job-2')).toBe(true);
      expect(limiter.tryAcquireSlot('job-3')).toBe(true);
    });

    it('refuses a slot when maxConcurrency is reached', () => {
      const limiter = makeLimiter();
      limiter.tryAcquireSlot('job-1');
      limiter.tryAcquireSlot('job-2');
      limiter.tryAcquireSlot('job-3');

      expect(limiter.tryAcquireSlot('job-4')).toBe(false);
    });

    it('allows slot acquisition again after a slot is released', () => {
      const limiter = makeLimiter();
      limiter.tryAcquireSlot('job-1');
      limiter.tryAcquireSlot('job-2');
      limiter.tryAcquireSlot('job-3');
      expect(limiter.tryAcquireSlot('job-4')).toBe(false);

      limiter.releaseSlot('job-1');

      expect(limiter.tryAcquireSlot('job-4')).toBe(true);
    });

    it('increments activeCount on each successful acquisition', () => {
      const limiter = makeLimiter();
      limiter.tryAcquireSlot('job-1');
      expect(limiter.getMetrics().activeCount).toBe(1);
      limiter.tryAcquireSlot('job-2');
      expect(limiter.getMetrics().activeCount).toBe(2);
    });

    it('does not increment activeCount when capacity is full', () => {
      const limiter = makeLimiter();
      limiter.tryAcquireSlot('job-1');
      limiter.tryAcquireSlot('job-2');
      limiter.tryAcquireSlot('job-3');
      limiter.tryAcquireSlot('job-4'); // refused

      expect(limiter.getMetrics().activeCount).toBe(3);
    });

    it('works correctly with maxConcurrency of 1', () => {
      const limiter = makeLimiter(
        makeConfigService({ 'translationJobs.maxConcurrency': 1 }),
      );
      expect(limiter.tryAcquireSlot('job-1')).toBe(true);
      expect(limiter.tryAcquireSlot('job-2')).toBe(false);
    });
  });

  describe('releaseSlot', () => {
    it('decrements activeCount on release', () => {
      const limiter = makeLimiter();
      limiter.tryAcquireSlot('job-1');
      expect(limiter.getMetrics().activeCount).toBe(1);

      limiter.releaseSlot('job-1');

      expect(limiter.getMetrics().activeCount).toBe(0);
    });

    it('does not go below zero on extra releases', () => {
      const limiter = makeLimiter();
      limiter.releaseSlot('job-1'); // no slot was acquired

      expect(limiter.getMetrics().activeCount).toBe(0);
    });

    it('keeps the counter consistent across multiple acquire/release cycles', () => {
      const limiter = makeLimiter();

      limiter.tryAcquireSlot('job-1');
      limiter.tryAcquireSlot('job-2');
      limiter.releaseSlot('job-1');
      limiter.tryAcquireSlot('job-3');
      limiter.releaseSlot('job-2');
      limiter.releaseSlot('job-3');

      expect(limiter.getMetrics().activeCount).toBe(0);
    });
  });

  describe('getMetrics', () => {
    it('returns activeCount 0 and correct maxConcurrency on a fresh instance', () => {
      const limiter = makeLimiter();
      expect(limiter.getMetrics()).toEqual({
        activeCount: 0,
        maxConcurrency: MAX_CONCURRENCY,
      });
    });

    it('reflects the current active count after acquisitions', () => {
      const limiter = makeLimiter();
      limiter.tryAcquireSlot('job-1');
      limiter.tryAcquireSlot('job-2');

      expect(limiter.getMetrics()).toEqual({
        activeCount: 2,
        maxConcurrency: MAX_CONCURRENCY,
      });
    });

    it('reflects the correct count after a release', () => {
      const limiter = makeLimiter();
      limiter.tryAcquireSlot('job-1');
      limiter.releaseSlot('job-1');

      expect(limiter.getMetrics()).toEqual({
        activeCount: 0,
        maxConcurrency: MAX_CONCURRENCY,
      });
    });
  });
});
