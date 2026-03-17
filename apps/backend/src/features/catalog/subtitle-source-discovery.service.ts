import { Inject, Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import { AppCacheService } from 'common/cache/app-cache.service';
import {
  ServiceUnavailableDomainError,
  ValidationDomainError,
} from 'common/domain/errors/domain.error';
import { SearchMediaType } from 'common/domain/enums/search-media-type.enum';
import { StructuredLogger } from 'common/utils/structured-logger';
import { timed } from 'common/utils/timed.util';

import { GetSubtitleSourcesQueryDto } from 'features/catalog/dto/get-subtitle-sources-query.dto';
import { CatalogMediaDetails } from 'features/catalog/models/catalog-media-details.model';
import { CatalogSubtitleSource } from 'features/catalog/models/catalog-subtitle-source.model';
import { SubtitleSourceCandidate } from 'features/catalog/models/subtitle-source-candidate.model';
import { SubtitleSourceSearchInput } from 'features/catalog/models/subtitle-source-search-input.model';
import {
  SUBTITLE_SOURCE_PROVIDERS,
  SubtitleSourceProvider,
} from 'features/catalog/ports/subtitle-source-provider.port';
import { SubtitleProviderHealthService } from 'features/catalog/subtitle-provider-health.service';
import { buildSubtitleSourceCacheKey } from 'features/catalog/utils/subtitle-source-cache-key.util';
import { dedupeSubtitleSourceCandidates } from 'features/catalog/utils/subtitle-source-dedupe.util';
import { rankSubtitleSourceCandidates } from 'features/catalog/utils/subtitle-source-ranking.util';
import { toCatalogSubtitleSource } from 'features/catalog/utils/subtitle-source-response.mapper';

const DEFAULT_PREFERRED_LANGUAGE = 'en';
const MAX_PUBLIC_RESULTS = 20;

@Injectable()
export class SubtitleSourceDiscoveryService {
  private readonly log = new StructuredLogger(
    SubtitleSourceDiscoveryService.name,
  );

  constructor(
    private readonly cacheService: AppCacheService,
    private readonly configService: ConfigService,
    @Inject(SUBTITLE_SOURCE_PROVIDERS)
    private readonly providers: SubtitleSourceProvider[],
    private readonly providerHealthService: SubtitleProviderHealthService,
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

    this.log.info('subtitle.discovery.start', {
      mediaId: media.id,
      preferredLanguage: searchInput.preferredLanguage,
    });

    // Cheap in-memory peek — used only to determine cache state for the log.
    // Single-process Node.js means there is no TOCTOU risk between this and getOrSet.
    const isCacheHit =
      this.cacheService.get<CatalogSubtitleSource[]>(cacheKey) !== undefined;

    this.log.info(
      isCacheHit
        ? 'subtitle.discovery.cache.hit'
        : 'subtitle.discovery.cache.miss',
      { mediaId: media.id },
    );

    const results = await this.cacheService.getOrSet(
      cacheKey,
      async () => {
        const [primaryProvider, ...fallbackProviders] = this.providers;
        if (!primaryProvider) {
          return [];
        }

        let successfulProviderResponses = 0;
        let meaningfulFailures = 0;
        const collectedResults: SubtitleSourceCandidate[] = [];

        if (!this.providerHealthService.isAllowed(primaryProvider.name)) {
          this.log.info('subtitle.discovery.provider.skipped_unhealthy', {
            provider: primaryProvider.name,
            mediaId: media.id,
          });

          const fallbackResults = await this.collectFallbackResults(
            fallbackProviders,
            searchInput,
          );
          successfulProviderResponses += fallbackResults.successfulResponses;
          meaningfulFailures += fallbackResults.meaningfulFailures;
          collectedResults.push(...fallbackResults.results);
        } else {
          try {
            const { result: primaryResults, durationMs } = await timed(() =>
              primaryProvider.searchSources(searchInput),
            );
            successfulProviderResponses += 1;
            this.providerHealthService.recordSuccess(primaryProvider.name);

            this.log.info('subtitle.discovery.provider.success', {
              provider: primaryProvider.name,
              mediaId: media.id,
              resultCount: primaryResults.length,
              durationMs,
            });

            if (primaryResults.length > 0) {
              collectedResults.push(...primaryResults);
            } else {
              this.log.info('subtitle.discovery.fallback', {
                mediaId: media.id,
                reason: 'primary_returned_empty',
              });

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
            this.providerHealthService.recordFailure(primaryProvider.name);

            this.log.warn('subtitle.discovery.provider.failure', {
              provider: primaryProvider.name,
              mediaId: media.id,
              message:
                error instanceof Error ? error.message : 'Unknown provider error',
            });

            this.log.info('subtitle.discovery.fallback', {
              mediaId: media.id,
              reason: 'primary_failed',
            });

            const fallbackResults = await this.collectFallbackResults(
              fallbackProviders,
              searchInput,
            );
            successfulProviderResponses += fallbackResults.successfulResponses;
            meaningfulFailures += fallbackResults.meaningfulFailures;
            collectedResults.push(...fallbackResults.results);
          }
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

    this.log.info('subtitle.discovery.complete', {
      mediaId: media.id,
      resultCount: results.length,
    });

    return results;
  }

  private async collectFallbackResults(
    providers: SubtitleSourceProvider[],
    searchInput: Parameters<SubtitleSourceProvider['searchSources']>[0],
  ) {
    let successfulResponses = 0;
    let meaningfulFailures = 0;
    const results: SubtitleSourceCandidate[] = [];

    for (const provider of providers) {
      if (!this.providerHealthService.isAllowed(provider.name)) {
        this.log.info('subtitle.discovery.provider.skipped_unhealthy', {
          provider: provider.name,
          mediaId: searchInput.mediaId,
        });
        continue;
      }

      try {
        const { result: providerResults, durationMs } = await timed(() =>
          provider.searchSources(searchInput),
        );
        successfulResponses += 1;
        this.providerHealthService.recordSuccess(provider.name);
        results.push(...providerResults);

        this.log.info('subtitle.discovery.provider.success', {
          provider: provider.name,
          mediaId: searchInput.mediaId,
          resultCount: providerResults.length,
          durationMs,
        });
      } catch (error) {
        meaningfulFailures += 1;
        this.providerHealthService.recordFailure(provider.name);

        this.log.warn('subtitle.discovery.provider.failure', {
          provider: provider.name,
          mediaId: searchInput.mediaId,
          message:
            error instanceof Error ? error.message : 'Unknown provider error',
        });
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
}
