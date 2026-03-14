import { SubtitleSourceSearchInput } from '../models/subtitle-source-search-input.model';

const normalizeTextPart = (value: string | undefined): string => {
  const normalized = value?.trim().toLowerCase().replace(/\s+/g, '-');
  return normalized?.length ? encodeURIComponent(normalized) : 'none';
};

export const buildSubtitleSourceCacheKey = (
  input: SubtitleSourceSearchInput,
): string => {
  const prefix = 'catalog:subtitle-sources';
  const season = input.seasonNumber ?? 'none';
  const episode = input.episodeNumber ?? 'none';
  const language = encodeURIComponent(input.preferredLanguage);

  if (input.tmdbId || input.imdbId) {
    return [
      prefix,
      input.mediaType,
      `tmdb:${input.tmdbId ?? 'none'}`,
      `imdb:${encodeURIComponent(input.imdbId ?? 'none')}`,
      `s:${season}`,
      `e:${episode}`,
      `lang:${language}`,
    ].join(':');
  }

  return [
    prefix,
    input.mediaType,
    `title:${normalizeTextPart(input.title)}`,
    `original:${normalizeTextPart(input.originalTitle)}`,
    `year:${input.year ?? 'none'}`,
    `s:${season}`,
    `e:${episode}`,
    `lang:${language}`,
  ].join(':');
};
