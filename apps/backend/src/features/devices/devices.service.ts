import { Injectable } from '@nestjs/common';
import { ClientDevice } from '@prisma/client';

import { DevicesRepository } from 'features/devices/devices.repository';

@Injectable()
/** Resolves request-scoped device identities for header-based ownership. */
export class DevicesService {
  constructor(private readonly devicesRepository: DevicesRepository) {}

  /** Upserts and returns the persistent device record for a raw header value. */
  resolveDevice(deviceId: string): Promise<ClientDevice> {
    return this.devicesRepository.upsertByDeviceId(deviceId);
  }
}
