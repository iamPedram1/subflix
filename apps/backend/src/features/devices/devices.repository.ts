import { Injectable } from '@nestjs/common';
import { ClientDevice } from '@prisma/client';

import { BaseRepository } from 'common/database/base.repository';
import { PrismaService } from 'common/database/prisma/prisma.service';

@Injectable()
/** Encapsulates persistence for device ownership records. */
export class DevicesRepository extends BaseRepository {
  constructor(private readonly prisma: PrismaService) {
    super();
  }

  /** Upserts a device row from the public header identifier. */
  upsertByDeviceId(deviceId: string): Promise<ClientDevice> {
    return this.dbCall(() =>
      this.prisma.clientDevice.upsert({
        where: { deviceId },
        update: {},
        create: { deviceId },
      }),
    );
  }
}
