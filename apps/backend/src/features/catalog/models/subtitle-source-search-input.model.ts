export type SubtitleSourceSearchInput = {
  mediaId: string;
  tmdbId?: number;
  imdbId?: string;
  title: string;
  originalTitle?: string;
  year?: number;
  mediaType: 'movie' | 'tv';
  seasonNumber?: number;
  episodeNumber?: number;
  preferredLanguage: string;
  releaseHints?: string[];
};
