import { Injectable } from '@nestjs/common';
import { Prisma, TranslationJob, TranslationJobStatus } from '@prisma/client';

import { buildPagination, toPaginatedResult } from 'src/common/database/helpers/pagination.helper';
import { requireEntity } from 'src/common/database/helpers/entity.helper';
import { normalizeDatabaseError } from 'src/common/database/helpers/database-error.helper';
import { PrismaService } from 'src/common/database/prisma/prisma.service';

@Injectable()
export class TranslationJobsRepository {
  constructor(private readonly prisma: PrismaService) {}

  async createJob(
    data: Prisma.TranslationJobUncheckedCreateInput,
  ): Promise<TranslationJob> {
    try {
      return await this.prisma.translationJob.create({ data });
    } catch (error) {
      return normalizeDatabaseError(error);
    }
  }

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

  async getJobForRunner(jobId: string) {
    return this.prisma.translationJob.findUnique({
      where: { id: jobId },
    });
  }

  async findOwnedJob(clientDeviceId: string, jobId: string): Promise<TranslationJob> {
    const job = await this.prisma.translationJob.findFirst({
      where: {
        id: jobId,
        clientDeviceId,
      },
    });

    return requireEntity(job, 'The translation job was not found.');
  }

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

  async listAllOwnedJobCues(params: {
    clientDeviceId: string;
    jobId: string;
  }) {
    return this.prisma.translationJobCue.findMany({
      where: {
        job: {
          id: params.jobId,
          clientDeviceId: params.clientDeviceId,
        },
      },
      orderBy: { cueIndex: 'asc' },
    });
  }

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

  async countOwnedFailedJobs(clientDeviceId: string): Promise<number> {
    return this.prisma.translationJob.count({
      where: {
        clientDeviceId,
        status: TranslationJobStatus.failed,
      },
    });
  }
}
