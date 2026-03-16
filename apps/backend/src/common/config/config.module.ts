import { Global, Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';

import {
  appConfig,
  authConfig,
  databaseConfig,
  firebaseConfig,
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
        authConfig,
        databaseConfig,
        firebaseConfig,
        tmdbConfig,
        subtitleSourcesConfig,
        subtitleAlignmentConfig,
      ],
      envFilePath:
        process.env.NODE_ENV === 'production'
          ? '.env.production'
          : '.env.local',
    }),
  ],
})
export class AppConfigModule {}
