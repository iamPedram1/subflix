import { Transform } from 'class-transformer';
import {
  IsInt,
  IsOptional,
  IsString,
  Matches,
  MaxLength,
  Min,
  ValidateIf,
} from 'class-validator';

const LANGUAGE_CODE_PATTERN = /^[A-Za-z_-]{2,10}$/;
const RELEASE_HINT_PATTERN = /^[A-Za-z0-9][A-Za-z0-9 ._()\\[\\]-]{0,199}$/;

const toOptionalNumber = ({ value }: { value: unknown }) => {
  if (value === undefined || value === null || value === '') {
    return undefined;
  }

  const parsed = Number(value);
  return Number.isFinite(parsed) ? parsed : value;
};

export class GetSubtitleSourcesQueryDto {
  @IsOptional()
  @Transform(({ value }) =>
    typeof value === 'string' ? value.trim().toLowerCase() : value,
  )
  @IsString()
  @Matches(LANGUAGE_CODE_PATTERN)
  preferredLanguage?: string;

  @Transform(toOptionalNumber)
  @ValidateIf(
    ({ seasonNumber, episodeNumber }: GetSubtitleSourcesQueryDto) =>
      seasonNumber !== undefined || episodeNumber !== undefined,
  )
  @IsInt()
  @Min(1)
  seasonNumber?: number;

  @Transform(toOptionalNumber)
  @ValidateIf(
    ({ seasonNumber, episodeNumber }: GetSubtitleSourcesQueryDto) =>
      seasonNumber !== undefined || episodeNumber !== undefined,
  )
  @IsInt()
  @Min(1)
  episodeNumber?: number;

  @IsOptional()
  @Transform(({ value }) =>
    typeof value === 'string' ? value.trim() || undefined : value,
  )
  @IsString()
  @MaxLength(200)
  @Matches(RELEASE_HINT_PATTERN)
  releaseHint?: string;
}
