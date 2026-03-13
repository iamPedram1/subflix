import { Test } from '@nestjs/testing';

import { AppConfigModule } from 'src/common/config/config.module';
import { PrismaModule } from 'src/common/database/prisma/prisma.module';
import { PrismaService } from 'src/common/database/prisma/prisma.service';
import { DevicesModule } from 'src/features/devices/devices.module';
import { DevicesService } from 'src/features/devices/devices.service';

import { describeIfDatabase } from 'test/core/shared/database-test.helper';

describeIfDatabase('DevicesService integration', () => {
  let prismaService: PrismaService;
  let devicesService: DevicesService;

  beforeAll(async () => {
    const moduleRef = await Test.createTestingModule({
      imports: [AppConfigModule, PrismaModule, DevicesModule],
    }).compile();

    prismaService = moduleRef.get(PrismaService);
    devicesService = moduleRef.get(DevicesService);
  });

  beforeEach(async () => {
    await prismaService.userPreference.deleteMany();
    await prismaService.clientDevice.deleteMany();
  });

  afterAll(async () => {
    await prismaService.$disconnect();
  });

  it('upserts a device by header id', async () => {
    const device = await devicesService.resolveDevice('integration-device-001');
    const sameDevice = await devicesService.resolveDevice(
      'integration-device-001',
    );

    expect(device.id).toBe(sameDevice.id);
    expect(device.deviceId).toBe('integration-device-001');
  });
});
