import { ConfigService } from '@nestjs/config';

import { RateLimitService } from 'common/rate-limit/rate-limit.service';

describe('RateLimitService', () => {
  it('blocks requests after the configured limit and resets after the window', () => {
    vi.useFakeTimers();

    const service = new RateLimitService({
      get: vi.fn().mockReturnValue(60_000),
    } as unknown as ConfigService);

    const first = service.consume({
      key: 'catalog-search:actor',
      limit: 2,
      windowMs: 1_000,
    });
    const second = service.consume({
      key: 'catalog-search:actor',
      limit: 2,
      windowMs: 1_000,
    });
    const third = service.consume({
      key: 'catalog-search:actor',
      limit: 2,
      windowMs: 1_000,
    });

    expect(first.allowed).toBe(true);
    expect(first.remaining).toBe(1);
    expect(second.allowed).toBe(true);
    expect(second.remaining).toBe(0);
    expect(third.allowed).toBe(false);
    expect(third.retryAfterSeconds).toBeGreaterThan(0);

    vi.advanceTimersByTime(1_100);

    const afterReset = service.consume({
      key: 'catalog-search:actor',
      limit: 2,
      windowMs: 1_000,
    });

    expect(afterReset.allowed).toBe(true);
    expect(afterReset.remaining).toBe(1);

    service.onModuleDestroy();
    vi.useRealTimers();
  });

  it('cleans up expired buckets', () => {
    vi.useFakeTimers();

    const service = new RateLimitService({
      get: vi.fn().mockReturnValue(100),
    } as unknown as ConfigService);

    service.onModuleInit();
    service.consume({ key: 'preview:actor', limit: 1, windowMs: 50 });
    expect(service.getBucketCount()).toBe(1);

    vi.advanceTimersByTime(200);

    expect(service.getBucketCount()).toBe(0);

    service.onModuleDestroy();
    vi.useRealTimers();
  });
});
