import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import { StructuredLogger } from 'common/utils/structured-logger';

/**
 * Enforces a per-process ceiling on the number of translation jobs that may
 * execute concurrently. Any call to tryAcquireSlot() that cannot be satisfied
 * returns false so the caller can defer the job until capacity opens.
 *
 * Single-instance assumption:
 *   The counter is in-memory. Running multiple instances behind a load balancer
 *   means each process manages its own concurrency budget independently.
 *   Global concurrency control across instances is not implemented in this phase.
 */
@Injectable()
export class TranslationJobExecutionLimiterService {
  private readonly log = new StructuredLogger(
    TranslationJobExecutionLimiterService.name,
  );

  private readonly maxConcurrency: number;
  private activeCount = 0;

  constructor(private readonly configService: ConfigService) {
    this.maxConcurrency = this.configService.get<number>(
      'translationJobs.maxConcurrency',
    )!;
  }

  /**
   * Attempts to claim one execution slot.
   *
   * Returns true and increments the active counter if a slot is available.
   * Returns false without modifying state when the limit is already reached.
   */
  tryAcquireSlot(jobId: string): boolean {
    if (this.activeCount >= this.maxConcurrency) {
      this.log.info('translation.execution.capacity_reached', {
        jobId,
        activeCount: this.activeCount,
        maxConcurrency: this.maxConcurrency,
      });
      return false;
    }

    this.activeCount++;
    this.log.info('translation.execution.slot_acquired', {
      jobId,
      activeCount: this.activeCount,
      maxConcurrency: this.maxConcurrency,
    });
    return true;
  }

  /**
   * Releases a previously acquired execution slot.
   *
   * Always call this in a finally block to prevent slot leaks.
   */
  releaseSlot(jobId: string): void {
    if (this.activeCount > 0) {
      this.activeCount--;
    }
    this.log.info('translation.execution.slot_released', {
      jobId,
      activeCount: this.activeCount,
      maxConcurrency: this.maxConcurrency,
    });
  }

  /** Returns a snapshot of the current execution state for observability. */
  getMetrics(): { activeCount: number; maxConcurrency: number } {
    return {
      activeCount: this.activeCount,
      maxConcurrency: this.maxConcurrency,
    };
  }
}
