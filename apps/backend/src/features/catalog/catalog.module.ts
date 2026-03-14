import { Module } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import { CacheModule } from 'common/cache/cache.module';

import { CatalogController } from 'features/catalog/catalog.controller';
import { CatalogService } from 'features/catalog/catalog.service';
import { CATALOG_SUBTITLE_FILE_PROVIDERS } from 'features/catalog/ports/catalog-subtitle-file-provider.port';
import { MEDIA_CATALOG_PORT } from 'features/catalog/ports/media-catalog.port';
import { MockCatalogProvider } from 'features/catalog/providers/mock-catalog.provider';
import { CatalogSubtitleCueProvider } from 'features/catalog/providers/catalog-subtitle-cue.provider';
import { PodnapisiSubtitleSourceProvider } from 'features/catalog/providers/podnapisi-subtitle-source.provider';
import { PodnapisiSubtitleFileProvider } from 'features/catalog/providers/podnapisi-subtitle-file.provider';
import { SubdlSubtitleSourceProvider } from 'features/catalog/providers/subdl-subtitle-source.provider';
import { SubdlSubtitleFileProvider } from 'features/catalog/providers/subdl-subtitle-file.provider';
import { TmdbMediaCatalogProvider } from 'features/catalog/providers/tmdb-media-catalog.provider';
import { TvSubsSubtitleSourceProvider } from 'features/catalog/providers/tvsubs-subtitle-source.provider';
import { TvSubsSubtitleFileProvider } from 'features/catalog/providers/tvsubs-subtitle-file.provider';
import { SUBTITLE_CUE_PORT } from 'features/catalog/ports/subtitle-cue.port';
import { SUBTITLE_SOURCE_PROVIDERS } from 'features/catalog/ports/subtitle-source-provider.port';
import { SubtitleSourceDiscoveryService } from 'features/catalog/subtitle-source-discovery.service';
import { SubtitlesModule } from 'features/subtitles/subtitles.module';
import { SubtitleQualityEvaluationService } from 'features/catalog/subtitle-quality-evaluation.service';
import { SubtitleTimingAlignmentService } from 'features/catalog/subtitle-timing-alignment.service';

@Module({
  imports: [CacheModule, SubtitlesModule],
  controllers: [CatalogController],
  providers: [
    CatalogService,
    SubtitleSourceDiscoveryService,
    SubtitleQualityEvaluationService,
    SubtitleTimingAlignmentService,
    MockCatalogProvider,
    CatalogSubtitleCueProvider,
    TmdbMediaCatalogProvider,
    SubdlSubtitleSourceProvider,
    SubdlSubtitleFileProvider,
    PodnapisiSubtitleSourceProvider,
    PodnapisiSubtitleFileProvider,
    TvSubsSubtitleSourceProvider,
    TvSubsSubtitleFileProvider,
    {
      provide: MEDIA_CATALOG_PORT,
      useExisting: TmdbMediaCatalogProvider,
    },
    {
      provide: SUBTITLE_CUE_PORT,
      useExisting: CatalogSubtitleCueProvider,
    },
    {
      provide: CATALOG_SUBTITLE_FILE_PROVIDERS,
      inject: [
        ConfigService,
        SubdlSubtitleFileProvider,
        PodnapisiSubtitleFileProvider,
        TvSubsSubtitleFileProvider,
      ],
      useFactory: (
        configService: ConfigService,
        subdlProvider: SubdlSubtitleFileProvider,
        podnapisiProvider: PodnapisiSubtitleFileProvider,
        tvSubsProvider: TvSubsSubtitleFileProvider,
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
  exports: [
    CatalogService,
    MEDIA_CATALOG_PORT,
    SUBTITLE_CUE_PORT,
    SubtitleQualityEvaluationService,
    SubtitleTimingAlignmentService,
  ],
})
export class CatalogModule {}
