import { Injectable } from '@nestjs/common';
import { SubtitleFormat } from '@prisma/client';

import { SubtitleExportCue } from '../models/subtitle-cue.model';

@Injectable()
/** Converts normalized subtitle cues back into downloadable subtitle file text. */
export class SubtitleExportService {
  /** Formats cues using either SRT or VTT output rules. */
  formatCues(cues: SubtitleExportCue[], format: SubtitleFormat): string {
    return format === SubtitleFormat.vtt ? this.toVtt(cues) : this.toSrt(cues);
  }

  /** Serializes cues using the SRT format. */
  private toSrt(cues: SubtitleExportCue[]): string {
    return cues
      .map(
        (cue) =>
          `${cue.cueIndex}\n${this.formatTimestamp(cue.startMs, ',')} --> ${this.formatTimestamp(cue.endMs, ',')}\n${cue.text}`,
      )
      .join('\n\n');
  }

  /** Serializes cues using the VTT format with the required header. */
  private toVtt(cues: SubtitleExportCue[]): string {
    const body = cues
      .map(
        (cue) =>
          `${cue.cueIndex}\n${this.formatTimestamp(cue.startMs, '.')} --> ${this.formatTimestamp(cue.endMs, '.')}\n${cue.text}`,
      )
      .join('\n\n');

    return `WEBVTT\n\n${body}`;
  }

  /** Formats milliseconds into an SRT- or VTT-compatible timestamp token. */
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
