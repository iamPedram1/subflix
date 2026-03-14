import { Global, Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';

import {
  appConfig,
  databaseConfig,
  subtitleAlignmentConfig,
  subtitleSourcesConfig,
  tmdbConfig,
} from 'common/config/app.config';

@Global()
@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      cache: true,
      load: [
        appConfig,
        databaseConfig,
        tmdbConfig,
        subtitleSourcesConfig,
        subtitleAlignmentConfig,
      ],
      envFilePath: ['.env.local', '.env'],
    }),
  ],
})
export class AppConfigModule {}
