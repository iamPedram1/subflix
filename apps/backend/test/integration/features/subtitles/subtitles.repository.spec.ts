import { Test } from '@nestjs/testing';
import { AppLanguage, SubtitleFormat } from '@prisma/client';

import { AppConfigModule } from 'common/config/config.module';
import { PrismaModule } from 'common/database/prisma/prisma.module';
import { PrismaService } from 'common/database/prisma/prisma.service';
import { NotFoundDomainError } from 'common/domain/errors/domain.error';
import { SubtitlesRepository } from 'features/subtitles/subtitles.repository';

import {
  describeIfDatabase,
  resetDatabase,
} from 'test/core/shared/database-test.helper';

// ---------------------------------------------------------------------------
// Shared fixtures
// ---------------------------------------------------------------------------

const TWO_CUES = [
  { cueIndex: 1, startMs: 1_000, endMs: 3_500, text: 'We only have one clean pass.' },
  { cueIndex: 2, startMs: 4_000, endMs: 6_250, text: 'Keep the line open.' },
] as const;

const buildFileParams = (clientDeviceId: string, overrides: Partial<{
  fileName: string;
  format: SubtitleFormat;
  cues: typeof TWO_CUES;
}> = {}) => ({
  clientDeviceId,
  fileName: overrides.fileName ?? 'sample.srt',
  format: overrides.format ?? SubtitleFormat.srt,
  sourceLanguage: AppLanguage.en,
  lineCount: overrides.cues?.length ?? TWO_CUES.length,
  durationMs: 6_250,
  checksum: 'test-checksum-abc123',
  rawContent: '1\n00:00:01,000 --> 00:00:03,500\nWe only have one clean pass.',
  cues: [...(overrides.cues ?? TWO_CUES)],
});

// ---------------------------------------------------------------------------
// Test suite
// ---------------------------------------------------------------------------

describeIfDatabase('SubtitlesRepository integration', () => {
  let prisma: PrismaService;
  let repository: SubtitlesRepository;

  beforeAll(async () => {
    const moduleRef = await Test.createTestingModule({
      imports: [AppConfigModule, PrismaModule],
      providers: [SubtitlesRepository],
    }).compile();

    prisma = moduleRef.get(PrismaService);
    repository = moduleRef.get(SubtitlesRepository);
  });

  beforeEach(async () => {
    await resetDatabase(prisma);
  });

  afterAll(async () => {
    await prisma.$disconnect();
  });

  // -------------------------------------------------------------------------
  // createParsedFile
  // -------------------------------------------------------------------------

  describe('createParsedFile', () => {
    it('persists the file record and all cues atomically', async () => {
      const device = await prisma.clientDevice.create({
        data: { deviceId: 'subtitles-repo-create-001' },
      });

      const result = await repository.createParsedFile(buildFileParams(device.id));

      expect(result.id).toBeDefined();
      expect(result.clientDeviceId).toBe(device.id);
      expect(result.fileName).toBe('sample.srt');
      expect(result.format).toBe(SubtitleFormat.srt);
      expect(result.lineCount).toBe(2);
      expect(result.durationMs).toBe(6_250);

      const cues = await prisma.parsedSubtitleCue.findMany({
        where: { parsedFileId: result.id },
        orderBy: { cueIndex: 'asc' },
      });

      expect(cues).toHaveLength(2);
      expect(cues[0].cueIndex).toBe(1);
      expect(cues[0].startMs).toBe(1_000);
      expect(cues[0].endMs).toBe(3_500);
      expect(cues[0].text).toBe('We only have one clean pass.');
      expect(cues[1].cueIndex).toBe(2);
      expect(cues[1].text).toBe('Keep the line open.');
    });

    it('persists a file with zero cues', async () => {
      const device = await prisma.clientDevice.create({
        data: { deviceId: 'subtitles-repo-create-empty-001' },
      });

      const result = await repository.createParsedFile(
        buildFileParams(device.id, { cues: [] as unknown as typeof TWO_CUES }),
      );

      expect(result.lineCount).toBe(0);

      const cueCount = await prisma.parsedSubtitleCue.count({
        where: { parsedFileId: result.id },
      });
      expect(cueCount).toBe(0);
    });

    it('stores the VTT format correctly', async () => {
      const device = await prisma.clientDevice.create({
        data: { deviceId: 'subtitles-repo-create-vtt-001' },
      });

      const result = await repository.createParsedFile(
        buildFileParams(device.id, { fileName: 'sample.vtt', format: SubtitleFormat.vtt }),
      );

      expect(result.format).toBe(SubtitleFormat.vtt);
      expect(result.fileName).toBe('sample.vtt');
    });

    it('two devices can store files with the same name without conflict', async () => {
      const deviceA = await prisma.clientDevice.create({
        data: { deviceId: 'subtitles-repo-create-multi-a' },
      });
      const deviceB = await prisma.clientDevice.create({
        data: { deviceId: 'subtitles-repo-create-multi-b' },
      });

      const fileA = await repository.createParsedFile(buildFileParams(deviceA.id));
      const fileB = await repository.createParsedFile(buildFileParams(deviceB.id));

      expect(fileA.id).not.toBe(fileB.id);
      expect(fileA.clientDeviceId).toBe(deviceA.id);
      expect(fileB.clientDeviceId).toBe(deviceB.id);
    });
  });

  // -------------------------------------------------------------------------
  // findOwnedParsedFileSummary
  // -------------------------------------------------------------------------

  describe('findOwnedParsedFileSummary', () => {
    it('returns only the summary fields for a device-owned file', async () => {
      const device = await prisma.clientDevice.create({
        data: { deviceId: 'subtitles-repo-summary-001' },
      });
      const created = await repository.createParsedFile(buildFileParams(device.id));

      const summary = await repository.findOwnedParsedFileSummary({
        clientDeviceId: device.id,
        parsedFileId: created.id,
      });

      expect(summary.id).toBe(created.id);
      expect(summary.fileName).toBe('sample.srt');
      expect(summary.format).toBe(SubtitleFormat.srt);
      expect(summary.lineCount).toBe(2);
      expect(summary.durationMs).toBe(6_250);
      // rawContent and checksum should NOT be present in the summary
      expect((summary as Record<string, unknown>).rawContent).toBeUndefined();
      expect((summary as Record<string, unknown>).checksum).toBeUndefined();
    });

    it('throws NotFoundDomainError when the file does not exist', async () => {
      const device = await prisma.clientDevice.create({
        data: { deviceId: 'subtitles-repo-summary-notfound-001' },
      });

      await expect(
        repository.findOwnedParsedFileSummary({
          clientDeviceId: device.id,
          parsedFileId: '00000000-0000-0000-0000-000000000000',
        }),
      ).rejects.toBeInstanceOf(NotFoundDomainError);
    });

    it('throws NotFoundDomainError when the file belongs to a different device', async () => {
      const deviceA = await prisma.clientDevice.create({
        data: { deviceId: 'subtitles-repo-summary-iso-a' },
      });
      const deviceB = await prisma.clientDevice.create({
        data: { deviceId: 'subtitles-repo-summary-iso-b' },
      });

      const created = await repository.createParsedFile(buildFileParams(deviceA.id));

      await expect(
        repository.findOwnedParsedFileSummary({
          clientDeviceId: deviceB.id,
          parsedFileId: created.id,
        }),
      ).rejects.toBeInstanceOf(NotFoundDomainError);
    });
  });

  // -------------------------------------------------------------------------
  // listOwnedParsedFileCues
  // -------------------------------------------------------------------------

  describe('listOwnedParsedFileCues', () => {
    it('returns cues ordered by cueIndex for a device-owned file', async () => {
      const device = await prisma.clientDevice.create({
        data: { deviceId: 'subtitles-repo-cues-order-001' },
      });
      const created = await repository.createParsedFile(buildFileParams(device.id));

      const cues = await repository.listOwnedParsedFileCues({
        clientDeviceId: device.id,
        parsedFileId: created.id,
      });

      expect(cues).toHaveLength(2);
      expect(cues[0].cueIndex).toBe(1);
      expect(cues[0].startMs).toBe(1_000);
      expect(cues[0].endMs).toBe(3_500);
      expect(cues[0].text).toBe('We only have one clean pass.');
      expect(cues[1].cueIndex).toBe(2);
      expect(cues[1].text).toBe('Keep the line open.');
    });

    it('returns an empty array for a file that exists but has no cues', async () => {
      const device = await prisma.clientDevice.create({
        data: { deviceId: 'subtitles-repo-cues-empty-001' },
      });
      const created = await repository.createParsedFile(
        buildFileParams(device.id, { cues: [] as unknown as typeof TWO_CUES }),
      );

      const cues = await repository.listOwnedParsedFileCues({
        clientDeviceId: device.id,
        parsedFileId: created.id,
      });

      expect(cues).toHaveLength(0);
      expect(Array.isArray(cues)).toBe(true);
    });

    it('throws NotFoundDomainError when the file belongs to a different device', async () => {
      const deviceA = await prisma.clientDevice.create({
        data: { deviceId: 'subtitles-repo-cues-iso-a' },
      });
      const deviceB = await prisma.clientDevice.create({
        data: { deviceId: 'subtitles-repo-cues-iso-b' },
      });

      const created = await repository.createParsedFile(buildFileParams(deviceA.id));

      await expect(
        repository.listOwnedParsedFileCues({
          clientDeviceId: deviceB.id,
          parsedFileId: created.id,
        }),
      ).rejects.toBeInstanceOf(NotFoundDomainError);
    });

    it('throws NotFoundDomainError for a completely unknown file id', async () => {
      const device = await prisma.clientDevice.create({
        data: { deviceId: 'subtitles-repo-cues-notfound-001' },
      });

      await expect(
        repository.listOwnedParsedFileCues({
          clientDeviceId: device.id,
          parsedFileId: '00000000-0000-0000-0000-000000000000',
        }),
      ).rejects.toBeInstanceOf(NotFoundDomainError);
    });
  });
});
