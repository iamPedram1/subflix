import { Controller, Get, Param, Query } from '@nestjs/common';

import { CatalogService } from './catalog.service';
import { SearchCatalogQueryDto } from './dto/search-catalog-query.dto';

@Controller('catalog')
/** Exposes catalog search and subtitle source discovery endpoints. */
export class CatalogController {
  constructor(private readonly catalogService: CatalogService) {}

  /** Searches the mocked media catalog by a user query. */
  @Get('search')
  search(@Query() query: SearchCatalogQueryDto) {
    return this.catalogService.search(query.q);
  }

  /** Returns subtitle source options for a selected media item. */
  @Get('media/:mediaId/subtitle-sources')
  getSubtitleSources(@Param('mediaId') mediaId: string) {
    return this.catalogService.getSubtitleSources(mediaId);
  }
}
