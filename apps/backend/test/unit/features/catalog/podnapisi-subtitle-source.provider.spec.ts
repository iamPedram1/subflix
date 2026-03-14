import { ConfigService } from '@nestjs/config';

import { PodnapisiSubtitleSourceProvider } from 'src/features/catalog/providers/podnapisi-subtitle-source.provider';
import { podnapisiSearchHtml } from 'test/core/shared/catalog-subtitle-provider.fixtures';

describe('PodnapisiSubtitleSourceProvider', () => {
  const createConfigService = (overrides?: Record<string, unknown>) =>
    ({
      get: vi.fn((key: string) => {
        const defaults: Record<string, unknown> = {
          'subtitleSources.podnapisi.baseUrl': 'https://www.podnapisi.net',
          'subtitleSources.podnapisi.timeoutMs': 10_000,
          ...overrides,
        };

        return defaults[key];
      }),
    }) as unknown as ConfigService;

  beforeEach(() => {
    vi.restoreAllMocks();
  });

  it('parses subtitle rows into normalized candidates', async () => {
    vi.stubGlobal(
      'fetch',
      vi.fn().mockResolvedValue(
        new Response(podnapisiSearchHtml, {
          status: 200,
          headers: {
            'content-type': 'text/html',
          },
        }),
      ),
    );

    const provider = new PodnapisiSubtitleSourceProvider(createConfigService());
    const results = await provider.searchSources({
      mediaId: 'inception',
      title: 'Inception',
      originalTitle: 'Inception',
      year: 2010,
      mediaType: 'movie',
      preferredLanguage: 'en',
      releaseHints: [],
    });

    expect(results[0]).toMatchObject({
      provider: 'podnapisi',
      providerSubtitleId: 'pdQ8',
      mediaTitle: 'Inception',
      year: 2010,
      languageCode: 'en',
      hearingImpaired: true,
      downloadCount: 15749,
    });
  });

  it('returns an empty list on parser drift instead of throwing', async () => {
    vi.stubGlobal(
      'fetch',
      vi.fn().mockResolvedValue(
        new Response('<html><body>No rows here</body></html>', {
          status: 200,
          headers: {
            'content-type': 'text/html',
          },
        }),
      ),
    );

    const provider = new PodnapisiSubtitleSourceProvider(createConfigService());
    await expect(
      provider.searchSources({
        mediaId: 'inception',
        title: 'Inception',
        originalTitle: 'Inception',
        year: 2010,
        mediaType: 'movie',
        preferredLanguage: 'en',
        releaseHints: [],
      }),
    ).resolves.toEqual([]);
  });
});
