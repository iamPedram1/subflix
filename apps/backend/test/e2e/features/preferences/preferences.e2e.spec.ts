import { createE2eApp } from 'test/core/shared/e2e-app.helper';
import { describeIfDatabase } from 'test/core/shared/database-test.helper';
import {
  createApiRequest,
  createDeviceHeaders,
} from 'test/core/shared/request.helper';

describeIfDatabase('Preferences endpoints', () => {
  it('returns default preferences for a new device', async () => {
    const app = await createE2eApp();
    const api = createApiRequest(app);

    await api
      .get('/v1/preferences')
      .set(createDeviceHeaders('preferences-e2e-001'))
      .expect(200)
      .expect(({ body }) => {
        expect(body.hasSeenOnboarding).toBe(false);
        expect(body.preferredTargetLanguage).toBe('es');
        expect(body.themePreference).toBe('system');
      });

    await app.close();
  });

  it('updates and persists preference fields', async () => {
    const app = await createE2eApp();
    const api = createApiRequest(app);
    const headers = createDeviceHeaders('preferences-e2e-002');

    await api
      .patch('/v1/preferences')
      .set(headers)
      .send({
        hasSeenOnboarding: true,
        preferredTargetLanguage: 'fr',
        themePreference: 'dark',
      })
      .expect(200)
      .expect(({ body }) => {
        expect(body.hasSeenOnboarding).toBe(true);
        expect(body.preferredTargetLanguage).toBe('fr');
        expect(body.themePreference).toBe('dark');
      });

    await api
      .get('/v1/preferences')
      .set(headers)
      .expect(200)
      .expect(({ body }) => {
        expect(body.hasSeenOnboarding).toBe(true);
        expect(body.preferredTargetLanguage).toBe('fr');
        expect(body.themePreference).toBe('dark');
      });

    await app.close();
  });
});
