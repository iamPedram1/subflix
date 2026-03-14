import { parseReleaseHint } from 'features/catalog/utils/release-hint-parser.util';

describe('parseReleaseHint', () => {
  it('parses bluray, resolution, codec, and release group from a typical release name', () => {
    const parsed = parseReleaseHint('Inception.2010.1080p.BluRay.x264-YIFY');

    expect(parsed.sourceType).toBe('bluray');
    expect(parsed.resolution).toBe(1080);
    expect(parsed.codec).toBe('x264');
    expect(parsed.releaseGroup).toBe('yify');
    expect(parsed.tokens).toEqual(
      expect.arrayContaining(['1080p', 'bluray', 'x264', 'yify']),
    );
  });

  it('parses WEB-DL and H.264 tokenization variants', () => {
    const parsed = parseReleaseHint('Show.S01E01.720p.WEB-DL.H.264-GROUP');

    expect(parsed.sourceType).toBe('webdl');
    expect(parsed.resolution).toBe(720);
    expect(parsed.codec).toBe('h264');
    expect(parsed.releaseGroup).toBe('group');
  });

  it('prefers an explicit releaseGroup override', () => {
    const parsed = parseReleaseHint('Movie.1080p.WEBRip.x265-Other', {
      releaseGroupOverride: 'MyGroup',
    });

    expect(parsed.sourceType).toBe('webrip');
    expect(parsed.resolution).toBe(1080);
    expect(parsed.codec).toBe('x265');
    expect(parsed.releaseGroup).toBe('mygroup');
  });

  it('returns an empty token set for empty input', () => {
    expect(parseReleaseHint(undefined).tokens).toEqual([]);
    expect(parseReleaseHint('').tokens).toEqual([]);
    expect(parseReleaseHint('   ').tokens).toEqual([]);
  });
});
