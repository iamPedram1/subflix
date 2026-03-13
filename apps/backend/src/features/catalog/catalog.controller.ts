import { Controller, Get, Param, Query } from '@nestjs/common';

import { CatalogService } from './catalog.service';
import { SearchCatalogQueryDto } from './dto/search-catalog-query.dto';

@Controller('catalog')
export class CatalogController {
  constructor(private readonly catalogService: CatalogService) {}

  @Get('search')
  search(@Query() query: SearchCatalogQueryDto) {
    return this.catalogService.search(query.q);
  }

  @Get('media/:mediaId/subtitle-sources')
  getSubtitleSources(@Param('mediaId') mediaId: string) {
    return this.catalogService.getSubtitleSources(mediaId);
  }
}
