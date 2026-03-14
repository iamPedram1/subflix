import { Injectable, Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import {
  NotFoundDomainError,
  ServiceUnavailableDomainError,
  ValidationDomainError,
} from 'common/domain/errors/domain.error';
import { AppCacheService } from 'common/cache/app-cache.service';
import { SearchMediaType } from 'common/domain/enums/search-media-type.enum';

import {
  TMDB_MOVIE_GENRE_MAP,
  TMDB_SERIES_GENRE_MAP,
} from 'features/catalog/data/tmdb-genre-map';
import { CatalogMediaDetails } from 'features/catalog/models/catalog-media-details.model';
import { CatalogMediaItem } from 'features/catalog/models/catalog-media-item.model';
import { MediaCatalogPort } from 'features/catalog/ports/media-catalog.port';
import { MockCatalogProvider } from 'features/catalog/providers/mock-catalog.provider';

type TmdbMultiSearchResult = {
  id: number;
  media_type?: 'movie' | 'tv' | 'person';
  title?: string;
  name?: string;
  overview?: string;
  popularity?: number;
  genre_ids?: number[];
  release_date?: string;
  first_air_date?: string;
};

type TmdbMovieDetail = {
  id: number;
  title?: string;
  original_title?: string;
  overview?: string;
  popularity?: number;
  genres?: Array<{ id: number; name: string }>;
  release_date?: string;
  runtime?: number | null;
};

type TmdbSeriesDetail = {
  id: number;
  name?: string;
  original_name?: string;
  overview?: string;
  popularity?: number;
  genres?: Array<{ id: number; name: string }>;
  first_air_date?: string;
  episode_run_time?: number[];
};

type TmdbExternalIds = {
  imdb_id?: string | null;
};

type TmdbListResponse<T> = {
  results?: T[];
};

@Injectable()
/** Real TMDb-backed media catalog provider with strong query caching. */
export class TmdbMediaCatalogProvider implements MediaCatalogPort {
  private readonly logger = new Logger(TmdbMediaCatalogProvider.name);

  constructor(
    private readonly cacheService: AppCacheService,
    private readonly configService: ConfigService,
    private readonly fallbackProvider: MockCatalogProvider,
  ) {}

  async search(query: string): Promise<CatalogMediaItem[]> {
    const normalizedQuery = query.trim().toLowerCase();

    if (!this.hasToken()) {
      return this.cacheService.getOrSet(
        this.buildFallbackSearchCacheKey(normalizedQuery),
        () => this.fallbackProvider.search(normalizedQuery),
      );
    }
    const movieCacheKey = this.buildSearchCacheKey(
      SearchMediaType.Movie,
      normalizedQuery,
    );
    const seriesCacheKey = this.buildSearchCacheKey(
      SearchMediaType.Series,
      normalizedQuery,
    );

    const cachedMovies =
      this.cacheService.get<CatalogMediaItem[]>(movieCacheKey);
    const cachedSeries =
      this.cacheService.get<CatalogMediaItem[]>(seriesCacheKey);

    if (cachedMovies && cachedSeries) {
      return this.mergeSearchResults(cachedMovies, cachedSeries);
    }

    if (!cachedMovies && !cachedSeries) {
      const combinedResults = await this.fetchJson<
        TmdbListResponse<TmdbMultiSearchResult>
      >('/search/multi', {
        query: normalizedQuery,
        include_adult: this.includeAdult,
        language: this.language,
      });

      const movies = this.mapSearchResults(
        combinedResults.results ?? [],
        SearchMediaType.Movie,
      );
      const series = this.mapSearchResults(
        combinedResults.results ?? [],
        SearchMediaType.Series,
      );

      this.cacheSearchResults(SearchMediaType.Movie, normalizedQuery, movies);
      this.cacheSearchResults(SearchMediaType.Series, normalizedQuery, series);

      return this.mergeSearchResults(movies, series);
    }

    const [movies, series] = await Promise.all([
      cachedMovies ??
        this.fetchTypedSearchResults(SearchMediaType.Movie, normalizedQuery),
      cachedSeries ??
        this.fetchTypedSearchResults(SearchMediaType.Series, normalizedQuery),
    ]);

    return this.mergeSearchResults(movies, series);
  }

  async findById(mediaId: string): Promise<CatalogMediaDetails | null> {
    if (!this.hasToken()) {
      return this.cacheService.getOrSet(
        this.buildFallbackMediaCacheKey(mediaId),
        () => this.fallbackProvider.findById(mediaId),
      );
    }

    const cachedItem = this.cacheService.get<CatalogMediaDetails>(
      this.buildMediaCacheKey(mediaId),
    );
    if (cachedItem) {
      return cachedItem;
    }

    const parsedMediaId = this.parseMediaId(mediaId);

    if (!parsedMediaId) {
      throw new ValidationDomainError(
        'The requested catalog media id is invalid.',
        undefined,
        {
          key: 'errors.catalog.invalid_media_id',
        },
      );
    }

    const item =
      parsedMediaId.mediaType === SearchMediaType.Movie
        ? await this.fetchMovieById(parsedMediaId.tmdbId)
        : await this.fetchSeriesById(parsedMediaId.tmdbId);

    if (!item) {
      return null;
    }

    this.cacheMediaItem(item);
    return item;
  }

  private async fetchMovieById(
    tmdbId: number,
  ): Promise<CatalogMediaDetails | null> {
    const [movie, externalIds] = await Promise.all([
      this.fetchOptionalJson<TmdbMovieDetail>(`/movie/${tmdbId}`, {
        language: this.language,
      }),
      this.fetchOptionalJson<TmdbExternalIds>(
        `/movie/${tmdbId}/external_ids`,
        {},
      ),
    ]);
    if (!movie) {
      return null;
    }

    return {
      id: this.buildMediaId(SearchMediaType.Movie, tmdbId),
      title: movie.title?.trim() || 'Untitled movie',
      year: this.parseYear(movie.release_date),
      mediaType: SearchMediaType.Movie,
      synopsis: this.normalizeSynopsis(movie.overview),
      genres: this.normalizeGenres(
        movie.genres?.map((genre) => genre.name) ?? [],
        SearchMediaType.Movie,
      ),
      runtimeMinutes: this.normalizeRuntime(
        SearchMediaType.Movie,
        movie.runtime ?? undefined,
      ),
      popularity: this.normalizePopularity(movie.popularity),
      tmdbId,
      imdbId: externalIds?.imdb_id?.trim() || undefined,
      originalTitle: movie.original_title?.trim() || movie.title?.trim(),
      providerMediaType: 'movie',
    };
  }

  private async fetchSeriesById(
    tmdbId: number,
  ): Promise<CatalogMediaDetails | null> {
    const [series, externalIds] = await Promise.all([
      this.fetchOptionalJson<TmdbSeriesDetail>(`/tv/${tmdbId}`, {
        language: this.language,
      }),
      this.fetchOptionalJson<TmdbExternalIds>(`/tv/${tmdbId}/external_ids`, {}),
    ]);
    if (!series) {
      return null;
    }

    return {
      id: this.buildMediaId(SearchMediaType.Series, tmdbId),
      title: series.name?.trim() || 'Untitled series',
      year: this.parseYear(series.first_air_date),
      mediaType: SearchMediaType.Series,
      synopsis: this.normalizeSynopsis(series.overview),
      genres: this.normalizeGenres(
        series.genres?.map((genre) => genre.name) ?? [],
        SearchMediaType.Series,
      ),
      runtimeMinutes: this.normalizeRuntime(
        SearchMediaType.Series,
        series.episode_run_time?.[0],
      ),
      popularity: this.normalizePopularity(series.popularity),
      tmdbId,
      imdbId: externalIds?.imdb_id?.trim() || undefined,
      originalTitle: series.original_name?.trim() || series.name?.trim(),
      providerMediaType: 'tv',
    };
  }

  private async fetchTypedSearchResults(
    mediaType: SearchMediaType,
    normalizedQuery: string,
  ): Promise<CatalogMediaItem[]> {
    const endpoint =
      mediaType === SearchMediaType.Movie ? '/search/movie' : '/search/tv';
    const response = await this.fetchJson<
      TmdbListResponse<TmdbMultiSearchResult>
    >(endpoint, {
      query: normalizedQuery,
      include_adult: this.includeAdult,
      language: this.language,
    });

    const items = this.mapSearchResults(response.results ?? [], mediaType);
    this.cacheSearchResults(mediaType, normalizedQuery, items);
    return items;
  }

  private mapSearchResults(
    results: TmdbMultiSearchResult[],
    mediaType: SearchMediaType,
  ): CatalogMediaItem[] {
    const genreMap =
      mediaType === SearchMediaType.Movie
        ? TMDB_MOVIE_GENRE_MAP
        : TMDB_SERIES_GENRE_MAP;

    const filteredResults = results.filter((result) =>
      mediaType === SearchMediaType.Movie
        ? (result.media_type ?? 'movie') === 'movie'
        : (result.media_type ?? 'tv') === 'tv',
    );

    return filteredResults.map((result) => ({
      id: this.buildMediaId(mediaType, result.id),
      title:
        mediaType === SearchMediaType.Movie
          ? result.title?.trim() || 'Untitled movie'
          : result.name?.trim() || 'Untitled series',
      year: this.parseYear(
        mediaType === SearchMediaType.Movie
          ? result.release_date
          : result.first_air_date,
      ),
      mediaType,
      synopsis: this.normalizeSynopsis(result.overview),
      genres: this.normalizeGenres(
        (result.genre_ids ?? []).map(
          (genreId) => genreMap[genreId] ?? 'Unknown',
        ),
        mediaType,
      ),
      runtimeMinutes: this.normalizeRuntime(mediaType),
      popularity: this.normalizePopularity(result.popularity),
    }));
  }

  private mergeSearchResults(
    movies: CatalogMediaItem[],
    series: CatalogMediaItem[],
  ): CatalogMediaItem[] {
    return [...movies, ...series].sort((left, right) => {
      return right.popularity - left.popularity;
    });
  }

  private cacheSearchResults(
    mediaType: SearchMediaType,
    normalizedQuery: string,
    items: CatalogMediaItem[],
  ): void {
    this.cacheService.set(
      this.buildSearchCacheKey(mediaType, normalizedQuery),
      items,
      this.resolveTtl(mediaType),
    );
  }

  private cacheMediaItem(item: CatalogMediaDetails): void {
    this.cacheService.set(
      this.buildMediaCacheKey(item.id),
      item,
      this.resolveDetailTtl(item.mediaType),
    );
  }

  private buildSearchCacheKey(
    mediaType: SearchMediaType,
    normalizedQuery: string,
  ): string {
    return `catalog:tmdb:search:${mediaType}:${encodeURIComponent(normalizedQuery)}`;
  }

  private buildMediaCacheKey(mediaId: string): string {
    return `catalog:tmdb:media:${encodeURIComponent(mediaId)}`;
  }

  private buildFallbackSearchCacheKey(normalizedQuery: string): string {
    return `catalog:fallback:search:${encodeURIComponent(normalizedQuery)}`;
  }

  private buildFallbackMediaCacheKey(mediaId: string): string {
    return `catalog:fallback:media:${encodeURIComponent(mediaId)}`;
  }

  private buildMediaId(mediaType: SearchMediaType, tmdbId: number): string {
    return `${mediaType}_${tmdbId}`;
  }

  private parseMediaId(
    mediaId: string,
  ): { mediaType: SearchMediaType; tmdbId: number } | null {
    const [rawType, rawId] = mediaId.split('_', 2);
    const tmdbId = Number(rawId);
    if (!Number.isInteger(tmdbId)) {
      return null;
    }

    if (rawType === 'movie') {
      return {
        mediaType: SearchMediaType.Movie,
        tmdbId,
      };
    }

    if (rawType === 'series') {
      return {
        mediaType: SearchMediaType.Series,
        tmdbId,
      };
    }

    return null;
  }

  private async fetchJson<T>(
    path: string,
    query: Record<string, string | boolean>,
  ): Promise<T> {
    const payload = await this.fetchOptionalJson<T>(path, query);
    if (payload) {
      return payload;
    }

    throw new NotFoundDomainError(
      'The requested catalog title was not found.',
      undefined,
      {
        key: 'errors.catalog.not_found',
      },
    );
  }

  private async fetchOptionalJson<T>(
    path: string,
    query: Record<string, string | boolean>,
  ): Promise<T | null> {
    const url = new URL(
      `${this.configService.get<string>('tmdb.apiBaseUrl') ?? 'https://api.themoviedb.org/3'}${path}`,
    );
    Object.entries(query).forEach(([key, value]) => {
      url.searchParams.set(key, String(value));
    });

    const response = await fetch(url, {
      headers: {
        Accept: 'application/json',
        Authorization: `Bearer ${this.token}`,
      },
    });

    if (!response.ok) {
      if (response.status === 404) {
        return null;
      }

      this.logger.warn(
        `TMDb request failed for ${path} with status ${response.status}.`,
      );
      throw new ServiceUnavailableDomainError(
        'The movie catalog provider is temporarily unavailable.',
      );
    }

    return (await response.json()) as T;
  }

  private hasToken(): boolean {
    return this.token.length > 0;
  }

  private get token(): string {
    return (this.configService.get<string>('tmdb.apiReadToken') ?? '').trim();
  }

  private get includeAdult(): boolean {
    return this.configService.get<boolean>('tmdb.includeAdult') ?? false;
  }

  private get language(): string {
    return this.configService.get<string>('tmdb.defaultLanguage') ?? 'en-US';
  }

  private resolveTtl(mediaType: SearchMediaType): number {
    return mediaType === SearchMediaType.Movie
      ? (this.configService.get<number>('tmdb.movieSearchCacheTtlMs') ??
          30 * 24 * 60 * 60_000)
      : (this.configService.get<number>('tmdb.seriesSearchCacheTtlMs') ??
          24 * 60 * 60_000);
  }

  private resolveDetailTtl(mediaType: SearchMediaType): number {
    return mediaType === SearchMediaType.Movie
      ? (this.configService.get<number>('tmdb.movieDetailCacheTtlMs') ??
          30 * 24 * 60 * 60_000)
      : (this.configService.get<number>('tmdb.seriesDetailCacheTtlMs') ??
          24 * 60 * 60_000);
  }

  private normalizeSynopsis(overview?: string): string {
    const trimmed = overview?.trim();
    return trimmed?.length
      ? trimmed
      : 'No synopsis is available yet for this title.';
  }

  private normalizeGenres(
    genres: string[],
    mediaType: SearchMediaType,
  ): string[] {
    const uniqueGenres = genres
      .map((genre) => genre.trim())
      .filter(Boolean)
      .filter((genre, index, values) => values.indexOf(genre) === index);

    if (uniqueGenres.length > 0) {
      return uniqueGenres;
    }

    return [mediaType === SearchMediaType.Movie ? 'Feature' : 'Series'];
  }

  private normalizeRuntime(
    mediaType: SearchMediaType,
    runtimeMinutes?: number,
  ): number {
    if (
      Number.isFinite(runtimeMinutes) &&
      runtimeMinutes &&
      runtimeMinutes > 0
    ) {
      return runtimeMinutes;
    }

    return mediaType === SearchMediaType.Movie ? 120 : 45;
  }

  private normalizePopularity(popularity?: number): number {
    const safePopularity = Number.isFinite(popularity) ? (popularity ?? 0) : 0;
    return Number(safePopularity.toFixed(1));
  }

  private parseYear(rawDate?: string): number {
    const year = Number(rawDate?.slice(0, 4));
    return Number.isInteger(year) && year > 1800
      ? year
      : new Date().getUTCFullYear();
  }
}
