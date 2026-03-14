import { SubtitleFormat } from '@prisma/client';

import { ValidationDomainError } from 'common/domain/errors/domain.error';
import { SubtitleParserService } from 'features/subtitles/utils/subtitle-parser.service';

import { sampleSrt, sampleVtt } from 'test/core/shared/subtitle-fixtures';

describe('SubtitleParserService', () => {
  let service: SubtitleParserService;

  beforeEach(() => {
    service = new SubtitleParserService();
  });

  it('parses SRT content into normalized cues', () => {
    const cues = service.parse({
      content: sampleSrt,
      format: SubtitleFormat.srt,
    });

    expect(cues).toHaveLength(2);
    expect(cues[0]).toMatchObject({
      cueIndex: 1,
      startMs: 1000,
      endMs: 3500,
      text: 'We only have one clean pass.',
    });
  });

  it('parses VTT content into normalized cues', () => {
    const cues = service.parse({
      content: sampleVtt,
      format: SubtitleFormat.vtt,
    });

    expect(cues).toHaveLength(2);
    expect(cues[1]).toMatchObject({
      cueIndex: 2,
      startMs: 4000,
      endMs: 6250,
      text: 'Keep the line open.',
    });
  });

  it('rejects files that do not contain any valid subtitle cues', () => {
    expect(() =>
      service.parse({
        content: 'WEBVTT\n\nthis is not a cue block',
        format: SubtitleFormat.vtt,
      }),
    ).toThrow(ValidationDomainError);
  });
});
