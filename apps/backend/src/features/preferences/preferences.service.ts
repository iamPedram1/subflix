import { Injectable } from '@nestjs/common';
import { ClientDevice, UserPreference } from '@prisma/client';

import { AppLanguage } from 'src/common/domain/enums/app-language.enum';
import { ThemePreference } from 'src/common/domain/enums/theme-preference.enum';

import { UpdatePreferencesDto } from './dto/update-preferences.dto';
import { PreferencesRepository } from './preferences.repository';

type PreferenceWriteModel = Parameters<
  PreferencesRepository['upsertByClientDeviceId']
>[1];

/** Coordinates preference defaults and partial updates for a device-scoped user session. */
@Injectable()
export class PreferencesService {
  constructor(private readonly preferencesRepository: PreferencesRepository) {}

  /** Returns persisted preferences or creates the default record for a new device. */
  async getPreferences(device: ClientDevice): Promise<UserPreference> {
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
  }

  /** Applies a partial preference update while preserving unspecified fields. */
  async updatePreferences(
    device: ClientDevice,
    input: UpdatePreferencesDto,
  ): Promise<UserPreference> {
    const current = await this.getPreferences(device);

    return this.preferencesRepository.upsertByClientDeviceId(
      device.id,
      this.mergePreferences(device.id, current, input),
    );
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
}
