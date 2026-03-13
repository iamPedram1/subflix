import {
  Controller,
  HttpCode,
  HttpStatus,
  Post,
  UploadedFile,
  UseGuards,
  UseInterceptors,
} from '@nestjs/common';
import { ClientDevice } from '@prisma/client';
import { FileInterceptor } from '@nestjs/platform-express';

import { CurrentDevice } from 'src/common/http/decorators/current-device.decorator';
import { DeviceContextGuard } from 'src/common/http/guards/device-context.guard';

import { SubtitlesService } from './subtitles.service';

@UseGuards(DeviceContextGuard)
@Controller('subtitles')
/** Accepts subtitle uploads and forwards them into the parsing pipeline. */
export class SubtitlesController {
  constructor(private readonly subtitlesService: SubtitlesService) {}

  @Post('parse')
  @HttpCode(HttpStatus.CREATED)
  @UseInterceptors(FileInterceptor('file'))
  /** Parses and persists an uploaded subtitle file for the current device. */
  parseFile(
    @CurrentDevice() device: ClientDevice,
    @UploadedFile() file?: Express.Multer.File,
  ) {
    return this.subtitlesService.parseAndStore(device, file);
  }
}
