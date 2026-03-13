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
