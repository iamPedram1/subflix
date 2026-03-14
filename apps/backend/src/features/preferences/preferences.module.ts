import { Module } from '@nestjs/common';

import { CacheModule } from 'common/cache/cache.module';

import { DevicesModule } from 'features/devices/devices.module';
import { PreferencesController } from 'features/preferences/preferences.controller';
import { PreferencesRepository } from 'features/preferences/preferences.repository';
import { PreferencesService } from 'features/preferences/preferences.service';

@Module({
  imports: [DevicesModule, CacheModule],
  controllers: [PreferencesController],
  providers: [PreferencesRepository, PreferencesService],
  exports: [PreferencesService],
})
export class PreferencesModule {}
