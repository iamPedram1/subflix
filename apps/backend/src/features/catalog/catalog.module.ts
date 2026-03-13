import { Module } from '@nestjs/common';

import { CacheModule } from 'src/common/cache/cache.module';

import { CatalogController } from './catalog.controller';
import { CatalogService } from './catalog.service';
import { MEDIA_CATALOG_PORT } from './ports/media-catalog.port';
import { SUBTITLE_SOURCE_PORT } from './ports/subtitle-source.port';
import { MockCatalogProvider } from './providers/mock-catalog.provider';
import { TmdbMediaCatalogProvider } from './providers/tmdb-media-catalog.provider';

@Module({
  imports: [CacheModule],
  controllers: [CatalogController],
  providers: [
    CatalogService,
    MockCatalogProvider,
    TmdbMediaCatalogProvider,
    {
      provide: MEDIA_CATALOG_PORT,
      useExisting: TmdbMediaCatalogProvider,
    },
    {
      provide: SUBTITLE_SOURCE_PORT,
      useExisting: MockCatalogProvider,
    },
  ],
  exports: [CatalogService, MEDIA_CATALOG_PORT, SUBTITLE_SOURCE_PORT],
})
export class CatalogModule {}
