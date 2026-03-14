import { ConfigService } from '@nestjs/config';

import { TvSubsSubtitleSourceProvider } from 'features/catalog/providers/tvsubs-subtitle-source.provider';
import {
  tvSubsSearchHtml,
  tvSubsSeasonHtml,
} from 'test/core/shared/catalog-subtitle-provider.fixtures';

describe('TvSubsSubtitleSourceProvider', () => {
  const createConfigService = (overrides?: Record<string, unknown>) =>
    ({
      get: vi.fn((key: string) => {
        const defaults: Record<string, unknown> = {
          'subtitleSources.tvsubs.baseUrl': 'https://www.tvsubtitles.net',
          'subtitleSources.tvsubs.timeoutMs': 10_000,
          ...overrides,
        };

        return defaults[key];
      }),
    }) as unknown as ConfigService;

  beforeEach(() => {
    vi.restoreAllMocks();
  });

  it('parses season episode links for the preferred language', async () => {
    const fetchMock = vi
      .fn()
      .mockResolvedValueOnce(
        new Response(tvSubsSearchHtml, {
          status: 200,
          headers: {
            'content-type': 'text/html',
          },
        }),
      )
      .mockResolvedValueOnce(
        new Response(tvSubsSeasonHtml, {
          status: 200,
          headers: {
            'content-type': 'text/html',
          },
        }),
      );
    vi.stubGlobal('fetch', fetchMock);

    const provider = new TvSubsSubtitleSourceProvider(createConfigService());
    const results = await provider.searchSources({
      mediaId: 'breaking_bad',
      title: 'Breaking Bad',
      originalTitle: 'Breaking Bad',
      year: 2008,
      mediaType: 'tv',
      seasonNumber: 5,
      episodeNumber: 16,
      preferredLanguage: 'en',
      releaseHints: [],
    });

    expect(fetchMock).toHaveBeenCalledTimes(2);
    expect(results).toHaveLength(1);
    expect(results[0]).toMatchObject({
      provider: 'tvsubs',
      providerSubtitleId: '248324',
      mediaTitle: 'Breaking Bad',
      seasonNumber: 5,
      episodeNumber: 16,
      languageCode: 'en',
      releaseName: 'Felina',
    });
  });
});
