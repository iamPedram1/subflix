import { Module } from '@nestjs/common';

import { DevicesRepository } from './devices.repository';
import { DevicesService } from './devices.service';

@Module({
  providers: [DevicesRepository, DevicesService],
  exports: [DevicesService],
})
export class DevicesModule {}
