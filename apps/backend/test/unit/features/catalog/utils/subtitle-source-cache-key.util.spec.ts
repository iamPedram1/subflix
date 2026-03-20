import { buildSubtitleSourceCacheKey } from 'features/catalog/utils/subtitle-source-cache-key.util';

describe('buildSubtitleSourceCacheKey', () => {
  it('prefers canonical ids when available', () => {
    const cacheKey = buildSubtitleSourceCacheKey({
      mediaId: 'movie_27205',
      tmdbId: 27205,
      imdbId: 'tt1375666',
      title: 'Inception',
      originalTitle: 'Inception',
      year: 2010,
      mediaType: 'movie',
      preferredLanguage: 'en',
      releaseHints: [],
    });

    expect(cacheKey).toBe(
      'catalog:subtitle-sources:movie:tmdb:27205:imdb:tt1375666:s:none:e:none:lang:en:hint:none',
    );
  });

  it('falls back to normalized text identity when canonical ids are unavailable', () => {
    const cacheKey = buildSubtitleSourceCacheKey({
      mediaId: 'breaking_bad',
      title: 'Breaking Bad',
      originalTitle: 'Breaking Bad',
      year: 2008,
      mediaType: 'tv',
      seasonNumber: 5,
      episodeNumber: 16,
      preferredLanguage: 'en',
      releaseHints: [],
    });

    expect(cacheKey).toBe(
      'catalog:subtitle-sources:tv:title:breaking-bad:original:breaking-bad:year:2008:s:5:e:16:lang:en:hint:none',
    );
  });

  it('includes the first release hint so cache entries stay query-specific', () => {
    const cacheKey = buildSubtitleSourceCacheKey({
      mediaId: 'movie_27205',
      tmdbId: 27205,
      imdbId: 'tt1375666',
      title: 'Inception',
      originalTitle: 'Inception',
      year: 2010,
      mediaType: 'movie',
      preferredLanguage: 'en',
      releaseHints: ['Inception.2010.1080p.BluRay.x264-GRP'],
    });

    expect(cacheKey).toContain(
      'hint:inception.2010.1080p.bluray.x264-grp',
    );
  });
});
