import { Injectable, Logger } from '@nestjs/common';
import { AppLanguage } from '@prisma/client';

import { CatalogService } from 'features/catalog/catalog.service';
import { SubtitleQualityEvaluationService } from 'features/catalog/subtitle-quality-evaluation.service';
import { CatalogSubtitleSource } from 'features/catalog/models/catalog-subtitle-source.model';

import { SubtitleAcquisitionDecision } from 'features/translation-jobs/models/subtitle-acquisition-decision.model';
import { canReuseTargetLanguageSubtitle } from 'features/translation-jobs/utils/subtitle-acquisition-policy.util';

const normalizeLang = (value: string): string => value.trim().toLowerCase();

@Injectable()
export class SubtitleAcquisitionStrategyService {
  private readonly logger = new Logger(SubtitleAcquisitionStrategyService.name);

  constructor(
    private readonly catalogService: CatalogService,
    private readonly subtitleQualityEvaluationService: SubtitleQualityEvaluationService,
  ) {}

  async decideCatalogAcquisition(params: {
    mediaId: string;
    fallbackSubtitleSourceId: string;
    targetLanguage: AppLanguage;
    seasonNumber?: number;
    episodeNumber?: number;
    releaseHint?: string;
  }): Promise<SubtitleAcquisitionDecision> {
    const requestedTargetLanguage = normalizeLang(params.targetLanguage);

    const media = await this.catalogService.findById(params.mediaId);
    if (!media) {
      return {
        acquisitionMode: 'ai_translation',
        subtitleSourceIdToUse: params.fallbackSubtitleSourceId,
        selectedLanguageCode: 'en',
        requestedTargetLanguage,
        reusedExistingSubtitle: false,
        reason: 'media_not_found',
      };
    }

    let candidates: CatalogSubtitleSource[] = [];
    try {
      const results = await this.catalogService.getSubtitleSources(
        params.mediaId,
        {
          preferredLanguage: requestedTargetLanguage,
          seasonNumber: params.seasonNumber,
          episodeNumber: params.episodeNumber,
          releaseHint: params.releaseHint,
        },
      );

      candidates = results.filter(
        (candidate) =>
          normalizeLang(candidate.languageCode ?? '') ===
          requestedTargetLanguage,
      );
    } catch (error) {
      const message = error instanceof Error ? error.message : 'Unknown error';
      this.logger.warn(
        `Target-language subtitle discovery failed for ${params.mediaId}: ${message}`,
      );
      candidates = [];
    }

    if (candidates.length === 0) {
      return {
        acquisitionMode: 'ai_translation',
        subtitleSourceIdToUse: params.fallbackSubtitleSourceId,
        selectedLanguageCode: 'en',
        requestedTargetLanguage,
        reusedExistingSubtitle: false,
        reason: 'no_target_subtitle_candidates',
      };
    }

    const candidatesToEvaluate = candidates.slice(0, 2);

    for (const candidate of candidatesToEvaluate) {
      try {
        const cues = await this.catalogService.getSubtitleCues(
          params.mediaId,
          candidate.id,
        );

        const evaluation =
          this.subtitleQualityEvaluationService.evaluateCatalogJob({
            media,
            cues,
            subtitleSourceId: candidate.id,
            sourceName: candidate.label,
            releaseHint: params.releaseHint,
            seasonNumber: params.seasonNumber,
            episodeNumber: params.episodeNumber,
            expectedLanguageCode: requestedTargetLanguage,
          });

        const policy = canReuseTargetLanguageSubtitle(evaluation);
        if (policy.allowed) {
          return {
            acquisitionMode: 'existing_target_subtitle',
            subtitleSourceIdToUse: candidate.id,
            selectedLanguageCode: requestedTargetLanguage,
            requestedTargetLanguage,
            reusedExistingSubtitle: true,
            reason: policy.reason,
            subtitleSourceLabel: candidate.label,
            subtitleSourceFormat: candidate.format,
            reusedSubtitleQuality: {
              confidenceScore: evaluation.confidenceScore,
              confidenceLevel: evaluation.confidenceLevel,
              warnings: evaluation.warnings,
            },
            cues,
          };
        }
      } catch (error) {
        const message =
          error instanceof Error ? error.message : 'Unknown error';
        this.logger.warn(
          `Target-language subtitle evaluation failed for ${candidate.id}: ${message}`,
        );
      }
    }

    return {
      acquisitionMode: 'ai_translation',
      subtitleSourceIdToUse: params.fallbackSubtitleSourceId,
      selectedLanguageCode: 'en',
      requestedTargetLanguage,
      reusedExistingSubtitle: false,
      reason: 'target_subtitle_rejected',
    };
  }
}
