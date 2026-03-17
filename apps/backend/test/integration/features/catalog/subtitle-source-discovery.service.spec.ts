import { ConfigService } from '@nestjs/config';

import { AppCacheService } from 'common/cache/app-cache.service';
import { SearchMediaType } from 'common/domain/enums/search-media-type.enum';
import { SubtitleProviderHealthService } from 'features/catalog/subtitle-provider-health.service';
import { SubtitleSourceDiscoveryService } from 'features/catalog/subtitle-source-discovery.service';
import { SubtitleSourceProvider } from 'features/catalog/ports/subtitle-source-provider.port';

describe('SubtitleSourceDiscoveryService integration', () => {
  const createConfigService = (overrides?: Record<string, unknown>) =>
    ({
      get: vi.fn((key: string) => {
        const defaults: Record<string, unknown> = {
          'subtitleSources.cacheTtlMs': 60_000,
          'subtitleSources.providerFailureThreshold': 3,
          'subtitleSources.providerCooldownMs': 60_000,
          'app.cacheDefaultTtlMs': 60_000,
          'app.cacheCleanupIntervalMs': 60_000,
          'app.cacheMaxEntries': 1000,
          ...overrides,
        };

        return defaults[key];
      }),
    }) as unknown as ConfigService;

  const media = {
    id: 'movie_27205',
    title: 'Inception',
    originalTitle: 'Inception',
    year: 2010,
    mediaType: SearchMediaType.Movie,
    providerMediaType: 'movie' as const,
    synopsis: 'A dream heist.',
    genres: ['Sci-Fi'],
    runtimeMinutes: 148,
    popularity: 9.4,
    tmdbId: 27205,
    imdbId: 'tt1375666',
  };

  const createProvider = (
    name: SubtitleSourceProvider['name'],
    searchSources: SubtitleSourceProvider['searchSources'],
  ): SubtitleSourceProvider => ({
    name,
    searchSources,
  });

  const createCandidate = (provider: SubtitleSourceProvider['name']) => ({
    provider,
    providerSubtitleId: `${provider}-1`,
    mediaTitle: 'Inception',
    mediaType: 'movie' as const,
    year: 2010,
    languageCode: 'en',
    languageName: 'English',
    releaseName: 'Inception 2010 BluRay',
    hearingImpaired: false,
    downloadCount: 100,
    providerRating: 4.2,
    sourcePageUrl: `https://${provider}.test/1`,
    score: 0,
    tmdbId: 27205,
    imdbId: 'tt1375666',
  });

  const createHealthService = (overrides?: Record<string, unknown>) =>
    new SubtitleProviderHealthService(createConfigService(overrides));

  it('coalesces concurrent requests for the same canonical cache key', async () => {
    const cacheService = new AppCacheService(createConfigService());
    const subdlProvider = createProvider(
      'subdl',
      vi.fn().mockImplementation(async () => {
        await new Promise((resolve) => setTimeout(resolve, 10));
        return [createCandidate('subdl')];
      }),
    );

    const service = new SubtitleSourceDiscoveryService(
      cacheService,
      createConfigService(),
      [subdlProvider],
      createHealthService(),
    );

    const [first, second] = await Promise.all([
      service.discover(media),
      service.discover(media),
    ]);

    expect(subdlProvider.searchSources).toHaveBeenCalledTimes(1);
    expect(first).toEqual(second);
  });

  it('keeps working when one fallback provider fails but another succeeds', async () => {
    const cacheService = new AppCacheService(createConfigService());
    const service = new SubtitleSourceDiscoveryService(
      cacheService,
      createConfigService(),
      [
        createProvider('subdl', vi.fn().mockResolvedValue([])),
        createProvider(
          'podnapisi',
          vi.fn().mockRejectedValue(new Error('podnapisi offline')),
        ),
        createProvider(
          'tvsubs',
          vi.fn().mockResolvedValue([createCandidate('tvsubs')]),
        ),
      ],
      createHealthService(),
    );

    const results = await service.discover(media);

    expect(results).toHaveLength(1);
    expect(results[0]?.id).toContain('ssrc:tvsubs:');
  });

  it('skips an unhealthy primary provider and falls back to the next', async () => {
    const configService = createConfigService({
      'subtitleSources.providerFailureThreshold': 3,
    });
    const cacheService = new AppCacheService(configService);
    const healthService = new SubtitleProviderHealthService(configService);

    // Drive subdl's circuit open by recording 3 consecutive failures.
    healthService.recordFailure('subdl');
    healthService.recordFailure('subdl');
    healthService.recordFailure('subdl');

    const subdlProvider = createProvider(
      'subdl',
      vi.fn().mockResolvedValue([createCandidate('subdl')]),
    );
    const tvSubsProvider = createProvider(
      'tvsubs',
      vi.fn().mockResolvedValue([createCandidate('tvsubs')]),
    );

    const service = new SubtitleSourceDiscoveryService(
      cacheService,
      configService,
      [subdlProvider, tvSubsProvider],
      healthService,
    );

    const results = await service.discover(media);

    // subdl is open — must not be called even though it would succeed.
    expect(subdlProvider.searchSources).not.toHaveBeenCalled();
    // tvsubs is healthy and returns results.
    expect(tvSubsProvider.searchSources).toHaveBeenCalledTimes(1);
    expect(results).toHaveLength(1);
    expect(results[0]?.id).toContain('ssrc:tvsubs:');
  });

  it('recovers the primary provider after cooldown and uses it again', async () => {
    vi.useFakeTimers();
    const T0 = Date.now();

    const configService = createConfigService({
      'subtitleSources.providerFailureThreshold': 3,
      'subtitleSources.providerCooldownMs': 30_000,
      'subtitleSources.cacheTtlMs': 1, // effectively no caching so each discover() runs the loader
    });

    // Use a fresh cache so that each discover() call runs the loader.
    const healthService = new SubtitleProviderHealthService(configService);

    // Open subdl's circuit.
    healthService.recordFailure('subdl');
    healthService.recordFailure('subdl');
    healthService.recordFailure('subdl');

    const subdlProvider = createProvider(
      'subdl',
      vi.fn().mockResolvedValue([createCandidate('subdl')]),
    );

    const createFreshService = () =>
      new SubtitleSourceDiscoveryService(
        new AppCacheService(configService),
        configService,
        [subdlProvider],
        healthService,
      );

    // While circuit is open, subdl is skipped and no results are returned.
    const firstResult = await createFreshService().discover(media);
    expect(firstResult).toHaveLength(0);
    expect(subdlProvider.searchSources).not.toHaveBeenCalled();

    // Advance past the cooldown window so the circuit enters half_open.
    vi.setSystemTime(T0 + 30_001);

    const secondResult = await createFreshService().discover(media);
    // subdl is tried (half_open trial) and succeeds — results come back.
    expect(subdlProvider.searchSources).toHaveBeenCalledTimes(1);
    expect(secondResult).toHaveLength(1);

    vi.useRealTimers();
  });
});
