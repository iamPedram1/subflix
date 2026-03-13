import { Injectable } from '@nestjs/common';
import { ClientDevice, UserPreference } from '@prisma/client';

import { AppLanguage } from 'src/common/domain/enums/app-language.enum';
import { ThemePreference } from 'src/common/domain/enums/theme-preference.enum';

import { UpdatePreferencesDto } from './dto/update-preferences.dto';
import { PreferencesRepository } from './preferences.repository';

@Injectable()
export class PreferencesService {
  constructor(private readonly preferencesRepository: PreferencesRepository) {}

  async getPreferences(device: ClientDevice): Promise<UserPreference> {
    const existing = await this.preferencesRepository.findByClientDeviceId(
      device.id,
    );

    if (existing) {
      return existing;
    }

    return this.preferencesRepository.upsertByClientDeviceId(device.id, {
      clientDeviceId: device.id,
      hasSeenOnboarding: false,
      preferredTargetLanguage: AppLanguage.Spanish,
      themePreference: ThemePreference.System,
    });
  }

  async updatePreferences(
    device: ClientDevice,
    input: UpdatePreferencesDto,
  ): Promise<UserPreference> {
    const current = await this.getPreferences(device);

    return this.preferencesRepository.upsertByClientDeviceId(device.id, {
      clientDeviceId: device.id,
      hasSeenOnboarding: input.hasSeenOnboarding ?? current.hasSeenOnboarding,
      preferredTargetLanguage:
        input.preferredTargetLanguage ?? current.preferredTargetLanguage,
      themePreference: input.themePreference ?? current.themePreference,
    });
  }
}
