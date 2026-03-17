import { withE2eApp } from 'test/core/shared/e2e-app.helper';
import { describeIfDatabase } from 'test/core/shared/database-test.helper';
import { pollUntil } from 'test/core/shared/polling.helper';
import {
  createApiRequest,
  createDeviceHeaders,
} from 'test/core/shared/request.helper';
import { sampleSrt } from 'test/core/shared/subtitle-fixtures';

describeIfDatabase('Translation jobs endpoints', () => {
  // -------------------------------------------------------------------------
  // Route guard – device header
  // -------------------------------------------------------------------------

  it('returns 400 when x-device-id header is missing', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);

      await api
        .post('/v1/translation-jobs')
        .send({ sourceType: 'upload', parsedFileId: '00000000-0000-0000-0000-000000000001', targetLanguage: 'fr' })
        .expect(400)
        .expect(({ body }) => {
          expect(body.code).toBe('http_error');
        });
    });
  });

  it('returns 400 when x-device-id header is malformed', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);

      await api
        .post('/v1/translation-jobs')
        .set('x-device-id', 'bad device!')
        .send({ sourceType: 'upload', parsedFileId: '00000000-0000-0000-0000-000000000001', targetLanguage: 'fr' })
        .expect(400)
        .expect(({ body }) => {
          expect(body.code).toBe('http_error');
        });
    });
  });

  // -------------------------------------------------------------------------
  // DTO validation
  // -------------------------------------------------------------------------

  it('returns 400 when sourceType is missing', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);
      const headers = createDeviceHeaders('translation-validation-001');

      await api
        .post('/v1/translation-jobs')
        .set(headers)
        .send({ parsedFileId: '00000000-0000-0000-0000-000000000001', targetLanguage: 'fr' })
        .expect(400)
        .expect(({ body }) => {
          expect(body.code).toBe('http_error');
        });
    });
  });

  it('returns 400 when targetLanguage is missing', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);
      const headers = createDeviceHeaders('translation-validation-002');

      await api
        .post('/v1/translation-jobs')
        .set(headers)
        .send({ sourceType: 'upload', parsedFileId: '00000000-0000-0000-0000-000000000001' })
        .expect(400)
        .expect(({ body }) => {
          expect(body.code).toBe('http_error');
        });
    });
  });

  it('returns 400 when upload job is submitted without a parsedFileId', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);
      const headers = createDeviceHeaders('translation-validation-003');

      await api
        .post('/v1/translation-jobs')
        .set(headers)
        .send({ sourceType: 'upload', targetLanguage: 'fr' })
        .expect(400);
    });
  });

  it('returns 400 when catalog job is submitted without a mediaId', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);
      const headers = createDeviceHeaders('translation-validation-004');

      await api
        .post('/v1/translation-jobs')
        .set(headers)
        .send({ sourceType: 'catalog', subtitleSourceId: 'ssrc:subdl:abc', targetLanguage: 'fr' })
        .expect(400);
    });
  });

  it('returns 400 when targetLanguage is not a valid AppLanguage enum value', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);
      const headers = createDeviceHeaders('translation-validation-005');

      await api
        .post('/v1/translation-jobs')
        .set(headers)
        .send({ sourceType: 'upload', parsedFileId: '00000000-0000-0000-0000-000000000001', targetLanguage: 'xx' })
        .expect(400)
        .expect(({ body }) => {
          expect(body.code).toBe('http_error');
        });
    });
  });

  // -------------------------------------------------------------------------
  // Pagination contract
  // -------------------------------------------------------------------------

  it('returns 400 when limit exceeds the maximum of 100', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);
      const headers = createDeviceHeaders('translation-pagination-limit-001');

      await api
        .get('/v1/translation-jobs?limit=101')
        .set(headers)
        .expect(400)
        .expect(({ body }) => {
          expect(body.code).toBe('http_error');
        });
    });
  });

  it('returns 400 when page is less than 1', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);
      const headers = createDeviceHeaders('translation-pagination-page-001');

      await api
        .get('/v1/translation-jobs?page=0')
        .set(headers)
        .expect(400)
        .expect(({ body }) => {
          expect(body.code).toBe('http_error');
        });
    });
  });

  it('returns the full paginated response envelope on a list call', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);
      const headers = createDeviceHeaders('translation-pagination-shape-001');

      await api
        .get('/v1/translation-jobs?page=1&limit=10')
        .set(headers)
        .expect(200)
        .expect(({ body }) => {
          expect(Array.isArray(body.items)).toBe(true);
          expect(typeof body.total).toBe('number');
          expect(body.page).toBe(1);
          expect(body.limit).toBe(10);
          expect(typeof body.totalPages).toBe('number');
          expect(body.totalPages).toBeGreaterThanOrEqual(1);
        });
    });
  });

  // -------------------------------------------------------------------------
  // List jobs
  // -------------------------------------------------------------------------

  it('lists jobs for the device and returns an empty list when no jobs exist', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);
      const headers = createDeviceHeaders('translation-list-001');

      await api
        .get('/v1/translation-jobs')
        .set(headers)
        .expect(200)
        .expect(({ body }) => {
          expect(Array.isArray(body.items)).toBe(true);
          expect(body.items).toHaveLength(0);
          expect(typeof body.total).toBe('number');
        });
    });
  });

  it('returns only jobs owned by the requesting device', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);
      const deviceA = createDeviceHeaders('translation-isolation-001a');
      const deviceB = createDeviceHeaders('translation-isolation-001b');

      // Device A creates a job
      const parsedResponse = await api
        .post('/v1/subtitles/parse')
        .set(deviceA)
        .attach('file', Buffer.from(sampleSrt, 'utf8'), 'sample.srt')
        .expect(201);

      await api
        .post('/v1/translation-jobs')
        .set(deviceA)
        .send({ sourceType: 'upload', parsedFileId: parsedResponse.body.id, targetLanguage: 'fr' })
        .expect(201);

      // Device B should see zero jobs
      await api
        .get('/v1/translation-jobs')
        .set(deviceB)
        .expect(200)
        .expect(({ body }) => {
          expect(body.items).toHaveLength(0);
        });
    });
  });

  // -------------------------------------------------------------------------
  // Clear history
  // -------------------------------------------------------------------------

  it('clears all translation history for the device', async () => {
    await withE2eApp(async (app) => {
      const api = createApiRequest(app);
      const headers = createDeviceHeaders('translation-clear-001');

      const parsedResponse = await api
        .post('/v1/subtitles/parse')
        .set(headers)
        .attach('file', Buffer.from(sampleSrt, 'utf8'), 'sample.srt')
        .expect(201);

      await api
        .post('/v1/translation-jobs')
        .set(headers)
        .send({ sourceType: 'upload', parsedFileId: parsedResponse.body.id, targetLanguage: 'fr' })
        .expect(201);

      await api
        .get('/v1/translation-jobs')
        .set(headers)
        .expect(200)
        .expect(({ body }) => {
          expect(body.items.length).toBeGreaterThan(0);
        });

      await api
        .delete('/v1/translation-jobs')
        .set(headers)
        .expect(200)
        .expect(({ body }) => {
          expect(body.cleared).toBe(true);
        });

      await api
        .get('/v1/translation-jobs')
        .set(headers)
        .expect(200)
        .expect(({ body }) => {
          expect(body.items).toHaveLength(0);
        });
    });
  });

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
