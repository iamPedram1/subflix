import request from 'supertest';

import { createE2eApp } from 'test/core/shared/e2e-app.helper';

describe('Catalog endpoints', () => {
  it('searches titles through the public catalog endpoint', async () => {
    const app = await createE2eApp();

    await request(app.getHttpServer())
      .get('/v1/catalog/search')
      .query({ q: 'dune' })
      .expect(200)
      .expect(({ body }) => {
        expect(body).toHaveLength(1);
        expect(body[0]?.id).toBe('dune_part_two');
      });

    await app.close();
  });

  it('returns subtitle sources for a media title', async () => {
    const app = await createE2eApp();

    await request(app.getHttpServer())
      .get('/v1/catalog/media/inception/subtitle-sources')
      .expect(200)
      .expect(({ body }) => {
        expect(body).toHaveLength(3);
        expect(body[0]).toMatchObject({
          id: 'inception-webdl',
          format: 'srt',
        });
      });

    await app.close();
  });

  it('rejects short search queries through validation', async () => {
    const app = await createE2eApp();

    await request(app.getHttpServer())
      .get('/v1/catalog/search')
      .query({ q: 'a' })
      .expect(400)
      .expect(({ body }) => {
        expect(body.code).toBe('validation_failed');
      });

    await app.close();
  });
});
