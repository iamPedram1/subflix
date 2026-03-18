import { Injectable } from '@nestjs/common';
import {
  AppLanguage,
  Prisma,
  TranslationJob,
  TranslationJobStatus,
  TranslationSourceType,
} from '@prisma/client';

import {
  buildPagination,
  toPaginatedResult,
} from 'common/database/helpers/pagination.helper';
import { requireEntity } from 'common/database/helpers/entity.helper';
import { normalizeDatabaseError } from 'common/database/helpers/database-error.helper';
import { PrismaService } from 'common/database/prisma/prisma.service';

@Injectable()
/** Encapsulates persistence for translation jobs, previews, and exports. */
export class TranslationJobsRepository {
  private static readonly translationJobSummarySelect =
    Prisma.validator<Prisma.TranslationJobSelect>()({
      id: true,
      status: true,
      stageLabel: true,
      progress: true,
      title: true,
      sourceName: true,
      sourceType: true,
      sourceLanguage: true,
      targetLanguage: true,
      format: true,
      createdAt: true,
      updatedAt: true,
      lineCount: true,
      durationMs: true,
      errorMessage: true,
      subtitleSourceRef: true,
      jobMeta: true,
    });
  private static readonly translationJobCuePayloadSelect =
    Prisma.validator<Prisma.TranslationJobCueSelect>()({
      cueIndex: true,
      startMs: true,
      endMs: true,
      originalText: true,
      translatedText: true,
    });

  constructor(private readonly prisma: PrismaService) {}

  /**
   * Atomically claims a queued job so only one runner can start processing it.
   *
   * Uses SELECT ... FOR UPDATE SKIP LOCKED so that concurrent claim attempts
   * from multiple process instances do not block each other. If another
   * transaction already holds a row lock on this job (e.g. a concurrent claim
   * from a second worker), SKIP LOCKED returns immediately with no row rather
   * than waiting — the caller receives null and the job stays queued.
   *
   * This is safe for multi-instance deployments: at most one runner will
   * successfully claim any given job, with no risk of deadlocks or long waits
   * under claim contention.
   */
  async claimQueuedJobForRunner(jobId: string): Promise<TranslationJob | null> {
    const startedAt = new Date();

    try {
      return await this.prisma.$transaction(async (tx) => {
        // Attempt a non-blocking row lock on the target job.
        // SKIP LOCKED returns an empty result set immediately if the row is
        // already locked by another transaction, so we never block on contention.
        const locked = await tx.$queryRaw<Array<{ id: string }>>`
          SELECT id
          FROM "TranslationJob"
          WHERE id = ${jobId}::uuid
            AND status = 'queued'::"TranslationJobStatus"
          FOR UPDATE SKIP LOCKED
        `;

        if (locked.length === 0) {
          return null;
        }

        return tx.translationJob.update({
          where: { id: jobId },
          data: {
            status: TranslationJobStatus.translating,
            stageLabel: 'Loading source subtitle cues',
            progress: 0.18,
            startedAt,
            errorMessage: null,
          },
        });
      });
    } catch (error) {
      return normalizeDatabaseError(error);
    }
  }

  /** Persists a newly created translation job. */
  async createJob(
    data: Prisma.TranslationJobUncheckedCreateInput,
  ): Promise<TranslationJob> {
    try {
      return await this.prisma.translationJob.create({ data });
    } catch (error) {
      return normalizeDatabaseError(error);
    }
  }

  /** Applies a partial update to a persisted translation job. */
  async updateJob(
    jobId: string,
    data: Prisma.TranslationJobUncheckedUpdateInput,
  ): Promise<TranslationJob> {
    try {
      return await this.prisma.translationJob.update({
        where: { id: jobId },
        data,
      });
    } catch (error) {
      return normalizeDatabaseError(error);
    }
  }

  /** Replaces all persisted preview/export cues for a translation job. */
  async replaceJobCues(
    jobId: string,
    cues: Array<{
      cueIndex: number;
      startMs: number;
      endMs: number;
      originalText: string;
      translatedText: string | null;
    }>,
  ): Promise<void> {
    try {
      await this.prisma.$transaction(async (tx) => {
        await tx.translationJobCue.deleteMany({
          where: { jobId },
        });

        await tx.translationJobCue.createMany({
          data: cues.map((cue) => ({
            jobId,
            cueIndex: cue.cueIndex,
            startMs: cue.startMs,
            endMs: cue.endMs,
            originalText: cue.originalText,
            translatedText: cue.translatedText,
          })),
        });
      });
    } catch (error) {
      return normalizeDatabaseError(error);
    }
  }

  /** Returns a single device-owned job or throws when it is missing. */
  async findOwnedJob(
    clientDeviceId: string,
    jobId: string,
  ): Promise<TranslationJob> {
    const job = await this.prisma.translationJob.findFirst({
      where: {
        id: jobId,
        clientDeviceId,
      },
    });

    return requireEntity(job, 'The translation job was not found.');
  }

  /** Returns a single device-owned job summary without loading internal-only fields. */
  async findOwnedJobSummary(clientDeviceId: string, jobId: string) {
    const job = await this.prisma.translationJob.findFirst({
      where: {
        id: jobId,
        clientDeviceId,
      },
      select: TranslationJobsRepository.translationJobSummarySelect,
    });

    return requireEntity(job, 'The translation job was not found.');
  }

  /** Lists paginated job summaries for a single device. */
  async listOwnedJobs(params: {
    clientDeviceId: string;
    page: number;
    limit: number;
  }) {
    const pagination = buildPagination(params);
    const [items, total] = await this.prisma.$transaction([
      this.prisma.translationJob.findMany({
        where: { clientDeviceId: params.clientDeviceId },
        orderBy: { createdAt: 'desc' },
        select: TranslationJobsRepository.translationJobSummarySelect,
        ...pagination,
      }),
      this.prisma.translationJob.count({
        where: { clientDeviceId: params.clientDeviceId },
      }),
    ]);

    return toPaginatedResult({
      items,
      total,
      page: params.page,
      limit: params.limit,
    });
  }

  /** Lists paginated preview cues, optionally filtered by search text. */
  async listPreviewCues(params: {
    clientDeviceId: string;
    jobId: string;
    page: number;
    limit: number;
    query?: string;
  }) {
    const pagination = buildPagination(params);
    const where: Prisma.TranslationJobCueWhereInput = {
      job: {
        id: params.jobId,
        clientDeviceId: params.clientDeviceId,
      },
      ...(params.query
        ? {
            OR: [
              {
                originalText: {
                  contains: params.query,
                  mode: 'insensitive',
                },
              },
              {
                translatedText: {
                  contains: params.query,
                  mode: 'insensitive',
                },
              },
            ],
          }
        : {}),
    };

    const [items, total] = await this.prisma.$transaction([
      this.prisma.translationJobCue.findMany({
        where,
        orderBy: { cueIndex: 'asc' },
        select: TranslationJobsRepository.translationJobCuePayloadSelect,
        ...pagination,
      }),
      this.prisma.translationJobCue.count({ where }),
    ]);

    return toPaginatedResult({
      items,
      total,
      page: params.page,
      limit: params.limit,
    });
  }

  /** Returns every cue needed to build a downloadable subtitle export. */
  async listAllOwnedJobCues(params: { clientDeviceId: string; jobId: string }) {
    return this.prisma.translationJobCue.findMany({
      where: {
        job: {
          id: params.jobId,
          clientDeviceId: params.clientDeviceId,
        },
      },
      orderBy: { cueIndex: 'asc' },
      select: TranslationJobsRepository.translationJobCuePayloadSelect,
    });
  }

  /**
   * Returns persisted source cues from the most recent completed catalog job that used the
   * same media id + subtitle source id. This avoids redownloading/reparsing on retries.
   */
  async findReusableCatalogSourceCues(params: {
    clientDeviceId: string;
    mediaId: string;
    subtitleSourceId: string;
    excludeJobId?: string;
  }): Promise<
    Array<{
      cueIndex: number;
      startMs: number;
      endMs: number;
      text: string;
    }>
  > {
    const job = await this.prisma.translationJob.findFirst({
      where: {
        clientDeviceId: params.clientDeviceId,
        ...(params.excludeJobId ? { id: { not: params.excludeJobId } } : {}),
        sourceType: TranslationSourceType.catalog,
        status: TranslationJobStatus.completed,
        mediaRef: {
          path: ['mediaId'],
          equals: params.mediaId,
        },
        OR: [
          {
            subtitleSourceRef: {
              path: ['subtitleSourceId'],
              equals: params.subtitleSourceId,
            },
          },
          {
            subtitleSourceRef: {
              path: ['selectedSubtitleSourceId'],
              equals: params.subtitleSourceId,
            },
          },
        ],
        cues: {
          some: {},
        },
      },
      orderBy: [{ completedAt: 'desc' }, { createdAt: 'desc' }],
      select: { id: true },
    });

    if (!job) {
      return [];
    }

    const cues = await this.prisma.translationJobCue.findMany({
      where: { jobId: job.id },
      orderBy: { cueIndex: 'asc' },
      select: {
        cueIndex: true,
        startMs: true,
        endMs: true,
        originalText: true,
      },
    });

    return cues.map((cue) => ({
      cueIndex: cue.cueIndex,
      startMs: cue.startMs,
      endMs: cue.endMs,
      text: cue.originalText,
    }));
  }

  /**
   * Returns translated cues from the most recent completed catalog job that used the same
   * subtitle source id + target language. This avoids re-issuing translation provider requests.
   */
  async findReusableCatalogTranslation(params: {
    clientDeviceId: string;
    subtitleSourceId: string;
    targetLanguage: AppLanguage;
    excludeJobId?: string;
  }): Promise<{
    jobId: string;
    cues: Array<{
      cueIndex: number;
      startMs: number;
      endMs: number;
      translatedText: string;
    }>;
  } | null> {
    const job = await this.prisma.translationJob.findFirst({
      where: {
        clientDeviceId: params.clientDeviceId,
        ...(params.excludeJobId ? { id: { not: params.excludeJobId } } : {}),
        sourceType: TranslationSourceType.catalog,
        status: TranslationJobStatus.completed,
        targetLanguage: params.targetLanguage,
        OR: [
          {
            subtitleSourceRef: {
              path: ['subtitleSourceId'],
              equals: params.subtitleSourceId,
            },
          },
          {
            subtitleSourceRef: {
              path: ['selectedSubtitleSourceId'],
              equals: params.subtitleSourceId,
            },
          },
        ],
        cues: {
          some: {},
        },
      },
      orderBy: [{ completedAt: 'desc' }, { createdAt: 'desc' }],
      select: { id: true },
    });

    if (!job) {
      return null;
    }

    const cues = await this.prisma.translationJobCue.findMany({
      where: { jobId: job.id },
      orderBy: { cueIndex: 'asc' },
      select: {
        cueIndex: true,
        startMs: true,
        endMs: true,
        translatedText: true,
      },
    });

    if (
      cues.length === 0 ||
      cues.some((cue) => typeof cue.translatedText !== 'string')
    ) {
      return null;
    }

    return {
      jobId: job.id,
      cues: cues.map((cue) => ({
        cueIndex: cue.cueIndex,
        startMs: cue.startMs,
        endMs: cue.endMs,
        translatedText: cue.translatedText as string,
      })),
    };
  }

  /** Clears all persisted history and upload artifacts owned by one device. */
  async clearOwnedHistory(clientDeviceId: string): Promise<void> {
    try {
      await this.prisma.$transaction(async (tx) => {
        await tx.translationJobCue.deleteMany({
          where: { job: { clientDeviceId } },
        });
        await tx.translationJob.deleteMany({
          where: { clientDeviceId },
        });
        await tx.parsedSubtitleCue.deleteMany({
          where: { parsedFile: { clientDeviceId } },
        });
        await tx.parsedSubtitleFile.deleteMany({
          where: { clientDeviceId },
        });
      });
    } catch (error) {
      return normalizeDatabaseError(error);
    }
  }

  /** Counts failed jobs for the current device. */
  async countOwnedFailedJobs(clientDeviceId: string): Promise<number> {
    return this.prisma.translationJob.count({
      where: {
        clientDeviceId,
        status: TranslationJobStatus.failed,
      },
    });
  }

  /**
   * Returns translating jobs that have had no DB activity since before the
   * given cutoff date. The `updatedAt` column serves as an implicit heartbeat
   * because every markProgress() call triggers an update.
   */
  async findStalledJobs(params: {
    staleBeforeDate: Date;
    limit?: number;
  }): Promise<
    Array<{
      id: string;
      clientDeviceId: string;
      jobMeta: Prisma.JsonValue;
      updatedAt: Date;
      startedAt: Date | null;
    }>
  > {
    return this.prisma.translationJob.findMany({
      where: {
        status: TranslationJobStatus.translating,
        updatedAt: { lt: params.staleBeforeDate },
      },
      orderBy: { updatedAt: 'asc' },
      take: params.limit ?? 100,
      select: {
        id: true,
        clientDeviceId: true,
        jobMeta: true,
        updatedAt: true,
        startedAt: true,
      },
    });
  }

  /**
   * Atomically transitions a stalled translating job back to queued so the
   * runner can reclaim it. Returns true when the update was applied.
   */
  async requeueStalledJob(
    jobId: string,
    jobMeta: Prisma.InputJsonValue,
  ): Promise<boolean> {
    try {
      const result = await this.prisma.translationJob.updateMany({
        where: {
          id: jobId,
          status: TranslationJobStatus.translating,
        },
        data: {
          status: TranslationJobStatus.queued,
          stageLabel: 'Queued for translation',
          progress: 0.05,
          errorMessage: null,
          jobMeta,
        },
      });

      return result.count > 0;
    } catch (error) {
      return normalizeDatabaseError(error);
    }
  }

  /**
   * Returns the IDs of the oldest queued jobs ordered by creation time
   * (oldest first for FIFO fairness). Used by the dispatch coordinator to
   * fill available execution slots from durable DB state.
   */
  async findNextQueuedJobs(limit: number): Promise<Array<{ id: string }>> {
    return this.prisma.translationJob.findMany({
      where: { status: TranslationJobStatus.queued },
      orderBy: { createdAt: 'asc' },
      take: limit,
      select: { id: true },
    });
  }

  /**
   * Returns queued job candidates with the fields required for dispatch
   * priority computation.
   *
   * Fetches up to `limit * DISPATCH_OVERSCAN_FACTOR` candidates (capped at
   * DISPATCH_OVERSCAN_MAX) pre-sorted by createdAt ASC so the dispatch
   * coordinator can apply priority sorting before selecting the final set
   * of jobs to schedule. The overscan ensures that lower-priority jobs at
   * the front of the FIFO queue do not block higher-priority jobs behind them.
   */
  async findQueuedJobsForDispatch(limit: number): Promise<
    Array<{
      id: string;
      sourceType: TranslationSourceType;
      createdAt: Date;
      jobMeta: Prisma.JsonValue;
    }>
  > {
    const overscan = Math.min(
      limit * TranslationJobsRepository.DISPATCH_OVERSCAN_FACTOR,
      TranslationJobsRepository.DISPATCH_OVERSCAN_MAX,
    );

    return this.prisma.translationJob.findMany({
      where: { status: TranslationJobStatus.queued },
      orderBy: { createdAt: 'asc' },
      take: overscan,
      select: { id: true, sourceType: true, createdAt: true, jobMeta: true },
    });
  }

  private static readonly DISPATCH_OVERSCAN_FACTOR = 5;
  private static readonly DISPATCH_OVERSCAN_MAX = 50;

  /**
   * Stable PostgreSQL advisory lock key for the translation-job recovery
   * coordinator. Chosen to be unique within this application and stable
   * across deployments. Within bigint range; avoids the int4 boundary.
   *
   * Only one process instance should hold this lock at a time, making
   * recovery cycles safe under concurrent multi-instance deployments.
   */
  private static readonly RECOVERY_ADVISORY_LOCK_KEY = 7_734_812_019;

  /**
   * Tries to acquire a PostgreSQL session-level advisory lock for the
   * recovery coordinator. Returns true when the lock was acquired, false
   * when another connection already holds it (non-blocking).
   *
   * Always pair with releaseRecoveryAdvisoryLock() in a finally block.
   */
  async tryAcquireRecoveryAdvisoryLock(): Promise<boolean> {
    const rows = await this.prisma.$queryRawUnsafe<Array<{ acquired: boolean }>>(
      `SELECT pg_try_advisory_lock(${TranslationJobsRepository.RECOVERY_ADVISORY_LOCK_KEY}) AS acquired`,
    );
    return rows[0]?.acquired === true;
  }

  /**
   * Releases the session-level advisory lock previously acquired via
   * tryAcquireRecoveryAdvisoryLock(). Safe to call even if the lock was
   * not held — PostgreSQL silently ignores the unlock in that case.
   */
  async releaseRecoveryAdvisoryLock(): Promise<void> {
    await this.prisma.$queryRawUnsafe(
      `SELECT pg_advisory_unlock(${TranslationJobsRepository.RECOVERY_ADVISORY_LOCK_KEY})`,
    );
  }

  /**
   * Atomically transitions a stalled translating job to failed when retry
   * attempts have been exhausted. Returns true when the update was applied.
   */
  async failStalledJob(
    jobId: string,
    jobMeta: Prisma.InputJsonValue,
    errorMessage: string,
  ): Promise<boolean> {
    try {
      const result = await this.prisma.translationJob.updateMany({
        where: {
          id: jobId,
          status: TranslationJobStatus.translating,
        },
        data: {
          status: TranslationJobStatus.failed,
          stageLabel: 'Translation failed',
          errorMessage,
          jobMeta,
        },
      });

      return result.count > 0;
    } catch (error) {
      return normalizeDatabaseError(error);
    }
  }
}
