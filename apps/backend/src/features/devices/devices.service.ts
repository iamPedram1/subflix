import { Injectable } from '@nestjs/common';
import { ClientDevice } from '@prisma/client';

import { DevicesRepository } from './devices.repository';

@Injectable()
export class DevicesService {
  constructor(private readonly devicesRepository: DevicesRepository) {}

  resolveDevice(deviceId: string): Promise<ClientDevice> {
    return this.devicesRepository.upsertByDeviceId(deviceId);
  }
}
