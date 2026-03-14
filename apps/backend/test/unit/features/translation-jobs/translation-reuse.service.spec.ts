import { AppLanguage } from '@prisma/client';

import { TranslationJobsRepository } from 'features/translation-jobs/translation-jobs.repository';
import { TranslationReuseService } from 'features/translation-jobs/translation-reuse.service';

describe('TranslationReuseService', () => {
  it('returns not allowed when no completed reusable job exists', async () => {
    const repository = {
      findReusableCatalogTranslation: vi.fn().mockResolvedValue(null),
    } as unknown as TranslationJobsRepository;

    const service = new TranslationReuseService(repository);

    const decision = await service.decideCatalogTranslationReuse({
      clientDeviceId: 'device-1',
      subtitleSourceId: 'ssrc:subdl:abc',
      targetLanguage: AppLanguage.fr,
      alignedCues: [
        { cueIndex: 1, startMs: 1_000, endMs: 2_000, text: 'Hello' },
      ],
      excludeJobId: 'job-1',
    });

    expect(decision.reuseAllowed).toBe(false);
    expect(decision.reuseReason).toBe('no_reusable_translation');
  });

  it('rejects reuse when cue shape is incompatible', async () => {
    const repository = {
      findReusableCatalogTranslation: vi.fn().mockResolvedValue({
        jobId: 'job-old',
        cues: [
          {
            cueIndex: 1,
            startMs: 999,
            endMs: 2_000,
            translatedText: 'Salut',
          },
        ],
      }),
    } as unknown as TranslationJobsRepository;

    const service = new TranslationReuseService(repository);

    const decision = await service.decideCatalogTranslationReuse({
      clientDeviceId: 'device-1',
      subtitleSourceId: 'ssrc:subdl:abc',
      targetLanguage: AppLanguage.fr,
      alignedCues: [
        { cueIndex: 1, startMs: 1_000, endMs: 2_000, text: 'Hello' },
      ],
      excludeJobId: 'job-1',
    });

    expect(decision.reuseAllowed).toBe(false);
    expect(decision.reuseReason).toBe('cue_timing_mismatch');
  });

  it('allows reuse when cues are compatible', async () => {
    const repository = {
      findReusableCatalogTranslation: vi.fn().mockResolvedValue({
        jobId: 'job-old',
        cues: [
          {
            cueIndex: 1,
            startMs: 1_000,
            endMs: 2_000,
            translatedText: 'Salut',
          },
          {
            cueIndex: 2,
            startMs: 2_500,
            endMs: 3_000,
            translatedText: 'Monde',
          },
        ],
      }),
    } as unknown as TranslationJobsRepository;

    const service = new TranslationReuseService(repository);

    const decision = await service.decideCatalogTranslationReuse({
      clientDeviceId: 'device-1',
      subtitleSourceId: 'ssrc:subdl:abc',
      targetLanguage: AppLanguage.fr,
      alignedCues: [
        { cueIndex: 1, startMs: 1_000, endMs: 2_000, text: 'Hello' },
        { cueIndex: 2, startMs: 2_500, endMs: 3_000, text: 'World' },
      ],
      excludeJobId: 'job-1',
    });

    expect(decision.reuseAllowed).toBe(true);
    expect(decision.reusableJobId).toBe('job-old');
    expect(decision.translatedCues?.map((cue) => cue.translatedText)).toEqual([
      'Salut',
      'Monde',
    ]);
  });
});
