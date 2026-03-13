import {
  BadRequestException,
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

import {
  DEFAULT_MAX_UPLOAD_BYTES,
  SUBTITLE_FILE_NAME_PATTERN,
} from './subtitle-upload.constants';
import { SubtitlesService } from './subtitles.service';

@UseGuards(DeviceContextGuard)
@Controller('subtitles')
/** Accepts subtitle uploads and forwards them into the parsing pipeline. */
export class SubtitlesController {
  constructor(private readonly subtitlesService: SubtitlesService) {}

  @Post('parse')
  @HttpCode(HttpStatus.CREATED)
  @UseInterceptors(
    FileInterceptor('file', {
      limits: {
        files: 1,
        fileSize: DEFAULT_MAX_UPLOAD_BYTES,
      },
      fileFilter: (_request, file, callback) => {
        if (!SUBTITLE_FILE_NAME_PATTERN.test(file.originalname)) {
          callback(
            new BadRequestException(
              'Unsupported file type. Only .srt and .vtt files are accepted.',
            ) as unknown as Error,
            false,
          );
          return;
        }

        callback(null, true);
      },
    }),
  )
  /** Parses and persists an uploaded subtitle file for the current device. */
  parseFile(
    @CurrentDevice() device: ClientDevice,
    @UploadedFile() file?: Express.Multer.File,
  ) {
    return this.subtitlesService.parseAndStore(device, file);
  }
}
