import { Module } from '@nestjs/common';

import { DevicesRepository } from 'features/devices/devices.repository';
import { DevicesService } from 'features/devices/devices.service';

@Module({
  providers: [DevicesRepository, DevicesService],
  exports: [DevicesService],
})
export class DevicesModule {}
