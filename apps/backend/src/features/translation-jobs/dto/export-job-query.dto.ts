import { IsEnum, IsOptional } from 'class-validator';

import { SubtitleFormat } from 'src/common/domain/enums/subtitle-format.enum';

export class ExportJobQueryDto {
  @IsOptional()
  @IsEnum(SubtitleFormat)
  format?: SubtitleFormat;
}
