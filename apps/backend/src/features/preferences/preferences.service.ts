import { Injectable } from '@nestjs/common';
import { ClientDevice, UserPreference } from '@prisma/client';

import { AppCacheService } from 'src/common/cache/app-cache.service';
import { AppLanguage } from 'src/common/domain/enums/app-language.enum';
import { ThemePreference } from 'src/common/domain/enums/theme-preference.enum';

import { UpdatePreferencesDto } from './dto/update-preferences.dto';
import { PreferencesRepository } from './preferences.repository';

type PreferenceWriteModel = Parameters<
  PreferencesRepository['upsertByClientDeviceId']
>[1];
const PREFERENCE_CACHE_TTL_MS = 15 * 60_000;

/** Coordinates preference defaults and partial updates for a device-scoped user session. */
@Injectable()
export class PreferencesService {
  constructor(
    private readonly preferencesRepository: PreferencesRepository,
    private readonly cacheService: AppCacheService,
  ) {}

  /** Returns persisted preferences or creates the default record for a new device. */
  async getPreferences(device: ClientDevice): Promise<UserPreference> {
    return this.cacheService.getOrSet(
      this.buildCacheKey(device.id),
      async () => {
        const existing = await this.preferencesRepository.findByClientDeviceId(
          device.id,
        );

        if (existing) {
          return existing;
        }

        return this.preferencesRepository.upsertByClientDeviceId(
          device.id,
          this.buildDefaultPreferences(device.id),
        );
      },
      {
        ttlMs: PREFERENCE_CACHE_TTL_MS,
      },
    );
  }

  /** Applies a partial preference update while preserving unspecified fields. */
  async updatePreferences(
    device: ClientDevice,
    input: UpdatePreferencesDto,
  ): Promise<UserPreference> {
    const current = await this.getPreferences(device);

    const updated = await this.preferencesRepository.upsertByClientDeviceId(
      device.id,
      this.mergePreferences(device.id, current, input),
    );

    this.cacheService.set(
      this.buildCacheKey(device.id),
      updated,
      PREFERENCE_CACHE_TTL_MS,
    );

    return updated;
  }

  /** Builds the initial persisted preference state for a brand-new device. */
  private buildDefaultPreferences(
    clientDeviceId: string,
  ): PreferenceWriteModel {
    return {
      clientDeviceId,
      hasSeenOnboarding: false,
      preferredTargetLanguage: AppLanguage.Spanish,
      themePreference: ThemePreference.System,
    };
  }

  /** Merges an update DTO into the current persisted preference snapshot. */
  private mergePreferences(
    clientDeviceId: string,
    current: UserPreference,
    input: UpdatePreferencesDto,
  ): PreferenceWriteModel {
    return {
      clientDeviceId,
      hasSeenOnboarding: input.hasSeenOnboarding ?? current.hasSeenOnboarding,
      preferredTargetLanguage:
        input.preferredTargetLanguage ?? current.preferredTargetLanguage,
      themePreference: input.themePreference ?? current.themePreference,
    };
  }

  private buildCacheKey(clientDeviceId: string): string {
    return `preferences:${clientDeviceId}`;
  }
}
