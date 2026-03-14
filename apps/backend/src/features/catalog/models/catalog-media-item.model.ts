import { SearchMediaType } from 'common/domain/enums/search-media-type.enum';

export type CatalogMediaItem = {
  id: string;
  title: string;
  year: number;
  mediaType: SearchMediaType;
  synopsis: string;
  genres: string[];
  runtimeMinutes: number;
  popularity: number;
};
