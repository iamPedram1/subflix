import { CatalogMediaItem } from 'features/catalog/models/catalog-media-item.model';
import { CatalogMediaDetails } from 'features/catalog/models/catalog-media-details.model';

export const MEDIA_CATALOG_PORT = Symbol('MEDIA_CATALOG_PORT');

export interface MediaCatalogPort {
  search(query: string): Promise<CatalogMediaItem[]>;
  findById(mediaId: string): Promise<CatalogMediaDetails | null>;
}
