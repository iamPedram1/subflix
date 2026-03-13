import { Module } from '@nestjs/common';

import { CacheModule } from './common/cache/cache.module';
import { AppConfigModule } from './common/config/config.module';
import { PrismaModule } from './common/database/prisma/prisma.module';
import { CatalogModule } from './features/catalog/catalog.module';
import { DevicesModule } from './features/devices/devices.module';
import { HealthModule } from './features/health/health.module';
import { PreferencesModule } from './features/preferences/preferences.module';
import { SubtitlesModule } from './features/subtitles/subtitles.module';
import { TranslationJobsModule } from './features/translation-jobs/translation-jobs.module';

@Module({
  imports: [
    AppConfigModule,
    CacheModule,
    PrismaModule,
    DevicesModule,
    HealthModule,
    CatalogModule,
    PreferencesModule,
    SubtitlesModule,
    TranslationJobsModule,
  ],
})
export class AppModule {}
