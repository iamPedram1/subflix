import { buildSubtitleSourceCacheKey } from 'src/features/catalog/utils/subtitle-source-cache-key.util';

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
      'catalog:subtitle-sources:movie:tmdb:27205:imdb:tt1375666:s:none:e:none:lang:en',
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
      'catalog:subtitle-sources:tv:title:breaking-bad:original:breaking-bad:year:2008:s:5:e:16:lang:en',
    );
  });
});
