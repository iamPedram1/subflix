import { AppLanguage, SubtitleFormat } from '@prisma/client';

import { CatalogService } from 'features/catalog/catalog.service';
import { SubtitleQualityEvaluationService } from 'features/catalog/subtitle-quality-evaluation.service';
import { SubtitleAcquisitionStrategyService } from 'features/translation-jobs/subtitle-acquisition-strategy.service';

describe('SubtitleAcquisitionStrategyService', () => {
  it('reuses a high-confidence target-language subtitle when available', async () => {
    const catalogService = {
      findById: vi.fn().mockResolvedValue({
        id: 'inception',
        title: 'Inception',
        year: 2010,
        mediaType: 'movie',
        providerMediaType: 'movie',
        synopsis: '',
        genres: [],
        runtimeMinutes: 0,
        popularity: 1,
      }),
      getSubtitleSources: vi.fn().mockResolvedValue([
        {
          id: 'ssrc:subdl:fr',
          label: 'French Inception',
          languageCode: 'fr',
          languageName: 'French',
          releaseGroup: 'SubDL',
          format: SubtitleFormat.srt,
          hearingImpaired: false,
          lineCount: 20,
          downloads: 1,
          rating: 0,
        },
      ]),
      getSubtitleCues: vi
        .fn()
        .mockResolvedValue([
          { cueIndex: 1, startMs: 5_000, endMs: 6_000, text: 'Bonjour' },
        ]),
    } as unknown as CatalogService;

    const qualityService = {
      evaluateCatalogJob: vi.fn().mockReturnValue({
        confidenceScore: 70,
        confidenceLevel: 'medium',
        warnings: [],
        shouldBlockAutoUse: false,
        signals: {},
      }),
    } as unknown as SubtitleQualityEvaluationService;

    const service = new SubtitleAcquisitionStrategyService(
      catalogService,
      qualityService,
    );

    const decision = await service.decideCatalogAcquisition({
      mediaId: 'inception',
      fallbackSubtitleSourceId: 'ssrc:subdl:en',
      targetLanguage: AppLanguage.fr,
    });

    expect(decision.acquisitionMode).toBe('existing_target_subtitle');
    expect(decision.subtitleSourceIdToUse).toBe('ssrc:subdl:fr');
    expect(decision.reusedExistingSubtitle).toBe(true);
    expect(catalogService.getSubtitleCues).toHaveBeenCalledWith(
      'inception',
      'ssrc:subdl:fr',
    );
  });

  it('falls back to AI translation when no target-language candidates match', async () => {
    const catalogService = {
      findById: vi.fn().mockResolvedValue({
        id: 'inception',
        title: 'Inception',
        year: 2010,
        mediaType: 'movie',
        providerMediaType: 'movie',
        synopsis: '',
        genres: [],
        runtimeMinutes: 0,
        popularity: 1,
      }),
      getSubtitleSources: vi.fn().mockResolvedValue([
        {
          id: 'ssrc:subdl:en',
          label: 'English Inception',
          languageCode: 'en',
          languageName: 'English',
          releaseGroup: 'SubDL',
          format: SubtitleFormat.srt,
          hearingImpaired: false,
          lineCount: 20,
          downloads: 1,
          rating: 0,
        },
      ]),
      getSubtitleCues: vi.fn(),
    } as unknown as CatalogService;

    const qualityService = {
      evaluateCatalogJob: vi.fn(),
    } as unknown as SubtitleQualityEvaluationService;

    const service = new SubtitleAcquisitionStrategyService(
      catalogService,
      qualityService,
    );

    const decision = await service.decideCatalogAcquisition({
      mediaId: 'inception',
      fallbackSubtitleSourceId: 'ssrc:subdl:en',
      targetLanguage: AppLanguage.fr,
    });

    expect(decision.acquisitionMode).toBe('ai_translation');
    expect(decision.subtitleSourceIdToUse).toBe('ssrc:subdl:en');
    expect(catalogService.getSubtitleCues).not.toHaveBeenCalled();
  });
});
