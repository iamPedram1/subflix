import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Query,
  Res,
  UseGuards,
} from '@nestjs/common';
import { ClientDevice } from '@prisma/client';
import type { Response } from 'express';

import { CurrentDevice } from 'common/http/decorators/current-device.decorator';
import { DeviceContextGuard } from 'common/http/guards/device-context.guard';
import { RateLimit } from 'common/rate-limit/rate-limit.decorator';

import { CreateTranslationJobDto } from 'features/translation-jobs/dto/create-translation-job.dto';
import { ExportJobQueryDto } from 'features/translation-jobs/dto/export-job-query.dto';
import { JobPreviewQueryDto } from 'features/translation-jobs/dto/job-preview-query.dto';
import { TranslationJobParamsDto } from 'features/translation-jobs/dto/translation-job-params.dto';
import { TranslationJobsQueryDto } from 'features/translation-jobs/dto/translation-jobs-query.dto';
import { TranslationJobsService } from 'features/translation-jobs/translation-jobs.service';

@UseGuards(DeviceContextGuard)
@Controller('translation-jobs')
/** Exposes device-scoped translation job lifecycle endpoints. */
export class TranslationJobsController {
  constructor(
    private readonly translationJobsService: TranslationJobsService,
  ) {}

  /** Creates and queues a new translation job. */
  @Post()
  @RateLimit({
    limit: 12,
    windowMs: 10 * 60_000,
    key: 'translation-job-create',
  })
  createJob(
    @CurrentDevice() device: ClientDevice,
    @Body() body: CreateTranslationJobDto,
  ) {
    return this.translationJobsService.createJob(device, body);
  }

  /** Lists the current device's historical translation jobs. */
  @Get()
  listJobs(
    @CurrentDevice() device: ClientDevice,
    @Query() query: TranslationJobsQueryDto,
  ) {
    return this.translationJobsService.listJobs(device, query);
  }

  /** Returns the current status for a single translation job. */
  @Get(':jobId')
  getJob(
    @CurrentDevice() device: ClientDevice,
    @Param() params: TranslationJobParamsDto,
  ) {
    return this.translationJobsService.getJob(device, params.jobId);
  }

  /** Returns paginated preview cues for a translation job. */
  @Get(':jobId/preview')
  getPreview(
    @CurrentDevice() device: ClientDevice,
    @Param() params: TranslationJobParamsDto,
    @Query() query: JobPreviewQueryDto,
  ) {
    return this.translationJobsService.getPreview(
      device,
      params.jobId,
      query.page,
      query.limit,
      query.q,
    );
  }

  /** Streams a translated subtitle export to the caller. */
  @Get(':jobId/export')
  async exportJob(
    @CurrentDevice() device: ClientDevice,
    @Param() params: TranslationJobParamsDto,
    @Query() query: ExportJobQueryDto,
    @Res({ passthrough: true }) response: Response,
  ) {
    const result = await this.translationJobsService.exportJob(
      device,
      params.jobId,
      query.format,
    );

    response.setHeader('Content-Type', 'text/plain; charset=utf-8');
    response.setHeader(
      'Content-Disposition',
      `attachment; filename="${result.fileName}"`,
    );

    return result.content;
  }

  /** Replays an existing translation job with the same source context. */
  @Post(':jobId/retry')
  @RateLimit({ limit: 6, windowMs: 10 * 60_000, key: 'translation-job-retry' })
  retryJob(
    @CurrentDevice() device: ClientDevice,
    @Param() params: TranslationJobParamsDto,
  ) {
    return this.translationJobsService.retryJob(device, params.jobId);
  }

  /** Clears all translation history owned by the current device. */
  @Delete()
  clearHistory(@CurrentDevice() device: ClientDevice) {
    return this.translationJobsService.clearHistory(device);
  }
}
