import { zipSync } from 'fflate';

import { describeIfDatabase } from 'test/core/shared/database-test.helper';
import { withE2eApp } from 'test/core/shared/e2e-app.helper';
import { pollUntil } from 'test/core/shared/polling.helper';
import {
  createApiRequest,
  createDeviceHeaders,
} from 'test/core/shared/request.helper';
import { sampleSrt } from 'test/core/shared/subtitle-fixtures';

import { buildSubtitleSourceId } from 'features/catalog/utils/subtitle-source-id.util';

describeIfDatabase('Catalog translation jobs', () => {
  it('downloads and parses real catalog subtitle cues and completes a job', async () => {
    process.env.SUBDL_API_KEY = process.env.SUBDL_API_KEY || 'test-key';
    process.env.SUBDL_ENABLED = 'true';
    process.env.PODNAPISI_ENABLED = 'false';
    process.env.TVSUBS_ENABLED = 'false';

    const stableSubtitleSourceId = buildSubtitleSourceId('subdl', '123');
    const zipBytes = Buffer.from(
      zipSync({
        'sub.srt': new TextEncoder().encode(sampleSrt),
      }),
    );

    vi.stubGlobal(
      'fetch',
      vi.fn(async (input: RequestInfo | URL) => {
        const url =
          typeof input === 'string'
            ? input
            : input instanceof URL
              ? input.toString()
              : input.url;

        if (url.startsWith('https://api.subdl.com/api/v1/subtitles')) {
          return new Response(
            JSON.stringify({
              status: true,
              subtitles: [
                {
                  subtitle_id: '123',
                  movie_name: 'Inception',
                  release_name: 'Inception.2010.1080p.BluRay.x264-GRP',
                  language: 'EN',
                  url: 'https://subdl.com/subtitle/123',
                  downloads: 100,
                },
              ],
            }),
            {
              status: 200,
              headers: { 'content-type': 'application/json' },
            },
          );
        }

        if (url === 'https://subdl.com/subtitle/123') {
          return new Response(
            `<html><body><a href="https://subdl.com/download/123.zip">download</a></body></html>`,
            {
              status: 200,
              headers: { 'content-type': 'text/html' },
            },
          );
        }

        if (url === 'https://subdl.com/download/123.zip') {
          return new Response(zipBytes, {
            status: 200,
            headers: {
              'content-type': 'application/zip',
              'content-disposition': 'attachment; filename="subtitles.zip"',
            },
          });
        }

        return new Response('not found', { status: 404 });
      }),
    );

    await withE2eApp(async (app) => {
      const api = createApiRequest(app);
      const headers = createDeviceHeaders('catalog-translation-e2e-001');

      // Sanity: subtitle-sources route can resolve the stable id.
      await api
        .get('/v1/catalog/media/inception/subtitle-sources')
        .expect(200)
        .expect(({ body }) => {
          expect(body.items?.length ?? body.length).toBeDefined();
        });

      const createResponse = await api
        .post('/v1/translation-jobs')
        .set(headers)
        .send({
          sourceType: 'catalog',
          mediaId: 'inception',
          subtitleSourceId: stableSubtitleSourceId,
          targetLanguage: 'fr',
        })
        .expect(201);

      const completedJob = await pollUntil({
        label: `Catalog translation job ${createResponse.body.id}`,
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

      expect(completedJob.status).toBe('completed');
      expect(typeof completedJob.subtitleConfidenceScore).toBe('number');
      expect(completedJob.subtitleConfidenceScore).toBeGreaterThanOrEqual(0);
      expect(completedJob.subtitleConfidenceScore).toBeLessThanOrEqual(100);
      expect(['high', 'medium', 'low']).toContain(
        completedJob.subtitleConfidenceLevel,
      );
      expect(Array.isArray(completedJob.subtitleWarnings)).toBe(true);
      expect(typeof completedJob.subtitleTimingOffsetMs).toBe('number');
      expect(typeof completedJob.subtitleTimingConfidence).toBe('number');
      expect(typeof completedJob.subtitleTimingCorrected).toBe('boolean');
    });
  });

  it('fails a catalog job when downloaded subtitles are clearly broken and persists confidence warnings', async () => {
    process.env.SUBDL_API_KEY = process.env.SUBDL_API_KEY || 'test-key';
    process.env.SUBDL_ENABLED = 'true';
    process.env.PODNAPISI_ENABLED = 'false';
    process.env.TVSUBS_ENABLED = 'false';

    const stableSubtitleSourceId = buildSubtitleSourceId('subdl', '456');
    const brokenSrt = [
      '1',
      '00:00:05,000 --> 00:00:01,000',
      'I am the one.',
      '',
      '2',
      '00:00:06,000 --> 00:00:07,000',
      'And the only.',
      '',
    ].join('\n');
    const zipBytes = Buffer.from(
      zipSync({
        'sub.srt': new TextEncoder().encode(brokenSrt),
      }),
    );

    vi.stubGlobal(
      'fetch',
      vi.fn(async (input: RequestInfo | URL) => {
        const url =
          typeof input === 'string'
            ? input
            : input instanceof URL
              ? input.toString()
              : input.url;

        if (url.startsWith('https://api.subdl.com/api/v1/subtitles')) {
          return new Response(
            JSON.stringify({
              status: true,
              subtitles: [
                {
                  subtitle_id: '456',
                  movie_name: 'Inception',
                  release_name: 'Inception.2010.1080p.BluRay.x264-GRP',
                  language: 'EN',
                  url: 'https://subdl.com/subtitle/456',
                  downloads: 100,
                },
              ],
            }),
            {
              status: 200,
              headers: { 'content-type': 'application/json' },
            },
          );
        }

        if (url === 'https://subdl.com/subtitle/456') {
          return new Response(
            `<html><body><a href="https://subdl.com/download/456.zip">download</a></body></html>`,
            {
              status: 200,
              headers: { 'content-type': 'text/html' },
            },
          );
        }

        if (url === 'https://subdl.com/download/456.zip') {
          return new Response(zipBytes, {
            status: 200,
            headers: {
              'content-type': 'application/zip',
              'content-disposition': 'attachment; filename="subtitles.zip"',
            },
          });
        }

        return new Response('not found', { status: 404 });
      }),
    );

    await withE2eApp(async (app) => {
      const api = createApiRequest(app);
      const headers = createDeviceHeaders('catalog-translation-e2e-002');

      const createResponse = await api
        .post('/v1/translation-jobs')
        .set(headers)
        .send({
          sourceType: 'catalog',
          mediaId: 'inception',
          subtitleSourceId: stableSubtitleSourceId,
          targetLanguage: 'fr',
        })
        .expect(201);

      const failedJob = await pollUntil({
        label: `Catalog translation job ${createResponse.body.id}`,
        poll: async () =>
          (
            await api
              .get(`/v1/translation-jobs/${createResponse.body.id}`)
              .set(headers)
          ).body,
        isDone: (candidate) => candidate.status === 'failed',
      });

      expect(failedJob.status).toBe('failed');
      expect(failedJob.errorMessage).toContain('subtitle file');
      expect(failedJob.subtitleWarnings).toEqual(
        expect.arrayContaining(['invalid_timing_ranges']),
      );
    });
  });

  it('detects and corrects a constant timing offset before translation', async () => {
    process.env.SUBDL_API_KEY = process.env.SUBDL_API_KEY || 'test-key';
    process.env.SUBDL_ENABLED = 'true';
    process.env.PODNAPISI_ENABLED = 'false';
    process.env.TVSUBS_ENABLED = 'false';
    process.env.SUBTITLE_ALIGNMENT_ENABLED = 'true';
    process.env.SUBTITLE_ALIGNMENT_MAX_OFFSET_MS = '10000';
    process.env.SUBTITLE_ALIGNMENT_STEP_MS = '1000';
    process.env.SUBTITLE_ALIGNMENT_CONFIDENCE_THRESHOLD = '60';

    const stableSubtitleSourceId = buildSubtitleSourceId('subdl', '789');
    const offsetSrt = [
      '1',
      '00:00:00,000 --> 00:00:01,200',
      'I am the one.',
      '',
      '2',
      '00:00:01,500 --> 00:00:03,000',
      'And the only.',
      '',
      '3',
      '00:00:04,000 --> 00:00:06,000',
      'You and I will go to the end.',
      '',
    ].join('\n');
    const zipBytes = Buffer.from(
      zipSync({
        'sub.srt': new TextEncoder().encode(offsetSrt),
      }),
    );

    vi.stubGlobal(
      'fetch',
      vi.fn(async (input: RequestInfo | URL) => {
        const url =
          typeof input === 'string'
            ? input
            : input instanceof URL
              ? input.toString()
              : input.url;

        if (url.startsWith('https://api.subdl.com/api/v1/subtitles')) {
          return new Response(
            JSON.stringify({
              status: true,
              subtitles: [
                {
                  subtitle_id: '789',
                  movie_name: 'Inception',
                  release_name: 'Inception.2010.1080p.BluRay.x264-GRP',
                  language: 'EN',
                  url: 'https://subdl.com/subtitle/789',
                  downloads: 100,
                },
              ],
            }),
            {
              status: 200,
              headers: { 'content-type': 'application/json' },
            },
          );
        }

        if (url === 'https://subdl.com/subtitle/789') {
          return new Response(
            `<html><body><a href="https://subdl.com/download/789.zip">download</a></body></html>`,
            {
              status: 200,
              headers: { 'content-type': 'text/html' },
            },
          );
        }

        if (url === 'https://subdl.com/download/789.zip') {
          return new Response(zipBytes, {
            status: 200,
            headers: {
              'content-type': 'application/zip',
              'content-disposition': 'attachment; filename="subtitles.zip"',
            },
          });
        }

        return new Response('not found', { status: 404 });
      }),
    );

    await withE2eApp(async (app) => {
      const api = createApiRequest(app);
      const headers = createDeviceHeaders('catalog-translation-e2e-003');

      const createResponse = await api
        .post('/v1/translation-jobs')
        .set(headers)
        .send({
          sourceType: 'catalog',
          mediaId: 'inception',
          subtitleSourceId: stableSubtitleSourceId,
          targetLanguage: 'fr',
        })
        .expect(201);

      const completedJob = await pollUntil({
        label: `Catalog translation job ${createResponse.body.id}`,
        poll: async () =>
          (
            await api
              .get(`/v1/translation-jobs/${createResponse.body.id}`)
              .set(headers)
          ).body,
        isDone: (candidate) => candidate.status === 'completed',
      });

      expect(completedJob.subtitleTimingCorrected).toBe(true);
      expect(completedJob.subtitleTimingOffsetMs).toBe(1000);
      expect(completedJob.subtitleTimingConfidence).toBeGreaterThanOrEqual(60);
    });
  });

  it('reuses an existing target-language subtitle and skips AI translation', async () => {
    process.env.SUBDL_API_KEY = process.env.SUBDL_API_KEY || 'test-key';
    process.env.SUBDL_ENABLED = 'true';
    process.env.PODNAPISI_ENABLED = 'false';
    process.env.TVSUBS_ENABLED = 'false';

    const stableEnglishSubtitleSourceId = buildSubtitleSourceId('subdl', '123');
    const englishZipBytes = Buffer.from(
      zipSync({
        'sub.srt': new TextEncoder().encode(sampleSrt),
      }),
    );

    const frenchSrt = Array.from({ length: 20 })
      .map((_, index) => {
        const cueIndex = index + 1;
        const startSeconds = cueIndex * 6;
        const endSeconds = startSeconds + 2;
        const toTimestamp = (seconds: number) => {
          const mm = Math.floor(seconds / 60);
          const ss = seconds % 60;
          return `00:${mm.toString().padStart(2, '0')}:${ss.toString().padStart(2, '0')},000`;
        };

        return [
          `${cueIndex}`,
          `${toTimestamp(startSeconds)} --> ${toTimestamp(endSeconds)}`,
          `Ligne francaise ${cueIndex}`,
          '',
        ].join('\n');
      })
      .join('\n');

    const frenchZipBytes = Buffer.from(
      zipSync({
        'sub-fr.srt': new TextEncoder().encode(frenchSrt),
      }),
    );

    vi.stubGlobal(
      'fetch',
      vi.fn(async (input: RequestInfo | URL) => {
        const url =
          typeof input === 'string'
            ? input
            : input instanceof URL
              ? input.toString()
              : input.url;

        if (url.startsWith('https://api.subdl.com/api/v1/subtitles')) {
          return new Response(
            JSON.stringify({
              status: true,
              subtitles: [
                {
                  subtitle_id: '123',
                  movie_name: 'Inception',
                  release_name: 'Inception.2010.1080p.BluRay.x264-GRP',
                  language: 'EN',
                  url: 'https://subdl.com/subtitle/123',
                  downloads: 100,
                },
                {
                  subtitle_id: '124',
                  movie_name: 'Inception',
                  release_name: 'Inception.2010.1080p.BluRay.x264-GRP',
                  language: 'FR',
                  url: 'https://subdl.com/subtitle/124',
                  downloads: 90,
                },
              ],
            }),
            {
              status: 200,
              headers: { 'content-type': 'application/json' },
            },
          );
        }

        if (url === 'https://subdl.com/subtitle/123') {
          return new Response(
            `<html><body><a href="https://subdl.com/download/123.zip">download</a></body></html>`,
            {
              status: 200,
              headers: { 'content-type': 'text/html' },
            },
          );
        }

        if (url === 'https://subdl.com/subtitle/124') {
          return new Response(
            `<html><body><a href="https://subdl.com/download/124.zip">download</a></body></html>`,
            {
              status: 200,
              headers: { 'content-type': 'text/html' },
            },
          );
        }

        if (url === 'https://subdl.com/download/123.zip') {
          return new Response(englishZipBytes, {
            status: 200,
            headers: {
              'content-type': 'application/zip',
              'content-disposition': 'attachment; filename="subtitles.zip"',
            },
          });
        }

        if (url === 'https://subdl.com/download/124.zip') {
          return new Response(frenchZipBytes, {
            status: 200,
            headers: {
              'content-type': 'application/zip',
              'content-disposition': 'attachment; filename="subtitles.zip"',
            },
          });
        }

        return new Response('not found', { status: 404 });
      }),
    );

    await withE2eApp(async (app) => {
      const api = createApiRequest(app);
      const headers = createDeviceHeaders('catalog-translation-e2e-004');

      const createResponse = await api
        .post('/v1/translation-jobs')
        .set(headers)
        .send({
          sourceType: 'catalog',
          mediaId: 'inception',
          subtitleSourceId: stableEnglishSubtitleSourceId,
          targetLanguage: 'fr',
        })
        .expect(201);

      const completedJob = await pollUntil({
        label: `Catalog translation job ${createResponse.body.id}`,
        poll: async () =>
          (
            await api
              .get(`/v1/translation-jobs/${createResponse.body.id}`)
              .set(headers)
          ).body,
        isDone: (candidate) => candidate.status === 'completed',
      });

      const exported = await api
        .get(`/v1/translation-jobs/${createResponse.body.id}/export`)
        .set(headers)
        .expect(200);

      expect(exported.text).toContain('Ligne francaise 1');
      expect(exported.text).not.toContain('Version francaise');
      expect(completedJob.subtitleAcquisitionMode).toBe(
        'existing_target_subtitle',
      );
      expect(completedJob.reusedExistingSubtitle).toBe(true);
      expect(completedJob.reusedSubtitleConfidenceScore).toBeGreaterThan(0);
    });
  });
});
