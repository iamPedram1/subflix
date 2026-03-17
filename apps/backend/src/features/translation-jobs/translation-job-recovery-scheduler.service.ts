import {
  Injectable,
  OnApplicationBootstrap,
  OnApplicationShutdown,
} from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import { StructuredLogger } from 'common/utils/structured-logger';

import { TranslationJobRecoveryService } from 'features/translation-jobs/translation-job-recovery.service';

/**
 * Operationalizes the stalled-job recovery policy by wiring
 * TranslationJobRecoveryService into the application lifecycle.
 *
 * On bootstrap (if enabled):
 *   1. Optionally runs a one-shot startup recovery pass.
 *   2. Starts a repeating interval that calls recoverStalledJobs() on a
 *      configurable schedule.
 *
 * Keeps scheduling concerns entirely separate from the recovery policy logic,
 * which remains in TranslationJobRecoveryService.
 *
 * Single-instance assumption:
 *   The interval runs in-process. Running multiple instances without a
 *   distributed lock means concurrent recovery cycles are possible. The
 *   repository's atomic updateMany(status: translating) pre-check prevents
 *   double-recovery of the same job, so the worst outcome is redundant work
 *   rather than data corruption. For true multi-instance safety, add a
 *   database advisory lock or an external leader-election mechanism before
 *   deploying behind a load balancer.
 */
@Injectable()
export class TranslationJobRecoverySchedulerService
  implements OnApplicationBootstrap, OnApplicationShutdown
{
  private readonly log = new StructuredLogger(
    TranslationJobRecoverySchedulerService.name,
  );

  private recoveryTimer: ReturnType<typeof setInterval> | null = null;

  constructor(
    private readonly recoveryService: TranslationJobRecoveryService,
    private readonly configService: ConfigService,
  ) {}

  async onApplicationBootstrap(): Promise<void> {
    const recoveryEnabled = this.configService.get<boolean>(
      'translationJobs.recoveryEnabled',
    );

    if (!recoveryEnabled) {
      return;
    }

    const startupEnabled = this.configService.get<boolean>(
      'translationJobs.startupRecoveryEnabled',
    );

    if (startupEnabled) {
      await this.runStartupRecovery();
    }

    this.startRecoveryInterval();
  }

  onApplicationShutdown(): void {
    if (this.recoveryTimer !== null) {
      clearInterval(this.recoveryTimer);
      this.recoveryTimer = null;
    }
  }

  private async runStartupRecovery(): Promise<void> {
    this.log.info('translation.recovery.startup.started');
    try {
      const result = await this.recoveryService.recoverStalledJobs();
      this.log.info('translation.recovery.startup.completed', {
        requeuedCount: result.requeued,
        failedCount: result.failed,
        scannedCount: result.scanned,
      });
    } catch (error) {
      this.log.error('translation.recovery.startup.failed', {
        error: error instanceof Error ? error.message : String(error),
      });
    }
  }

  private startRecoveryInterval(): void {
    const intervalMs = this.configService.get<number>(
      'translationJobs.recoveryIntervalMs',
    )!;

    this.recoveryTimer = setInterval(() => {
      void this.runRecoveryCycle();
    }, intervalMs);
  }

  private async runRecoveryCycle(): Promise<void> {
    const startedAt = Date.now();
    try {
      const result = await this.recoveryService.recoverStalledJobs();
      const durationMs = Date.now() - startedAt;

      if (result.requeued > 0 || result.failed > 0) {
        this.log.info('translation.recovery.cycle.completed', {
          requeuedCount: result.requeued,
          failedCount: result.failed,
          scannedCount: result.scanned,
          durationMs,
        });
      }
    } catch (error) {
      const durationMs = Date.now() - startedAt;
      this.log.error('translation.recovery.cycle.failed', {
        error: error instanceof Error ? error.message : String(error),
        durationMs,
      });
    }
  }
}
