import { Injectable } from '@nestjs/common';
import { Prisma, UserPreference } from '@prisma/client';

import { normalizeDatabaseError } from 'common/database/helpers/database-error.helper';
import { PrismaService } from 'common/database/prisma/prisma.service';

@Injectable()
/** Encapsulates persistence for device-scoped user preferences. */
export class PreferencesRepository {
  constructor(private readonly prisma: PrismaService) {}

  /** Returns the stored preference record for a device when it exists. */
  findByClientDeviceId(clientDeviceId: string): Promise<UserPreference | null> {
    return this.prisma.userPreference.findUnique({
      where: { clientDeviceId },
    });
  }

  /** Creates or updates a device preference record using one shared write path. */
  async upsertByClientDeviceId(
    clientDeviceId: string,
    data: Prisma.UserPreferenceUncheckedCreateInput,
  ): Promise<UserPreference> {
    try {
      return await this.prisma.userPreference.upsert({
        where: { clientDeviceId },
        update: {
          hasSeenOnboarding: data.hasSeenOnboarding,
          preferredTargetLanguage: data.preferredTargetLanguage,
          themePreference: data.themePreference,
        },
        create: data,
      });
    } catch (error) {
      return normalizeDatabaseError(error);
    }
  }
}
