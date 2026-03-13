import { Injectable } from '@nestjs/common';
import { SubtitleFormat } from '@prisma/client';

import { SubtitleExportCue } from '../models/subtitle-cue.model';

@Injectable()
export class SubtitleExportService {
  formatCues(cues: SubtitleExportCue[], format: SubtitleFormat): string {
    return format === SubtitleFormat.vtt
      ? this.toVtt(cues)
      : this.toSrt(cues);
  }

  private toSrt(cues: SubtitleExportCue[]): string {
    return cues
      .map(
        (cue) =>
          `${cue.cueIndex}\n${this.formatTimestamp(cue.startMs, ',')} --> ${this.formatTimestamp(cue.endMs, ',')}\n${cue.text}`,
      )
      .join('\n\n');
  }

  private toVtt(cues: SubtitleExportCue[]): string {
    const body = cues
      .map(
        (cue) =>
          `${cue.cueIndex}\n${this.formatTimestamp(cue.startMs, '.')} --> ${this.formatTimestamp(cue.endMs, '.')}\n${cue.text}`,
      )
      .join('\n\n');

    return `WEBVTT\n\n${body}`;
  }

  private formatTimestamp(milliseconds: number, separator: ',' | '.'): string {
    const totalMilliseconds = Math.max(0, milliseconds);
    const hours = Math.floor(totalMilliseconds / 3_600_000);
    const minutes = Math.floor((totalMilliseconds % 3_600_000) / 60_000);
    const seconds = Math.floor((totalMilliseconds % 60_000) / 1_000);
    const ms = totalMilliseconds % 1_000;

    return `${hours.toString().padStart(2, '0')}:${minutes
      .toString()
      .padStart(2, '0')}:${seconds.toString().padStart(2, '0')}${separator}${ms
      .toString()
      .padStart(3, '0')}`;
  }
}
