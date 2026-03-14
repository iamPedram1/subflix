import { withE2eApp } from 'test/core/shared/e2e-app.helper';
import { createApiRequest } from 'test/core/shared/request.helper';
import {
  podnapisiSearchHtml,
  subdlMovieResponse,
} from 'test/core/shared/catalog-subtitle-provider.fixtures';

const toRequestUrl = (input: RequestInfo | URL): string => {
  if (typeof input === 'string') {
    return input;
  }

  if (input instanceof URL) {
    return input.toString();
  }

  return input.url;
};

const withSubtitleEnv = async (
  overrides: Record<string, string | undefined>,
  run: () => Promise<void>,
) => {
  const previousValues = Object.fromEntries(
    Object.keys(overrides).map((key) => [key, process.env[key]]),
  );

  Object.entries(overrides).forEach(([key, value]) => {
    if (value === undefined) {
      delete process.env[key];
      return;
    }

    process.env[key] = value;
  });

  try {
    await run();
  } finally {
    Object.entries(previousValues).forEach(([key, value]) => {
      if (value === undefined) {
        delete process.env[key];
        return;
      }

      process.env[key] = value;
    });
  }
};

describe('Catalog endpoints', () => {
  afterEach(() => {
    vi.restoreAllMocks();
  });

  it('searches titles through the public catalog endpoint', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);

      await api
        .get('/v1/catalog/search')
        .query({ q: 'dune' })
        .expect(200)
        .expect((response) => {
          const { body, headers } = response;

          expect(body).toHaveLength(1);
          expect(body[0]?.id).toBe('dune_part_two');
          expect(headers['cache-control']).toContain('public');
          expect(headers['ratelimit-limit']).toBe('30');
        });
    });
  });

  it('returns subtitle sources from the SubDL provider when it succeeds', async () => {
    await withSubtitleEnv(
      {
        SUBDL_API_KEY: 'subdl-key',
        SUBDL_ENABLED: 'true',
        PODNAPISI_ENABLED: 'true',
        TVSUBS_ENABLED: 'true',
      },
      async () => {
        const fetchMock = vi.fn(async (input: RequestInfo | URL) => {
          const url = toRequestUrl(input);
          if (url.includes('api.subdl.com')) {
            return new Response(JSON.stringify(subdlMovieResponse), {
              status: 200,
              headers: {
                'content-type': 'application/json',
              },
            });
          }

          throw new Error(`Unexpected fetch: ${url}`);
        });
        vi.stubGlobal('fetch', fetchMock);

        await withE2eApp(async (app) => {
          const api = createApiRequest(app);

          await api
            .get('/v1/catalog/media/inception/subtitle-sources')
            .expect(200)
            .expect(({ body, headers }) => {
              expect(body).toHaveLength(1);
              expect(body[0]).toMatchObject({
                id: expect.stringContaining('ssrc:subdl:'),
                label: expect.any(String),
                releaseGroup: expect.any(String),
                format: 'srt',
                hearingImpaired: true,
                lineCount: 0,
                downloads: 1200,
                rating: 4.8,
              });
              expect(headers['ratelimit-limit']).toBe('60');
            });
        });
      },
    );
  });

  it('falls back to scraper providers when SubDL returns empty', async () => {
    await withSubtitleEnv(
      {
        SUBDL_API_KEY: 'subdl-key',
        SUBDL_ENABLED: 'true',
        PODNAPISI_ENABLED: 'true',
        TVSUBS_ENABLED: 'true',
      },
      async () => {
        const fetchMock = vi.fn(async (input: RequestInfo | URL) => {
          const url = toRequestUrl(input);
          if (url.includes('api.subdl.com')) {
            return new Response(
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
            );
          }

          if (url.includes('podnapisi.net')) {
            return new Response(podnapisiSearchHtml, {
              status: 200,
              headers: {
                'content-type': 'text/html',
              },
            });
          }

          throw new Error(`Unexpected fetch: ${url}`);
        });
        vi.stubGlobal('fetch', fetchMock);

        await withE2eApp(async (app) => {
          const api = createApiRequest(app);

          await api
            .get('/v1/catalog/media/inception/subtitle-sources')
            .expect(200)
            .expect(({ body }) => {
              expect(body[0]).toMatchObject({
                id: expect.stringContaining('ssrc:podnapisi:'),
                format: 'srt',
                downloads: 15749,
              });
            });
        });
      },
    );
  });

  it('falls back to scraper providers when SubDL throws', async () => {
    await withSubtitleEnv(
      {
        SUBDL_API_KEY: 'subdl-key',
        SUBDL_ENABLED: 'true',
        PODNAPISI_ENABLED: 'true',
        TVSUBS_ENABLED: 'true',
      },
      async () => {
        const fetchMock = vi.fn(async (input: RequestInfo | URL) => {
          const url = toRequestUrl(input);
          if (url.includes('api.subdl.com')) {
            throw new Error('SubDL offline');
          }

          if (url.includes('podnapisi.net')) {
            return new Response(podnapisiSearchHtml, {
              status: 200,
              headers: {
                'content-type': 'text/html',
              },
            });
          }

          throw new Error(`Unexpected fetch: ${url}`);
        });
        vi.stubGlobal('fetch', fetchMock);

        await withE2eApp(async (app) => {
          const api = createApiRequest(app);

          await api
            .get('/v1/catalog/media/inception/subtitle-sources')
            .expect(200)
            .expect(({ body }) => {
              expect(body[0]?.id).toContain('ssrc:podnapisi:');
            });
        });
      },
    );
  });

  it('returns the normalized error envelope when every provider fails meaningfully', async () => {
    await withSubtitleEnv(
      {
        SUBDL_API_KEY: 'subdl-key',
        SUBDL_ENABLED: 'true',
        PODNAPISI_ENABLED: 'true',
        TVSUBS_ENABLED: 'true',
      },
      async () => {
        const fetchMock = vi.fn(async (input: RequestInfo | URL) => {
          const url = toRequestUrl(input);
          if (url.includes('api.subdl.com')) {
            throw new Error('SubDL offline');
          }

          if (url.includes('podnapisi.net')) {
            return new Response('Bad gateway', {
              status: 503,
            });
          }

          if (url.includes('tvsubtitles.net/search.php')) {
            return new Response('Search failed', {
              status: 503,
            });
          }

          if (url.includes('tvshow-133-5.html')) {
            return new Response('Season failed', {
              status: 503,
            });
          }

          throw new Error(`Unexpected fetch: ${url}`);
        });
        vi.stubGlobal('fetch', fetchMock);

        await withE2eApp(async (app) => {
          const api = createApiRequest(app);

          await api
            .get('/v1/catalog/media/breaking_bad/subtitle-sources')
            .query({ seasonNumber: 5, episodeNumber: 16 })
            .expect(503)
            .expect(({ body }) => {
              expect(body.code).toBe('service_unavailable');
              expect(body.requestId).toBeDefined();
            });
        });
      },
    );
  });

  it('rejects invalid subtitle source media ids through validation', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);

      await api
        .get('/v1/catalog/media/invalid$id/subtitle-sources')
        .expect(400)
        .expect(({ body }) => {
          expect(body.code).toBe('validation_failed');
        });
    });
  });

  it('rejects partial tv episode scope through validation', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);

      await api
        .get('/v1/catalog/media/breaking_bad/subtitle-sources')
        .query({ seasonNumber: 5 })
        .expect(400)
        .expect(({ body }) => {
          expect(body.code).toBe('validation_failed');
        });
    });
  });

  it('caches subtitle source lookups to avoid duplicate provider work', async () => {
    await withSubtitleEnv(
      {
        SUBDL_API_KEY: 'subdl-key',
        SUBDL_ENABLED: 'true',
        PODNAPISI_ENABLED: 'true',
        TVSUBS_ENABLED: 'true',
      },
      async () => {
        const fetchMock = vi.fn(async (input: RequestInfo | URL) => {
          const url = toRequestUrl(input);
          if (url.includes('api.subdl.com')) {
            return new Response(JSON.stringify(subdlMovieResponse), {
              status: 200,
              headers: {
                'content-type': 'application/json',
              },
            });
          }

          throw new Error(`Unexpected fetch: ${url}`);
        });
        vi.stubGlobal('fetch', fetchMock);

        await withE2eApp(async (app) => {
          const api = createApiRequest(app);

          await api
            .get('/v1/catalog/media/inception/subtitle-sources')
            .expect(200);
          await api
            .get('/v1/catalog/media/inception/subtitle-sources')
            .expect(200);

          expect(
            fetchMock.mock.calls.filter((call) =>
              toRequestUrl(call[0]).includes('api.subdl.com'),
            ),
          ).toHaveLength(1);
        });
      },
    );
  });

  it('rejects short search queries through validation', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);

      await api
        .get('/v1/catalog/search')
        .query({ q: 'a' })
        .expect(400)
        .expect(({ body }) => {
          expect(body.code).toBe('validation_failed');
        });
    });
  });

  it('rejects overly long catalog queries', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);

      await api
        .get('/v1/catalog/search')
        .query({ q: 'd'.repeat(121) })
        .expect(400)
        .expect(({ body }) => {
          expect(body.code).toBe('validation_failed');
        });
    });
  });

  it('rate limits repeated catalog search spam', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);

      for (let index = 0; index < 30; index += 1) {
        await api.get('/v1/catalog/search').query({ q: 'dune' }).expect(200);
      }

      await api
        .get('/v1/catalog/search')
        .query({ q: 'dune' })
        .expect(429)
        .expect(({ body, headers }) => {
          expect(body.code).toBe('rate_limited');
          expect(headers['retry-after']).toBeDefined();
          expect(headers['ratelimit-remaining']).toBe('0');
        });
    });
  });
});
