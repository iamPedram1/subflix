import { Injectable } from '@nestjs/common';
import { ClientDevice } from '@prisma/client';

import { normalizeDatabaseError } from 'src/common/database/helpers/database-error.helper';
import { PrismaService } from 'src/common/database/prisma/prisma.service';

@Injectable()
export class DevicesRepository {
  constructor(private readonly prisma: PrismaService) {}

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
