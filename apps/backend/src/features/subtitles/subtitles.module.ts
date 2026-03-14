import { Module } from '@nestjs/common';

import { DevicesModule } from 'features/devices/devices.module';
import { SubtitlesController } from 'features/subtitles/subtitles.controller';
import { SubtitlesRepository } from 'features/subtitles/subtitles.repository';
import { SubtitlesService } from 'features/subtitles/subtitles.service';
import { SubtitleExportService } from 'features/subtitles/utils/subtitle-export.service';
import { SubtitleParserService } from 'features/subtitles/utils/subtitle-parser.service';

@Module({
  imports: [DevicesModule],
  controllers: [SubtitlesController],
  providers: [
    SubtitlesRepository,
    SubtitlesService,
    SubtitleParserService,
    SubtitleExportService,
  ],
  exports: [
    SubtitlesRepository,
    SubtitlesService,
    SubtitleParserService,
    SubtitleExportService,
  ],
})
export class SubtitlesModule {}
