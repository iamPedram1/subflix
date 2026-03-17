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

export const subtitleSourcesConfig = registerAs('subtitleSources', () => ({
  cacheTtlMs: parseNumber(
    process.env.SUBTITLE_SOURCE_CACHE_TTL_MS,
    6 * 60 * 60_000,
  ),
  downloadMaxBytes: parseNumber(
    process.env.SUBTITLE_DOWNLOAD_MAX_BYTES,
    5 * 1024 * 1024,
  ),
  zipMaxExtractedBytes: parseNumber(
    process.env.SUBTITLE_ZIP_MAX_EXTRACTED_BYTES,
    10 * 1024 * 1024,
  ),
  providerFailureThreshold: parseNumber(
    process.env.SUBTITLE_PROVIDER_FAILURE_THRESHOLD,
    3,
  ),
  providerCooldownMs: parseNumber(
    process.env.SUBTITLE_PROVIDER_COOLDOWN_MS,
    60_000,
  ),
  subdl: {
    apiBaseUrl:
      process.env.SUBDL_API_BASE_URL ?? 'https://api.subdl.com/api/v1',
    apiKey: process.env.SUBDL_API_KEY ?? '',
    enabled:
      process.env.SUBDL_ENABLED !== 'false' &&
      (process.env.SUBDL_API_KEY ?? '').trim().length > 0,
    timeoutMs: parseNumber(process.env.SUBDL_TIMEOUT_MS, 7_000),
  },
  podnapisi: {
    baseUrl: process.env.PODNAPISI_BASE_URL ?? 'https://www.podnapisi.net',
    enabled: process.env.PODNAPISI_ENABLED !== 'false',
    timeoutMs: parseNumber(process.env.PODNAPISI_TIMEOUT_MS, 10_000),
  },
  tvsubs: {
    baseUrl: process.env.TVSUBS_BASE_URL ?? 'https://www.tvsubtitles.net',
    enabled: process.env.TVSUBS_ENABLED !== 'false',
    timeoutMs: parseNumber(process.env.TVSUBS_TIMEOUT_MS, 10_000),
  },
}));

export const subtitleAlignmentConfig = registerAs('subtitleAlignment', () => ({
  enabled: process.env.SUBTITLE_ALIGNMENT_ENABLED !== 'false',
  maxOffsetMs: parseNumber(
    process.env.SUBTITLE_ALIGNMENT_MAX_OFFSET_MS,
    10_000,
  ),
  stepMs: parseNumber(process.env.SUBTITLE_ALIGNMENT_STEP_MS, 1_000),
  confidenceThreshold: parseNumber(
    process.env.SUBTITLE_ALIGNMENT_CONFIDENCE_THRESHOLD,
    60,
  ),
}));

export const authConfig = registerAs('auth', () => ({
  jwtSecret: process.env.AUTH_JWT_SECRET ?? '',
  accessTokenTtlSeconds: parseNumber(
    process.env.AUTH_ACCESS_TOKEN_TTL_SECONDS,
    15 * 60,
  ),
  refreshTokenTtlDays: parseNumber(
    process.env.AUTH_REFRESH_TOKEN_TTL_DAYS,
    30,
  ),
  emailVerificationTokenTtlHours: parseNumber(
    process.env.AUTH_EMAIL_VERIFICATION_TTL_HOURS,
    24,
  ),
  passwordResetTokenTtlHours: parseNumber(
    process.env.AUTH_PASSWORD_RESET_TTL_HOURS,
    2,
  ),
  bcryptSaltRounds: parseNumber(process.env.AUTH_BCRYPT_SALT_ROUNDS, 12),
}));

export const translationJobsConfig = registerAs('translationJobs', () => ({
  staleAfterMs: parseNumber(
    process.env.TRANSLATION_JOB_STALE_AFTER_MS,
    5 * 60_000, // 5 minutes
  ),
  maxAttempts: parseNumber(process.env.TRANSLATION_JOB_MAX_ATTEMPTS, 3),
  recoveryEnabled: process.env.TRANSLATION_JOB_RECOVERY_ENABLED !== 'false',
  recoveryIntervalMs: parseNumber(
    process.env.TRANSLATION_JOB_RECOVERY_INTERVAL_MS,
    60_000, // 1 minute
  ),
  startupRecoveryEnabled:
    process.env.TRANSLATION_JOB_STARTUP_RECOVERY_ENABLED !== 'false',
  maxConcurrency: parseNumber(
    process.env.TRANSLATION_JOB_MAX_CONCURRENCY,
    3, // 3 concurrent jobs per process
  ),
}));

export const firebaseConfig = registerAs('firebase', () => ({
  projectId: process.env.FIREBASE_PROJECT_ID ?? '',
  clientEmail: process.env.FIREBASE_CLIENT_EMAIL ?? '',
  privateKey: process.env.FIREBASE_PRIVATE_KEY ?? '',
  serviceAccountJson: process.env.FIREBASE_SERVICE_ACCOUNT_JSON ?? '',
}));
