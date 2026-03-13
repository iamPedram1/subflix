import request from 'supertest';

import { createE2eApp } from 'test/core/shared/e2e-app.helper';

describe('Health endpoint', () => {
  it('returns a healthy status payload', async () => {
    const app = await createE2eApp();

    await request(app.getHttpServer())
      .get('/v1/health')
      .expect(200)
      .expect(({ body }) => {
        expect(body.status).toBe('ok');
        expect(body.service).toBe('subflix-back');
      });

    await app.close();
  });
});
