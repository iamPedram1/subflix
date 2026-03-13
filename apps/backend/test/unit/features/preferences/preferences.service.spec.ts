import { ClientDevice, UserPreference } from '@prisma/client';

import { AppLanguage } from 'src/common/domain/enums/app-language.enum';
import { ThemePreference } from 'src/common/domain/enums/theme-preference.enum';
import { PreferencesRepository } from 'src/features/preferences/preferences.repository';
import { PreferencesService } from 'src/features/preferences/preferences.service';

describe('PreferencesService', () => {
  const device = {
    id: 'device-1',
    deviceId: 'device-header-1',
    createdAt: new Date(),
    updatedAt: new Date(),
  } satisfies ClientDevice;

  const createPreference = (
    overrides: Partial<UserPreference> = {},
  ): UserPreference => ({
    id: 'preference-1',
    clientDeviceId: device.id,
    hasSeenOnboarding: false,
    preferredTargetLanguage: AppLanguage.Spanish,
    themePreference: ThemePreference.System,
    createdAt: new Date(),
    updatedAt: new Date(),
    ...overrides,
  });

  it('creates defaults when no preferences exist', async () => {
    const repository = {
      findByClientDeviceId: jest.fn().mockResolvedValue(null),
      upsertByClientDeviceId: jest.fn().mockResolvedValue(createPreference()),
    } as unknown as PreferencesRepository;

    const service = new PreferencesService(repository);
    const result = await service.getPreferences(device);

    expect(result.preferredTargetLanguage).toBe(AppLanguage.Spanish);
    expect(repository.upsertByClientDeviceId).toHaveBeenCalled();
  });

  it('updates a subset of preference fields', async () => {
    const repository = {
      findByClientDeviceId: jest
        .fn()
        .mockResolvedValue(
          createPreference({ themePreference: ThemePreference.System }),
        ),
      upsertByClientDeviceId: jest
        .fn()
        .mockResolvedValue(
          createPreference({ themePreference: ThemePreference.Dark }),
        ),
    } as unknown as PreferencesRepository;

    const service = new PreferencesService(repository);
    const result = await service.updatePreferences(device, {
      themePreference: ThemePreference.Dark,
    });

    expect(result.themePreference).toBe(ThemePreference.Dark);
    expect(repository.upsertByClientDeviceId).toHaveBeenCalledWith(
      device.id,
      expect.objectContaining({
        themePreference: ThemePreference.Dark,
        preferredTargetLanguage: AppLanguage.Spanish,
      }),
    );
  });
});
