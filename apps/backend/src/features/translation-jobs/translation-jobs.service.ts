import { Injectable } from '@nestjs/common';
import {
  AppLanguage,
  ClientDevice,
  SubtitleFormat,
  TranslationJobStatus as PrismaTranslationJobStatus,
  TranslationSourceType as PrismaTranslationSourceType,
} from '@prisma/client';

import { TranslationSourceType } from 'common/domain/enums/translation-source-type.enum';
import { ValidationDomainError } from 'common/domain/errors/domain.error';
import { CatalogService } from 'features/catalog/catalog.service';
import { SubtitleExportCue } from 'features/subtitles/models/subtitle-cue.model';
import { SubtitleExportService } from 'features/subtitles/utils/subtitle-export.service';
import { SubtitlesRepository } from 'features/subtitles/subtitles.repository';

import { CreateTranslationJobDto } from 'features/translation-jobs/dto/create-translation-job.dto';
import { TranslationJobsQueryDto } from 'features/translation-jobs/dto/translation-jobs-query.dto';
import {
  toTranslationJobSummary,
  toTranslationPreviewCue,
} from 'features/translation-jobs/translation-jobs.mapper';
import { TranslationJobRunnerService } from 'features/translation-jobs/translation-job-runner.service';
import { TranslationJobsRepository } from 'features/translation-jobs/translation-jobs.repository';

type JobSeed = {
  title: string;
  sourceName: string;
  format: SubtitleFormat;
  lineCount: number;
  durationMs: number;
  parsedFileId: string | null;
  mediaRef: { mediaId: string } | null;
  subtitleSourceRef: { subtitleSourceId: string } | null;
};

type CreateJobPayload = Parameters<TranslationJobsRepository['createJob']>[0];
type OwnedJob = Awaited<ReturnType<TranslationJobsRepository['findOwnedJob']>>;
type OwnedJobSummary = Awaited<
  ReturnType<TranslationJobsRepository['findOwnedJobSummary']>
>;
type ExportedCue = Awaited<
  ReturnType<TranslationJobsRepository['listAllOwnedJobCues']>
>[number];

/** Orchestrates creation, retry, listing, preview, and export for device-owned translation jobs. */
@Injectable()
export class TranslationJobsService {
  constructor(
    private readonly translationJobsRepository: TranslationJobsRepository,
    private readonly subtitlesRepository: SubtitlesRepository,
    private readonly catalogService: CatalogService,
    private readonly subtitleExportService: SubtitleExportService,
    private readonly translationJobRunnerService: TranslationJobRunnerService,
  ) {}

  /** Creates and queues a translation job for either uploaded or catalog subtitle sources. */
  async createJob(device: ClientDevice, input: CreateTranslationJobDto) {
    const jobSeed = await this.createJobSeed(device, input);
    const job = await this.translationJobsRepository.createJob(
      this.buildCreateJobPayload(device.id, input, jobSeed),
    );

    this.translationJobRunnerService.schedule(job.id);
    return toTranslationJobSummary(job);
  }

  /** Lists the current device's historical translation jobs with pagination. */
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

  /** Returns the current public state of a single device-owned job. */
  async getJob(device: ClientDevice, jobId: string) {
    const job = await this.getOwnedJobSummary(device.id, jobId);
    return toTranslationJobSummary(job);
  }

  /** Recreates a translation job using the original source context and target language. */
  async retryJob(device: ClientDevice, jobId: string) {
    const job = await this.getOwnedJob(device.id, jobId);
    return this.createJob(device, this.toRetryRequest(job));
  }

  /** Clears all translation history owned by the current device. */
  async clearHistory(device: ClientDevice) {
    await this.translationJobsRepository.clearOwnedHistory(device.id);
    return { cleared: true };
  }

  /** Returns paginated preview cues alongside the parent job summary. */
  async getPreview(
    device: ClientDevice,
    jobId: string,
    page: number,
    limit: number,
    query?: string,
  ) {
    const [job, preview] = await Promise.all([
      this.getOwnedJobSummary(device.id, jobId),
      this.translationJobsRepository.listPreviewCues({
        clientDeviceId: device.id,
        jobId,
        page,
        limit,
        query,
      }),
    ]);

    return {
      job: toTranslationJobSummary(job),
      ...preview,
      items: preview.items.map(toTranslationPreviewCue),
    };
  }

  /** Builds a downloadable subtitle payload for a completed translation job. */
  async exportJob(
    device: ClientDevice,
    jobId: string,
    format?: SubtitleFormat,
  ): Promise<{ fileName: string; content: string }> {
    const job = await this.getOwnedJob(device.id, jobId);
    this.ensureJobIsExportable(job);

    const exportFormat = format ?? job.format;
    const cues = await this.translationJobsRepository.listAllOwnedJobCues({
      clientDeviceId: device.id,
      jobId,
    });
    const content = this.subtitleExportService.formatCues(
      this.toExportCues(cues),
      exportFormat,
    );

    return {
      fileName: this.buildExportFileName(job, exportFormat),
      content,
    };
  }

  /** Chooses the correct job seed builder for upload and catalog inputs. */
  private createJobSeed(
    device: ClientDevice,
    input: CreateTranslationJobDto,
  ): Promise<JobSeed> {
    return input.sourceType === TranslationSourceType.Upload
      ? this.createUploadJobSeed(device, input)
      : this.createCatalogJobSeed(input);
  }

  /** Maps a validated job seed into the repository payload used for persistence. */
  private buildCreateJobPayload(
    clientDeviceId: string,
    input: CreateTranslationJobDto,
    jobSeed: JobSeed,
  ): CreateJobPayload {
    return {
      clientDeviceId,
      sourceType:
        input.sourceType === TranslationSourceType.Upload
          ? PrismaTranslationSourceType.upload
          : PrismaTranslationSourceType.catalog,
      status: PrismaTranslationJobStatus.queued,
      stageLabel: 'Queued for translation',
      title: jobSeed.title,
      sourceName: jobSeed.sourceName,
      sourceLanguage: AppLanguage.en,
      targetLanguage: input.targetLanguage,
      format: jobSeed.format,
      progress: 0.05,
      lineCount: jobSeed.lineCount,
      durationMs: jobSeed.durationMs,
      parsedFileId: jobSeed.parsedFileId,
      ...(jobSeed.mediaRef ? { mediaRef: jobSeed.mediaRef } : {}),
      ...(jobSeed.subtitleSourceRef
        ? { subtitleSourceRef: jobSeed.subtitleSourceRef }
        : {}),
    };
  }

  /** Loads a single job while enforcing device ownership in one shared place. */
  private getOwnedJob(
    clientDeviceId: string,
    jobId: string,
  ): Promise<OwnedJob> {
    return this.translationJobsRepository.findOwnedJob(clientDeviceId, jobId);
  }

  /** Loads a single job summary while enforcing device ownership in one shared place. */
  private getOwnedJobSummary(
    clientDeviceId: string,
    jobId: string,
  ): Promise<OwnedJobSummary> {
    return this.translationJobsRepository.findOwnedJobSummary(
      clientDeviceId,
      jobId,
    );
  }

  /** Rehydrates the DTO shape needed to rerun a previously created translation job. */
  private toRetryRequest(job: OwnedJob): CreateTranslationJobDto {
    return {
      sourceType:
        job.sourceType === PrismaTranslationSourceType.upload
          ? TranslationSourceType.Upload
          : TranslationSourceType.Catalog,
      parsedFileId: job.parsedFileId ?? undefined,
      mediaId: (job.mediaRef as { mediaId?: string } | null)?.mediaId,
      subtitleSourceId: (
        job.subtitleSourceRef as { subtitleSourceId?: string } | null
      )?.subtitleSourceId,
      targetLanguage: job.targetLanguage,
    };
  }

  /** Guards export so only finished jobs can be downloaded. */
  private ensureJobIsExportable(job: OwnedJob): void {
    if (job.status !== PrismaTranslationJobStatus.completed) {
      throw new ValidationDomainError(
        'Only completed translation jobs can be exported.',
        undefined,
        {
          key: 'errors.translation.export_requires_completion',
        },
      );
    }
  }

  /** Maps stored translated cues into the export formatter input shape. */
  private toExportCues(cues: ExportedCue[]): SubtitleExportCue[] {
    return cues.map((cue) => ({
      cueIndex: cue.cueIndex,
      startMs: cue.startMs,
      endMs: cue.endMs,
      text: cue.translatedText ?? cue.originalText,
    }));
  }

  /** Builds a stable export filename from the translated job metadata. */
  private buildExportFileName(job: OwnedJob, format: SubtitleFormat): string {
    const safeTitle = job.title.toLowerCase().replace(/[^a-z0-9]+/g, '-');
    return `${safeTitle}-${job.targetLanguage}.${format}`;
  }

  /** Builds the persisted metadata for translation jobs created from uploaded subtitles. */
  private async createUploadJobSeed(
    device: ClientDevice,
    input: CreateTranslationJobDto,
  ): Promise<JobSeed> {
    if (!input.parsedFileId) {
      throw new ValidationDomainError(
        'parsedFileId is required for uploaded subtitle translations.',
        undefined,
        {
          key: 'errors.translation.missing_upload_reference',
        },
      );
    }

    const parsedFile =
      await this.subtitlesRepository.findOwnedParsedFileSummary({
        clientDeviceId: device.id,
        parsedFileId: input.parsedFileId,
      });

    return {
      title: parsedFile.fileName.replace(/\.(srt|vtt)$/i, ''),
      sourceName: parsedFile.fileName,
      format: parsedFile.format,
      lineCount: parsedFile.lineCount,
      durationMs: parsedFile.durationMs,
      parsedFileId: parsedFile.id,
      mediaRef: null,
      subtitleSourceRef: null,
    };
  }

  /** Builds the persisted metadata for translation jobs created from catalog sources. */
  private async createCatalogJobSeed(
    input: CreateTranslationJobDto,
  ): Promise<JobSeed> {
    if (!input.mediaId || !input.subtitleSourceId) {
      throw new ValidationDomainError(
        'mediaId and subtitleSourceId are required for catalog translations.',
        undefined,
        {
          key: 'errors.translation.missing_catalog_reference',
        },
      );
    }

    const [media, subtitleSources] = await Promise.all([
      this.catalogService.findById(input.mediaId),
      this.catalogService.getSubtitleSources(input.mediaId),
    ]);

    if (!media) {
      throw new ValidationDomainError(
        'The requested media title was not found.',
        undefined,
        {
          key: 'errors.translation.media_not_found',
        },
      );
    }
    const subtitleSource = subtitleSources.find(
      (source) => source.id === input.subtitleSourceId,
    );
    if (!subtitleSource) {
      throw new ValidationDomainError(
        'The requested subtitle source was not found.',
        undefined,
        {
          key: 'errors.translation.subtitle_source_not_found',
        },
      );
    }

    return {
      title: media.title,
      sourceName: subtitleSource.label,
      format: subtitleSource.format,
      lineCount: subtitleSource.lineCount,
      durationMs: 0,
      parsedFileId: null,
      mediaRef: { mediaId: media.id },
      subtitleSourceRef: { subtitleSourceId: subtitleSource.id },
    };
  }
}
