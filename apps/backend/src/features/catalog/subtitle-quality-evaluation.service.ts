import { Injectable } from '@nestjs/common';

import { SubtitleCue } from 'features/subtitles/models/subtitle-cue.model';

import { CatalogMediaDetails } from 'features/catalog/models/catalog-media-details.model';
import { SubtitleQualityEvaluation } from 'features/catalog/models/subtitle-quality-evaluation.model';
import { evaluateCatalogSubtitleQuality } from 'features/catalog/utils/subtitle-quality.util';

@Injectable()
export class SubtitleQualityEvaluationService {
  evaluateCatalogJob(params: {
    media: CatalogMediaDetails;
    cues: SubtitleCue[];
    subtitleSourceId: string;
    sourceName: string;
    releaseHint?: string;
    seasonNumber?: number;
    episodeNumber?: number;
  }): SubtitleQualityEvaluation {
    return evaluateCatalogSubtitleQuality(params);
  }
}
