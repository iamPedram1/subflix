import { Injectable } from '@nestjs/common';
import { Prisma, UserPreference } from '@prisma/client';

import { BaseRepository } from 'common/database/base.repository';
import { PrismaService } from 'common/database/prisma/prisma.service';

@Injectable()
/** Encapsulates persistence for device-scoped user preferences. */
export class PreferencesRepository extends BaseRepository {
  constructor(private readonly prisma: PrismaService) {
    super();
  }

  /** Returns the stored preference record for a device when it exists. */
  findByClientDeviceId(clientDeviceId: string): Promise<UserPreference | null> {
    return this.prisma.userPreference.findUnique({
      where: { clientDeviceId },
    });
  }

  /** Creates or updates a device preference record using one shared write path. */
  upsertByClientDeviceId(
    clientDeviceId: string,
    data: Prisma.UserPreferenceUncheckedCreateInput,
  ): Promise<UserPreference> {
    return this.dbCall(() =>
      this.prisma.userPreference.upsert({
        where: { clientDeviceId },
        update: {
          hasSeenOnboarding: data.hasSeenOnboarding,
          preferredTargetLanguage: data.preferredTargetLanguage,
          themePreference: data.themePreference,
        },
        create: data,
      }),
    );
  }
}
