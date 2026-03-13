import { Module } from '@nestjs/common';

import { AppConfigModule } from './common/config/config.module';
import { PrismaModule } from './common/database/prisma/prisma.module';
import { HealthModule } from './features/health/health.module';

@Module({
  imports: [AppConfigModule, PrismaModule, HealthModule],
})
export class AppModule {}
