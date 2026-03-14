import { Controller, Get, Header, Param, Query } from '@nestjs/common';

import { RateLimit } from 'src/common/rate-limit/rate-limit.decorator';

import { CatalogService } from './catalog.service';
import { GetSubtitleSourcesParamsDto } from './dto/get-subtitle-sources-params.dto';
import { GetSubtitleSourcesQueryDto } from './dto/get-subtitle-sources-query.dto';
import { SearchCatalogQueryDto } from './dto/search-catalog-query.dto';

@Controller('catalog')
/** Exposes catalog search and subtitle source discovery endpoints. */
export class CatalogController {
  constructor(private readonly catalogService: CatalogService) {}

  /** Searches the mocked media catalog by a user query. */
  @Get('search')
  @RateLimit({ limit: 30, windowMs: 60_000, key: 'catalog-search' })
  @Header('Cache-Control', 'public, max-age=60, stale-while-revalidate=300')
  search(@Query() query: SearchCatalogQueryDto) {
    return this.catalogService.search(query.q);
  }

  /** Returns subtitle source options for a selected media item. */
  @Get('media/:mediaId/subtitle-sources')
  @RateLimit({ limit: 60, windowMs: 60_000, key: 'catalog-subtitle-sources' })
  @Header('Cache-Control', 'public, max-age=300, stale-while-revalidate=900')
  getSubtitleSources(
    @Param() params: GetSubtitleSourcesParamsDto,
    @Query() query: GetSubtitleSourcesQueryDto,
  ) {
    return this.catalogService.getSubtitleSources(params.mediaId, query);
  }
}
