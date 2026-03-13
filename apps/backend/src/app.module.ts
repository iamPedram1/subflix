import { Module } from '@nestjs/common';

import { AppConfigModule } from './common/config/config.module';
import { PrismaModule } from './common/database/prisma/prisma.module';
import { CatalogModule } from './features/catalog/catalog.module';
import { DevicesModule } from './features/devices/devices.module';
import { HealthModule } from './features/health/health.module';

@Module({
  imports: [
    AppConfigModule,
    PrismaModule,
    DevicesModule,
    HealthModule,
    CatalogModule,
  ],
})
export class AppModule {}
