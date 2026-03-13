import { Inject, Injectable } from '@nestjs/common';

import {
  MEDIA_CATALOG_PORT,
  MediaCatalogPort,
} from './ports/media-catalog.port';
import {
  SUBTITLE_SOURCE_PORT,
  SubtitleSourcePort,
} from './ports/subtitle-source.port';

@Injectable()
/** Coordinates catalog lookups through swappable provider ports. */
export class CatalogService {
  constructor(
    @Inject(MEDIA_CATALOG_PORT)
    private readonly mediaCatalogPort: MediaCatalogPort,
    @Inject(SUBTITLE_SOURCE_PORT)
    private readonly subtitleSourcePort: SubtitleSourcePort,
  ) {}

  /** Searches the external media catalog by a free-form user query. */
  search(query: string) {
    return this.mediaCatalogPort.search(query);
  }

  /** Loads a single media item by its provider-specific identifier. */
  findById(mediaId: string) {
    return this.mediaCatalogPort.findById(mediaId);
  }

  /** Lists subtitle source options for the selected media item. */
  getSubtitleSources(mediaId: string) {
    return this.subtitleSourcePort.getSubtitleSources(mediaId);
  }

  /** Retrieves normalized English subtitle cues for a chosen source. */
  getSubtitleCues(mediaId: string, subtitleSourceId: string) {
    return this.subtitleSourcePort.getSubtitleCues(mediaId, subtitleSourceId);
  }
}
