import { Test } from '@nestjs/testing';
import { AppLanguage, ThemePreference } from '@prisma/client';

import { AppConfigModule } from 'common/config/config.module';
import { PrismaModule } from 'common/database/prisma/prisma.module';
import { PrismaService } from 'common/database/prisma/prisma.service';
import { PreferencesRepository } from 'features/preferences/preferences.repository';

import {
  describeIfDatabase,
  resetDatabase,
} from 'test/core/shared/database-test.helper';

describeIfDatabase('PreferencesRepository integration', () => {
  let prisma: PrismaService;
  let repository: PreferencesRepository;

  beforeAll(async () => {
    const moduleRef = await Test.createTestingModule({
      imports: [AppConfigModule, PrismaModule],
      providers: [PreferencesRepository],
    }).compile();

    prisma = moduleRef.get(PrismaService);
    repository = moduleRef.get(PreferencesRepository);
  });

  beforeEach(async () => {
    await resetDatabase(prisma);
  });

  afterAll(async () => {
    await prisma.$disconnect();
  });

  // -------------------------------------------------------------------------
  // findByClientDeviceId
  // -------------------------------------------------------------------------

  describe('findByClientDeviceId', () => {
    it('returns null when no preference record exists for the device', async () => {
      // Create only the device — no preferences row yet
      const device = await prisma.clientDevice.create({
        data: { deviceId: 'pref-repo-find-empty-001' },
      });

      const result = await repository.findByClientDeviceId(device.id);

      expect(result).toBeNull();
    });

    it('returns the persisted record for a device that has preferences', async () => {
      const device = await prisma.clientDevice.create({
        data: { deviceId: 'pref-repo-find-001' },
      });
      await prisma.userPreference.create({
        data: {
          clientDeviceId: device.id,
          hasSeenOnboarding: true,
          preferredTargetLanguage: AppLanguage.fr,
          themePreference: ThemePreference.dark,
        },
      });

      const result = await repository.findByClientDeviceId(device.id);

      expect(result).not.toBeNull();
      expect(result!.clientDeviceId).toBe(device.id);
      expect(result!.hasSeenOnboarding).toBe(true);
      expect(result!.preferredTargetLanguage).toBe(AppLanguage.fr);
      expect(result!.themePreference).toBe(ThemePreference.dark);
    });

    it('does not return a record belonging to a different device', async () => {
      const deviceA = await prisma.clientDevice.create({
        data: { deviceId: 'pref-repo-find-isolation-a' },
      });
      const deviceB = await prisma.clientDevice.create({
        data: { deviceId: 'pref-repo-find-isolation-b' },
      });

      await prisma.userPreference.create({
        data: {
          clientDeviceId: deviceA.id,
          hasSeenOnboarding: true,
          preferredTargetLanguage: AppLanguage.fr,
          themePreference: ThemePreference.dark,
        },
      });

      const result = await repository.findByClientDeviceId(deviceB.id);

      expect(result).toBeNull();
    });
  });

  // -------------------------------------------------------------------------
  // upsertByClientDeviceId
  // -------------------------------------------------------------------------

  describe('upsertByClientDeviceId', () => {
    it('creates a preference record when none exists', async () => {
      const device = await prisma.clientDevice.create({
        data: { deviceId: 'pref-repo-upsert-create-001' },
      });

      const result = await repository.upsertByClientDeviceId(device.id, {
        clientDeviceId: device.id,
        hasSeenOnboarding: false,
        preferredTargetLanguage: AppLanguage.es,
        themePreference: ThemePreference.system,
      });

      expect(result.clientDeviceId).toBe(device.id);
      expect(result.hasSeenOnboarding).toBe(false);
      expect(result.preferredTargetLanguage).toBe(AppLanguage.es);
      expect(result.themePreference).toBe(ThemePreference.system);

      const dbRecord = await prisma.userPreference.findUnique({
        where: { clientDeviceId: device.id },
      });
      expect(dbRecord).not.toBeNull();
    });

    it('updates an existing preference record', async () => {
      const device = await prisma.clientDevice.create({
        data: { deviceId: 'pref-repo-upsert-update-001' },
      });

      await repository.upsertByClientDeviceId(device.id, {
        clientDeviceId: device.id,
        hasSeenOnboarding: false,
        preferredTargetLanguage: AppLanguage.es,
        themePreference: ThemePreference.system,
      });

      const updated = await repository.upsertByClientDeviceId(device.id, {
        clientDeviceId: device.id,
        hasSeenOnboarding: true,
        preferredTargetLanguage: AppLanguage.fr,
        themePreference: ThemePreference.dark,
      });

      expect(updated.hasSeenOnboarding).toBe(true);
      expect(updated.preferredTargetLanguage).toBe(AppLanguage.fr);
      expect(updated.themePreference).toBe(ThemePreference.dark);
    });

    it('maintains exactly one record per device after repeated upserts', async () => {
      const device = await prisma.clientDevice.create({
        data: { deviceId: 'pref-repo-upsert-idempotent-001' },
      });

      const data = {
        clientDeviceId: device.id,
        hasSeenOnboarding: false,
        preferredTargetLanguage: AppLanguage.en,
        themePreference: ThemePreference.light,
      };

      await repository.upsertByClientDeviceId(device.id, data);
      await repository.upsertByClientDeviceId(device.id, data);
      await repository.upsertByClientDeviceId(device.id, {
        ...data,
        hasSeenOnboarding: true,
      });

      const count = await prisma.userPreference.count({
        where: { clientDeviceId: device.id },
      });
      expect(count).toBe(1);
    });

    it('can set each supported theme preference value', async () => {
      const themes: ThemePreference[] = [
        ThemePreference.system,
        ThemePreference.light,
        ThemePreference.dark,
      ];

      for (const [i, theme] of themes.entries()) {
        const device = await prisma.clientDevice.create({
          data: { deviceId: `pref-repo-theme-${theme}-${i}` },
        });

        const result = await repository.upsertByClientDeviceId(device.id, {
          clientDeviceId: device.id,
          hasSeenOnboarding: false,
          preferredTargetLanguage: AppLanguage.en,
          themePreference: theme,
        });

        expect(result.themePreference).toBe(theme);
      }
    });
  });
});
