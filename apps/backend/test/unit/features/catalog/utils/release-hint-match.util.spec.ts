import { scoreReleaseHintMatch } from 'features/catalog/utils/release-hint-match.util';
import { parseReleaseHint } from 'features/catalog/utils/release-hint-parser.util';

describe('scoreReleaseHintMatch', () => {
  it('rewards exact release group matches', () => {
    const preferred = parseReleaseHint('Movie.1080p.BluRay.x264-YIFY');
    const candidate = parseReleaseHint('Movie.1080p.BluRay.x264-YIFY');

    const breakdown = scoreReleaseHintMatch(preferred, candidate);
    expect(breakdown.groupExact).toBe(true);
    expect(breakdown.scoreDelta).toBeGreaterThanOrEqual(25);
  });

  it('rewards source type, resolution, and codec matches', () => {
    const preferred = parseReleaseHint('Movie.2160p.WEB-DL.x265-GRP');
    const candidate = parseReleaseHint('Movie.2160p.WEB-DL.x265-Other');

    const breakdown = scoreReleaseHintMatch(preferred, candidate);
    expect(breakdown.sourceTypeMatch).toBe(true);
    expect(breakdown.resolutionMatch).toBe(true);
    expect(breakdown.codecMatch).toBe(true);
    expect(breakdown.scoreDelta).toBeGreaterThan(0);
  });

  it('penalizes contradictory source type and resolution when both are known', () => {
    const preferred = parseReleaseHint('Movie.1080p.BluRay.x264-GRP');
    const candidate = parseReleaseHint('Movie.720p.WEB-DL.x264-OTHER');

    const breakdown = scoreReleaseHintMatch(preferred, candidate);
    expect(breakdown.sourceTypeMismatch).toBe(true);
    expect(breakdown.resolutionMismatch).toBe(true);
    expect(breakdown.scoreDelta).toBeLessThan(0);
  });
});
