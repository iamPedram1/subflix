import { Test } from '@nestjs/testing';

import { AppConfigModule } from 'common/config/config.module';
import { PrismaModule } from 'common/database/prisma/prisma.module';
import { PrismaService } from 'common/database/prisma/prisma.service';
import { DevicesModule } from 'features/devices/devices.module';
import { DevicesService } from 'features/devices/devices.service';
import { PreferencesModule } from 'features/preferences/preferences.module';
import { PreferencesService } from 'features/preferences/preferences.service';

import {
  describeIfDatabase,
  resetDatabase,
} from 'test/core/shared/database-test.helper';

describeIfDatabase('PreferencesService integration', () => {
  let prismaService: PrismaService;
  let devicesService: DevicesService;
  let preferencesService: PreferencesService;

  beforeAll(async () => {
    const moduleRef = await Test.createTestingModule({
      imports: [
        AppConfigModule,
        PrismaModule,
        DevicesModule,
        PreferencesModule,
      ],
    }).compile();

    prismaService = moduleRef.get(PrismaService);
    devicesService = moduleRef.get(DevicesService);
    preferencesService = moduleRef.get(PreferencesService);
  });

  beforeEach(async () => {
    await resetDatabase(prismaService);
  });

  afterAll(async () => {
    await prismaService.$disconnect();
  });

  it('creates default preferences for a new device', async () => {
    const device = await devicesService.resolveDevice('preferences-device-001');

    const preference = await preferencesService.getPreferences(device);

    expect(preference.hasSeenOnboarding).toBe(false);
    expect(preference.preferredTargetLanguage).toBe('es');
    expect(preference.themePreference).toBe('system');
  });
});
