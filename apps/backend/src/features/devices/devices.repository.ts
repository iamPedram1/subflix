import { Injectable } from '@nestjs/common';
import { ClientDevice } from '@prisma/client';

import { normalizeDatabaseError } from 'src/common/database/helpers/database-error.helper';
import { PrismaService } from 'src/common/database/prisma/prisma.service';

@Injectable()
/** Encapsulates persistence for device ownership records. */
export class DevicesRepository {
  constructor(private readonly prisma: PrismaService) {}

  /** Upserts a device row from the public header identifier. */
  async upsertByDeviceId(deviceId: string): Promise<ClientDevice> {
    try {
      return await this.prisma.clientDevice.upsert({
        where: { deviceId },
        update: {},
        create: { deviceId },
      });
    } catch (error) {
      return normalizeDatabaseError(error);
    }
  }
}
