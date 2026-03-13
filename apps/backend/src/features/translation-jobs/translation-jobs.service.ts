import { Inject, Injectable } from '@nestjs/common';
import {
  AppLanguage as PrismaAppLanguage,
  ClientDevice,
  SubtitleFormat,
  TranslationJobStatus as PrismaTranslationJobStatus,
  TranslationSourceType as PrismaTranslationSourceType,
} from '@prisma/client';

import { AppLanguage } from 'src/common/domain/enums/app-language.enum';
import { TranslationSourceType } from 'src/common/domain/enums/translation-source-type.enum';
import { ValidationDomainError } from 'src/common/domain/errors/domain.error';
import { CatalogService } from 'src/features/catalog/catalog.service';
import { SubtitleExportService } from 'src/features/subtitles/utils/subtitle-export.service';
import { SubtitlesRepository } from 'src/features/subtitles/subtitles.repository';

import { CreateTranslationJobDto } from './dto/create-translation-job.dto';
import { TranslationJobsQueryDto } from './dto/translation-jobs-query.dto';
import {
  toTranslationJobSummary,
  toTranslationPreviewCue,
} from './translation-jobs.mapper';
import { TranslationJobRunnerService } from './translation-job-runner.service';
import { TranslationJobsRepository } from './translation-jobs.repository';

@Injectable()
export class TranslationJobsService {
  constructor(
    private readonly translationJobsRepository: TranslationJobsRepository,
    private readonly subtitlesRepository: SubtitlesRepository,
    private readonly catalogService: CatalogService,
    private readonly subtitleExportService: SubtitleExportService,
    private readonly translationJobRunnerService: TranslationJobRunnerService,
  ) {}

  async createJob(device: ClientDevice, input: CreateTranslationJobDto) {
    const jobSeed =
      input.sourceType === TranslationSourceType.Upload
        ? await this.createUploadJobSeed(device, input)
        : await this.createCatalogJobSeed(input);

    const job = await this.translationJobsRepository.createJob({
      clientDeviceId: device.id,
      sourceType:
        input.sourceType === TranslationSourceType.Upload
          ? PrismaTranslationSourceType.upload
          : PrismaTranslationSourceType.catalog,
      status: PrismaTranslationJobStatus.queued,
      stageLabel: 'Queued for translation',
      title: jobSeed.title,
      sourceName: jobSeed.sourceName,
      sourceLanguage: PrismaAppLanguage.en,
      targetLanguage: input.targetLanguage as PrismaAppLanguage,
      format: jobSeed.format,
      progress: 0.05,
      lineCount: jobSeed.lineCount,
      durationMs: jobSeed.durationMs,
      parsedFileId: jobSeed.parsedFileId,
      ...(jobSeed.mediaRef ? { mediaRef: jobSeed.mediaRef } : {}),
      ...(jobSeed.subtitleSourceRef
        ? { subtitleSourceRef: jobSeed.subtitleSourceRef }
        : {}),
    });

    this.translationJobRunnerService.schedule(job.id);
    return toTranslationJobSummary(job);
  }

  async listJobs(device: ClientDevice, query: TranslationJobsQueryDto) {
    const result = await this.translationJobsRepository.listOwnedJobs({
      clientDeviceId: device.id,
      page: query.page,
      limit: query.limit,
    });

    return {
      ...result,
      items: result.items.map(toTranslationJobSummary),
    };
  }

  async getJob(device: ClientDevice, jobId: string) {
    const job = await this.translationJobsRepository.findOwnedJob(device.id, jobId);
    return toTranslationJobSummary(job);
  }

  async retryJob(device: ClientDevice, jobId: string) {
    const job = await this.translationJobsRepository.findOwnedJob(device.id, jobId);

    return this.createJob(device, {
      sourceType:
        job.sourceType === PrismaTranslationSourceType.upload
          ? TranslationSourceType.Upload
          : TranslationSourceType.Catalog,
      parsedFileId: job.parsedFileId ?? undefined,
      mediaId: (job.mediaRef as { mediaId?: string } | null)?.mediaId,
      subtitleSourceId:
        (job.subtitleSourceRef as { subtitleSourceId?: string } | null)
          ?.subtitleSourceId,
      targetLanguage: job.targetLanguage as AppLanguage,
    });
  }

  async clearHistory(device: ClientDevice) {
    await this.translationJobsRepository.clearOwnedHistory(device.id);
    return { cleared: true };
  }

  async getPreview(
    device: ClientDevice,
    jobId: string,
    page: number,
    limit: number,
    query?: string,
  ) {
    const job = await this.translationJobsRepository.findOwnedJob(device.id, jobId);
    const preview = await this.translationJobsRepository.listPreviewCues({
      clientDeviceId: device.id,
      jobId,
      page,
      limit,
      query,
    });

    return {
      job: toTranslationJobSummary(job),
      ...preview,
      items: preview.items.map(toTranslationPreviewCue),
    };
  }

  async exportJob(
    device: ClientDevice,
    jobId: string,
    format?: string,
  ): Promise<{ fileName: string; content: string }> {
    const job = await this.translationJobsRepository.findOwnedJob(device.id, jobId);
    if (job.status !== PrismaTranslationJobStatus.completed) {
      throw new ValidationDomainError(
        'Only completed translation jobs can be exported.',
      );
    }

    const cues = await this.translationJobsRepository.listAllOwnedJobCues({
      clientDeviceId: device.id,
      jobId,
    });

    const exportFormat = (format ?? job.format) as SubtitleFormat;
    const content = this.subtitleExportService.formatCues(
      cues.map((cue) => ({
        cueIndex: cue.cueIndex,
        startMs: cue.startMs,
        endMs: cue.endMs,
        text: cue.translatedText ?? cue.originalText,
      })),
      exportFormat,
    );

    const safeTitle = job.title.toLowerCase().replace(/[^a-z0-9]+/g, '-');
    return {
      fileName: `${safeTitle}-${job.targetLanguage}.${exportFormat}`,
      content,
    };
  }

  private async createUploadJobSeed(
    device: ClientDevice,
    input: CreateTranslationJobDto,
  ) {
    if (!input.parsedFileId) {
      throw new ValidationDomainError(
        'parsedFileId is required for uploaded subtitle translations.',
      );
    }

    const parsedFile = await this.subtitlesRepository.findOwnedParsedFile({
      clientDeviceId: device.id,
      parsedFileId: input.parsedFileId,
    });

    return {
      title: parsedFile.fileName.replace(/\.(srt|vtt)$/i, ''),
      sourceName: parsedFile.fileName,
      format: parsedFile.format as SubtitleFormat,
      lineCount: parsedFile.lineCount,
      durationMs: parsedFile.durationMs,
      parsedFileId: parsedFile.id,
      mediaRef: null,
      subtitleSourceRef: null,
    };
  }

  private async createCatalogJobSeed(input: CreateTranslationJobDto) {
    if (!input.mediaId || !input.subtitleSourceId) {
      throw new ValidationDomainError(
        'mediaId and subtitleSourceId are required for catalog translations.',
      );
    }

    const media = await this.catalogService.findById(input.mediaId);
    if (!media) {
      throw new ValidationDomainError('The requested media title was not found.');
    }

    const subtitleSources = await this.catalogService.getSubtitleSources(input.mediaId);
    const subtitleSource = subtitleSources.find(
      (source) => source.id === input.subtitleSourceId,
    );
    if (!subtitleSource) {
      throw new ValidationDomainError(
        'The requested subtitle source was not found.',
      );
    }

    return {
      title: media.title,
      sourceName: subtitleSource.label,
      format: subtitleSource.format as SubtitleFormat,
      lineCount: subtitleSource.lineCount,
      durationMs: 0,
      parsedFileId: null,
      mediaRef: { mediaId: media.id },
      subtitleSourceRef: { subtitleSourceId: subtitleSource.id },
    };
  }
}
