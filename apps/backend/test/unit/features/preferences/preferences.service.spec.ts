import { ClientDevice, UserPreference } from '@prisma/client';

import { AppCacheService } from 'common/cache/app-cache.service';
import { AppLanguage } from 'common/domain/enums/app-language.enum';
import { ThemePreference } from 'common/domain/enums/theme-preference.enum';
import { PreferencesRepository } from 'features/preferences/preferences.repository';
import { PreferencesService } from 'features/preferences/preferences.service';

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

  const createCacheService = () =>
    ({
      getOrSet: vi.fn(async (_key, loader: () => Promise<unknown>) => loader()),
      set: vi.fn(),
    }) as unknown as AppCacheService;

  it('creates defaults when no preferences exist', async () => {
    const repository = {
      findByClientDeviceId: vi.fn().mockResolvedValue(null),
      upsertByClientDeviceId: vi.fn().mockResolvedValue(createPreference()),
    } as unknown as PreferencesRepository;
    const cacheService = createCacheService();

    const service = new PreferencesService(repository, cacheService);
    const result = await service.getPreferences(device);

    expect(result.preferredTargetLanguage).toBe(AppLanguage.Spanish);
    expect(repository.upsertByClientDeviceId).toHaveBeenCalled();
    expect(cacheService.getOrSet).toHaveBeenCalledWith(
      'preferences:device-1',
      expect.any(Function),
      expect.objectContaining({
        ttlMs: 15 * 60_000,
      }),
    );
  });

  it('updates a subset of preference fields', async () => {
    const repository = {
      findByClientDeviceId: vi
        .fn()
        .mockResolvedValue(
          createPreference({ themePreference: ThemePreference.System }),
        ),
      upsertByClientDeviceId: vi
        .fn()
        .mockResolvedValue(
          createPreference({ themePreference: ThemePreference.Dark }),
        ),
    } as unknown as PreferencesRepository;
    const cacheService = createCacheService();

    const service = new PreferencesService(repository, cacheService);
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
    expect(cacheService.set).toHaveBeenCalledWith(
      'preferences:device-1',
      expect.objectContaining({
        themePreference: ThemePreference.Dark,
      }),
      15 * 60_000,
    );
  });
});
