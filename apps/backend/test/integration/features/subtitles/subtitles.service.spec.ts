import { Test } from '@nestjs/testing';

import { AppConfigModule } from 'common/config/config.module';
import { PrismaModule } from 'common/database/prisma/prisma.module';
import { PrismaService } from 'common/database/prisma/prisma.service';
import { DevicesModule } from 'features/devices/devices.module';
import { DevicesService } from 'features/devices/devices.service';
import { SubtitlesModule } from 'features/subtitles/subtitles.module';
import { SubtitlesService } from 'features/subtitles/subtitles.service';

import {
  describeIfDatabase,
  resetDatabase,
} from 'test/core/shared/database-test.helper';
import { sampleSrt } from 'test/core/shared/subtitle-fixtures';

describeIfDatabase('SubtitlesService integration', () => {
  let prismaService: PrismaService;
  let devicesService: DevicesService;
  let subtitlesService: SubtitlesService;

  beforeAll(async () => {
    const moduleRef = await Test.createTestingModule({
      imports: [AppConfigModule, PrismaModule, DevicesModule, SubtitlesModule],
    }).compile();

    prismaService = moduleRef.get(PrismaService);
    devicesService = moduleRef.get(DevicesService);
    subtitlesService = moduleRef.get(SubtitlesService);
  });

  beforeEach(async () => {
    await resetDatabase(prismaService);
  });

  afterAll(async () => {
    await prismaService.$disconnect();
  });

  it('parses and stores a subtitle file with cues', async () => {
    const device = await devicesService.resolveDevice(
      'subtitle-integration-001',
    );

    const result = await subtitlesService.parseAndStore(device, {
      originalname: 'sample.srt',
      size: Buffer.byteLength(sampleSrt),
      buffer: Buffer.from(sampleSrt, 'utf8'),
    } as Express.Multer.File);

    const storedFile = await prismaService.parsedSubtitleFile.findUnique({
      where: { id: result.id },
      include: { cues: true },
    });

    expect(result.lineCount).toBe(2);
    expect(storedFile?.cues).toHaveLength(2);
  });
});
