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
export class SubtitlesController {
  constructor(private readonly subtitlesService: SubtitlesService) {}

  @Post('parse')
  @HttpCode(HttpStatus.CREATED)
  @UseInterceptors(FileInterceptor('file'))
  parseFile(
    @CurrentDevice() device: ClientDevice,
    @UploadedFile() file?: Express.Multer.File,
  ) {
    return this.subtitlesService.parseAndStore(device, file);
  }
}
