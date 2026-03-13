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

import { TranslationSourceType } from 'src/common/domain/enums/translation-source-type.enum';

const PROVIDER_IDENTIFIER_PATTERN = /^[A-Za-z0-9._:-]+$/;

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
