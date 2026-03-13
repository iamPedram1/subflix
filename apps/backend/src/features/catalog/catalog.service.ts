import { Inject, Injectable } from '@nestjs/common';

import { MEDIA_CATALOG_PORT, MediaCatalogPort } from './ports/media-catalog.port';
import {
  SUBTITLE_SOURCE_PORT,
  SubtitleSourcePort,
} from './ports/subtitle-source.port';

@Injectable()
export class CatalogService {
  constructor(
    @Inject(MEDIA_CATALOG_PORT)
    private readonly mediaCatalogPort: MediaCatalogPort,
    @Inject(SUBTITLE_SOURCE_PORT)
    private readonly subtitleSourcePort: SubtitleSourcePort,
  ) {}

  search(query: string) {
    return this.mediaCatalogPort.search(query);
  }

  findById(mediaId: string) {
    return this.mediaCatalogPort.findById(mediaId);
  }

  getSubtitleSources(mediaId: string) {
    return this.subtitleSourcePort.getSubtitleSources(mediaId);
  }

  getSubtitleCues(mediaId: string, subtitleSourceId: string) {
    return this.subtitleSourcePort.getSubtitleCues(mediaId, subtitleSourceId);
  }
}
