import { ConfigService } from '@nestjs/config';

import { AppCacheService } from 'src/common/cache/app-cache.service';
import { ServiceUnavailableDomainError } from 'src/common/domain/errors/domain.error';
import { SearchMediaType } from 'src/common/domain/enums/search-media-type.enum';
import { SubtitleSourceDiscoveryService } from 'src/features/catalog/subtitle-source-discovery.service';
import { SubtitleSourceProvider } from 'src/features/catalog/ports/subtitle-source-provider.port';

describe('SubtitleSourceDiscoveryService', () => {
  const createConfigService = (overrides?: Record<string, unknown>) =>
    ({
      get: vi.fn((key: string) => {
        const defaults: Record<string, unknown> = {
          'subtitleSources.cacheTtlMs': 60_000,
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
    providerRating: 4.5,
    sourcePageUrl: `https://${provider}.test/1`,
    score: 0,
    tmdbId: 27205,
    imdbId: 'tt1375666',
  });

  const createProvider = (
    name: SubtitleSourceProvider['name'],
    searchSources: SubtitleSourceProvider['searchSources'],
  ): SubtitleSourceProvider => ({
    name,
    searchSources,
  });

  const createCacheService = () => new AppCacheService(createConfigService());

  it('stops at SubDL when the primary provider returns results', async () => {
    const subdlProvider = createProvider(
      'subdl',
      vi.fn().mockResolvedValue([createCandidate('subdl')]),
    );
    const podnapisiProvider = createProvider(
      'podnapisi',
      vi.fn().mockResolvedValue([createCandidate('podnapisi')]),
    );
    const tvSubsProvider = createProvider(
      'tvsubs',
      vi.fn().mockResolvedValue([createCandidate('tvsubs')]),
    );

    const service = new SubtitleSourceDiscoveryService(
      createCacheService(),
      createConfigService(),
      [subdlProvider, podnapisiProvider, tvSubsProvider],
    );

    const results = await service.discover(media);

    expect(results).toHaveLength(1);
    expect(subdlProvider.searchSources).toHaveBeenCalledTimes(1);
    expect(podnapisiProvider.searchSources).not.toHaveBeenCalled();
    expect(tvSubsProvider.searchSources).not.toHaveBeenCalled();
  });

  it('falls back to scraper providers when SubDL throws and keeps successful results', async () => {
    const subdlProvider = createProvider(
      'subdl',
      vi.fn().mockRejectedValue(new Error('boom')),
    );
    const podnapisiProvider = createProvider(
      'podnapisi',
      vi.fn().mockResolvedValue([]),
    );
    const tvSubsProvider = createProvider(
      'tvsubs',
      vi.fn().mockResolvedValue([createCandidate('tvsubs')]),
    );

    const service = new SubtitleSourceDiscoveryService(
      createCacheService(),
      createConfigService(),
      [subdlProvider, podnapisiProvider, tvSubsProvider],
    );

    const results = await service.discover(media);

    expect(results).toHaveLength(1);
    expect(subdlProvider.searchSources).toHaveBeenCalledTimes(1);
    expect(podnapisiProvider.searchSources).toHaveBeenCalledTimes(1);
    expect(tvSubsProvider.searchSources).toHaveBeenCalledTimes(1);
  });

  it('returns an empty list when providers succeed but find nothing', async () => {
    const service = new SubtitleSourceDiscoveryService(
      createCacheService(),
      createConfigService(),
      [
        createProvider('subdl', vi.fn().mockResolvedValue([])),
        createProvider('podnapisi', vi.fn().mockResolvedValue([])),
        createProvider('tvsubs', vi.fn().mockResolvedValue([])),
      ],
    );

    await expect(service.discover(media)).resolves.toEqual([]);
  });

  it('throws service unavailable only when every provider fails meaningfully', async () => {
    const service = new SubtitleSourceDiscoveryService(
      createCacheService(),
      createConfigService(),
      [
        createProvider(
          'subdl',
          vi.fn().mockRejectedValue(new Error('subdl down')),
        ),
        createProvider(
          'podnapisi',
          vi.fn().mockRejectedValue(new Error('podnapisi down')),
        ),
        createProvider(
          'tvsubs',
          vi.fn().mockRejectedValue(new Error('tvsubs down')),
        ),
      ],
    );

    await expect(service.discover(media)).rejects.toBeInstanceOf(
      ServiceUnavailableDomainError,
    );
  });

  it('rejects movie lookups that include season or episode filters', async () => {
    const service = new SubtitleSourceDiscoveryService(
      createCacheService(),
      createConfigService(),
      [createProvider('subdl', vi.fn().mockResolvedValue([]))],
    );

    await expect(
      service.discover(media, {
        preferredLanguage: 'en',
        seasonNumber: 1,
        episodeNumber: 1,
      }),
    ).rejects.toThrow('seasonNumber and episodeNumber are only supported');
  });
});
