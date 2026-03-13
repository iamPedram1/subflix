import { Injectable } from '@nestjs/common';
import { Prisma, UserPreference } from '@prisma/client';

import { normalizeDatabaseError } from 'src/common/database/helpers/database-error.helper';
import { PrismaService } from 'src/common/database/prisma/prisma.service';

@Injectable()
export class PreferencesRepository {
  constructor(private readonly prisma: PrismaService) {}

  findByClientDeviceId(clientDeviceId: string): Promise<UserPreference | null> {
    return this.prisma.userPreference.findUnique({
      where: { clientDeviceId },
    });
  }

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
