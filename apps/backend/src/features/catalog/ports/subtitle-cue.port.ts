import { SubtitleCue } from 'features/subtitles/models/subtitle-cue.model';

export const SUBTITLE_CUE_PORT = Symbol('SUBTITLE_CUE_PORT');

export interface SubtitleCuePort {
  getSubtitleCues(
    mediaId: string,
    subtitleSourceId: string,
  ): Promise<SubtitleCue[]>;
}
