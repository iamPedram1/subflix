import { zipSync } from 'fflate';

import {
  rankArchiveEntries,
  unzipToEntries,
} from 'features/catalog/utils/subtitle-archive.util';

describe('subtitle-archive.util', () => {
  it('ignores zip-slip style entry names', () => {
    const zipped = zipSync({
      '../evil.srt': new TextEncoder().encode(
        '1\n00:00:00,000 --> 00:00:01,000\nHi\n',
      ),
      'safe.srt': new TextEncoder().encode(
        '1\n00:00:00,000 --> 00:00:01,000\nHello\n',
      ),
    });

    const entries = unzipToEntries(Buffer.from(zipped));
    expect(entries.some((entry) => entry.fileName.includes('evil'))).toBe(
      false,
    );
    expect(entries.some((entry) => entry.fileName === 'safe.srt')).toBe(true);
  });

  it('ranks .srt files above non-subtitle junk', () => {
    const entries = [
      { fileName: 'README.txt', bytes: Buffer.from('readme') },
      { fileName: 'subtitle.vtt', bytes: Buffer.from('WEBVTT\n\n') },
      {
        fileName: 'subtitle.srt',
        bytes: Buffer.from('1\n00:00:00,000 --> 00:00:01,000\nHello\n'),
      },
    ];

    const ranked = rankArchiveEntries(entries);
    expect(ranked[0]?.fileName).toBe('subtitle.srt');
  });
});
