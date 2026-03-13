import { ConfigService } from '@nestjs/config';

import { AppCacheService } from 'src/common/cache/app-cache.service';

describe('AppCacheService', () => {
  const createConfigService = () =>
    ({
      get: vi.fn((key: string) => {
        if (key === 'app.cacheDefaultTtlMs') {
          return 1_000;
        }

        if (key === 'app.cacheCleanupIntervalMs') {
          return 60_000;
        }

        if (key === 'app.cacheMaxEntries') {
          return 2;
        }

        return undefined;
      }),
    }) as unknown as ConfigService;

  it('coalesces concurrent loaders for the same key', async () => {
    const service = new AppCacheService(createConfigService());
    const loader = vi.fn(async () => ({ value: 'cached' }));

    const [first, second] = await Promise.all([
      service.getOrSet('key', loader),
      service.getOrSet('key', loader),
    ]);

    expect(loader).toHaveBeenCalledTimes(1);
    expect(first).toEqual({ value: 'cached' });
    expect(second).toEqual({ value: 'cached' });
  });

  it('evicts by prefix without touching other namespaces', () => {
    const service = new AppCacheService(createConfigService());

    service.set('catalog:search:dune', ['dune']);
    service.set('preferences:device-1', { theme: 'dark' });
    service.deleteByPrefix('catalog:');

    expect(service.get('catalog:search:dune')).toBeUndefined();
    expect(service.get('preferences:device-1')).toEqual({ theme: 'dark' });
  });
});
