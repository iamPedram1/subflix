import { Injectable, OnModuleDestroy, OnModuleInit } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

type CacheEntry<T> = {
  value: T;
  expiresAt: number;
};

type GetOrSetOptions = {
  ttlMs?: number;
};

/**
 * Small in-memory cache for read-heavy application paths.
 *
 * It provides:
 * - TTL-based expiration
 * - bounded entry count
 * - in-flight request coalescing to reduce duplicate work under concurrency
 */
@Injectable()
export class AppCacheService implements OnModuleInit, OnModuleDestroy {
  private readonly entries = new Map<string, CacheEntry<unknown>>();
  private readonly inFlight = new Map<string, Promise<unknown>>();
  private cleanupTimer?: NodeJS.Timeout;

  constructor(private readonly configService: ConfigService) {}

  onModuleInit(): void {
    const cleanupIntervalMs =
      this.configService.get<number>('app.cacheCleanupIntervalMs') ?? 60_000;

    this.cleanupTimer = setInterval(() => {
      this.removeExpiredEntries();
    }, cleanupIntervalMs);
    this.cleanupTimer.unref();
  }

  onModuleDestroy(): void {
    if (this.cleanupTimer) {
      clearInterval(this.cleanupTimer);
    }

    this.entries.clear();
    this.inFlight.clear();
  }

  /** Returns a cached value when a non-expired entry exists. */
  get<T>(key: string): T | undefined {
    const cached = this.readFreshEntry<T>(key);
    if (!cached.hit) {
      return undefined;
    }

    return this.cloneValue(cached.value);
  }

  /** Stores a cache entry and enforces the configured capacity bound. */
  set<T>(key: string, value: T, ttlMs?: number): T {
    const expiresAt = Date.now() + this.resolveTtl(ttlMs);
    this.entries.delete(key);
    this.entries.set(key, {
      value: this.cloneValue(value),
      expiresAt,
    });
    this.enforceCapacity();

    return this.cloneValue(value);
  }

  /** Deletes a single cache entry and any in-flight loader for the key. */
  delete(key: string): void {
    this.entries.delete(key);
    this.inFlight.delete(key);
  }

  /** Deletes every cache entry under the provided namespace prefix. */
  deleteByPrefix(prefix: string): void {
    for (const key of this.entries.keys()) {
      if (key.startsWith(prefix)) {
        this.entries.delete(key);
      }
    }

    for (const key of this.inFlight.keys()) {
      if (key.startsWith(prefix)) {
        this.inFlight.delete(key);
      }
    }
  }

  /**
   * Returns a cached value or executes a shared loader once under contention.
   *
   * Concurrent callers for the same key will await the same underlying promise.
   */
  async getOrSet<T>(
    key: string,
    loader: () => Promise<T>,
    options?: GetOrSetOptions,
  ): Promise<T> {
    const cached = this.readFreshEntry<T>(key);
    if (cached.hit) {
      return this.cloneValue(cached.value);
    }

    const existingLoad = this.inFlight.get(key);
    if (existingLoad) {
      return this.cloneValue((await existingLoad) as T);
    }

    const pendingLoad = loader()
      .then((value) => this.set(key, value, options?.ttlMs))
      .finally(() => {
        this.inFlight.delete(key);
      });

    this.inFlight.set(key, pendingLoad);
    return this.cloneValue((await pendingLoad) as T);
  }

  private readFreshEntry<T>(
    key: string,
  ): { hit: true; value: T } | { hit: false } {
    const entry = this.entries.get(key);
    if (!entry) {
      return { hit: false };
    }

    if (entry.expiresAt <= Date.now()) {
      this.entries.delete(key);
      return { hit: false };
    }

    this.entries.delete(key);
    this.entries.set(key, entry);

    return {
      hit: true,
      value: entry.value as T,
    };
  }

  private resolveTtl(ttlMs?: number): number {
    return (
      ttlMs ??
      this.configService.get<number>('app.cacheDefaultTtlMs') ??
      5 * 60_000
    );
  }

  private enforceCapacity(): void {
    const maxEntries =
      this.configService.get<number>('app.cacheMaxEntries') ?? 1_000;

    while (this.entries.size > maxEntries) {
      const oldestKey = this.entries.keys().next().value;
      if (typeof oldestKey !== 'string') {
        return;
      }

      this.entries.delete(oldestKey);
    }
  }

  private removeExpiredEntries(): void {
    const now = Date.now();

    for (const [key, entry] of this.entries.entries()) {
      if (entry.expiresAt <= now) {
        this.entries.delete(key);
      }
    }
  }

  private cloneValue<T>(value: T): T {
    return structuredClone(value);
  }
}
