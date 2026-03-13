import { Injectable, OnModuleDestroy, OnModuleInit } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

type RateLimitBucket = {
  count: number;
  resetAt: number;
};

type ConsumeRateLimitParams = {
  key: string;
  limit: number;
  windowMs: number;
};

export type RateLimitDecision = {
  allowed: boolean;
  limit: number;
  remaining: number;
  resetAt: number;
  retryAfterSeconds: number;
};

/** Maintains in-memory fixed-window rate-limit buckets for the current API process. */
@Injectable()
export class RateLimitService implements OnModuleInit, OnModuleDestroy {
  private readonly buckets = new Map<string, RateLimitBucket>();
  private cleanupTimer?: NodeJS.Timeout;

  constructor(private readonly configService: ConfigService) {}

  onModuleInit(): void {
    const cleanupIntervalMs =
      this.configService.get<number>('app.rateLimitCleanupIntervalMs') ??
      60_000;

    this.cleanupTimer = setInterval(() => {
      this.removeExpiredBuckets();
    }, cleanupIntervalMs);
    this.cleanupTimer.unref();
  }

  onModuleDestroy(): void {
    if (this.cleanupTimer) {
      clearInterval(this.cleanupTimer);
    }

    this.buckets.clear();
  }

  /** Consumes one request slot from the fixed window identified by the provided key. */
  consume(params: ConsumeRateLimitParams): RateLimitDecision {
    const now = Date.now();
    const existing = this.buckets.get(params.key);

    const bucket =
      !existing || existing.resetAt <= now
        ? this.createBucket(params.key, now + params.windowMs)
        : existing;

    bucket.count += 1;

    const remaining = Math.max(params.limit - bucket.count, 0);
    const retryAfterSeconds = Math.max(
      Math.ceil((bucket.resetAt - now) / 1000),
      0,
    );

    return {
      allowed: bucket.count <= params.limit,
      limit: params.limit,
      remaining,
      resetAt: bucket.resetAt,
      retryAfterSeconds,
    };
  }

  /** Clears all stored rate-limit state, primarily for tests. */
  reset(): void {
    this.buckets.clear();
  }

  /** Returns the current number of tracked buckets, primarily for tests. */
  getBucketCount(): number {
    return this.buckets.size;
  }

  private createBucket(key: string, resetAt: number): RateLimitBucket {
    const bucket: RateLimitBucket = {
      count: 0,
      resetAt,
    };

    this.buckets.set(key, bucket);
    return bucket;
  }

  private removeExpiredBuckets(): void {
    const now = Date.now();

    for (const [key, bucket] of this.buckets.entries()) {
      if (bucket.resetAt <= now) {
        this.buckets.delete(key);
      }
    }
  }
}
