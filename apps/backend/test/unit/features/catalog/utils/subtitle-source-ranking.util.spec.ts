import { rankSubtitleSourceCandidates } from 'features/catalog/utils/subtitle-source-ranking.util';

describe('rankSubtitleSourceCandidates', () => {
  it('prioritizes exact identity, year, language, and provider priority', () => {
    const ranked = rankSubtitleSourceCandidates(
      [
        {
          provider: 'podnapisi',
          providerSubtitleId: 'pod-1',
          mediaTitle: 'Inception',
          mediaType: 'movie',
          year: 2010,
          languageCode: 'en',
          hearingImpaired: false,
          downloadCount: 200,
          sourcePageUrl: 'https://podnapisi.net/pod-1',
          score: 0,
        },
        {
          provider: 'subdl',
          providerSubtitleId: 'subdl-1',
          mediaTitle: 'Inception',
          mediaType: 'movie',
          year: 2010,
          languageCode: 'en',
          hearingImpaired: false,
          downloadCount: 100,
          sourcePageUrl: 'https://subdl.com/subdl-1',
          score: 0,
          tmdbId: 27205,
          imdbId: 'tt1375666',
        },
      ],
      {
        mediaId: 'movie_27205',
        tmdbId: 27205,
        imdbId: 'tt1375666',
        title: 'Inception',
        originalTitle: 'Inception',
        year: 2010,
        mediaType: 'movie',
        preferredLanguage: 'en',
        releaseHints: [],
      },
    );

    expect(ranked[0]?.provider).toBe('subdl');
    expect(ranked[0]?.score).toBeGreaterThan(ranked[1]?.score ?? 0);
  });

  it('uses hearing impaired only as a low-priority tiebreaker', () => {
    const ranked = rankSubtitleSourceCandidates(
      [
        {
          provider: 'subdl',
          providerSubtitleId: 'a',
          mediaTitle: 'Inception',
          mediaType: 'movie',
          year: 2010,
          languageCode: 'en',
          hearingImpaired: false,
          downloadCount: 50,
          sourcePageUrl: 'https://subdl.com/a',
          score: 0,
        },
        {
          provider: 'subdl',
          providerSubtitleId: 'b',
          mediaTitle: 'Inception',
          mediaType: 'movie',
          year: 2010,
          languageCode: 'en',
          hearingImpaired: true,
          downloadCount: 50,
          sourcePageUrl: 'https://subdl.com/b',
          score: 0,
        },
      ],
      {
        mediaId: 'movie_27205',
        title: 'Inception',
        year: 2010,
        mediaType: 'movie',
        preferredLanguage: 'en',
        releaseHints: [],
      },
    );

    expect(ranked[0]?.providerSubtitleId).toBe('b');
    expect(ranked[0]?.score).toBe((ranked[1]?.score ?? 0) + 1);
  });

  it('rewards candidates that match the preferred release hint metadata', () => {
    const ranked = rankSubtitleSourceCandidates(
      [
        {
          provider: 'subdl',
          providerSubtitleId: 'good',
          mediaTitle: 'Inception',
          mediaType: 'movie',
          year: 2010,
          languageCode: 'en',
          hearingImpaired: false,
          downloadCount: 10,
          releaseName: 'Inception.2010.1080p.BluRay.x264-YIFY',
          sourcePageUrl: 'https://subdl.com/good',
          score: 0,
        },
        {
          provider: 'subdl',
          providerSubtitleId: 'bad',
          mediaTitle: 'Inception',
          mediaType: 'movie',
          year: 2010,
          languageCode: 'en',
          hearingImpaired: false,
          downloadCount: 10,
          releaseName: 'Inception.2010.720p.WEB-DL.x264-OTHER',
          sourcePageUrl: 'https://subdl.com/bad',
          score: 0,
        },
      ],
      {
        mediaId: 'movie_27205',
        title: 'Inception',
        year: 2010,
        mediaType: 'movie',
        preferredLanguage: 'en',
        releaseHints: ['Inception.2010.1080p.BluRay.x264-YIFY'],
      },
    );

    expect(ranked[0]?.providerSubtitleId).toBe('good');
    expect(ranked[0]?.score).toBeGreaterThan(ranked[1]?.score ?? 0);
  });
});
