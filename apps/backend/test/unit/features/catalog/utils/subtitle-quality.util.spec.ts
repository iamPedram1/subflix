import { SearchMediaType } from 'common/domain/enums/search-media-type.enum';

import { evaluateCatalogSubtitleQuality } from 'features/catalog/utils/subtitle-quality.util';

describe('evaluateCatalogSubtitleQuality', () => {
  const movie = {
    id: 'movie_1',
    title: 'Inception',
    originalTitle: 'Inception',
    year: 2010,
    mediaType: SearchMediaType.Movie,
    providerMediaType: 'movie' as const,
    synopsis: '',
    genres: [],
    runtimeMinutes: 148,
    popularity: 1,
    tmdbId: 27205,
    imdbId: 'tt1375666',
  };

  it('blocks clearly broken cues with invalid timing ranges', () => {
    const result = evaluateCatalogSubtitleQuality({
      media: movie,
      subtitleSourceId: 'ssrc:subdl:abc',
      sourceName: 'Inception.2010.1080p.BluRay.x264-GRP',
      cues: [
        { cueIndex: 1, startMs: 5_000, endMs: 1_000, text: 'I am the one.' },
        { cueIndex: 2, startMs: 6_000, endMs: 7_000, text: 'And the only.' },
      ],
      releaseHint: 'Inception 2010 1080p BluRay x264-GRP',
    });

    expect(result.shouldBlockAutoUse).toBe(true);
    expect(result.warnings).toContain('invalid_timing_ranges');
    expect(result.confidenceLevel).toBe('low');
    expect(result.confidenceScore).toBeLessThan(55);
  });

  it('warns on extremely low cue counts for movies without blocking', () => {
    const result = evaluateCatalogSubtitleQuality({
      media: movie,
      subtitleSourceId: 'ssrc:subdl:def',
      sourceName: 'Inception.2010.1080p.BluRay.x264-GRP',
      cues: [
        { cueIndex: 1, startMs: 1_000, endMs: 3_000, text: 'I am the one.' },
        { cueIndex: 2, startMs: 4_000, endMs: 6_000, text: 'And the only.' },
      ],
      releaseHint: 'Inception 2010 1080p BluRay x264-GRP',
    });

    expect(result.shouldBlockAutoUse).toBe(false);
    expect(result.warnings).toContain('extremely_low_cue_count');
    expect(result.warnings).toContain('suspiciously_short_subtitle');
    expect(result.confidenceScore).toBeLessThan(80);
  });

  it('warns when explicit episode metadata contradicts requested TV episode scope', () => {
    const tv = {
      ...movie,
      id: 'tv_1',
      title: 'Example Show',
      mediaType: SearchMediaType.Series,
      providerMediaType: 'tv' as const,
      runtimeMinutes: 45,
    };

    const result = evaluateCatalogSubtitleQuality({
      media: tv,
      subtitleSourceId: 'ssrc:subdl:ghi',
      sourceName: 'Example.Show.S01E03.1080p.WEB-DL.x264-GRP',
      cues: [
        {
          cueIndex: 1,
          startMs: 1_000,
          endMs: 3_000,
          text: 'I am the one and the only.',
        },
        {
          cueIndex: 2,
          startMs: 5_000,
          endMs: 8_000,
          text: 'You and I will go to the end.',
        },
      ],
      seasonNumber: 1,
      episodeNumber: 2,
    });

    expect(result.warnings).toContain('episode_mismatch');
  });

  it('flags release contradictions between preferred hint and source name', () => {
    const result = evaluateCatalogSubtitleQuality({
      media: movie,
      subtitleSourceId: 'ssrc:subdl:jkl',
      sourceName: 'Inception.2010.2160p.WEB-DL.HEVC-OTHER',
      cues: [
        {
          cueIndex: 1,
          startMs: 1_000,
          endMs: 3_000,
          text: 'I am the one and the only.',
        },
        {
          cueIndex: 2,
          startMs: 4_000,
          endMs: 7_000,
          text: 'You and I will go to the end.',
        },
      ],
      releaseHint: 'Inception 2010 1080p BluRay x264-GRP',
    });

    expect(result.warnings).toEqual(
      expect.arrayContaining(['release_mismatch']),
    );
    expect(result.confidenceScore).toBeLessThan(100);
  });

  it('warns when the parsed content is unlikely to be English', () => {
    const result = evaluateCatalogSubtitleQuality({
      media: movie,
      subtitleSourceId: 'ssrc:subdl:mno',
      sourceName: 'Inception.2010.1080p.BluRay.x264-GRP',
      expectedLanguageCode: 'en',
      cues: [
        { cueIndex: 1, startMs: 1_000, endMs: 3_000, text: '12345 67890' },
        { cueIndex: 2, startMs: 4_000, endMs: 6_000, text: '... ... ...' },
      ],
    });

    expect(result.warnings).toContain('language_unexpected');
  });
});
