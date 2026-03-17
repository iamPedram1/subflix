import { Test } from '@nestjs/testing';
import {
  AppLanguage,
  SubtitleFormat,
  TranslationJobStatus,
} from '@prisma/client';

import { AppConfigModule } from 'common/config/config.module';
import { PrismaModule } from 'common/database/prisma/prisma.module';
import { PrismaService } from 'common/database/prisma/prisma.service';
import { CatalogModule } from 'features/catalog/catalog.module';
import { SubtitlesModule } from 'features/subtitles/subtitles.module';
import { TranslationJobRecoveryService } from 'features/translation-jobs/translation-job-recovery.service';
import { TranslationJobsModule } from 'features/translation-jobs/translation-jobs.module';
import { TranslationJobsService } from 'features/translation-jobs/translation-jobs.service';
import { DevicesModule } from 'features/devices/devices.module';
import { DevicesService } from 'features/devices/devices.service';

import {
  describeIfDatabase,
  resetDatabase,
} from 'test/core/shared/database-test.helper';
import { pollUntil } from 'test/core/shared/polling.helper';
import { sampleSrt } from 'test/core/shared/subtitle-fixtures';
import { SubtitlesService } from 'features/subtitles/subtitles.service';
import { TranslationSourceType } from 'common/domain/enums/translation-source-type.enum';

const STALE_AFTER_MS = 5 * 60_000; // matches default config

/** Sets updatedAt on a TranslationJob directly via raw SQL to simulate staleness. */
const setJobUpdatedAt = async (
  prisma: PrismaService,
  jobId: string,
  updatedAt: Date,
) => {
  await prisma.$executeRaw`
    UPDATE "TranslationJob"
    SET "updatedAt" = ${updatedAt}
    WHERE id = ${jobId}::uuid
  `;
};

/** Forces a job into translating state directly, bypassing the runner. */
const forceJobToTranslating = async (
  prisma: PrismaService,
  jobId: string,
  updatedAt: Date,
) => {
  await prisma.translationJob.update({
    where: { id: jobId },
    data: {
      status: TranslationJobStatus.translating,
      stageLabel: 'Translating subtitle lines',
      progress: 0.5,
      startedAt: new Date(updatedAt.getTime() - 1_000),
    },
  });
  // Override updatedAt to simulate staleness
  await setJobUpdatedAt(prisma, jobId, updatedAt);
};

describeIfDatabase('TranslationJobRecoveryService integration', () => {
  let prismaService: PrismaService;
  let devicesService: DevicesService;
  let subtitlesService: SubtitlesService;
  let translationJobsService: TranslationJobsService;
  let recoveryService: TranslationJobRecoveryService;

  beforeAll(async () => {
    const moduleRef = await Test.createTestingModule({
      imports: [
        AppConfigModule,
        PrismaModule,
        DevicesModule,
        CatalogModule,
        SubtitlesModule,
        TranslationJobsModule,
      ],
    }).compile();

    prismaService = moduleRef.get(PrismaService);
    devicesService = moduleRef.get(DevicesService);
    subtitlesService = moduleRef.get(SubtitlesService);
    translationJobsService = moduleRef.get(TranslationJobsService);
    recoveryService = moduleRef.get(TranslationJobRecoveryService);
  });

  beforeEach(async () => {
    await resetDatabase(prismaService);
  });

  afterAll(async () => {
    await prismaService.$disconnect();
  });

  it('requeues a stalled translating job and runner completes it', async () => {
    const device = await devicesService.resolveDevice('recovery-integration-001');
    const parsed = await subtitlesService.parseAndStore(device, {
      originalname: 'sample.srt',
      size: Buffer.byteLength(sampleSrt),
      buffer: Buffer.from(sampleSrt, 'utf8'),
    } as Express.Multer.File);

    // Create a job and immediately intercept before the runner claims it.
    const job = await translationJobsService.createJob(device, {
      sourceType: TranslationSourceType.Upload,
      parsedFileId: parsed.id,
      targetLanguage: AppLanguage.fr,
    });

    // Wait for the runner to see it (it is scheduled immediately), then
    // wait until it completes normally first so we know the mechanism works.
    await pollUntil({
      label: `Job ${job.id} initial completion`,
      poll: () => translationJobsService.getJob(device, job.id),
      isDone: (j) =>
        j.status === TranslationJobStatus.completed ||
        j.status === TranslationJobStatus.failed,
    });

    // Reset the job to a stalled translating state so recovery can act on it.
    const pastUpdatedAt = new Date(Date.now() - STALE_AFTER_MS - 60_000);
    await forceJobToTranslating(prismaService, job.id, pastUpdatedAt);

    // The reference "now" is in the future relative to pastUpdatedAt
    const now = new Date();
    const result = await recoveryService.recoverStalledJobs(now);

    expect(result.requeued).toBeGreaterThanOrEqual(1);

    const recovered = await prismaService.translationJob.findUnique({
      where: { id: job.id },
    });

    expect(recovered?.status).toBe(TranslationJobStatus.queued);
    expect(recovered?.jobMeta).toMatchObject({ recoveredFromStall: true });
  });

  it('fails a stalled job that has exhausted max attempts', async () => {
    const device = await devicesService.resolveDevice('recovery-integration-002');
    const parsed = await subtitlesService.parseAndStore(device, {
      originalname: 'sample.srt',
      size: Buffer.byteLength(sampleSrt),
      buffer: Buffer.from(sampleSrt, 'utf8'),
    } as Express.Multer.File);

    const job = await translationJobsService.createJob(device, {
      sourceType: TranslationSourceType.Upload,
      parsedFileId: parsed.id,
      targetLanguage: AppLanguage.fr,
    });

    // Wait for initial execution
    await pollUntil({
      label: `Job ${job.id} initial completion`,
      poll: () => translationJobsService.getJob(device, job.id),
      isDone: (j) =>
        j.status === TranslationJobStatus.completed ||
        j.status === TranslationJobStatus.failed,
    });

    // Force into translating state with attemptCount already at max (3)
    const pastUpdatedAt = new Date(Date.now() - STALE_AFTER_MS - 60_000);
    await forceJobToTranslating(prismaService, job.id, pastUpdatedAt);
    await prismaService.translationJob.update({
      where: { id: job.id },
      data: { jobMeta: { attemptCount: 3 } },
    });
    await setJobUpdatedAt(prismaService, job.id, pastUpdatedAt);

    const result = await recoveryService.recoverStalledJobs(new Date());

    expect(result.failed).toBeGreaterThanOrEqual(1);

    const failed = await prismaService.translationJob.findUnique({
      where: { id: job.id },
    });

    expect(failed?.status).toBe(TranslationJobStatus.failed);
    expect(failed?.jobMeta).toMatchObject({
      lastFailureReasonCode: 'stall_recovery_exhausted',
    });
  });

  it('does not recover a job that was recently updated', async () => {
    const device = await devicesService.resolveDevice('recovery-integration-003');
    const parsed = await subtitlesService.parseAndStore(device, {
      originalname: 'sample.srt',
      size: Buffer.byteLength(sampleSrt),
      buffer: Buffer.from(sampleSrt, 'utf8'),
    } as Express.Multer.File);

    const job = await translationJobsService.createJob(device, {
      sourceType: TranslationSourceType.Upload,
      parsedFileId: parsed.id,
      targetLanguage: AppLanguage.fr,
    });

    // Forcibly set to translating with a RECENT updatedAt — this simulates an
    // actively running job that should not be recovered.
    await prismaService.translationJob.update({
      where: { id: job.id },
      data: {
        status: TranslationJobStatus.translating,
        stageLabel: 'Translating subtitle lines',
        progress: 0.5,
        startedAt: new Date(),
      },
    });
    // updatedAt is auto-set to now by @updatedAt on the update above, so it
    // will be very recent and the job should NOT appear as stalled.

    const result = await recoveryService.recoverStalledJobs(new Date());

    // The job was just updated — it should not be detected as stalled
    expect(result.requeued).toBe(0);
    expect(result.failed).toBe(0);

    const untouched = await prismaService.translationJob.findUnique({
      where: { id: job.id },
    });
    expect(untouched?.status).toBe(TranslationJobStatus.translating);
  });
});
