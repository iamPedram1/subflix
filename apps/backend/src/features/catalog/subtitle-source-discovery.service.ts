import { Inject, Injectable, Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import { AppCacheService } from 'common/cache/app-cache.service';
import {
  ServiceUnavailableDomainError,
  ValidationDomainError,
} from 'common/domain/errors/domain.error';
import { SearchMediaType } from 'common/domain/enums/search-media-type.enum';

import { GetSubtitleSourcesQueryDto } from 'features/catalog/dto/get-subtitle-sources-query.dto';
import { CatalogMediaDetails } from 'features/catalog/models/catalog-media-details.model';
import { CatalogSubtitleSource } from 'features/catalog/models/catalog-subtitle-source.model';
import { SubtitleSourceCandidate } from 'features/catalog/models/subtitle-source-candidate.model';
import { SubtitleSourceSearchInput } from 'features/catalog/models/subtitle-source-search-input.model';
import {
  SUBTITLE_SOURCE_PROVIDERS,
  SubtitleSourceProvider,
} from 'features/catalog/ports/subtitle-source-provider.port';
import { buildSubtitleSourceCacheKey } from 'features/catalog/utils/subtitle-source-cache-key.util';
import { dedupeSubtitleSourceCandidates } from 'features/catalog/utils/subtitle-source-dedupe.util';
import { rankSubtitleSourceCandidates } from 'features/catalog/utils/subtitle-source-ranking.util';
import { toCatalogSubtitleSource } from 'features/catalog/utils/subtitle-source-response.mapper';

const DEFAULT_PREFERRED_LANGUAGE = 'en';
const MAX_PUBLIC_RESULTS = 20;

@Injectable()
export class SubtitleSourceDiscoveryService {
  private readonly logger = new Logger(SubtitleSourceDiscoveryService.name);

  constructor(
    private readonly cacheService: AppCacheService,
    private readonly configService: ConfigService,
    @Inject(SUBTITLE_SOURCE_PROVIDERS)
    private readonly providers: SubtitleSourceProvider[],
  ) {}

  async discover(
    media: CatalogMediaDetails,
    query: GetSubtitleSourcesQueryDto = {},
  ): Promise<CatalogSubtitleSource[]> {
    this.validateEpisodeScope(media, query);

    const searchInput: SubtitleSourceSearchInput = {
      mediaId: media.id,
      tmdbId: media.tmdbId,
      imdbId: media.imdbId,
      title: media.title,
      originalTitle: media.originalTitle,
      year: media.year,
      mediaType: media.providerMediaType,
      seasonNumber: query.seasonNumber,
      episodeNumber: query.episodeNumber,
      preferredLanguage:
        query.preferredLanguage?.trim().toLowerCase() ??
        DEFAULT_PREFERRED_LANGUAGE,
      releaseHints: query.releaseHint?.trim() ? [query.releaseHint.trim()] : [],
    };
    const cacheKey = buildSubtitleSourceCacheKey(searchInput);

    return this.cacheService.getOrSet(
      cacheKey,
      async () => {
        const [primaryProvider, ...fallbackProviders] = this.providers;
        if (!primaryProvider) {
          return [];
        }

        let successfulProviderResponses = 0;
        let meaningfulFailures = 0;
        const collectedResults: SubtitleSourceCandidate[] = [];

        try {
          const primaryResults =
            await primaryProvider.searchSources(searchInput);
          successfulProviderResponses += 1;

          if (primaryResults.length > 0) {
            collectedResults.push(...primaryResults);
          } else {
            const fallbackResults = await this.collectFallbackResults(
              fallbackProviders,
              searchInput,
            );
            successfulProviderResponses += fallbackResults.successfulResponses;
            meaningfulFailures += fallbackResults.meaningfulFailures;
            collectedResults.push(...fallbackResults.results);
          }
        } catch (error) {
          meaningfulFailures += 1;
          this.logProviderFailure(primaryProvider.name, media.id, error);

          const fallbackResults = await this.collectFallbackResults(
            fallbackProviders,
            searchInput,
          );
          successfulProviderResponses += fallbackResults.successfulResponses;
          meaningfulFailures += fallbackResults.meaningfulFailures;
          collectedResults.push(...fallbackResults.results);
        }

        if (collectedResults.length === 0) {
          if (successfulProviderResponses === 0 && meaningfulFailures > 0) {
            throw new ServiceUnavailableDomainError(
              'Subtitle sources are temporarily unavailable for this title.',
              undefined,
              {
                key: 'errors.catalog.subtitles_unavailable',
              },
            );
          }

          return [];
        }

        return rankSubtitleSourceCandidates(
          dedupeSubtitleSourceCandidates(collectedResults),
          searchInput,
        )
          .slice(0, MAX_PUBLIC_RESULTS)
          .map(toCatalogSubtitleSource);
      },
      {
        ttlMs:
          this.configService.get<number>('subtitleSources.cacheTtlMs') ??
          6 * 60 * 60_000,
      },
    );
  }

  private async collectFallbackResults(
    providers: SubtitleSourceProvider[],
    searchInput: Parameters<SubtitleSourceProvider['searchSources']>[0],
  ) {
    let successfulResponses = 0;
    let meaningfulFailures = 0;
    const results: SubtitleSourceCandidate[] = [];

    for (const provider of providers) {
      try {
        const providerResults = await provider.searchSources(searchInput);
        successfulResponses += 1;
        results.push(...providerResults);
      } catch (error) {
        meaningfulFailures += 1;
        this.logProviderFailure(provider.name, searchInput.mediaId, error);
      }
    }

    return {
      results,
      successfulResponses,
      meaningfulFailures,
    };
  }

  private validateEpisodeScope(
    media: CatalogMediaDetails,
    query: GetSubtitleSourcesQueryDto,
  ): void {
    if (
      media.mediaType === SearchMediaType.Movie &&
      (query.seasonNumber !== undefined || query.episodeNumber !== undefined)
    ) {
      throw new ValidationDomainError(
        'seasonNumber and episodeNumber are only supported for TV titles.',
        undefined,
        {
          key: 'errors.catalog.tv_only_episode_scope',
        },
      );
    }
  }

  private logProviderFailure(
    providerName: string,
    mediaId: string,
    error: unknown,
  ): void {
    const message =
      error instanceof Error ? error.message : 'Unknown provider failure.';
    this.logger.warn(
      `Subtitle source provider ${providerName} failed for ${mediaId}: ${message}`,
    );
  }
}
