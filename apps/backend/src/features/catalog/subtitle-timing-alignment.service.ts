import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import { SubtitleCue } from 'features/subtitles/models/subtitle-cue.model';

import { SubtitleTimingAnalysis } from 'features/catalog/models/subtitle-timing-analysis.model';
import { analyzeSubtitleTimingOffset } from 'features/catalog/utils/subtitle-timing-alignment.util';

@Injectable()
export class SubtitleTimingAlignmentService {
  constructor(private readonly configService: ConfigService) {}

  alignCatalogCues(cues: SubtitleCue[]): {
    cues: SubtitleCue[];
    analysis: SubtitleTimingAnalysis;
  } {
    return analyzeSubtitleTimingOffset({
      cues,
      enabled:
        (this.configService.get<boolean>('subtitleAlignment.enabled') ??
          true) &&
        cues.length > 0,
      maxOffsetMs:
        this.configService.get<number>('subtitleAlignment.maxOffsetMs') ??
        10_000,
      stepMs:
        this.configService.get<number>('subtitleAlignment.stepMs') ?? 1_000,
      confidenceThreshold:
        this.configService.get<number>(
          'subtitleAlignment.confidenceThreshold',
        ) ?? 60,
    });
  }
}
