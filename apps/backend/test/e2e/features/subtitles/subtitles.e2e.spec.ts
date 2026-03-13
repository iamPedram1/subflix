import { createE2eApp } from 'test/core/shared/e2e-app.helper';
import { describeIfDatabase } from 'test/core/shared/database-test.helper';
import {
  createApiRequest,
  createDeviceHeaders,
} from 'test/core/shared/request.helper';
import { sampleSrt } from 'test/core/shared/subtitle-fixtures';

describeIfDatabase('Subtitles parse endpoint', () => {
  it('parses and stores an uploaded subtitle file', async () => {
    const app = await createE2eApp();
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

    await app.close();
  });
});
