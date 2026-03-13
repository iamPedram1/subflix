import { withE2eApp } from 'test/core/shared/e2e-app.helper';
import { createApiRequest } from 'test/core/shared/request.helper';

describe('Catalog endpoints', () => {
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

  it('returns subtitle sources for a media title', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);

      await api
        .get('/v1/catalog/media/inception/subtitle-sources')
        .expect(200)
        .expect(({ body, headers }) => {
          expect(body).toHaveLength(3);
          expect(body[0]).toMatchObject({
            id: 'inception-webdl',
            format: 'srt',
          });
          expect(headers['ratelimit-limit']).toBe('60');
        });
    });
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
