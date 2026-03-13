import { Controller, Get, Header, Param, Query } from '@nestjs/common';

import { CatalogService } from './catalog.service';
import { SearchCatalogQueryDto } from './dto/search-catalog-query.dto';

@Controller('catalog')
/** Exposes catalog search and subtitle source discovery endpoints. */
export class CatalogController {
  constructor(private readonly catalogService: CatalogService) {}

  /** Searches the mocked media catalog by a user query. */
  @Get('search')
  @Header('Cache-Control', 'public, max-age=60, stale-while-revalidate=300')
  search(@Query() query: SearchCatalogQueryDto) {
    return this.catalogService.search(query.q);
  }

  /** Returns subtitle source options for a selected media item. */
  @Get('media/:mediaId/subtitle-sources')
  @Header('Cache-Control', 'public, max-age=300, stale-while-revalidate=900')
  getSubtitleSources(@Param('mediaId') mediaId: string) {
    return this.catalogService.getSubtitleSources(mediaId);
  }
}
