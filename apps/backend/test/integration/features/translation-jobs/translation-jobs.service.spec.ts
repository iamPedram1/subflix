import { Test } from '@nestjs/testing';
import { TranslationJobStatus } from '@prisma/client';

import { AppConfigModule } from 'src/common/config/config.module';
import { PrismaModule } from 'src/common/database/prisma/prisma.module';
import { PrismaService } from 'src/common/database/prisma/prisma.service';
import { CatalogModule } from 'src/features/catalog/catalog.module';
import { DevicesModule } from 'src/features/devices/devices.module';
import { DevicesService } from 'src/features/devices/devices.service';
import { SubtitlesModule } from 'src/features/subtitles/subtitles.module';
import { SubtitlesService } from 'src/features/subtitles/subtitles.service';
import { TranslationJobsModule } from 'src/features/translation-jobs/translation-jobs.module';
import { TranslationJobsService } from 'src/features/translation-jobs/translation-jobs.service';

import { describeIfDatabase } from 'test/core/shared/database-test.helper';
import { sampleSrt } from 'test/core/shared/subtitle-fixtures';

const waitForCompletion = async (
  translationJobsService: TranslationJobsService,
  device: { id: string; deviceId: string; createdAt: Date; updatedAt: Date },
  jobId: string,
) => {
  for (let attempt = 0; attempt < 20; attempt += 1) {
    const job = await translationJobsService.getJob(device, jobId);
    if (job.status === TranslationJobStatus.completed) {
      return job;
    }

    await new Promise((resolve) => setTimeout(resolve, 200));
  }

  throw new Error(`Job ${jobId} did not complete in time.`);
};

describeIfDatabase('TranslationJobsService integration', () => {
  let prismaService: PrismaService;
  let devicesService: DevicesService;
  let subtitlesService: SubtitlesService;
  let translationJobsService: TranslationJobsService;

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
  });

  beforeEach(async () => {
    await prismaService.translationJobCue.deleteMany();
    await prismaService.translationJob.deleteMany();
    await prismaService.parsedSubtitleCue.deleteMany();
    await prismaService.parsedSubtitleFile.deleteMany();
    await prismaService.userPreference.deleteMany();
    await prismaService.clientDevice.deleteMany();
  });

  afterAll(async () => {
    await prismaService.$disconnect();
  });

  it('creates, completes, previews, exports, and retries an uploaded job', async () => {
    const device = await devicesService.resolveDevice('job-integration-001');
    const parsed = await subtitlesService.parseAndStore(
      device,
      {
        originalname: 'sample.srt',
        size: Buffer.byteLength(sampleSrt),
        buffer: Buffer.from(sampleSrt, 'utf8'),
      } as Express.Multer.File,
    );

    const job = await translationJobsService.createJob(device, {
      sourceType: 'upload',
      parsedFileId: parsed.id,
      targetLanguage: 'fr',
    });

    const completed = await waitForCompletion(
      translationJobsService,
      device,
      job.id,
    );
    const preview = await translationJobsService.getPreview(
      device,
      job.id,
      1,
      20,
    );
    const exportFile = await translationJobsService.exportJob(device, job.id);
    const retry = await translationJobsService.retryJob(device, job.id);

    expect(completed.status).toBe(TranslationJobStatus.completed);
    expect(preview.items).toHaveLength(2);
    expect(exportFile.fileName.endsWith('.srt')).toBe(true);
    expect(retry.id).not.toBe(job.id);
  });
});
