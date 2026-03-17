import { Injectable } from '@nestjs/common';
import { AppLanguage } from '@prisma/client';

import { StructuredLogger } from 'common/utils/structured-logger';
import { CatalogService } from 'features/catalog/catalog.service';
import { SubtitleQualityEvaluationService } from 'features/catalog/subtitle-quality-evaluation.service';
import { CatalogSubtitleSource } from 'features/catalog/models/catalog-subtitle-source.model';

import { SubtitleAcquisitionDecision } from 'features/translation-jobs/models/subtitle-acquisition-decision.model';
import { canReuseTargetLanguageSubtitle } from 'features/translation-jobs/utils/subtitle-acquisition-policy.util';

const normalizeLang = (value: string): string => value.trim().toLowerCase();

@Injectable()
export class SubtitleAcquisitionStrategyService {
  private readonly log = new StructuredLogger(
    SubtitleAcquisitionStrategyService.name,
  );

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

    this.log.info('subtitle.acquisition.start', {
      mediaId: params.mediaId,
      targetLanguage: requestedTargetLanguage,
      fallbackSubtitleSourceId: params.fallbackSubtitleSourceId,
    });

    const media = await this.catalogService.findById(params.mediaId);
    if (!media) {
      const decision: SubtitleAcquisitionDecision = {
        acquisitionMode: 'ai_translation',
        subtitleSourceIdToUse: params.fallbackSubtitleSourceId,
        selectedLanguageCode: 'en',
        requestedTargetLanguage,
        reusedExistingSubtitle: false,
        reason: 'media_not_found',
      };

      this.log.warn('subtitle.acquisition.decision', {
        mediaId: params.mediaId,
        mode: decision.acquisitionMode,
        reason: decision.reason,
        subtitleSourceIdToUse: decision.subtitleSourceIdToUse,
      });

      return decision;
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
      this.log.warn('subtitle.acquisition.discovery.failed', {
        mediaId: params.mediaId,
        targetLanguage: requestedTargetLanguage,
        message,
      });
      candidates = [];
    }

    this.log.info('subtitle.acquisition.candidates.found', {
      mediaId: params.mediaId,
      targetLanguage: requestedTargetLanguage,
      count: candidates.length,
    });

    if (candidates.length === 0) {
      const decision: SubtitleAcquisitionDecision = {
        acquisitionMode: 'ai_translation',
        subtitleSourceIdToUse: params.fallbackSubtitleSourceId,
        selectedLanguageCode: 'en',
        requestedTargetLanguage,
        reusedExistingSubtitle: false,
        reason: 'no_target_subtitle_candidates',
      };

      this.log.info('subtitle.acquisition.decision', {
        mediaId: params.mediaId,
        mode: decision.acquisitionMode,
        reason: decision.reason,
        subtitleSourceIdToUse: decision.subtitleSourceIdToUse,
      });

      return decision;
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
          const decision: SubtitleAcquisitionDecision = {
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

          this.log.info('subtitle.acquisition.decision', {
            mediaId: params.mediaId,
            mode: decision.acquisitionMode,
            reason: decision.reason,
            subtitleSourceIdToUse: decision.subtitleSourceIdToUse,
            confidenceScore: evaluation.confidenceScore,
            confidenceLevel: evaluation.confidenceLevel,
          });

          return decision;
        }
      } catch (error) {
        const message =
          error instanceof Error ? error.message : 'Unknown error';
        this.log.warn('subtitle.acquisition.candidate.failed', {
          subtitleSourceId: candidate.id,
          mediaId: params.mediaId,
          message,
        });
      }
    }

    const decision: SubtitleAcquisitionDecision = {
      acquisitionMode: 'ai_translation',
      subtitleSourceIdToUse: params.fallbackSubtitleSourceId,
      selectedLanguageCode: 'en',
      requestedTargetLanguage,
      reusedExistingSubtitle: false,
      reason: 'target_subtitle_rejected',
    };

    this.log.info('subtitle.acquisition.decision', {
      mediaId: params.mediaId,
      mode: decision.acquisitionMode,
      reason: decision.reason,
      subtitleSourceIdToUse: decision.subtitleSourceIdToUse,
    });

    return decision;
  }
}
