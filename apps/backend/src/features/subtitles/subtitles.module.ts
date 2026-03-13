import { Module } from '@nestjs/common';

import { DevicesModule } from '../devices/devices.module';
import { SubtitlesController } from './subtitles.controller';
import { SubtitlesRepository } from './subtitles.repository';
import { SubtitlesService } from './subtitles.service';
import { SubtitleExportService } from './utils/subtitle-export.service';
import { SubtitleParserService } from './utils/subtitle-parser.service';

@Module({
  imports: [DevicesModule],
  controllers: [SubtitlesController],
  providers: [
    SubtitlesRepository,
    SubtitlesService,
    SubtitleParserService,
    SubtitleExportService,
  ],
  exports: [SubtitlesRepository, SubtitlesService, SubtitleParserService, SubtitleExportService],
})
export class SubtitlesModule {}
