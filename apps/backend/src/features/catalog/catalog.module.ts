import { Module } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import { CacheModule } from 'common/cache/cache.module';

import { CatalogController } from 'features/catalog/catalog.controller';
import { CatalogService } from 'features/catalog/catalog.service';
import { MEDIA_CATALOG_PORT } from 'features/catalog/ports/media-catalog.port';
import { MockCatalogProvider } from 'features/catalog/providers/mock-catalog.provider';
import { MockSubtitleCueProvider } from 'features/catalog/providers/mock-subtitle-cue.provider';
import { PodnapisiSubtitleSourceProvider } from 'features/catalog/providers/podnapisi-subtitle-source.provider';
import { SubdlSubtitleSourceProvider } from 'features/catalog/providers/subdl-subtitle-source.provider';
import { TmdbMediaCatalogProvider } from 'features/catalog/providers/tmdb-media-catalog.provider';
import { TvSubsSubtitleSourceProvider } from 'features/catalog/providers/tvsubs-subtitle-source.provider';
import { SUBTITLE_CUE_PORT } from 'features/catalog/ports/subtitle-cue.port';
import { SUBTITLE_SOURCE_PROVIDERS } from 'features/catalog/ports/subtitle-source-provider.port';
import { SubtitleSourceDiscoveryService } from 'features/catalog/subtitle-source-discovery.service';

@Module({
  imports: [CacheModule],
  controllers: [CatalogController],
  providers: [
    CatalogService,
    SubtitleSourceDiscoveryService,
    MockCatalogProvider,
    MockSubtitleCueProvider,
    TmdbMediaCatalogProvider,
    SubdlSubtitleSourceProvider,
    PodnapisiSubtitleSourceProvider,
    TvSubsSubtitleSourceProvider,
    {
      provide: MEDIA_CATALOG_PORT,
      useExisting: TmdbMediaCatalogProvider,
    },
    {
      provide: SUBTITLE_CUE_PORT,
      useExisting: MockSubtitleCueProvider,
    },
    {
      provide: SUBTITLE_SOURCE_PROVIDERS,
      inject: [
        ConfigService,
        SubdlSubtitleSourceProvider,
        PodnapisiSubtitleSourceProvider,
        TvSubsSubtitleSourceProvider,
      ],
      useFactory: (
        configService: ConfigService,
        subdlProvider: SubdlSubtitleSourceProvider,
        podnapisiProvider: PodnapisiSubtitleSourceProvider,
        tvSubsProvider: TvSubsSubtitleSourceProvider,
      ) => {
        const providers = [];

        if (
          configService.get<boolean>('subtitleSources.subdl.enabled') ??
          false
        ) {
          providers.push(subdlProvider);
        }

        if (
          configService.get<boolean>('subtitleSources.podnapisi.enabled') ??
          true
        ) {
          providers.push(podnapisiProvider);
        }

        if (
          configService.get<boolean>('subtitleSources.tvsubs.enabled') ??
          true
        ) {
          providers.push(tvSubsProvider);
        }

        return providers;
      },
    },
  ],
  exports: [CatalogService, MEDIA_CATALOG_PORT, SUBTITLE_CUE_PORT],
})
export class CatalogModule {}
