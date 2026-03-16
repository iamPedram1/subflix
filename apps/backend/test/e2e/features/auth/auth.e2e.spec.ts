import { randomUUID } from 'node:crypto';

import { withE2eApp } from 'test/core/shared/e2e-app.helper';
import { describeIfDatabase } from 'test/core/shared/database-test.helper';
import { createApiRequest } from 'test/core/shared/request.helper';

const createAuthPayload = () => {
  const suffix = randomUUID();
  return {
    email: `auth-e2e-${suffix}@example.com`,
    password: 'ChangeMe123!',
    displayName: 'Auth E2E',
  };
};

describeIfDatabase('Auth endpoints', () => {
  it('registers a user and returns tokens', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);
      const payload = createAuthPayload();

      await api
        .post('/v1/auth/signup')
        .send(payload)
        .expect(201)
        .expect(({ body }) => {
          expect(body.user.email).toBe(payload.email.toLowerCase());
          expect(body.accessToken).toBeTruthy();
          expect(body.refreshToken).toBeTruthy();
          expect(body.tokenType).toBe('Bearer');
          expect(body.expiresIn).toBeGreaterThan(0);
        });
    });
  });

  it('signs in an existing user and returns tokens', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);
      const payload = createAuthPayload();

      await api.post('/v1/auth/signup').send(payload).expect(201);

      await api
        .post('/v1/auth/signin')
        .send({ email: payload.email, password: payload.password })
        .expect(201)
        .expect(({ body }) => {
          expect(body.user.email).toBe(payload.email.toLowerCase());
          expect(body.accessToken).toBeTruthy();
          expect(body.refreshToken).toBeTruthy();
        });
    });
  });

  it('rejects sign in when credentials are invalid', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);
      const payload = createAuthPayload();

      await api.post('/v1/auth/signup').send(payload).expect(201);

      await api
        .post('/v1/auth/signin')
        .send({ email: payload.email, password: 'WrongPassword123!' })
        .expect(403)
        .expect(({ body }) => {
          expect(body.code).toBe('forbidden');
        });
    });
  });

  it('requires an access token for the profile endpoint', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);
      const payload = createAuthPayload();

      await api
        .get('/v1/auth/me')
        .expect(401)
        .expect(({ body }) => {
          expect(body.code).toBe('http_error');
        });

      const signUpResponse = await api
        .post('/v1/auth/signup')
        .send(payload)
        .expect(201);

      const accessToken = signUpResponse.body.accessToken;

      await api
        .get('/v1/auth/me')
        .set('authorization', `Bearer ${accessToken}`)
        .expect(200)
        .expect(({ body }) => {
          expect(body.user.email).toBe(payload.email.toLowerCase());
        });
    });
  });

  it('rotates refresh tokens and rejects reuse', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);
      const payload = createAuthPayload();

      const signUpResponse = await api
        .post('/v1/auth/signup')
        .send(payload)
        .expect(201);

      const originalRefreshToken = signUpResponse.body.refreshToken;

      const refreshResponse = await api
        .post('/v1/auth/refresh')
        .send({ refreshToken: originalRefreshToken })
        .expect(201);

      expect(refreshResponse.body.refreshToken).toBeTruthy();
      expect(refreshResponse.body.refreshToken).not.toBe(originalRefreshToken);

      await api
        .post('/v1/auth/refresh')
        .send({ refreshToken: originalRefreshToken })
        .expect(403)
        .expect(({ body }) => {
          expect(body.code).toBe('forbidden');
        });
    });
  });

  it('revokes refresh tokens on sign out', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);
      const payload = createAuthPayload();

      const signUpResponse = await api
        .post('/v1/auth/signup')
        .send(payload)
        .expect(201);

      const refreshToken = signUpResponse.body.refreshToken;

      await api
        .post('/v1/auth/signout')
        .send({ refreshToken })
        .expect(200)
        .expect(({ body }) => {
          expect(body.revoked).toBe(true);
        });

      await api
        .post('/v1/auth/refresh')
        .send({ refreshToken })
        .expect(403)
        .expect(({ body }) => {
          expect(body.code).toBe('forbidden');
        });
    });
  });

  const hasFirebaseConfig = Boolean(
    process.env.FIREBASE_SERVICE_ACCOUNT_JSON?.trim() ||
      (process.env.FIREBASE_PROJECT_ID?.trim() &&
        process.env.FIREBASE_CLIENT_EMAIL?.trim() &&
        process.env.FIREBASE_PRIVATE_KEY?.trim()),
  );

  (hasFirebaseConfig ? it.skip : it)(
    'returns 503 when Firebase OAuth is not configured',
    async () => {
      await withE2eApp(async (app) => {
        const api = createApiRequest(app);

        await api
          .post('/v1/auth/oauth/firebase')
          .send({ idToken: 'invalid-token' })
          .expect(503)
          .expect(({ body }) => {
            expect(body.code).toBe('service_unavailable');
          });
      });
    },
  );
});
