import { ConfigService } from '@nestjs/config';

import { SubdlSubtitleSourceProvider } from 'src/features/catalog/providers/subdl-subtitle-source.provider';
import { subdlMovieResponse } from 'test/core/shared/catalog-subtitle-provider.fixtures';

describe('SubdlSubtitleSourceProvider', () => {
  const createConfigService = (overrides?: Record<string, unknown>) =>
    ({
      get: vi.fn((key: string) => {
        const defaults: Record<string, unknown> = {
          'subtitleSources.subdl.apiKey': 'subdl-key',
          'subtitleSources.subdl.apiBaseUrl': 'https://api.subdl.com/api/v1',
          'subtitleSources.subdl.timeoutMs': 7_000,
          ...overrides,
        };

        return defaults[key];
      }),
    }) as unknown as ConfigService;

  beforeEach(() => {
    vi.restoreAllMocks();
  });

  it('prefers canonical ids in the request mapping and normalizes results', async () => {
    const fetchMock = vi.fn().mockResolvedValue(
      new Response(JSON.stringify(subdlMovieResponse), {
        status: 200,
        headers: {
          'content-type': 'application/json',
        },
      }),
    );
    vi.stubGlobal('fetch', fetchMock);

    const provider = new SubdlSubtitleSourceProvider(createConfigService());
    const results = await provider.searchSources({
      mediaId: 'movie_27205',
      tmdbId: 27205,
      imdbId: 'tt1375666',
      title: 'Inception',
      originalTitle: 'Inception',
      year: 2010,
      mediaType: 'movie',
      preferredLanguage: 'en',
      releaseHints: [],
    });

    const requestUrl = new URL(fetchMock.mock.calls[0]?.[0] as string);
    expect(requestUrl.searchParams.get('tmdb_id')).toBe('27205');
    expect(requestUrl.searchParams.get('imdb_id')).toBe('tt1375666');
    expect(requestUrl.searchParams.get('film_name')).toBeNull();
    expect(requestUrl.searchParams.get('languages')).toBe('EN');
    expect(results[0]).toMatchObject({
      provider: 'subdl',
      providerSubtitleId: 'subdl-1',
      languageCode: 'en',
      hearingImpaired: true,
      downloadCount: 1200,
      tmdbId: 27205,
      imdbId: 'tt1375666',
    });
  });

  it('falls back to title search when canonical ids are unavailable', async () => {
    const fetchMock = vi.fn().mockResolvedValue(
      new Response(
        JSON.stringify({
          status: true,
          statusCode: 200,
          subtitles: [],
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

    const provider = new SubdlSubtitleSourceProvider(createConfigService());
    await provider.searchSources({
      mediaId: 'inception',
      title: 'Inception',
      originalTitle: 'Inception',
      year: 2010,
      mediaType: 'movie',
      preferredLanguage: 'en',
      releaseHints: [],
    });

    const requestUrl = new URL(fetchMock.mock.calls[0]?.[0] as string);
    expect(requestUrl.searchParams.get('film_name')).toBe('Inception');
    expect(requestUrl.searchParams.get('tmdb_id')).toBeNull();
    expect(requestUrl.searchParams.get('imdb_id')).toBeNull();
  });
});
