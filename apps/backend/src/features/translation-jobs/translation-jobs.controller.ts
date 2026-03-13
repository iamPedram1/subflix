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
import { Response } from 'express';

import { CurrentDevice } from 'src/common/http/decorators/current-device.decorator';
import { DeviceContextGuard } from 'src/common/http/guards/device-context.guard';

import { CreateTranslationJobDto } from './dto/create-translation-job.dto';
import { ExportJobQueryDto } from './dto/export-job-query.dto';
import { JobPreviewQueryDto } from './dto/job-preview-query.dto';
import { TranslationJobsQueryDto } from './dto/translation-jobs-query.dto';
import { TranslationJobsService } from './translation-jobs.service';

@UseGuards(DeviceContextGuard)
@Controller('translation-jobs')
export class TranslationJobsController {
  constructor(private readonly translationJobsService: TranslationJobsService) {}

  @Post()
  createJob(
    @CurrentDevice() device: ClientDevice,
    @Body() body: CreateTranslationJobDto,
  ) {
    return this.translationJobsService.createJob(device, body);
  }

  @Get()
  listJobs(
    @CurrentDevice() device: ClientDevice,
    @Query() query: TranslationJobsQueryDto,
  ) {
    return this.translationJobsService.listJobs(device, query);
  }

  @Get(':jobId')
  getJob(@CurrentDevice() device: ClientDevice, @Param('jobId') jobId: string) {
    return this.translationJobsService.getJob(device, jobId);
  }

  @Get(':jobId/preview')
  getPreview(
    @CurrentDevice() device: ClientDevice,
    @Param('jobId') jobId: string,
    @Query() query: JobPreviewQueryDto,
  ) {
    return this.translationJobsService.getPreview(
      device,
      jobId,
      query.page,
      query.limit,
      query.q,
    );
  }

  @Get(':jobId/export')
  async exportJob(
    @CurrentDevice() device: ClientDevice,
    @Param('jobId') jobId: string,
    @Query() query: ExportJobQueryDto,
    @Res({ passthrough: true }) response: Response,
  ) {
    const result = await this.translationJobsService.exportJob(
      device,
      jobId,
      query.format,
    );

    response.setHeader('Content-Type', 'text/plain; charset=utf-8');
    response.setHeader(
      'Content-Disposition',
      `attachment; filename=\"${result.fileName}\"`,
    );

    return result.content;
  }

  @Post(':jobId/retry')
  retryJob(
    @CurrentDevice() device: ClientDevice,
    @Param('jobId') jobId: string,
  ) {
    return this.translationJobsService.retryJob(device, jobId);
  }

  @Delete()
  clearHistory(@CurrentDevice() device: ClientDevice) {
    return this.translationJobsService.clearHistory(device);
  }
}
