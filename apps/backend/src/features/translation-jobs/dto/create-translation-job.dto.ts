import { Transform } from 'class-transformer';
import { AppLanguage } from '@prisma/client';
import {
  IsInt,
  IsEnum,
  IsOptional,
  IsString,
  IsUUID,
  Matches,
  MaxLength,
  Min,
  ValidateIf,
} from 'class-validator';

import { PROVIDER_IDENTIFIER_PATTERN } from 'common/domain/constants/provider-identifier.pattern';
import { TranslationSourceType } from 'common/domain/enums/translation-source-type.enum';

const RELEASE_HINT_PATTERN = new RegExp(
  '^[A-Za-z0-9][A-Za-z0-9 ._()\\[\\]-]{0,199}$',
);

const toOptionalNumber = ({ value }: { value: unknown }) => {
  if (value === undefined || value === null || value === '') {
    return undefined;
  }

  const parsed = Number(value);
  return Number.isFinite(parsed) ? parsed : value;
};

export class CreateTranslationJobDto {
  @IsEnum(TranslationSourceType)
  sourceType!: TranslationSourceType;

  @IsOptional()
  @Transform(({ value }) => (typeof value === 'string' ? value.trim() : value))
  @IsString()
  @MaxLength(120)
  @Matches(PROVIDER_IDENTIFIER_PATTERN)
  mediaId?: string;

  @IsOptional()
  @Transform(({ value }) => (typeof value === 'string' ? value.trim() : value))
  @IsString()
  @MaxLength(120)
  @Matches(PROVIDER_IDENTIFIER_PATTERN)
  subtitleSourceId?: string;

  @IsOptional()
  @IsUUID()
  parsedFileId?: string;

  @Transform(toOptionalNumber)
  @ValidateIf(
    ({ sourceType, seasonNumber, episodeNumber }: CreateTranslationJobDto) =>
      sourceType === TranslationSourceType.Catalog &&
      (seasonNumber !== undefined || episodeNumber !== undefined),
  )
  @IsInt()
  @Min(1)
  seasonNumber?: number;

  @Transform(toOptionalNumber)
  @ValidateIf(
    ({ sourceType, seasonNumber, episodeNumber }: CreateTranslationJobDto) =>
      sourceType === TranslationSourceType.Catalog &&
      (seasonNumber !== undefined || episodeNumber !== undefined),
  )
  @IsInt()
  @Min(1)
  episodeNumber?: number;

  @ValidateIf(
    ({ sourceType, releaseHint }: CreateTranslationJobDto) =>
      sourceType === TranslationSourceType.Catalog && releaseHint !== undefined,
  )
  @Transform(({ value }) =>
    typeof value === 'string' ? value.trim() || undefined : value,
  )
  @IsString()
  @MaxLength(200)
  @Matches(RELEASE_HINT_PATTERN)
  releaseHint?: string;

  @IsEnum(AppLanguage)
  targetLanguage!: AppLanguage;
}
