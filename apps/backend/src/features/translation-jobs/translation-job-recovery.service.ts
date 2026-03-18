import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { Prisma } from '@prisma/client';

import { StructuredLogger } from 'common/utils/structured-logger';

import { TranslationJobRunnerService } from 'features/translation-jobs/translation-job-runner.service';
import { TranslationJobsRepository } from 'features/translation-jobs/translation-jobs.repository';
import {
  applyAttemptFailed,
  applyRecoveredFromStall,
  canRetryAfterStall,
  parseJobRetryMeta,
} from 'features/translation-jobs/utils/job-staleness.util';

/**
 * Identifies translation jobs that have been stuck in the translating state
 * for too long and recovers them according to the retry policy.
 *
 * A job is considered stalled when its `updatedAt` timestamp has not advanced
 * for longer than the configured stale threshold. Every markProgress() call
 * updates `updatedAt`, so it doubles as a heartbeat.
 *
 * Recovery policy:
 *   - attemptCount < maxAttempts  → requeue (status: queued, marked recoveredFromStall)
 *   - attemptCount >= maxAttempts → fail (status: failed, reason: stall_recovery_exhausted)
 *
 * Multi-instance safety:
 *   Before running a recovery cycle this service acquires a PostgreSQL session-
 *   level advisory lock. Only one instance at a time can hold the lock, so
 *   concurrent recovery cycles across multiple workers are prevented. If the
 *   lock is unavailable the cycle skips cleanly without modifying any job state.
 */
@Injectable()
export class TranslationJobRecoveryService {
  private readonly log = new StructuredLogger(
    TranslationJobRecoveryService.name,
  );

  constructor(
    private readonly translationJobsRepository: TranslationJobsRepository,
    private readonly translationJobRunnerService: TranslationJobRunnerService,
    private readonly configService: ConfigService,
  ) {}

  /**
   * Finds all stalled jobs and applies the recovery policy to each one.
   *
   * Accepts an optional `now` date so callers (especially tests) can control
   * the reference time without needing fake system timers.
   *
   * Acquires a PostgreSQL advisory lock before scanning so that at most one
   * process instance runs a recovery cycle at a time. Returns zeros immediately
   * if the lock is unavailable (another instance is already recovering).
   */
  async recoverStalledJobs(
    now?: Date,
  ): Promise<{ requeued: number; failed: number; scanned: number }> {
    const recoveryEnabled = this.configService.get<boolean>(
      'translationJobs.recoveryEnabled',
    );

    if (!recoveryEnabled) {
      return { requeued: 0, failed: 0, scanned: 0 };
    }

    const acquired =
      await this.translationJobsRepository.tryAcquireRecoveryAdvisoryLock();

    if (!acquired) {
      this.log.info('translation.recovery.lock_skipped');
      return { requeued: 0, failed: 0, scanned: 0 };
    }

    this.log.info('translation.recovery.lock_acquired');

    try {
      return await this.runRecovery(now);
    } finally {
      await this.translationJobsRepository.releaseRecoveryAdvisoryLock();
      this.log.info('translation.recovery.lock_released');
    }
  }

  /** Core recovery logic, called after the advisory lock has been acquired. */
  private async runRecovery(
    now?: Date,
  ): Promise<{ requeued: number; failed: number; scanned: number }> {
    const staleAfterMs = this.configService.get<number>(
      'translationJobs.staleAfterMs',
    )!;
    const maxAttempts = this.configService.get<number>(
      'translationJobs.maxAttempts',
    )!;

    const currentTime = now ?? new Date();
    const staleBeforeDate = new Date(currentTime.getTime() - staleAfterMs);

    const stalledJobs = await this.translationJobsRepository.findStalledJobs({
      staleBeforeDate,
    });

    let requeued = 0;
    let failed = 0;

    for (const job of stalledJobs) {
      const meta = parseJobRetryMeta(job.jobMeta);

      this.log.warn('translation.stalled.detected', {
        jobId: job.id,
        attemptCount: meta.attemptCount,
        lastUpdatedAt: job.updatedAt.toISOString(),
        staleBeforeDate: staleBeforeDate.toISOString(),
      });

      if (canRetryAfterStall(meta, maxAttempts)) {
        const recoveredMeta = applyRecoveredFromStall(meta);
        const success =
          await this.translationJobsRepository.requeueStalledJob(
            job.id,
            recoveredMeta as unknown as Prisma.InputJsonValue,
          );

        if (success) {
          this.log.info('translation.stalled.requeued', {
            jobId: job.id,
            attemptCount: meta.attemptCount,
            maxAttempts,
          });

          this.translationJobRunnerService.schedule(job.id);
          requeued++;
        }
      } else {
        const failedMeta = applyAttemptFailed(
          meta,
          'stall_recovery_exhausted',
          currentTime,
        );
        const success = await this.translationJobsRepository.failStalledJob(
          job.id,
          failedMeta as unknown as Prisma.InputJsonValue,
          'Translation job stalled and exceeded maximum retry attempts.',
        );

        if (success) {
          this.log.warn('translation.stalled.failed', {
            jobId: job.id,
            attemptCount: meta.attemptCount,
            maxAttempts,
          });

          failed++;
        }
      }
    }

    return { requeued, failed, scanned: stalledJobs.length };
  }
}
