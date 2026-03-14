import { Transform } from 'class-transformer';
import { AppLanguage } from '@prisma/client';
import {
  IsEnum,
  IsOptional,
  IsString,
  IsUUID,
  Matches,
  MaxLength,
} from 'class-validator';

import { PROVIDER_IDENTIFIER_PATTERN } from 'src/common/domain/constants/provider-identifier.pattern';
import { TranslationSourceType } from 'src/common/domain/enums/translation-source-type.enum';

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

  @IsEnum(AppLanguage)
  targetLanguage!: AppLanguage;
}
