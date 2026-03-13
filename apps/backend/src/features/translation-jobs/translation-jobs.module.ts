import { Module } from '@nestjs/common';

import { CatalogModule } from '../catalog/catalog.module';
import { DevicesModule } from '../devices/devices.module';
import { SubtitlesModule } from '../subtitles/subtitles.module';
import { MockTranslationProvider } from './providers/mock-translation.provider';
import { TRANSLATION_PROVIDER_PORT } from './ports/translation-provider.port';
import { TranslationJobRunnerService } from './translation-job-runner.service';
import { TranslationJobsController } from './translation-jobs.controller';
import { TranslationJobsRepository } from './translation-jobs.repository';
import { TranslationJobsService } from './translation-jobs.service';

@Module({
  imports: [DevicesModule, CatalogModule, SubtitlesModule],
  controllers: [TranslationJobsController],
  providers: [
    TranslationJobsRepository,
    TranslationJobsService,
    TranslationJobRunnerService,
    MockTranslationProvider,
    {
      provide: TRANSLATION_PROVIDER_PORT,
      useExisting: MockTranslationProvider,
    },
  ],
  exports: [TranslationJobsService],
})
export class TranslationJobsModule {}
