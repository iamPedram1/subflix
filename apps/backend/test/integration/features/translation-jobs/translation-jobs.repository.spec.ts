import { Test } from '@nestjs/testing';
import {
  AppLanguage,
  SubtitleFormat,
  TranslationJobStatus,
} from '@prisma/client';

import { AppConfigModule } from 'common/config/config.module';
import { PrismaModule } from 'common/database/prisma/prisma.module';
import { PrismaService } from 'common/database/prisma/prisma.service';
import { TranslationJobsRepository } from 'features/translation-jobs/translation-jobs.repository';

import {
  describeIfDatabase,
  resetDatabase,
} from 'test/core/shared/database-test.helper';

describeIfDatabase('TranslationJobsRepository integration', () => {
  let prismaService: PrismaService;
  let repository: TranslationJobsRepository;

  beforeAll(async () => {
    const moduleRef = await Test.createTestingModule({
      imports: [AppConfigModule, PrismaModule],
      providers: [TranslationJobsRepository],
    }).compile();

    prismaService = moduleRef.get(PrismaService);
    repository = moduleRef.get(TranslationJobsRepository);
  });

  beforeEach(async () => {
    await resetDatabase(prismaService);
  });

  afterAll(async () => {
    await prismaService.$disconnect();
  });

  it('finds the most recent completed catalog translation by subtitle source id + target language', async () => {
    const device = await prismaService.clientDevice.create({
      data: { deviceId: 'translation-reuse-repo-001' },
    });

    const subtitleSourceId = 'ssrc:subdl:abc';

    const older = await prismaService.translationJob.create({
      data: {
        clientDeviceId: device.id,
        sourceType: 'catalog',
        status: TranslationJobStatus.completed,
        stageLabel: 'Translation ready',
        title: 'Inception',
        sourceName: 'SubDL EN',
        sourceLanguage: AppLanguage.en,
        targetLanguage: AppLanguage.fr,
        format: SubtitleFormat.srt,
        progress: 1,
        lineCount: 1,
        durationMs: 3_000,
        mediaRef: { mediaId: 'inception' },
        subtitleSourceRef: { subtitleSourceId },
        completedAt: new Date('2026-01-01T00:00:00.000Z'),
      },
    });

    await prismaService.translationJobCue.create({
      data: {
        jobId: older.id,
        cueIndex: 1,
        startMs: 1_000,
        endMs: 3_000,
        originalText: 'Dream bigger.',
        translatedText: 'Reve plus grand.',
      },
    });

    const newer = await prismaService.translationJob.create({
      data: {
        clientDeviceId: device.id,
        sourceType: 'catalog',
        status: TranslationJobStatus.completed,
        stageLabel: 'Translation ready',
        title: 'Inception',
        sourceName: 'SubDL EN',
        sourceLanguage: AppLanguage.en,
        targetLanguage: AppLanguage.fr,
        format: SubtitleFormat.srt,
        progress: 1,
        lineCount: 1,
        durationMs: 3_000,
        mediaRef: { mediaId: 'inception' },
        subtitleSourceRef: { subtitleSourceId },
        completedAt: new Date('2026-02-01T00:00:00.000Z'),
      },
    });

    await prismaService.translationJobCue.create({
      data: {
        jobId: newer.id,
        cueIndex: 1,
        startMs: 1_000,
        endMs: 3_000,
        originalText: 'Dream bigger.',
        translatedText: 'Reve plus grand.',
      },
    });

    const reusable = await repository.findReusableCatalogTranslation({
      clientDeviceId: device.id,
      subtitleSourceId,
      targetLanguage: AppLanguage.fr,
    });

    expect(reusable?.jobId).toBe(newer.id);
    expect(reusable?.cues).toEqual([
      {
        cueIndex: 1,
        startMs: 1_000,
        endMs: 3_000,
        translatedText: 'Reve plus grand.',
      },
    ]);
  });

  it('does not return translations across device boundaries', async () => {
    const deviceA = await prismaService.clientDevice.create({
      data: { deviceId: 'translation-reuse-repo-002a' },
    });
    const deviceB = await prismaService.clientDevice.create({
      data: { deviceId: 'translation-reuse-repo-002b' },
    });

    const subtitleSourceId = 'ssrc:subdl:def';

    const job = await prismaService.translationJob.create({
      data: {
        clientDeviceId: deviceA.id,
        sourceType: 'catalog',
        status: TranslationJobStatus.completed,
        stageLabel: 'Translation ready',
        title: 'Inception',
        sourceName: 'SubDL EN',
        sourceLanguage: AppLanguage.en,
        targetLanguage: AppLanguage.fr,
        format: SubtitleFormat.srt,
        progress: 1,
        lineCount: 1,
        durationMs: 3_000,
        mediaRef: { mediaId: 'inception' },
        subtitleSourceRef: { subtitleSourceId },
        completedAt: new Date('2026-02-01T00:00:00.000Z'),
      },
    });

    await prismaService.translationJobCue.create({
      data: {
        jobId: job.id,
        cueIndex: 1,
        startMs: 1_000,
        endMs: 3_000,
        originalText: 'Dream bigger.',
        translatedText: 'Reve plus grand.',
      },
    });

    const reusable = await repository.findReusableCatalogTranslation({
      clientDeviceId: deviceB.id,
      subtitleSourceId,
      targetLanguage: AppLanguage.fr,
    });

    expect(reusable).toBeNull();
  });
});
