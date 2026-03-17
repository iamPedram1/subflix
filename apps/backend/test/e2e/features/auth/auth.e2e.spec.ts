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

const signUpAndConfirm = async (api: ReturnType<typeof createApiRequest>) => {
  const payload = createAuthPayload();
  const signUpResponse = await api.post('/v1/auth/signup').send(payload).expect(201);

  expect(signUpResponse.body.verificationRequired).toBe(true);
  const verificationToken = signUpResponse.body.verificationToken as string | undefined;
  if (!verificationToken) {
    throw new Error('Expected verificationToken in non-production environments.');
  }

  await api
    .post('/v1/auth/confirm-email')
    .send({ token: verificationToken })
    .expect(200)
    .expect(({ body }) => {
      expect(body.verified).toBe(true);
    });

  return { payload, verificationToken };
};

describeIfDatabase('Auth endpoints', () => {
  it('requires email verification before sign in', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);
      const payload = createAuthPayload();

      const signUpResponse = await api
        .post('/v1/auth/signup')
        .send(payload)
        .expect(201);

      expect(signUpResponse.body.verificationRequired).toBe(true);

      await api
        .post('/v1/auth/signin')
        .send({ email: payload.email, password: payload.password })
        .expect(403)
        .expect(({ body }) => {
          expect(body.code).toBe('forbidden');
        });

      const verificationToken = signUpResponse.body.verificationToken as string | undefined;
      if (!verificationToken) {
        throw new Error('Expected verificationToken in non-production environments.');
      }

      await api
        .post('/v1/auth/confirm-email')
        .send({ token: verificationToken })
        .expect(200);

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

  it('requires an access token for the profile endpoint', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);

      await api
        .get('/v1/auth/me')
        .expect(401)
        .expect(({ body }) => {
          expect(body.code).toBe('http_error');
        });

      const { payload } = await signUpAndConfirm(api);

      const signInResponse = await api
        .post('/v1/auth/signin')
        .send({ email: payload.email, password: payload.password })
        .expect(201);

      const accessToken = signInResponse.body.accessToken;

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
      const { payload } = await signUpAndConfirm(api);

      const signInResponse = await api
        .post('/v1/auth/signin')
        .send({ email: payload.email, password: payload.password })
        .expect(201);

      const originalRefreshToken = signInResponse.body.refreshToken;

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
      const { payload } = await signUpAndConfirm(api);

      const signInResponse = await api
        .post('/v1/auth/signin')
        .send({ email: payload.email, password: payload.password })
        .expect(201);

      const refreshToken = signInResponse.body.refreshToken;

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

  it('resets passwords with a valid reset token', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);
      const { payload } = await signUpAndConfirm(api);

      const forgotResponse = await api
        .post('/v1/auth/forgot-password')
        .send({ email: payload.email })
        .expect(200);

      expect(forgotResponse.body.sent).toBe(true);
      const resetToken = forgotResponse.body.resetToken as string | undefined;
      if (!resetToken) {
        throw new Error('Expected resetToken in non-production environments.');
      }

      const newPassword = 'ChangeMe456!';
      await api
        .post('/v1/auth/reset-password')
        .send({ token: resetToken, password: newPassword })
        .expect(200)
        .expect(({ body }) => {
          expect(body.reset).toBe(true);
        });

      await api
        .post('/v1/auth/signin')
        .send({ email: payload.email, password: payload.password })
        .expect(403);

      await api
        .post('/v1/auth/signin')
        .send({ email: payload.email, password: newPassword })
        .expect(201)
        .expect(({ body }) => {
          expect(body.accessToken).toBeTruthy();
        });
    });
  });

  // -------------------------------------------------------------------------
  // Input validation – signup
  // -------------------------------------------------------------------------

  it('rejects signup with a missing email', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);

      await api
        .post('/v1/auth/signup')
        .send({ password: 'Password1!' })
        .expect(400)
        .expect(({ body }) => {
          expect(body.code).toBe('http_error');
        });
    });
  });

  it('rejects signup with an invalid email format', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);

      await api
        .post('/v1/auth/signup')
        .send({ email: 'not-an-email', password: 'Password1!' })
        .expect(400)
        .expect(({ body }) => {
          expect(body.code).toBe('http_error');
        });
    });
  });

  it('rejects signup with a password that is too short', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);

      await api
        .post('/v1/auth/signup')
        .send({ email: 'alice@example.com', password: 'short' })
        .expect(400)
        .expect(({ body }) => {
          expect(body.code).toBe('http_error');
        });
    });
  });

  it('returns 409 when the email is already registered', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);
      const payload = createAuthPayload();

      await api.post('/v1/auth/signup').send(payload).expect(201);

      await api
        .post('/v1/auth/signup')
        .send(payload)
        .expect(409)
        .expect(({ body }) => {
          expect(body.code).toBe('conflict');
        });
    });
  });

  // -------------------------------------------------------------------------
  // Input validation – signin
  // -------------------------------------------------------------------------

  it('rejects signin with a missing password', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);

      await api
        .post('/v1/auth/signin')
        .send({ email: 'alice@example.com' })
        .expect(400)
        .expect(({ body }) => {
          expect(body.code).toBe('http_error');
        });
    });
  });

  it('rejects signin with an invalid email format', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);

      await api
        .post('/v1/auth/signin')
        .send({ email: 'bad-email', password: 'Password1!' })
        .expect(400)
        .expect(({ body }) => {
          expect(body.code).toBe('http_error');
        });
    });
  });

  // -------------------------------------------------------------------------
  // Input validation – confirm-email
  // -------------------------------------------------------------------------

  it('rejects confirm-email when token is missing', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);

      await api
        .post('/v1/auth/confirm-email')
        .send({})
        .expect(400)
        .expect(({ body }) => {
          expect(body.code).toBe('http_error');
        });
    });
  });

  it('returns 403 when an invalid verification token is submitted', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);

      await api
        .post('/v1/auth/confirm-email')
        .send({ token: 'completely-invalid-token' })
        .expect(403)
        .expect(({ body }) => {
          expect(body.code).toBe('forbidden');
        });
    });
  });

  // -------------------------------------------------------------------------
  // Input validation – forgot/reset password
  // -------------------------------------------------------------------------

  it('rejects forgot-password with a missing email', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);

      await api
        .post('/v1/auth/forgot-password')
        .send({})
        .expect(400)
        .expect(({ body }) => {
          expect(body.code).toBe('http_error');
        });
    });
  });

  it('returns 403 when an invalid reset token is submitted', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);

      await api
        .post('/v1/auth/reset-password')
        .send({ token: 'bad-token', password: 'NewPass1!' })
        .expect(403)
        .expect(({ body }) => {
          expect(body.code).toBe('forbidden');
        });
    });
  });

  it('rejects reset-password with a password that is too short', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);

      await api
        .post('/v1/auth/reset-password')
        .send({ token: 'some-token', password: 'short' })
        .expect(400)
        .expect(({ body }) => {
          expect(body.code).toBe('http_error');
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
