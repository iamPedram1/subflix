import { Module } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import { CacheModule } from 'src/common/cache/cache.module';

import { CatalogController } from './catalog.controller';
import { CatalogService } from './catalog.service';
import { MEDIA_CATALOG_PORT } from './ports/media-catalog.port';
import { MockCatalogProvider } from './providers/mock-catalog.provider';
import { MockSubtitleCueProvider } from './providers/mock-subtitle-cue.provider';
import { PodnapisiSubtitleSourceProvider } from './providers/podnapisi-subtitle-source.provider';
import { SubdlSubtitleSourceProvider } from './providers/subdl-subtitle-source.provider';
import { TmdbMediaCatalogProvider } from './providers/tmdb-media-catalog.provider';
import { TvSubsSubtitleSourceProvider } from './providers/tvsubs-subtitle-source.provider';
import { SUBTITLE_CUE_PORT } from './ports/subtitle-cue.port';
import { SUBTITLE_SOURCE_PROVIDERS } from './ports/subtitle-source-provider.port';
import { SubtitleSourceDiscoveryService } from './subtitle-source-discovery.service';

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
