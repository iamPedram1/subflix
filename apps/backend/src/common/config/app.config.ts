import { registerAs } from '@nestjs/config';

const parseNumber = (value: string | undefined, fallback: number): number => {
  const parsed = Number(value);
  return Number.isFinite(parsed) ? parsed : fallback;
};

export const appConfig = registerAs('app', () => ({
  nodeEnv: process.env.NODE_ENV ?? 'development',
  port: parseNumber(process.env.PORT, 3000),
  maxUploadBytes: parseNumber(process.env.MAX_UPLOAD_BYTES, 2 * 1024 * 1024),
}));

export const databaseConfig = registerAs('database', () => ({
  url:
    process.env.DATABASE_URL ??
    'postgresql://postgres:postgres@localhost:5432/subflix',
}));
