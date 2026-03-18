import { Injectable } from '@nestjs/common';

import { StructuredLogger } from 'common/utils/structured-logger';
import { TranslationJobExecutionLimiterService } from 'features/translation-jobs/translation-job-execution-limiter.service';
import { TranslationJobRunnerService } from 'features/translation-jobs/translation-job-runner.service';
import { TranslationJobsRepository } from 'features/translation-jobs/translation-jobs.repository';

/**
 * Coordinates durable dispatch of queued translation jobs against the
 * current in-process concurrency budget.
 *
 * Uses the DB as the source of truth for which jobs are waiting — rather than
 * an in-memory queue — so queued jobs survive process restarts.
 *
 * Call dispatch() from any point where capacity may be available:
 *   - after a new translation job is created
 *   - on application startup (after stalled-job recovery)
 *   - on a configurable polling interval as a safety net
 *
 * Dispatch order: oldest queued job first (createdAt ASC) for FIFO fairness.
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
  ) {}

  /**
   * Fills available execution slots from the DB-backed queue of waiting jobs.
   *
   * Reads current concurrency metrics, fetches up to that many queued jobs
   * (oldest first), and schedules each one for execution. Exits immediately if
   * there is no capacity or no queued jobs.
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

    const jobs =
      await this.translationJobsRepository.findNextQueuedJobs(slotsAvailable);

    if (jobs.length === 0) {
      this.log.info('translation.dispatch.no_jobs', { slotsAvailable });
      return;
    }

    for (const job of jobs) {
      this.log.info('translation.dispatch.claimed', { jobId: job.id });
      this.runner.schedule(job.id);
    }

    this.log.info('translation.dispatch.completed', {
      trigger,
      dispatched: jobs.length,
      slotsAvailable,
    });
  }
}
