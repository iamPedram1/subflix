import request from 'supertest';

import { createE2eApp } from 'test/core/shared/e2e-app.helper';
import { describeIfDatabase } from 'test/core/shared/database-test.helper';
import { createDeviceHeaders } from 'test/core/shared/request.helper';
import { sampleSrt } from 'test/core/shared/subtitle-fixtures';

const waitForCompletedJob = async (
  app: Awaited<ReturnType<typeof createE2eApp>>,
  headers: Record<string, string>,
  jobId: string,
) => {
  for (let attempt = 0; attempt < 20; attempt += 1) {
    const response = await request(app.getHttpServer())
      .get(`/v1/translation-jobs/${jobId}`)
      .set(headers);

    if (response.body.status === 'completed') {
      return response.body;
    }

    await new Promise((resolve) => setTimeout(resolve, 200));
  }

  throw new Error(`Job ${jobId} did not complete in time.`);
};

describeIfDatabase('Translation jobs endpoints', () => {
  it('runs the upload translation flow end to end', async () => {
    const app = await createE2eApp();
    const headers = createDeviceHeaders('translation-e2e-001');

    const parsedResponse = await request(app.getHttpServer())
      .post('/v1/subtitles/parse')
      .set(headers)
      .attach('file', Buffer.from(sampleSrt, 'utf8'), 'sample.srt')
      .expect(201);

    const createResponse = await request(app.getHttpServer())
      .post('/v1/translation-jobs')
      .set(headers)
      .send({
        sourceType: 'upload',
        parsedFileId: parsedResponse.body.id,
        targetLanguage: 'fr',
      })
      .expect(201);

    const completedJob = await waitForCompletedJob(
      app,
      headers,
      createResponse.body.id,
    );

    await request(app.getHttpServer())
      .get(`/v1/translation-jobs/${createResponse.body.id}/preview`)
      .set(headers)
      .expect(200)
      .expect(({ body }) => {
        expect(body.items.length).toBeGreaterThan(0);
      });

    await request(app.getHttpServer())
      .get(`/v1/translation-jobs/${createResponse.body.id}/export`)
      .set(headers)
      .expect(200)
      .expect((response) => {
        expect(response.text).toContain('Version francaise');
      });

    await request(app.getHttpServer())
      .post(`/v1/translation-jobs/${createResponse.body.id}/retry`)
      .set(headers)
      .expect(201);

    expect(completedJob.status).toBe('completed');
    await app.close();
  });
});
