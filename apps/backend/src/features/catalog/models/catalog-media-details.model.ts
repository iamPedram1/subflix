import { CatalogMediaItem } from './catalog-media-item.model';

export type CatalogMediaDetails = CatalogMediaItem & {
  tmdbId?: number;
  imdbId?: string;
  originalTitle?: string;
  providerMediaType: 'movie' | 'tv';
};
