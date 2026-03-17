import { withE2eApp } from 'test/core/shared/e2e-app.helper';
import { describeIfDatabase } from 'test/core/shared/database-test.helper';
import {
  createApiRequest,
  createDeviceHeaders,
} from 'test/core/shared/request.helper';
import { sampleSrt } from 'test/core/shared/subtitle-fixtures';

describeIfDatabase('Subtitles parse endpoint', () => {
  // -------------------------------------------------------------------------
  // i18n – Accept-Language localization
  // -------------------------------------------------------------------------

  it('returns a localized error in French when Accept-Language is fr', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);

      await api
        .post('/v1/subtitles/parse')
        .set(createDeviceHeaders('subtitle-i18n-fr-001'))
        .set('Accept-Language', 'fr')
        // No file attached — triggers requireFile() → ValidationDomainError
        .expect(400)
        .expect(({ body }) => {
          expect(body.code).toBe('validation_failed');
          expect(body.message).toBe('Un fichier de sous-titres est requis.');
        });
    });
  });

  it('returns an English error when no Accept-Language header is provided', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);

      await api
        .post('/v1/subtitles/parse')
        .set(createDeviceHeaders('subtitle-i18n-en-001'))
        // No Accept-Language header — falls back to English
        .expect(400)
        .expect(({ body }) => {
          expect(body.code).toBe('validation_failed');
          expect(body.message).toBe('A subtitle file is required.');
        });
    });
  });

  it('parses and stores an uploaded subtitle file', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);

      await api
        .post('/v1/subtitles/parse')
        .set(createDeviceHeaders('subtitle-e2e-001'))
        .attach('file', Buffer.from(sampleSrt, 'utf8'), 'sample.srt')
        .expect(201)
        .expect(({ body }) => {
          expect(body.fileName).toBe('sample.srt');
          expect(body.format).toBe('srt');
          expect(body.lineCount).toBe(2);
        });
    });
  });

  it('rejects unsupported subtitle file extensions', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);

      await api
        .post('/v1/subtitles/parse')
        .set(createDeviceHeaders('subtitle-e2e-002'))
        .attach('file', Buffer.from(sampleSrt, 'utf8'), 'sample.exe')
        .expect(400)
        .expect(({ body }) => {
          expect(body.code).toBe('http_error');
        });
    });
  });
});
