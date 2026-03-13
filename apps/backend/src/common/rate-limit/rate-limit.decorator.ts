import { SetMetadata } from '@nestjs/common';

import {
  RATE_LIMIT_METADATA_KEY,
  SKIP_RATE_LIMIT_METADATA_KEY,
} from './rate-limit.constants';

export type RateLimitOptions = {
  limit: number;
  windowMs: number;
  key?: string;
};

/** Applies a per-handler or per-controller rate limit override. */
export const RateLimit = (options: RateLimitOptions) =>
  SetMetadata(RATE_LIMIT_METADATA_KEY, options);

/** Opts a route or controller out of the global rate limiter. */
export const SkipRateLimit = () =>
  SetMetadata(SKIP_RATE_LIMIT_METADATA_KEY, true);
