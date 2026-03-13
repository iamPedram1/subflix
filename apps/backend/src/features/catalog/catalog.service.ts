import { Inject, Injectable } from '@nestjs/common';

import { AppCacheService } from 'src/common/cache/app-cache.service';

import {
  MEDIA_CATALOG_PORT,
  MediaCatalogPort,
} from './ports/media-catalog.port';
import {
  SUBTITLE_SOURCE_PORT,
  SubtitleSourcePort,
} from './ports/subtitle-source.port';

const SEARCH_CACHE_TTL_MS = 5 * 60_000;
const DETAIL_CACHE_TTL_MS = 15 * 60_000;
const CUE_CACHE_TTL_MS = 30 * 60_000;

@Injectable()
/** Coordinates catalog lookups through swappable provider ports. */
export class CatalogService {
  constructor(
    private readonly cacheService: AppCacheService,
    @Inject(MEDIA_CATALOG_PORT)
    private readonly mediaCatalogPort: MediaCatalogPort,
    @Inject(SUBTITLE_SOURCE_PORT)
    private readonly subtitleSourcePort: SubtitleSourcePort,
  ) {}

  /** Searches the external media catalog by a free-form user query. */
  search(query: string) {
    const normalizedQuery = query.trim().toLowerCase();

    return this.cacheService.getOrSet(
      this.buildCacheKey('search', normalizedQuery),
      () => this.mediaCatalogPort.search(normalizedQuery),
      {
        ttlMs: SEARCH_CACHE_TTL_MS,
      },
    );
  }

  /** Loads a single media item by its provider-specific identifier. */
  findById(mediaId: string) {
    return this.cacheService.getOrSet(
      this.buildCacheKey('media', mediaId),
      () => this.mediaCatalogPort.findById(mediaId),
      {
        ttlMs: DETAIL_CACHE_TTL_MS,
      },
    );
  }

  /** Lists subtitle source options for the selected media item. */
  getSubtitleSources(mediaId: string) {
    return this.cacheService.getOrSet(
      this.buildCacheKey('sources', mediaId),
      () => this.subtitleSourcePort.getSubtitleSources(mediaId),
      {
        ttlMs: DETAIL_CACHE_TTL_MS,
      },
    );
  }

  /** Retrieves normalized English subtitle cues for a chosen source. */
  getSubtitleCues(mediaId: string, subtitleSourceId: string) {
    return this.cacheService.getOrSet(
      this.buildCacheKey('cues', mediaId, subtitleSourceId),
      () => this.subtitleSourcePort.getSubtitleCues(mediaId, subtitleSourceId),
      {
        ttlMs: CUE_CACHE_TTL_MS,
      },
    );
  }

  private buildCacheKey(scope: string, ...parts: string[]): string {
    return [
      'catalog',
      scope,
      ...parts.map((part) => encodeURIComponent(part)),
    ].join(':');
  }
}
