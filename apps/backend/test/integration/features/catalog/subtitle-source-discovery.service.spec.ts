import { ConfigService } from '@nestjs/config';

import { AppCacheService } from 'src/common/cache/app-cache.service';
import { SearchMediaType } from 'src/common/domain/enums/search-media-type.enum';
import { SubtitleSourceDiscoveryService } from 'src/features/catalog/subtitle-source-discovery.service';
import { SubtitleSourceProvider } from 'src/features/catalog/ports/subtitle-source-provider.port';

describe('SubtitleSourceDiscoveryService integration', () => {
  const createConfigService = (overrides?: Record<string, unknown>) =>
    ({
      get: vi.fn((key: string) => {
        const defaults: Record<string, unknown> = {
          'subtitleSources.cacheTtlMs': 60_000,
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
    );

    const results = await service.discover(media);

    expect(results).toHaveLength(1);
    expect(results[0]?.id).toContain('ssrc:tvsubs:');
  });
});
