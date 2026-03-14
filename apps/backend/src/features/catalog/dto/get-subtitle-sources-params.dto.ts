import { Transform } from 'class-transformer';
import { IsString, Matches, MaxLength } from 'class-validator';

import { PROVIDER_IDENTIFIER_PATTERN } from 'src/common/domain/constants/provider-identifier.pattern';

export class GetSubtitleSourcesParamsDto {
  @Transform(({ value }) => (typeof value === 'string' ? value.trim() : value))
  @IsString()
  @MaxLength(120)
  @Matches(PROVIDER_IDENTIFIER_PATTERN)
  mediaId!: string;
}
