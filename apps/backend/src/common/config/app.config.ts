import { registerAs } from '@nestjs/config';

const parseNumber = (value: string | undefined, fallback: number): number => {
  const parsed = Number(value);
  return Number.isFinite(parsed) ? parsed : fallback;
};

export const appConfig = registerAs('app', () => ({
  nodeEnv: process.env.NODE_ENV ?? 'development',
  port: parseNumber(process.env.PORT, 3000),
  maxUploadBytes: parseNumber(process.env.MAX_UPLOAD_BYTES, 2 * 1024 * 1024),
  maxBodyBytes: parseNumber(process.env.MAX_BODY_BYTES, 32 * 1024),
  rateLimitDefaultLimit: parseNumber(process.env.RATE_LIMIT_DEFAULT_LIMIT, 120),
  rateLimitDefaultWindowMs: parseNumber(
    process.env.RATE_LIMIT_DEFAULT_WINDOW_MS,
    60_000,
  ),
  rateLimitCleanupIntervalMs: parseNumber(
    process.env.RATE_LIMIT_CLEANUP_INTERVAL_MS,
    60_000,
  ),
  cacheDefaultTtlMs: parseNumber(process.env.CACHE_DEFAULT_TTL_MS, 5 * 60_000),
  cacheCleanupIntervalMs: parseNumber(
    process.env.CACHE_CLEANUP_INTERVAL_MS,
    60_000,
  ),
  cacheMaxEntries: parseNumber(process.env.CACHE_MAX_ENTRIES, 1_000),
}));

export const databaseConfig = registerAs('database', () => ({
  url:
    process.env.DATABASE_URL ??
    'postgresql://postgres:postgres@localhost:5432/subflix',
}));

export const tmdbConfig = registerAs('tmdb', () => ({
  apiBaseUrl: process.env.TMDB_API_BASE_URL ?? 'https://api.themoviedb.org/3',
  apiReadToken: process.env.TMDB_API_READ_TOKEN ?? '',
  movieSearchCacheTtlMs: parseNumber(
    process.env.TMDB_MOVIE_SEARCH_CACHE_TTL_MS,
    30 * 24 * 60 * 60_000,
  ),
  seriesSearchCacheTtlMs: parseNumber(
    process.env.TMDB_SERIES_SEARCH_CACHE_TTL_MS,
    24 * 60 * 60_000,
  ),
  movieDetailCacheTtlMs: parseNumber(
    process.env.TMDB_MOVIE_DETAIL_CACHE_TTL_MS,
    30 * 24 * 60 * 60_000,
  ),
  seriesDetailCacheTtlMs: parseNumber(
    process.env.TMDB_SERIES_DETAIL_CACHE_TTL_MS,
    24 * 60 * 60_000,
  ),
  includeAdult: process.env.TMDB_INCLUDE_ADULT === 'true',
  defaultLanguage: process.env.TMDB_DEFAULT_LANGUAGE ?? 'en-US',
}));
