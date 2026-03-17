import { Injectable } from '@nestjs/common';
import { AppLanguage } from '@prisma/client';

import { StructuredLogger } from 'common/utils/structured-logger';
import { SubtitleCue } from 'features/subtitles/models/subtitle-cue.model';
import { TranslationJobsRepository } from 'features/translation-jobs/translation-jobs.repository';
import { TranslationReuseDecision } from 'features/translation-jobs/models/translation-reuse-decision.model';
import {
  checkTranslationReuseCompatibility,
  TranslatedCue,
} from 'features/translation-jobs/utils/translation-reuse-compat.util';

@Injectable()
export class TranslationReuseService {
  private readonly log = new StructuredLogger(TranslationReuseService.name);

  constructor(
    private readonly translationJobsRepository: TranslationJobsRepository,
  ) {}

  async decideCatalogTranslationReuse(params: {
    clientDeviceId: string;
    subtitleSourceId: string;
    targetLanguage: AppLanguage;
    alignedCues: SubtitleCue[];
    excludeJobId?: string;
  }): Promise<TranslationReuseDecision> {
    const reusable =
      await this.translationJobsRepository.findReusableCatalogTranslation({
        clientDeviceId: params.clientDeviceId,
        subtitleSourceId: params.subtitleSourceId,
        targetLanguage: params.targetLanguage,
        excludeJobId: params.excludeJobId,
      });

    if (!reusable) {
      this.log.info('translation.reuse.miss', {
        subtitleSourceId: params.subtitleSourceId,
        targetLanguage: params.targetLanguage,
        reason: 'no_reusable_translation',
      });
      return { reuseAllowed: false, reuseReason: 'no_reusable_translation' };
    }

    const compatibility = checkTranslationReuseCompatibility(
      params.alignedCues,
      reusable.cues,
    );
    if (!compatibility.compatible) {
      this.log.info('translation.reuse.miss', {
        subtitleSourceId: params.subtitleSourceId,
        targetLanguage: params.targetLanguage,
        reason: compatibility.reason,
      });
      return {
        reuseAllowed: false,
        reuseReason: compatibility.reason,
      };
    }

    this.log.info('translation.reuse.hit', {
      subtitleSourceId: params.subtitleSourceId,
      targetLanguage: params.targetLanguage,
      reusableJobId: reusable.jobId,
      cueCount: reusable.cues.length,
    });

    return {
      reuseAllowed: true,
      reusableJobId: reusable.jobId,
      reuseReason: 'reused_completed_translation',
      translatedCues: reusable.cues satisfies TranslatedCue[],
    };
  }
}
