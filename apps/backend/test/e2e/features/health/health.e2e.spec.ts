import { withE2eApp } from 'test/core/shared/e2e-app.helper';
import { createApiRequest } from 'test/core/shared/request.helper';

describe('Health endpoint', () => {
  it('returns a healthy status payload', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);

      await api
        .get('/v1/health')
        .expect(200)
        .expect(({ body }) => {
          expect(body.status).toBe('ok');
          expect(body.service).toBe('subflix-back');
        });
    });
  });

  it('adds security headers and sanitizes unsafe request ids', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);

      await api
        .get('/v1/health')
        .set('x-request-id', 'unsafe request id with spaces')
        .expect(200)
        .expect((response) => {
          expect(response.headers['cache-control']).toContain('no-store');
          expect(response.headers['x-content-type-options']).toBe('nosniff');
          expect(response.headers['x-request-id']).not.toBe(
            'unsafe request id with spaces',
          );
          expect(response.headers['x-request-id']).toMatch(/^[a-f0-9-]{36}$/i);
        });
    });
  });
});
