import { SubtitleFormat } from '@prisma/client';

import { SubtitleExportService } from 'src/features/subtitles/utils/subtitle-export.service';

describe('SubtitleExportService', () => {
  let service: SubtitleExportService;

  beforeEach(() => {
    service = new SubtitleExportService();
  });

  it('formats SRT cues for download', () => {
    const result = service.formatCues(
      [
        {
          cueIndex: 1,
          startMs: 1000,
          endMs: 3500,
          text: 'Hola mundo.',
        },
      ],
      SubtitleFormat.srt,
    );

    expect(result).toContain('00:00:01,000 --> 00:00:03,500');
    expect(result).toContain('Hola mundo.');
  });

  it('formats VTT cues for download', () => {
    const result = service.formatCues(
      [
        {
          cueIndex: 1,
          startMs: 1000,
          endMs: 3500,
          text: 'Bonjour le monde.',
        },
      ],
      SubtitleFormat.vtt,
    );

    expect(result.startsWith('WEBVTT')).toBe(true);
    expect(result).toContain('00:00:01.000 --> 00:00:03.500');
  });
});
