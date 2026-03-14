import { ConfigService } from '@nestjs/config';

import { AppCacheService } from 'common/cache/app-cache.service';
import { SearchMediaType } from 'common/domain/enums/search-media-type.enum';
import { CatalogMediaItem } from 'features/catalog/models/catalog-media-item.model';
import { MockCatalogProvider } from 'features/catalog/providers/mock-catalog.provider';
import { TmdbMediaCatalogProvider } from 'features/catalog/providers/tmdb-media-catalog.provider';

describe('TmdbMediaCatalogProvider', () => {
  const movieCacheTtlMs = 30 * 24 * 60 * 60_000;
  const seriesCacheTtlMs = 24 * 60 * 60_000;

  const createConfigService = (overrides?: Record<string, unknown>) =>
    ({
      get: vi.fn((key: string) => {
        const defaults: Record<string, unknown> = {
          'tmdb.apiBaseUrl': 'https://api.themoviedb.org/3',
          'tmdb.apiReadToken': 'test-token',
          'tmdb.movieSearchCacheTtlMs': movieCacheTtlMs,
          'tmdb.seriesSearchCacheTtlMs': seriesCacheTtlMs,
          'tmdb.movieDetailCacheTtlMs': movieCacheTtlMs,
          'tmdb.seriesDetailCacheTtlMs': seriesCacheTtlMs,
          'tmdb.includeAdult': false,
          'tmdb.defaultLanguage': 'en-US',
          ...overrides,
        };

        return defaults[key];
      }),
    }) as unknown as ConfigService;

  const createCacheService = () => {
    const entries = new Map<string, unknown>();
    const get = vi.fn((key: string) => entries.get(key));
    const set = vi.fn((key: string, value: unknown) => {
      entries.set(key, structuredClone(value));
      return value;
    });
    const getOrSet = vi.fn(
      async (key: string, loader: () => Promise<unknown>) => {
        const cached = entries.get(key);
        if (cached !== undefined) {
          return structuredClone(cached);
        }

        const value = await loader();
        entries.set(key, structuredClone(value));
        return value;
      },
    );

    return {
      service: {
        get,
        getOrSet,
        set,
      } as unknown as AppCacheService,
      get,
      getOrSet,
      set,
    };
  };

  beforeEach(() => {
    vi.restoreAllMocks();
  });

  it('uses TMDb multi search once and then serves the same query from cache', async () => {
    const cacheService = createCacheService();
    const fallbackProvider = {
      search: vi.fn(),
      findById: vi.fn(),
    } as unknown as MockCatalogProvider;

    const fetchMock = vi.fn().mockResolvedValue(
      new Response(
        JSON.stringify({
          results: [
            {
              id: 157336,
              media_type: 'movie',
              title: 'Interstellar',
              overview: 'A mission leaves Earth to search for a new home.',
              popularity: 88.123,
              genre_ids: [12, 878],
              release_date: '2014-11-05',
            },
            {
              id: 135157,
              media_type: 'tv',
              name: 'Interstellar Files',
              overview: 'A companion documentary series.',
              popularity: 21.345,
              genre_ids: [99],
              first_air_date: '2025-03-01',
            },
          ],
        }),
        {
          status: 200,
          headers: {
            'content-type': 'application/json',
          },
        },
      ),
    );
    vi.stubGlobal('fetch', fetchMock);

    const provider = new TmdbMediaCatalogProvider(
      cacheService.service,
      createConfigService(),
      fallbackProvider,
    );

    const firstResults = await provider.search('Interstellar');
    const secondResults = await provider.search(' Interstellar ');

    expect(fetchMock).toHaveBeenCalledTimes(1);
    expect(firstResults).toEqual(secondResults);
    expect(firstResults).toHaveLength(2);
    expect(firstResults[0]).toMatchObject({
      id: 'movie_157336',
      title: 'Interstellar',
      mediaType: SearchMediaType.Movie,
      genres: ['Adventure', 'Science Fiction'],
      runtimeMinutes: 120,
    } satisfies Partial<CatalogMediaItem>);
    expect(firstResults[1]).toMatchObject({
      id: 'series_135157',
      mediaType: SearchMediaType.Series,
      genres: ['Documentary'],
      runtimeMinutes: 45,
    } satisfies Partial<CatalogMediaItem>);
    expect(cacheService.set.mock.calls).toEqual(
      expect.arrayContaining([
        [
          'catalog:tmdb:search:movie:interstellar',
          expect.any(Array),
          movieCacheTtlMs,
        ],
        [
          'catalog:tmdb:search:series:interstellar',
          expect.any(Array),
          seriesCacheTtlMs,
        ],
      ]),
    );
  });

  it('falls back to the deterministic mock provider when no TMDb token is configured', async () => {
    const fallbackProvider = {
      search: vi.fn().mockResolvedValue([
        {
          id: 'interstellar',
          title: 'Interstellar',
        },
      ]),
      findById: vi.fn(),
    } as unknown as MockCatalogProvider;

    const provider = new TmdbMediaCatalogProvider(
      createCacheService().service,
      createConfigService({
        'tmdb.apiReadToken': '',
      }),
      fallbackProvider,
    );

    const results = await provider.search('interstellar');

    expect(results).toEqual([
      {
        id: 'interstellar',
        title: 'Interstellar',
      },
    ]);
    expect(fallbackProvider.search).toHaveBeenCalledWith('interstellar');
  });

  it('returns cached media items from findById without calling TMDb again', async () => {
    const cacheService = createCacheService();
    const cachedItem: CatalogMediaItem = {
      id: 'movie_157336',
      title: 'Interstellar',
      year: 2014,
      mediaType: SearchMediaType.Movie,
      synopsis: 'A mission leaves Earth to search for a new home.',
      genres: ['Adventure'],
      runtimeMinutes: 169,
      popularity: 88.1,
    };
    cacheService.get.mockImplementation((key: string) => {
      return key === 'catalog:tmdb:media:movie_157336' ? cachedItem : undefined;
    });

    const fetchMock = vi.fn();
    vi.stubGlobal('fetch', fetchMock);

    const provider = new TmdbMediaCatalogProvider(
      cacheService.service,
      createConfigService(),
      {
        search: vi.fn(),
        findById: vi.fn(),
      } as unknown as MockCatalogProvider,
    );

    const item = await provider.findById('movie_157336');

    expect(item).toEqual(cachedItem);
    expect(fetchMock).not.toHaveBeenCalled();
  });
});
