import {
  Injectable,
  OnApplicationBootstrap,
  OnApplicationShutdown,
} from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import { StructuredLogger } from 'common/utils/structured-logger';

import { TranslationJobDispatchService } from 'features/translation-jobs/translation-job-dispatch.service';
import { TranslationJobRecoveryService } from 'features/translation-jobs/translation-job-recovery.service';

/**
 * Operationalizes the stalled-job recovery policy and DB-backed dispatch by
 * wiring both services into the application lifecycle.
 *
 * On bootstrap (if recovery is enabled):
 *   1. Optionally runs a one-shot startup recovery pass.
 *   2. Runs a one-shot startup dispatch pass (after recovery, if enabled).
 *   3. Starts a repeating recovery interval.
 *   4. Starts a repeating dispatch interval (if dispatchPollIntervalMs > 0).
 *
 * Startup ordering: recovery always runs before dispatch so that stalled jobs
 * are requeued before the dispatch coordinator looks for queued work.
 *
 * Keeps scheduling concerns entirely separate from the recovery policy logic
 * (in TranslationJobRecoveryService) and the dispatch logic
 * (in TranslationJobDispatchService).
 *
 * Single-instance assumption:
 *   All timers run in-process. See TranslationJobRecoveryService and
 *   TranslationJobDispatchService for multi-instance caveats.
 */
@Injectable()
export class TranslationJobRecoverySchedulerService
  implements OnApplicationBootstrap, OnApplicationShutdown
{
  private readonly log = new StructuredLogger(
    TranslationJobRecoverySchedulerService.name,
  );

  private recoveryTimer: ReturnType<typeof setInterval> | null = null;
  private dispatchTimer: ReturnType<typeof setInterval> | null = null;

  constructor(
    private readonly recoveryService: TranslationJobRecoveryService,
    private readonly dispatchService: TranslationJobDispatchService,
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

    const dispatchOnStartup = this.configService.get<boolean>(
      'translationJobs.dispatchOnStartupEnabled',
    );

    if (dispatchOnStartup) {
      await this.runStartupDispatch();
    }

    this.startDispatchInterval();
  }

  onApplicationShutdown(): void {
    if (this.recoveryTimer !== null) {
      clearInterval(this.recoveryTimer);
      this.recoveryTimer = null;
    }

    if (this.dispatchTimer !== null) {
      clearInterval(this.dispatchTimer);
      this.dispatchTimer = null;
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

  private async runStartupDispatch(): Promise<void> {
    this.log.info('translation.dispatch.startup');
    try {
      await this.dispatchService.dispatch('startup');
    } catch (error) {
      this.log.error('translation.dispatch.startup.failed', {
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

  private startDispatchInterval(): void {
    const intervalMs = this.configService.get<number>(
      'translationJobs.dispatchPollIntervalMs',
    );

    if (!intervalMs || intervalMs <= 0) {
      return;
    }

    this.dispatchTimer = setInterval(() => {
      void this.runDispatchCycle();
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

  private async runDispatchCycle(): Promise<void> {
    try {
      await this.dispatchService.dispatch('poll');
    } catch (error) {
      this.log.error('translation.dispatch.cycle.failed', {
        error: error instanceof Error ? error.message : String(error),
      });
    }
  }
}
