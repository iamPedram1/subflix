import { Module } from '@nestjs/common';

import { CacheModule } from 'src/common/cache/cache.module';

import { DevicesModule } from '../devices/devices.module';
import { PreferencesController } from './preferences.controller';
import { PreferencesRepository } from './preferences.repository';
import { PreferencesService } from './preferences.service';

@Module({
  imports: [DevicesModule, CacheModule],
  controllers: [PreferencesController],
  providers: [PreferencesRepository, PreferencesService],
  exports: [PreferencesService],
})
export class PreferencesModule {}
