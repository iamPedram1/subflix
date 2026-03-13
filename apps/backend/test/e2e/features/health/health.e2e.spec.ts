import { createE2eApp } from 'test/core/shared/e2e-app.helper';
import { createApiRequest } from 'test/core/shared/request.helper';

describe('Health endpoint', () => {
  it('returns a healthy status payload', async () => {
    const app = await createE2eApp();
    const api = createApiRequest(app);

    await api
      .get('/v1/health')
      .expect(200)
      .expect(({ body }) => {
        expect(body.status).toBe('ok');
        expect(body.service).toBe('subflix-back');
      });

    await app.close();
  });
});
