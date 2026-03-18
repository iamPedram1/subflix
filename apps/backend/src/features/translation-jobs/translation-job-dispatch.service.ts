import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import { StructuredLogger } from 'common/utils/structured-logger';
import { TranslationJobExecutionLimiterService } from 'features/translation-jobs/translation-job-execution-limiter.service';
import { TranslationJobRunnerService } from 'features/translation-jobs/translation-job-runner.service';
import { TranslationJobsRepository } from 'features/translation-jobs/translation-jobs.repository';
import { pickDispatchCandidates } from 'features/translation-jobs/utils/translation-job-priority.util';

/**
 * Coordinates durable, priority-aware dispatch of queued translation jobs
 * against the current in-process concurrency budget.
 *
 * Uses the DB as the source of truth for which jobs are waiting — rather than
 * an in-memory queue — so queued jobs survive process restarts.
 *
 * Call dispatch() from any point where capacity may be available:
 *   - after a new translation job is created
 *   - on application startup (after stalled-job recovery)
 *   - on a configurable polling interval as a safety net
 *
 * Dispatch order:
 *   Jobs are selected by priority tier first, then by createdAt ascending
 *   (FIFO) as a tiebreaker within the same tier. See DispatchPriority for
 *   the full tier semantics.
 *
 * Fairness:
 *   Recovered-from-stall jobs are placed in the RECOVERED tier initially.
 *   Once their age (from createdAt) exceeds dispatchFairnessThresholdMs they
 *   are promoted back to their base tier to prevent indefinite starvation.
 *
 * Single-instance assumption:
 *   The concurrency check reads from the in-memory limiter, which is per-process.
 *   Concurrent dispatch() calls (e.g. startup + poll firing simultaneously) may
 *   each read the same available slot count and schedule the same job. The runner's
 *   scheduledJobIds dedup and the repository's atomic claimQueuedJobForRunner
 *   prevent duplicate execution — at most one runner will successfully claim any
 *   given job.
 */
@Injectable()
export class TranslationJobDispatchService {
  private readonly log = new StructuredLogger(
    TranslationJobDispatchService.name,
  );

  constructor(
    private readonly translationJobsRepository: TranslationJobsRepository,
    private readonly executionLimiter: TranslationJobExecutionLimiterService,
    private readonly runner: TranslationJobRunnerService,
    private readonly configService: ConfigService,
  ) {}

  /**
   * Fills available execution slots from the DB-backed queue using priority
   * scheduling.
   *
   * 1. Reads current concurrency metrics to determine how many slots are free.
   * 2. Fetches an overscanned candidate batch from the repository so that
   *    higher-priority jobs can be selected even when lower-priority jobs are
   *    older.
   * 3. Applies priority scoring and picks the best candidates up to
   *    slotsAvailable.
   * 4. Schedules each selected job for execution via the runner.
   */
  async dispatch(trigger: string): Promise<void> {
    this.log.info('translation.dispatch.triggered', { trigger });

    const { activeCount, maxConcurrency } = this.executionLimiter.getMetrics();
    const slotsAvailable = maxConcurrency - activeCount;

    if (slotsAvailable <= 0) {
      this.log.info('translation.dispatch.no_capacity', {
        activeCount,
        maxConcurrency,
      });
      return;
    }

    const candidates =
      await this.translationJobsRepository.findQueuedJobsForDispatch(
        slotsAvailable,
      );

    if (candidates.length === 0) {
      this.log.info('translation.dispatch.no_jobs', { slotsAvailable });
      return;
    }

    const fairnessThresholdMs = this.configService.get<number>(
      'translationJobs.dispatchFairnessThresholdMs',
    )!;

    const selected = pickDispatchCandidates(
      candidates,
      slotsAvailable,
      new Date(),
      fairnessThresholdMs,
    );

    this.log.info('translation.dispatch.prioritized', {
      candidates: candidates.length,
      selected: selected.length,
      slotsAvailable,
    });

    for (const job of selected) {
      this.log.info('translation.dispatch.claimed', {
        jobId: job.id,
        priority: job.priority,
        sourceType: job.sourceType,
      });
      this.runner.schedule(job.id);
    }

    this.log.info('translation.dispatch.completed', {
      trigger,
      dispatched: selected.length,
      slotsAvailable,
    });
  }
}
