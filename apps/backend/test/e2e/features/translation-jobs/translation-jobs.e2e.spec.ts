import { withE2eApp } from 'test/core/shared/e2e-app.helper';
import { describeIfDatabase } from 'test/core/shared/database-test.helper';
import { pollUntil } from 'test/core/shared/polling.helper';
import {
  createApiRequest,
  createDeviceHeaders,
} from 'test/core/shared/request.helper';
import { sampleSrt } from 'test/core/shared/subtitle-fixtures';

describeIfDatabase('Translation jobs endpoints', () => {
  it('runs the upload translation flow end to end', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);
      const headers = createDeviceHeaders('translation-e2e-001');

      const parsedResponse = await api
        .post('/v1/subtitles/parse')
        .set(headers)
        .attach('file', Buffer.from(sampleSrt, 'utf8'), 'sample.srt')
        .expect(201);

      const createResponse = await api
        .post('/v1/translation-jobs')
        .set(headers)
        .send({
          sourceType: 'upload',
          parsedFileId: parsedResponse.body.id,
          targetLanguage: 'fr',
        })
        .expect(201);

      const completedJob = await pollUntil({
        label: `Translation job ${createResponse.body.id}`,
        poll: async () =>
          (
            await api
              .get(`/v1/translation-jobs/${createResponse.body.id}`)
              .set(headers)
          ).body,
        isDone: (candidate) => candidate.status === 'completed',
      });

      await api
        .get(`/v1/translation-jobs/${createResponse.body.id}/preview`)
        .set(headers)
        .expect(200)
        .expect(({ body }) => {
          expect(body.items.length).toBeGreaterThan(0);
        });

      await api
        .get(`/v1/translation-jobs/${createResponse.body.id}/export`)
        .set(headers)
        .expect(200)
        .expect((response) => {
          expect(response.text).toContain('Version francaise');
        });

      await api
        .post(`/v1/translation-jobs/${createResponse.body.id}/retry`)
        .set(headers)
        .expect(201);

      expect(completedJob.status).toBe('completed');
    });
  });
});
