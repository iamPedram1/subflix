import { Module } from '@nestjs/common';

import { CatalogModule } from 'features/catalog/catalog.module';
import { DevicesModule } from 'features/devices/devices.module';
import { SubtitlesModule } from 'features/subtitles/subtitles.module';
import { MockTranslationProvider } from 'features/translation-jobs/providers/mock-translation.provider';
import { TRANSLATION_PROVIDER_PORT } from 'features/translation-jobs/ports/translation-provider.port';
import { TranslationJobRecoverySchedulerService } from 'features/translation-jobs/translation-job-recovery-scheduler.service';
import { TranslationJobRecoveryService } from 'features/translation-jobs/translation-job-recovery.service';
import { TranslationJobRunnerService } from 'features/translation-jobs/translation-job-runner.service';
import { TranslationJobsController } from 'features/translation-jobs/translation-jobs.controller';
import { TranslationJobsRepository } from 'features/translation-jobs/translation-jobs.repository';
import { TranslationJobsService } from 'features/translation-jobs/translation-jobs.service';
import { SubtitleAcquisitionStrategyService } from 'features/translation-jobs/subtitle-acquisition-strategy.service';
import { TranslationReuseService } from 'features/translation-jobs/translation-reuse.service';

@Module({
  imports: [DevicesModule, CatalogModule, SubtitlesModule],
  controllers: [TranslationJobsController],
  providers: [
    TranslationJobsRepository,
    TranslationJobsService,
    TranslationJobRunnerService,
    TranslationJobRecoveryService,
    TranslationJobRecoverySchedulerService,
    SubtitleAcquisitionStrategyService,
    TranslationReuseService,
    MockTranslationProvider,
    {
      provide: TRANSLATION_PROVIDER_PORT,
      useExisting: MockTranslationProvider,
    },
  ],
  exports: [TranslationJobsService],
})
export class TranslationJobsModule {}
