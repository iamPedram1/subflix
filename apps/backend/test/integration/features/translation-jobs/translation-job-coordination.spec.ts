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

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/** Creates a minimal queued translation job for testing. */
const createQueuedJob = async (
  prisma: PrismaService,
  deviceId: string,
  suffix: string,
) => {
  const device = await prisma.clientDevice.create({
    data: { deviceId: `coord-test-device-${suffix}` },
  });

  return prisma.translationJob.create({
    data: {
      clientDeviceId: device.id,
      sourceType: 'upload',
      status: TranslationJobStatus.queued,
      stageLabel: 'Queued',
      title: `Job ${suffix}`,
      sourceName: `${suffix}.srt`,
      sourceLanguage: AppLanguage.en,
      targetLanguage: AppLanguage.fr,
      format: SubtitleFormat.srt,
      progress: 0.05,
      lineCount: 1,
      durationMs: 1_000,
    },
  });
};

// ---------------------------------------------------------------------------
// Suite
// ---------------------------------------------------------------------------

describeIfDatabase('Multi-instance coordination integration', () => {
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

  // -------------------------------------------------------------------------
  // DB-safe job claiming
  // -------------------------------------------------------------------------

  describe('claimQueuedJobForRunner', () => {
    it('claims a queued job and transitions it to translating', async () => {
      const job = await createQueuedJob(prismaService, 'dev', 'claim-001');

      const claimed = await repository.claimQueuedJobForRunner(job.id);

      expect(claimed).not.toBeNull();
      expect(claimed!.id).toBe(job.id);
      expect(claimed!.status).toBe(TranslationJobStatus.translating);
    });

    it('returns null when the job does not exist', async () => {
      const result = await repository.claimQueuedJobForRunner(
        '00000000-0000-0000-0000-000000000000',
      );
      expect(result).toBeNull();
    });

    it('returns null when the job is already translating', async () => {
      const job = await createQueuedJob(prismaService, 'dev', 'claim-002');
      // First claim — should succeed
      await repository.claimQueuedJobForRunner(job.id);

      // Second claim — job is already translating, not queued
      const second = await repository.claimQueuedJobForRunner(job.id);
      expect(second).toBeNull();
    });

    it('only one caller claims a job when two race simultaneously', async () => {
      const job = await createQueuedJob(prismaService, 'dev', 'claim-003');

      // Simulate two workers racing to claim the same job.
      const [result1, result2] = await Promise.all([
        repository.claimQueuedJobForRunner(job.id),
        repository.claimQueuedJobForRunner(job.id),
      ]);

      const successes = [result1, result2].filter(Boolean);
      const failures = [result1, result2].filter((r) => r === null);

      // Exactly one claim must succeed
      expect(successes).toHaveLength(1);
      expect(failures).toHaveLength(1);

      // The DB row must be in translating status (claimed exactly once)
      const dbJob = await prismaService.translationJob.findUnique({
        where: { id: job.id },
      });
      expect(dbJob?.status).toBe(TranslationJobStatus.translating);
    });

    it('competing workers each claim a different job', async () => {
      const jobA = await createQueuedJob(prismaService, 'dev', 'claim-004a');
      const jobB = await createQueuedJob(prismaService, 'dev', 'claim-004b');

      // Two workers, each trying to claim one distinct job
      const [claimA, claimB] = await Promise.all([
        repository.claimQueuedJobForRunner(jobA.id),
        repository.claimQueuedJobForRunner(jobB.id),
      ]);

      expect(claimA?.id).toBe(jobA.id);
      expect(claimB?.id).toBe(jobB.id);
    });

    it('does not claim a completed or failed job', async () => {
      const job = await createQueuedJob(prismaService, 'dev', 'claim-005');
      await prismaService.translationJob.update({
        where: { id: job.id },
        data: { status: TranslationJobStatus.completed },
      });

      const result = await repository.claimQueuedJobForRunner(job.id);
      expect(result).toBeNull();
    });
  });

  // -------------------------------------------------------------------------
  // Advisory lock for recovery coordination
  // -------------------------------------------------------------------------

  describe('recovery advisory lock', () => {
    afterEach(async () => {
      // Always release the lock so tests do not bleed into each other.
      // pg_advisory_unlock is idempotent when the lock is not held.
      await repository.releaseRecoveryAdvisoryLock();
    });

    it('acquires the lock and returns true', async () => {
      const acquired = await repository.tryAcquireRecoveryAdvisoryLock();
      expect(acquired).toBe(true);
    });

    it('returns false when the lock is already held by the same connection', async () => {
      // PostgreSQL session-level advisory locks are re-entrant by the same
      // session, but pg_try_advisory_lock returns true on re-entry and
      // requires a matching number of unlocks. For multi-instance behaviour we
      // test with a second independent PrismaService connection.
      const moduleRef2 = await Test.createTestingModule({
        imports: [AppConfigModule, PrismaModule],
        providers: [TranslationJobsRepository],
      }).compile();

      const repo2 = moduleRef2.get(TranslationJobsRepository);

      try {
        // Hold the lock from the primary connection
        const firstAcquired =
          await repository.tryAcquireRecoveryAdvisoryLock();
        expect(firstAcquired).toBe(true);

        // Second connection should be unable to acquire the same lock
        const secondAcquired =
          await repo2.tryAcquireRecoveryAdvisoryLock();
        expect(secondAcquired).toBe(false);
      } finally {
        await repo2['prisma'].$disconnect();
      }
    });

    it('allows a second acquire after the first is released', async () => {
      const first = await repository.tryAcquireRecoveryAdvisoryLock();
      expect(first).toBe(true);

      await repository.releaseRecoveryAdvisoryLock();

      // After release, the lock should be available again
      const second = await repository.tryAcquireRecoveryAdvisoryLock();
      expect(second).toBe(true);
    });
  });
});
