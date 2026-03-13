import { SubtitleCue } from 'src/features/subtitles/models/subtitle-cue.model';

import { CatalogSubtitleSource } from '../models/catalog-subtitle-source.model';

export const SUBTITLE_SOURCE_PORT = Symbol('SUBTITLE_SOURCE_PORT');

export interface SubtitleSourcePort {
  getSubtitleSources(mediaId: string): Promise<CatalogSubtitleSource[]>;
  getSubtitleCues(
    mediaId: string,
    subtitleSourceId: string,
  ): Promise<SubtitleCue[]>;
}
