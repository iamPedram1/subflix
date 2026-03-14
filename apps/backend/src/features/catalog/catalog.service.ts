import { Inject, Injectable } from '@nestjs/common';

import { AppCacheService } from 'src/common/cache/app-cache.service';
import { NotFoundDomainError } from 'src/common/domain/errors/domain.error';

import {
  MEDIA_CATALOG_PORT,
  MediaCatalogPort,
} from './ports/media-catalog.port';
import { SUBTITLE_CUE_PORT, SubtitleCuePort } from './ports/subtitle-cue.port';
import { GetSubtitleSourcesQueryDto } from './dto/get-subtitle-sources-query.dto';
import { SubtitleSourceDiscoveryService } from './subtitle-source-discovery.service';

const CUE_CACHE_TTL_MS = 30 * 60_000;

@Injectable()
/** Coordinates catalog lookups through swappable provider ports. */
export class CatalogService {
  constructor(
    private readonly cacheService: AppCacheService,
    private readonly subtitleSourceDiscoveryService: SubtitleSourceDiscoveryService,
    @Inject(MEDIA_CATALOG_PORT)
    private readonly mediaCatalogPort: MediaCatalogPort,
    @Inject(SUBTITLE_CUE_PORT)
    private readonly subtitleCuePort: SubtitleCuePort,
  ) {}

  /** Searches the external media catalog by a free-form user query. */
  search(query: string) {
    const normalizedQuery = query.trim().toLowerCase();
    return this.mediaCatalogPort.search(normalizedQuery);
  }

  /** Loads a single media item by its provider-specific identifier. */
  findById(mediaId: string) {
    return this.mediaCatalogPort.findById(mediaId);
  }

  /** Lists subtitle source options for the selected media item. */
  async getSubtitleSources(
    mediaId: string,
    query: GetSubtitleSourcesQueryDto = {},
  ) {
    const media = await this.findById(mediaId);
    if (!media) {
      throw new NotFoundDomainError(
        'The requested catalog title was not found.',
      );
    }

    return this.subtitleSourceDiscoveryService.discover(media, query);
  }

  /** Retrieves normalized English subtitle cues for a chosen source. */
  getSubtitleCues(mediaId: string, subtitleSourceId: string) {
    return this.cacheService.getOrSet(
      this.buildCacheKey('cues', mediaId, subtitleSourceId),
      () => this.subtitleCuePort.getSubtitleCues(mediaId, subtitleSourceId),
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
