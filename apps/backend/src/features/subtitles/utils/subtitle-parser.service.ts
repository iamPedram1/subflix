import { Injectable } from '@nestjs/common';
import { SubtitleFormat } from '@prisma/client';

import { ValidationDomainError } from 'common/domain/errors/domain.error';

import { SubtitleCue } from 'features/subtitles/models/subtitle-cue.model';

@Injectable()
/** Parses raw subtitle text into normalized cue objects shared across the app. */
export class SubtitleParserService {
  /** Parses `.srt` or `.vtt` content into normalized cues. */
  parse(params: { content: string; format: SubtitleFormat }): SubtitleCue[] {
    const normalizedContent = params.content.replace(/\r\n/g, '\n').trim();
    const withoutHeader =
      params.format === SubtitleFormat.vtt
        ? normalizedContent.replace(/^WEBVTT[^\n]*\n+/i, '')
        : normalizedContent;

    const blocks = withoutHeader
      .split(/\n{2,}/)
      .map((block) => block.trim())
      .filter(Boolean);

    const cues = blocks
      .map((block, index) => this.parseBlock(block, index + 1))
      .filter((cue): cue is SubtitleCue => cue !== null);

    if (cues.length === 0) {
      throw new ValidationDomainError(
        'The subtitle file did not contain valid cues.',
        undefined,
        {
          key: 'errors.subtitles.no_valid_cues',
        },
      );
    }

    return cues;
  }

  /** Parses a single subtitle block into a normalized cue when possible. */
  private parseBlock(block: string, fallbackIndex: number): SubtitleCue | null {
    const lines = block.split('\n').map((line) => line.trimEnd());
    const firstLine = lines[0]?.trim() ?? '';
    const hasExplicitIndex = /^\d+$/.test(firstLine);
    const timingLine = hasExplicitIndex ? lines[1] : lines[0];
    const textLines = hasExplicitIndex ? lines.slice(2) : lines.slice(1);

    if (!timingLine || !timingLine.includes('-->')) {
      return null;
    }

    const [startToken, endToken] = timingLine.split(/\s+-->\s+/);
    if (!startToken || !endToken) {
      return null;
    }

    const cleanEndToken = endToken.split(/\s+/)[0] ?? endToken;
    const text = textLines.join('\n').trim();
    if (!text) {
      return null;
    }

    return {
      cueIndex: hasExplicitIndex ? Number(firstLine) : fallbackIndex,
      startMs: this.parseTimestamp(startToken),
      endMs: this.parseTimestamp(cleanEndToken),
      text,
    };
  }

  /** Converts an SRT/VTT timestamp token into absolute milliseconds. */
  private parseTimestamp(value: string): number {
    const normalized = value.trim().replace(',', '.');
    const [timePart, millisecondsPart = '000'] = normalized.split('.');
    const segments = timePart.split(':').map((segment) => Number(segment));

    if (segments.some((segment) => Number.isNaN(segment))) {
      throw new ValidationDomainError(
        `Invalid subtitle timestamp: ${value}`,
        undefined,
        {
          key: 'errors.subtitles.invalid_timestamp',
          args: { value },
        },
      );
    }

    const [hours, minutes, seconds] =
      segments.length === 3
        ? segments
        : [0, segments[0] ?? 0, segments[1] ?? 0];

    return (
      hours * 3_600_000 +
      minutes * 60_000 +
      seconds * 1_000 +
      Number(millisecondsPart.padEnd(3, '0').slice(0, 3))
    );
  }
}
